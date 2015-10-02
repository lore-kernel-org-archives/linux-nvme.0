From: hch@lst.de (Christoph Hellwig)
Date: Fri,  2 Oct 2015 19:58:15 +0200
Subject: [PATCH 3/7] nvme: factor reset code into a common helper
In-Reply-To: <1443808699-4738-1-git-send-email-hch@lst.de>
References: <1443808699-4738-1-git-send-email-hch@lst.de>
Message-ID: <1443808699-4738-4-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-core.c | 48 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e8a4218f..d69b831 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -84,6 +84,7 @@ static wait_queue_head_t nvme_kthread_wait;
 
 static struct class *nvme_class;
 
+static int __nvme_reset(struct nvme_dev *dev);
 static int nvme_reset(struct nvme_dev *dev);
 static int nvme_process_cq(struct nvme_queue *nvmeq);
 
@@ -1278,17 +1279,13 @@ static void nvme_abort_req(struct request *req)
 	struct nvme_command cmd;
 
 	if (!nvmeq->qid || cmd_rq->aborted) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&dev_list_lock, flags);
-		if (work_busy(&dev->reset_work))
-			goto out;
-		list_del_init(&dev->node);
-		dev_warn(dev->dev, "I/O %d QID %d timeout, reset controller\n",
-							req->tag, nvmeq->qid);
-		queue_work(nvme_workq, &dev->reset_work);
- out:
-		spin_unlock_irqrestore(&dev_list_lock, flags);
+		spin_lock(&dev_list_lock);
+		if (!__nvme_reset(dev)) {
+			dev_warn(dev->dev,
+				 "I/O %d QID %d timeout, reset controller\n",
+				 req->tag, nvmeq->qid);
+		}
+		spin_unlock(&dev_list_lock);
 		return;
 	}
 
@@ -2083,13 +2080,11 @@ static int nvme_kthread(void *data)
 
 			if ((dev->subsystem && (csts & NVME_CSTS_NSSRO)) ||
 							csts & NVME_CSTS_CFS) {
-				if (work_busy(&dev->reset_work))
-					continue;
-				list_del_init(&dev->node);
-				dev_warn(dev->dev,
-					"Failed status: %x, reset controller\n",
-					readl(&dev->bar->csts));
-				queue_work(nvme_workq, &dev->reset_work);
+				if (!__nvme_reset(dev)) {
+					dev_warn(dev->dev,
+						"Failed status: %x, reset controller\n",
+						readl(&dev->bar->csts));
+				}
 				continue;
 			}
 			for (i = 0; i < dev->queue_count; i++) {
@@ -3078,19 +3073,24 @@ static void nvme_reset_work(struct work_struct *ws)
 	schedule_work(&dev->probe_work);
 }
 
+static int __nvme_reset(struct nvme_dev *dev)
+{
+	if (work_pending(&dev->reset_work))
+		return -EBUSY;
+	list_del_init(&dev->node);
+	queue_work(nvme_workq, &dev->reset_work);
+	return 0;
+}
+
 static int nvme_reset(struct nvme_dev *dev)
 {
-	int ret = -EBUSY;
+	int ret;
 
 	if (!dev->admin_q || blk_queue_dying(dev->admin_q))
 		return -ENODEV;
 
 	spin_lock(&dev_list_lock);
-	if (!work_pending(&dev->reset_work)) {
-		list_del_init(&dev->node);
-		queue_work(nvme_workq, &dev->reset_work);
-		ret = 0;
-	}
+	ret = __nvme_reset(dev);
 	spin_unlock(&dev_list_lock);
 
 	if (!ret) {
-- 
1.9.1
