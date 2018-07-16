From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 16 Jul 2018 09:51:07 +0300
Subject: nvme-rdma and rdma comp vector affinity problem
In-Reply-To: <984d4c8e-16b9-d459-e4b9-bf1703b4c226@opengridcomputing.com>
References: <bf6b909e-b3b9-cc77-2837-c65302f7c22c@opengridcomputing.com>
 <984d4c8e-16b9-d459-e4b9-bf1703b4c226@opengridcomputing.com>
Message-ID: <c3faccbe-a3ac-96ac-00f9-1dd5997b5510@grimberg.me>


> Hey Sagi and Christoph,
> 
> Do you all have any thoughts on this?? It seems like a bug in nvme-rdma
> or the blk-mq code.?? I can debug it further, if we agree this does look
> like a bug...

It is a bug... blk-mq tells expects us to skip unmapped queues but
we fail the controller altogether...

I assume managed affinity would have take care of linearization for us..

Does this quick untested patch work?
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8023054ec83e..766d10acb1b9 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -604,20 +604,33 @@ static int nvme_rdma_start_queue(struct 
nvme_rdma_ctrl *ctrl, int idx)

  static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl)
  {
-       int i, ret = 0;
+       int i, ret = 0, count = 0;

         for (i = 1; i < ctrl->ctrl.queue_count; i++) {
                 ret = nvme_rdma_start_queue(ctrl, i);
-               if (ret)
+               if (ret) {
+                       if (ret == -EXDEV) {
+                               /* unmapped queue, skip ... */
+                               nvme_rdma_free_queue(&ctrl->queues[i]);
+                               continue;
+                       }
                         goto out_stop_queues;
+               }
+               count++;
         }

+       if (!count)
+               /* no started queues, fail */
+               goto out_stop_queues;
+
+       dev_info(ctrl->ctrl.device, "connected %d I/O queues.\n", count);
+
         return 0;

  out_stop_queues:
         for (i--; i >= 1; i--)
                 nvme_rdma_stop_queue(&ctrl->queues[i]);
-       return ret;
+       return -EIO;
  }

  static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
--
