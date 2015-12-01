From: hch@lst.de (Christoph Hellwig)
Date: Tue,  1 Dec 2015 19:52:53 +0100
Subject: [PATCH 18/26] nvme: factor out a few helpers from req_completion
In-Reply-To: <1448995981-11982-1-git-send-email-hch@lst.de>
References: <1448995981-11982-1-git-send-email-hch@lst.de>
Message-ID: <1448995981-11982-19-git-send-email-hch@lst.de>

We'll need them in other places later.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 11 +++++++++++
 drivers/nvme/host/nvme.h |  7 +++++++
 drivers/nvme/host/pci.c  | 12 ++----------
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 41e5efa..0a7a5107 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -78,6 +78,17 @@ static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk)
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
index aa4b42e..b041762 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -216,6 +216,12 @@ static inline int nvme_error_status(u16 status)
 	}
 }
 
+static inline bool nvme_req_needs_retry(struct request *req, u16 status)
+{
+	return !(status & NVME_SC_DNR || blk_noretry_request(req)) &&
+		(jiffies - req->start_time) < req->timeout;
+}
+
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
@@ -230,6 +236,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, unsigned int flags);
+void nvme_requeue_req(struct request *req);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 686a4e2..808fb73 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -607,17 +607,9 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
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
