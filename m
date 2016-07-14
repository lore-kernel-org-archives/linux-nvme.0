From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 14 Jul 2016 12:15:33 +0300
Subject: [PATCH 2/2] nvme-rdma: move admin queue cleanup to
 nvme_rdma_free_ctrl
In-Reply-To: <1468445196-6915-3-git-send-email-mlin@kernel.org>
References: <1468445196-6915-1-git-send-email-mlin@kernel.org>
 <1468445196-6915-3-git-send-email-mlin@kernel.org>
Message-ID: <57875835.5050001@grimberg.me>

Hey Ming, Steve,


> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index f845304..0d3c227 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -671,9 +671,6 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl)
>   	nvme_rdma_free_qe(ctrl->queues[0].device->dev, &ctrl->async_event_sqe,
>   			sizeof(struct nvme_command), DMA_TO_DEVICE);
>   	nvme_rdma_stop_and_free_queue(&ctrl->queues[0]);
> -	blk_cleanup_queue(ctrl->ctrl.admin_q);
> -	blk_mq_free_tag_set(&ctrl->admin_tag_set);
> -	nvme_rdma_dev_put(ctrl->device);
>   }
>
>   static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
> @@ -687,6 +684,10 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
>   	list_del(&ctrl->list);
>   	mutex_unlock(&nvme_rdma_ctrl_mutex);
>
> +	blk_cleanup_queue(ctrl->ctrl.admin_q);
> +	blk_mq_free_tag_set(&ctrl->admin_tag_set);
> +	nvme_rdma_dev_put(ctrl->device);
> +
>   	if (ctrl->ctrl.tagset) {
>   		blk_cleanup_queue(ctrl->ctrl.connect_q);
>   		blk_mq_free_tag_set(&ctrl->tag_set);
>

This patch introduces asymmetry between create and destroy
of the admin queue. Does this alternative patch solve
the problem?

The patch changes the order of device removal flow from:
1. delete controller
2. destroy queue

to:
1. destroy queue
2. delete controller

Or more specifically:
1. own the controller deletion (make sure we are not
competing with anyone)
2. get rid of inflight reconnects (which also destroy and
create queues)
3. destroy the queue
4. safely queue controller deletion

Thoughts?

--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 21ecbf3f3603..36cb4e33175a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -169,7 +169,6 @@ MODULE_PARM_DESC(register_always,
  static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
                 struct rdma_cm_event *event);
  static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc);
-static int __nvme_rdma_del_ctrl(struct nvme_rdma_ctrl *ctrl);

  /* XXX: really should move to a generic header sooner or later.. */
  static inline void put_unaligned_le24(u32 val, u8 *p)
@@ -1325,30 +1324,36 @@ out_destroy_queue_ib:
  static int nvme_rdma_device_unplug(struct nvme_rdma_queue *queue)
  {
         struct nvme_rdma_ctrl *ctrl = queue->ctrl;
-       int ret, ctrl_deleted = 0;
+       int ret;

-       /* First disable the queue so ctrl delete won't free it */
-       if (!test_and_clear_bit(NVME_RDMA_Q_CONNECTED, &queue->flags))
-               goto out;
+       /* Own the controller deletion */
+       if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING))
+               return 0;

-       /* delete the controller */
-       ret = __nvme_rdma_del_ctrl(ctrl);
-       if (!ret) {
-               dev_warn(ctrl->ctrl.device,
-                       "Got rdma device removal event, deleting ctrl\n");
-               flush_work(&ctrl->delete_work);
+       dev_warn(ctrl->ctrl.device,
+               "Got rdma device removal event, deleting ctrl\n");

-               /* Return non-zero so the cm_id will destroy implicitly */
-               ctrl_deleted = 1;
+       /* Get rid of reconnect work if its running */
+       cancel_delayed_work_sync(&ctrl->reconnect_work);

-               /* Free this queue ourselves */
-               rdma_disconnect(queue->cm_id);
-               ib_drain_qp(queue->qp);
-               nvme_rdma_destroy_queue_ib(queue);
+       /* Disable the queue so ctrl delete won't free it */
+       if (!test_and_clear_bit(NVME_RDMA_Q_CONNECTED, &queue->flags)) {
+               ret = 0;
+               goto queue_delete;
         }

-out:
-       return ctrl_deleted;
+       /* Free this queue ourselves */
+       nvme_rdma_stop_queue(queue);
+       nvme_rdma_destroy_queue_ib(queue);
+
+       /* Return non-zero so the cm_id will destroy implicitly */
+       ret = 1;
+
+queue_delete:
+       /* queue controller deletion */
+       queue_work(nvme_rdma_wq, &ctrl->delete_work);
+       flush_work(&ctrl->delete_work);
+       return ret;
  }

  static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
--
