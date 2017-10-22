From: nitzanc@mellanox.com (Nitzan Carmi)
Date: Sun, 22 Oct 2017 09:37:04 +0000
Subject: [PATCH] nvme-rdma: Add debug message when reaches timeout
Message-ID: <20171022093704.25203-1-nitzanc@mellanox.com>

Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 92a03ff..f2f9a47 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1582,6 +1582,10 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 
+	dev_warn(req->queue->ctrl->ctrl.device,
+		 "I/O %d QID %d timeout, recover controller\n",
+		 rq->tag, nvme_rdma_queue_idx(req->queue));
+
 	/* queue error recovery */
 	nvme_rdma_error_recovery(req->queue->ctrl);
 
-- 
2.9.4
