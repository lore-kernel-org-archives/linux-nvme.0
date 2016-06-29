From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 29 Jun 2016 09:57:16 -0500
Subject: [PATCH] nvme-rdma: Always signal fabrics private commands
In-Reply-To: <005201d1d148$32c33740$9849a5c0$@opengridcomputing.com>
References: <1466698104-32521-1-git-send-email-sagi@grimberg.me>
 <20160624070740.GB4252@infradead.org> <577005C3.4000802@grimberg.me>
 <20160628084105.GA13533@lst.de>
 <005201d1d148$32c33740$9849a5c0$@opengridcomputing.com>
Message-ID: <010501d1d216$86c0f0c0$9442d240$@opengridcomputing.com>

> > On Sun, Jun 26, 2016@07:41:39PM +0300, Sagi Grimberg wrote:
> > > Our error path is freeing the tagset before we free the queue (draining
> > > the qp) so we get to a use-after-free condition (->done() is a freed
> > > tag memory).
> > >
> > > Note that we must allocate the qp before we allocate the tagset because
> > > we need the device when init_request callouts come. So we allocated
> > > before, we free after. An alternative fix was to free the queue before
> > > the tagset even though we allocated it before (as Steve suggested).
> >
> > Would draining, but not freeing the qp before freeing the tagset work?
> > That seems like the most sensible option here.
> 
> disconnecting and draining, I think.

How about this?

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index e1205c0..d3a0396 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -604,23 +604,32 @@ out_destroy_cm_id:
        return ret;
 }

-static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
+static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 {
-       if (!test_and_clear_bit(NVME_RDMA_Q_CONNECTED, &queue->flags))
-               return;
-
        rdma_disconnect(queue->cm_id);
        ib_drain_qp(queue->qp);
+}
+
+static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
+{
        nvme_rdma_destroy_queue_ib(queue);
        rdma_destroy_id(queue->cm_id);
 }

+static void nvme_rdma_stop_and_free_queue(struct nvme_rdma_queue *queue)
+{
+       if (!test_and_clear_bit(NVME_RDMA_Q_CONNECTED, &queue->flags))
+               return;
+       nvme_rdma_stop_queue(queue);
+       nvme_rdma_free_queue(queue);
+}
+
 static void nvme_rdma_free_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
        int i;

        for (i = 1; i < ctrl->queue_count; i++)
-               nvme_rdma_free_queue(&ctrl->queues[i]);
+               nvme_rdma_stop_and_free_queue(&ctrl->queues[i]);
 }

 static int nvme_rdma_connect_io_queues(struct nvme_rdma_ctrl *ctrl)
@@ -653,7 +662,7 @@ static int nvme_rdma_init_io_queues(struct nvme_rdma_ctrl
*ctrl)

 out_free_queues:
        for (; i >= 1; i--)
-               nvme_rdma_free_queue(&ctrl->queues[i]);
+               nvme_rdma_stop_and_free_queue(&ctrl->queues[i]);

        return ret;
 }
@@ -662,7 +671,7 @@ static void nvme_rdma_destroy_admin_queue(struct
nvme_rdma_ctrl *ctrl)
 {
        nvme_rdma_free_qe(ctrl->queues[0].device->dev, &ctrl->async_event_sqe,
                        sizeof(struct nvme_command), DMA_TO_DEVICE);
-       nvme_rdma_free_queue(&ctrl->queues[0]);
+       nvme_rdma_stop_and_free_queue(&ctrl->queues[0]);
        blk_cleanup_queue(ctrl->ctrl.admin_q);
        blk_mq_free_tag_set(&ctrl->admin_tag_set);
        nvme_rdma_dev_put(ctrl->device);
@@ -705,7 +714,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct
*work)
                        goto requeue;
        }

-       nvme_rdma_free_queue(&ctrl->queues[0]);
+       nvme_rdma_stop_and_free_queue(&ctrl->queues[0]);

        ret = blk_mq_reinit_tagset(&ctrl->admin_tag_set);
        if (ret)
@@ -1617,6 +1626,7 @@ static int nvme_rdma_configure_admin_queue(struct
nvme_rdma_ctrl *ctrl)
 out_cleanup_queue:
        blk_cleanup_queue(ctrl->ctrl.admin_q);
 out_free_tagset:
+       nvme_rdma_stop_queue(&ctrl->queues[0]);
        blk_mq_free_tag_set(&ctrl->admin_tag_set);
 out_put_dev:
        nvme_rdma_dev_put(ctrl->device);
