From: hch@lst.de (Christoph Hellwig)
Date: Sat, 21 Nov 2015 08:28:26 +0100
Subject: [PATCH 08/16] nvme: factor out a few helpers from req_completion
In-Reply-To: <1448090914-13121-1-git-send-email-hch@lst.de>
References: <1448090914-13121-1-git-send-email-hch@lst.de>
Message-ID: <1448090914-13121-9-git-send-email-hch@lst.de>

We'll need them in other places later.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 11 +++++++++++
 drivers/nvme/host/nvme.h |  7 +++++++
 drivers/nvme/host/pci.c  | 12 ++----------
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dd3e469..b46d1e4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -77,6 +77,17 @@ static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk)
 	return ns;
 }
 
+void nvme_requeue_req(struct request *req)
+{
+	unsigned long flags;
+
+	blk_mq_requeue_request(req);
+	spin_lock_irqsave(req->q->queue_lock, flags);
+	if (!blk_queue_stopped(req->q))
+		blk_mq_kick_requeue_list(req->q);
+	spin_unlock_irqrestore(req->q->queue_lock, flags);
+}
+
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, unsigned int flags)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 52ccf95..769c1d7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -195,6 +195,12 @@ static inline int nvme_error_status(u16 status)
 	}
 }
 
+static inline bool nvme_req_needs_retry(struct request *req, u16 status)
+{
+	return !(status & NVME_SC_DNR || blk_noretry_request(req)) &&
+		(jiffies - req->start_time) < req->timeout;
+}
+
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		const struct nvme_ctrl_ops *ops, u16 vendor,
@@ -207,6 +213,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, unsigned int flags);
+void nvme_requeue_req(struct request *req);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1a9966d..e6ce398 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -606,17 +606,9 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 	int error = 0;
 
 	if (unlikely(status)) {
-		if (!(status & NVME_SC_DNR || blk_noretry_request(req))
-		    && (jiffies - req->start_time) < req->timeout) {
-			unsigned long flags;
-
+		if (nvme_req_needs_retry(req, status)) {
 			nvme_unmap_data(nvmeq->dev, iod);
-
-			blk_mq_requeue_request(req);
-			spin_lock_irqsave(req->q->queue_lock, flags);
-			if (!blk_queue_stopped(req->q))
-				blk_mq_kick_requeue_list(req->q);
-			spin_unlock_irqrestore(req->q->queue_lock, flags);
+			nvme_requeue_req(req);
 			return;
 		}
 
-- 
1.9.1
