From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 25 Feb 2018 19:45:37 +0200
Subject: nvme-rdma corrupts memory upon timeout
In-Reply-To: <CAF9HSintgS0U2X=E=_uJnU4y95HDcCUnyCKBDF_tNaDcY9pucg@mail.gmail.com>
References: <CAF9HSintgS0U2X=E=_uJnU4y95HDcCUnyCKBDF_tNaDcY9pucg@mail.gmail.com>
Message-ID: <65c6d928-dd82-70b6-79a7-481dc629c3db@grimberg.me>


> Hey,

Hi Alon, thanks for reporting!

> Some additional information: we use a keepalive and reconnect timeout
> of 1 second. ConnectX4 with OFED 4.1. I validated the code hasn't
> changed in latest linux sources.

So we obviously cannot help you with OFED (or anything that is not
upstream for that matter). This mailing list is designed to develop
Linux upstream and does not have any control of any other code
distribution.

For OFED issues the correct address for filing bug reports would be:
http://bugs.openfabrics.org/

For Mellanox OFED I believe you probably already have a support
channel...

Now as to your issue,

 > We're running nvmf over a large cluster using RDMA. Sometimes, there's
 > some congestion that causes the nvme host driver to time out (we use a
 > 4 second timeout).
 > Even though the host (initiator) times out and returns with an error
 > to userspace, we can see the buffer being written after the io
 > returned. This can obviously cause serious crashes and corruptions.
 > We suspect the same happens with writes but have yet to prove it.
 >
 > We think we can spot the root cause: 'nvme_rdma_error_recovery'
 > handles the timeout in an asynchronous manner. It queues a task for
 > reconnecting the nvme device. Until that task is executed by the
 > worker thread the qp is open and a rdma write can get through. Does
 > this make sense?

Yes it does. The problem is that for I/O timeout kicking error recovery
we don't make sure to either invalidate the rkey nor drain the rdma
queue pair (either will do).

Does this patch help?
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2ef761b5a26e..856ae9a7615a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -956,15 +956,15 @@ static void nvme_rdma_error_recovery_work(struct 
work_struct *work)

         if (ctrl->ctrl.queue_count > 1) {
                 nvme_stop_queues(&ctrl->ctrl);
+               nvme_rdma_destroy_io_queues(ctrl, false);
                 blk_mq_tagset_busy_iter(&ctrl->tag_set,
                                         nvme_cancel_request, &ctrl->ctrl);
-               nvme_rdma_destroy_io_queues(ctrl, false);
         }

         blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+       nvme_rdma_destroy_admin_queue(ctrl, false);
         blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
                                 nvme_cancel_request, &ctrl->ctrl);
-       nvme_rdma_destroy_admin_queue(ctrl, false);

         /*
          * queues are not a live anymore, so restart the queues to fail 
fast
@@ -1724,9 +1724,9 @@ static void nvme_rdma_shutdown_ctrl(struct 
nvme_rdma_ctrl *ctrl, bool shutdown)

         if (ctrl->ctrl.queue_count > 1) {
                 nvme_stop_queues(&ctrl->ctrl);
+               nvme_rdma_destroy_io_queues(ctrl, shutdown);
                 blk_mq_tagset_busy_iter(&ctrl->tag_set,
                                         nvme_cancel_request, &ctrl->ctrl);
-               nvme_rdma_destroy_io_queues(ctrl, shutdown);
         }

         if (shutdown)
@@ -1735,10 +1735,10 @@ static void nvme_rdma_shutdown_ctrl(struct 
nvme_rdma_ctrl *ctrl, bool shutdown)
                 nvme_disable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);

         blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+       nvme_rdma_destroy_admin_queue(ctrl, shutdown);
         blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
                                 nvme_cancel_request, &ctrl->ctrl);
         blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
-       nvme_rdma_destroy_admin_queue(ctrl, shutdown);
  }

  static void nvme_rdma_delete_ctrl(struct nvme_ctrl *ctrl)
--
