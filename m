From: Tomita.Haruo@toshiba-sol.co.jp (Tomita.Haruo@toshiba-sol.co.jp)
Date: Tue, 22 Nov 2016 05:32:42 +0000
Subject: [PATCH] Use rsps_lock in nvmet_rdma_free_rsp
Message-ID: <8528f5ceac0745759549bc25fe17228c@TGXML382.toshiba.local>

Hi Christoph and Sagi,

Without using rsps_lock in nvmet_rdma_free_rsp,  free_list is being operated.
The following patch, this issue fixed. Is this patch right?

rdma.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-4.9-rc6/drivers/nvme/target/rdma.c.org        2016-11-21 06:52:19.000000000 +0900
+++ linux-4.9-rc6/drivers/nvme/target/rdma.c    2016-11-22 14:04:59.387510444 +0900
@@ -423,11 +423,14 @@ static void nvmet_rdma_free_rsps(struct
 {
        struct nvmet_rdma_device *ndev = queue->dev;
        int i, nr_rsps = queue->recv_queue_size * 2;
+       unsigned long flags;

        for (i = 0; i < nr_rsps; i++) {
+               spin_lock_irqsave(&queue->rsps_lock, flags);
                struct nvmet_rdma_rsp *rsp = &queue->rsps[i];

                list_del(&rsp->free_list);
+               spin_unlock_irqrestore(&queue->rsps_lock, flags);
                nvmet_rdma_free_rsp(ndev, rsp);
        }
        kfree(queue->rsps);

thanks
--
Haruo
