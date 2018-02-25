From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 25 Feb 2018 20:14:12 +0200
Subject: nvme-rdma corrupts memory upon timeout
In-Reply-To: <65c6d928-dd82-70b6-79a7-481dc629c3db@grimberg.me>
References: <CAF9HSintgS0U2X=E=_uJnU4y95HDcCUnyCKBDF_tNaDcY9pucg@mail.gmail.com>
 <65c6d928-dd82-70b6-79a7-481dc629c3db@grimberg.me>
Message-ID: <9569a169-76cb-cd49-e31a-f33978fe2025@grimberg.me>


> Does this patch help?
> -- 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 2ef761b5a26e..856ae9a7615a 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -956,15 +956,15 @@ static void nvme_rdma_error_recovery_work(struct 
> work_struct *work)
> 
>  ??????? if (ctrl->ctrl.queue_count > 1) {
>  ??????????????? nvme_stop_queues(&ctrl->ctrl);
> +?????????????? nvme_rdma_destroy_io_queues(ctrl, false);
>  ??????????????? blk_mq_tagset_busy_iter(&ctrl->tag_set,
>  ??????????????????????????????????????? nvme_cancel_request, &ctrl->ctrl);
> -?????????????? nvme_rdma_destroy_io_queues(ctrl, false);
>  ??????? }
> 
>  ??????? blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
> +?????? nvme_rdma_destroy_admin_queue(ctrl, false);
>  ??????? blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
>  ??????????????????????????????? nvme_cancel_request, &ctrl->ctrl);
> -?????? nvme_rdma_destroy_admin_queue(ctrl, false);
> 
>  ??????? /*
>  ???????? * queues are not a live anymore, so restart the queues to fail 
> fast
> @@ -1724,9 +1724,9 @@ static void nvme_rdma_shutdown_ctrl(struct 
> nvme_rdma_ctrl *ctrl, bool shutdown)
> 
>  ??????? if (ctrl->ctrl.queue_count > 1) {
>  ??????????????? nvme_stop_queues(&ctrl->ctrl);
> +?????????????? nvme_rdma_destroy_io_queues(ctrl, shutdown);
>  ??????????????? blk_mq_tagset_busy_iter(&ctrl->tag_set,
>  ??????????????????????????????????????? nvme_cancel_request, &ctrl->ctrl);
> -?????????????? nvme_rdma_destroy_io_queues(ctrl, shutdown);
>  ??????? }
> 
>  ??????? if (shutdown)
> @@ -1735,10 +1735,10 @@ static void nvme_rdma_shutdown_ctrl(struct 
> nvme_rdma_ctrl *ctrl, bool shutdown)
>  ??????????????? nvme_disable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
> 
>  ??????? blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
> +?????? nvme_rdma_destroy_admin_queue(ctrl, shutdown);
>  ??????? blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
>  ??????????????????????????????? nvme_cancel_request, &ctrl->ctrl);
>  ??????? blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
> -?????? nvme_rdma_destroy_admin_queue(ctrl, shutdown);
>  ?}
> 
>  ?static void nvme_rdma_delete_ctrl(struct nvme_ctrl *ctrl)
> -- 

Or maybe this should do a better job:
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 4c32518a6c81..e45801fe78c1 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -956,12 +956,14 @@ static void nvme_rdma_error_recovery_work(struct 
work_struct *work)

         if (ctrl->ctrl.queue_count > 1) {
                 nvme_stop_queues(&ctrl->ctrl);
+               nvme_rdma_stop_io_queues(ctrl);
                 blk_mq_tagset_busy_iter(&ctrl->tag_set,
                                         nvme_cancel_request, &ctrl->ctrl);
                 nvme_rdma_destroy_io_queues(ctrl, false);
         }

         blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+       nvme_rdma_stop_queue(&ctrl->queues[0]);
         blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
                                 nvme_cancel_request, &ctrl->ctrl);
         nvme_rdma_destroy_admin_queue(ctrl, false);
@@ -1729,9 +1731,12 @@ static void nvme_rdma_shutdown_ctrl(struct 
nvme_rdma_ctrl *ctrl, bool shutdown)

         if (ctrl->ctrl.queue_count > 1) {
                 nvme_stop_queues(&ctrl->ctrl);
+               nvme_rdma_stop_io_queues(ctrl);
                 blk_mq_tagset_busy_iter(&ctrl->tag_set,
                                         nvme_cancel_request, &ctrl->ctrl);
                 nvme_rdma_destroy_io_queues(ctrl, shutdown);
+               if (shutdown)
+                       nvme_start_queues(&ctrl->ctrl);
         }

         if (shutdown)
@@ -1740,10 +1745,11 @@ static void nvme_rdma_shutdown_ctrl(struct 
nvme_rdma_ctrl *ctrl, bool shutdown)
                 nvme_disable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);

         blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+       nvme_rdma_stop_queue(&ctrl->queues[0]);
         blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
                                 nvme_cancel_request, &ctrl->ctrl);
-       blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
         nvme_rdma_destroy_admin_queue(ctrl, shutdown);
+       blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
  }

  static void nvme_rdma_delete_ctrl(struct nvme_ctrl *ctrl)
--
