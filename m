From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 May 2017 15:11:15 +0300
Subject: NVMeoF: multipath stuck after bringing one ethernet port down
In-Reply-To: <e685401a-25c4-deb4-3eb2-b5182ccbd64c@gmail.com>
References: <CAK0KL7DPLw+0AB8cGop7jowfE1HV9wyXBmJhE90trpor-PcSYw@mail.gmail.com>
 <ebb7ffb8-4dec-5540-5cef-ffd36bef3e25@grimberg.me>
 <fa6277fa-948f-103e-1322-f8b2362467c3@gmail.com>
 <656fd267-1e01-b561-fc74-e36c1892d1f9@gmail.com>
 <e685401a-25c4-deb4-3eb2-b5182ccbd64c@gmail.com>
Message-ID: <9f4ff83a-0581-c6f1-08c0-8ec2b75a204a@grimberg.me>


> OK, so the indefinite retries are due to the
> nvme/host/rdma.c:nvme_rdma_queue_rq returning BLK_MQ_RQ_QUEUE_BUSY when
> the queue is not ready, wouldn't it be better to return
> BLK_MQ_RQ_QUEUE_ERROR so that the application may handle it? Or
> alternatively return an error after several retries (per Q or something).
>
> I tested a patch (on top of Sagi's) converting the return value to
> QUEUE_ERROR, and both dd, and multipath -ll return instantly.

We shouldn't return QUEUE_ERROR unconditionally, probably only if
the controller is in state RECONNECTING (RESETTING is a quick phase
and DELETING is going to kill the request anyway).

Does this keeps the existing behavior:
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 28bd255c144d..f0d700220ec1 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1433,7 +1433,7 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
  /*
   * We cannot accept any other command until the Connect command has 
completed.
   */
-static inline bool nvme_rdma_queue_is_ready(struct nvme_rdma_queue *queue,
+static inline int nvme_rdma_queue_is_ready(struct nvme_rdma_queue *queue,
                 struct request *rq)
  {
         if (unlikely(!test_bit(NVME_RDMA_Q_LIVE, &queue->flags))) {
@@ -1441,11 +1441,15 @@ static inline bool 
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
@@ -1463,8 +1467,9 @@ static int nvme_rdma_queue_rq(struct blk_mq_hw_ctx 
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
