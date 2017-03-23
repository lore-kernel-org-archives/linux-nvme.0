From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Thu, 23 Mar 2017 10:04:09 +0100 (CET)
Subject: [PATCH RFC] nvme-rdma: support devices with queue size < 32
Message-ID: <1315914765.312051621.1490259849534.JavaMail.zimbra@kalray.eu>

In the case of small NVMe-oF queue size (<32) we may enter
a deadlock caused by the fact that the IB completions aren't sent
waiting for 32 and the send queue will fill up.

The error is seen as (using mlx5):
[ 2048.693355] mlx5_0:mlx5_ib_post_send:3765:(pid 7273):
[ 2048.693360] nvme nvme1: nvme_rdma_post_send failed with error code -12

The patch doesn't change the behaviour for remote devices with
larger queues.

Signed-off-by: Marta Rybczynska <marta.rybczynska at kalray.eu>
Signed-off-by: Samuel Jones <sjones at kalray.eu>
---
 drivers/nvme/host/rdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 779f516..8ea4cba 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1023,6 +1023,7 @@ static int nvme_rdma_post_send(struct nvme_rdma_queue *queue,
 {
        struct ib_send_wr wr, *bad_wr;
        int ret;
+       int sig_limit;
 
        sge->addr   = qe->dma;
        sge->length = sizeof(struct nvme_command),
@@ -1054,7 +1055,8 @@ static int nvme_rdma_post_send(struct nvme_rdma_queue *queue,
         * embedded in request's payload, is not freed when __ib_process_cq()
         * calls wr_cqe->done().
         */
-       if ((++queue->sig_count % 32) == 0 || flush)
+       sig_limit = min(queue->queue_size, 32);
+       if ((++queue->sig_count % sig_limit) == 0 || flush)
                wr.send_flags |= IB_SEND_SIGNALED;
 
        if (first)
-- 
1.8.3.1
