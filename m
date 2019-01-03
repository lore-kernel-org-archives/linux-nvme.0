From: rajur@chelsio.com (Raju Rangoju)
Date: Thu,  3 Jan 2019 16:03:36 +0530
Subject: [PATCH v2] nvmet-rdma: fix null dereference under heavy load
Message-ID: <20190103103336.6343-1-rajur@chelsio.com>

Under heavy load if we don't have any pre-allocated rsps left, we
dynamically allocate a rsp, but we are not actually allocating memory
for nvme_completion (rsp->req.rsp). In such a case, accessing pointer
fields (req->rsp->status) in nvmet_req_init() will result in crash.

To fix this, allocate the memory for nvme_completion by calling
nvmet_rdma_alloc_rsp()

Fixes: 8407879c("nvmet-rdma:fix possible bogus dereference under heavy load")

Cc: <stable at vger.kernel.org>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Raju Rangoju <rajur at chelsio.com>

--
Changes from v1:
- Moved integer to 'if' block
- Used 'unlikely' in datapath flow condition
---
 drivers/nvme/target/rdma.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index a8d23eb80192..8f9e6645fcf9 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -139,6 +139,10 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc);
 static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc);
 static void nvmet_rdma_qp_event(struct ib_event *event, void *priv);
 static void nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue);
+static void nvmet_rdma_free_rsp(struct nvmet_rdma_device *ndev,
+				struct nvmet_rdma_rsp *r);
+static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
+				struct nvmet_rdma_rsp *r);
 
 static const struct nvmet_fabrics_ops nvmet_rdma_ops;
 
@@ -182,9 +186,17 @@ nvmet_rdma_get_rsp(struct nvmet_rdma_queue *queue)
 	spin_unlock_irqrestore(&queue->rsps_lock, flags);
 
 	if (unlikely(!rsp)) {
-		rsp = kmalloc(sizeof(*rsp), GFP_KERNEL);
+		int ret = -EINVAL;
+
+		rsp = kzalloc(sizeof(*rsp), GFP_KERNEL);
 		if (unlikely(!rsp))
 			return NULL;
+		ret = nvmet_rdma_alloc_rsp(queue->dev, rsp);
+		if (unlikely(ret)) {
+			kfree(rsp);
+			return NULL;
+		}
+
 		rsp->allocated = true;
 	}
 
@@ -197,6 +209,7 @@ nvmet_rdma_put_rsp(struct nvmet_rdma_rsp *rsp)
 	unsigned long flags;
 
 	if (unlikely(rsp->allocated)) {
+		nvmet_rdma_free_rsp(rsp->queue->dev, rsp);
 		kfree(rsp);
 		return;
 	}
-- 
2.12.0
