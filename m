From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 15:29:10 +0300
Subject: [PATCH 5/7] nvme-rdma: Don't local invalidate if the queue is not live
In-Reply-To: <1507724952-13917-1-git-send-email-sagi@grimberg.me>
References: <1507724952-13917-1-git-send-email-sagi@grimberg.me>
Message-ID: <1507724952-13917-6-git-send-email-sagi@grimberg.me>

No chance for the local invalidate to succeed if the queue-pair
is in error state. Most likely the target will do a remote
invalidation of our mr so not a big loss on the test_bit.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 93f4dd0b6f26..e3fe57011fcb 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1055,7 +1055,7 @@ static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
 	if (!blk_rq_bytes(rq))
 		return;
 
-	if (req->mr->need_inval) {
+	if (req->mr->need_inval && test_bit(NVME_RDMA_Q_LIVE, &req->queue->flags)) {
 		res = nvme_rdma_inv_rkey(queue, req);
 		if (unlikely(res < 0)) {
 			dev_err(ctrl->ctrl.device,
-- 
2.7.4
