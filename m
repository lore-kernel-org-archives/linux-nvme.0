From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 May 2017 17:17:40 +0300
Subject: NVMeoF: multipath stuck after bringing one ethernet port down
In-Reply-To: <48b14a96-e419-f6d1-090e-cbe774139e11@mellanox.com>
References: <CAK0KL7DPLw+0AB8cGop7jowfE1HV9wyXBmJhE90trpor-PcSYw@mail.gmail.com>
 <ebb7ffb8-4dec-5540-5cef-ffd36bef3e25@grimberg.me>
 <fa6277fa-948f-103e-1322-f8b2362467c3@gmail.com>
 <656fd267-1e01-b561-fc74-e36c1892d1f9@gmail.com>
 <5b5b0a61-41cc-8018-19db-f683a604d7e4@grimberg.me>
 <48b14a96-e419-f6d1-090e-cbe774139e11@mellanox.com>
Message-ID: <459af627-3918-768e-c35f-3f99768b82cb@grimberg.me>


> Hi guys,
> this is a known issue in upstream code and Mellanox OFED code as well.
> I agree with Sagi's approach for future issues using our package.
> For this one, we will test the proposed fixes and update you regarding
> the results.

You can try:

--
[PATCH] nvme-rdma: fast fail incoming requests while we reconnect

When we encounter an transport/controller errors, error recovery
kicks in which performs:
1. stops io/admin queues
2. moves transport queues out of LIVE state
3. fast fail pending io
4. schedule periodic reconnects.

But we also need to fast fail incoming IO taht enters after we
already scheduled. Given that our queue is not LIVE anymore, simply
restart the request queues to fail in .queue_rq

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
  drivers/nvme/host/rdma.c | 37 ++++++++++++++++++++++---------------
  1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 28bd255c144d..ce8f1e992e64 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -753,28 +753,26 @@ static void nvme_rdma_reconnect_ctrl_work(struct 
work_struct *work)
         if (ret)
                 goto requeue;

-       blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
-
         ret = nvmf_connect_admin_queue(&ctrl->ctrl);
         if (ret)
-               goto stop_admin_q;
+               goto requeue;

         set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags);

         ret = nvme_enable_ctrl(&ctrl->ctrl, ctrl->cap);
         if (ret)
-               goto stop_admin_q;
+               goto requeue;

         nvme_start_keep_alive(&ctrl->ctrl);

         if (ctrl->queue_count > 1) {
                 ret = nvme_rdma_init_io_queues(ctrl);
                 if (ret)
-                       goto stop_admin_q;
+                       goto requeue;

                 ret = nvme_rdma_connect_io_queues(ctrl);
                 if (ret)
-                       goto stop_admin_q;
+                       goto requeue;
         }

         changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
@@ -782,7 +780,6 @@ static void nvme_rdma_reconnect_ctrl_work(struct 
work_struct *work)
         ctrl->ctrl.opts->nr_reconnects = 0;

         if (ctrl->queue_count > 1) {
-               nvme_start_queues(&ctrl->ctrl);
                 nvme_queue_scan(&ctrl->ctrl);
                 nvme_queue_async_events(&ctrl->ctrl);
         }
@@ -791,8 +788,6 @@ static void nvme_rdma_reconnect_ctrl_work(struct 
work_struct *work)

         return;

-stop_admin_q:
-       blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
  requeue:
         dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
                         ctrl->ctrl.opts->nr_reconnects);
@@ -823,6 +818,13 @@ static void nvme_rdma_error_recovery_work(struct 
work_struct *work)
         blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
                                 nvme_cancel_request, &ctrl->ctrl);

+       /*
+        * queues are not a live anymore, so restart the queues to fail fast
+        * new IO
+        */
+       blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
+       nvme_start_queues(&ctrl->ctrl);
+
         nvme_rdma_reconnect_or_remove(ctrl);
  }

@@ -1433,7 +1435,7 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
  /*
   * We cannot accept any other command until the Connect command has 
completed.
   */
-static inline bool nvme_rdma_queue_is_ready(struct nvme_rdma_queue *queue,
+static inline int nvme_rdma_queue_is_ready(struct nvme_rdma_queue *queue,
                 struct request *rq)
  {
         if (unlikely(!test_bit(NVME_RDMA_Q_LIVE, &queue->flags))) {
@@ -1441,11 +1443,15 @@ static inline bool 
nvme_rdma_queue_is_ready(struct nvme_rdma_queue *queue,

                 if (!blk_rq_is_passthrough(rq) ||
                     cmd->common.opcode != nvme_fabrics_command ||
-                   cmd->fabrics.fctype != nvme_fabrics_type_connect)
-                       return false;
+                   cmd->fabrics.fctype != nvme_fabrics_type_connect) {
+                       if (queue->ctrl->ctrl->state == 
NVME_CTRL_RECONNECTING)
+                               return -EIO;
+                       else
+                               return -EAGAIN;
+               }
         }

-       return true;
+       return 0;
  }

  static int nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
@@ -1463,8 +1469,9 @@ static int nvme_rdma_queue_rq(struct blk_mq_hw_ctx 
*hctx,

         WARN_ON_ONCE(rq->tag < 0);

-       if (!nvme_rdma_queue_is_ready(queue, rq))
-               return BLK_MQ_RQ_QUEUE_BUSY;
+       ret = nvme_rdma_queue_is_ready(queue, rq);
+       if (unlikely(ret))
+               goto err;

         dev = queue->device->dev;
         ib_dma_sync_single_for_cpu(dev, sqe->dma,
--
