From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 2 Aug 2012 13:55:46 -0400
Subject: [PATCH] Cancel outstanding IOs on queue deletion
Message-ID: <20120802175546.GD4325@linux.intel.com>


If the device is hot-unplugged while there are active commands, we should
time out the I/Os so that upper layers don't just see the I/Os disappear.

Most of the bulk of this patch is just moving nvme_timeout_ios so that it
doesn't need to be declared before its first use.

Signed-off-by: Matthew Wilcox <matthew.r.wilcox at intel.com>

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 3278fbd..570080e 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -868,11 +869,33 @@ static int nvme_set_features(struct nvme_dev *dev, unsigned fid,
 	return nvme_submit_admin_cmd(dev, &c, result);
 }
 
+static void nvme_timeout_ios(struct nvme_queue *nvmeq)
+{
+	int depth = nvmeq->q_depth - 1;
+	struct nvme_cmd_info *info = nvme_cmd_info(nvmeq);
+	unsigned long now = jiffies;
+	int cmdid;
+
+	for_each_set_bit(cmdid, nvmeq->cmdid_data, depth) {
+		void *ctx;
+		nvme_completion_fn fn;
+		static struct nvme_completion cqe = { .status = cpu_to_le16(NVME_SC_ABORT_REQ) << 1, };
+
+		if (!time_after(now, info[cmdid].timeout))
+			continue;
+		dev_warn(nvmeq->q_dmadev, "Timing out I/O %d\n", cmdid);
+		ctx = cancel_cmdid(nvmeq, cmdid, &fn);
+		fn(nvmeq->dev, ctx, &cqe);
+	}
+}
+
 static void nvme_free_queue(struct nvme_dev *dev, int qid)
 {
 	struct nvme_queue *nvmeq = dev->queues[qid];
 	int vector = dev->entry[nvmeq->cq_vector].vector;
 
+	nvme_timeout_ios(nvmeq);
+
 	irq_set_affinity_hint(vector, NULL);
 	free_irq(vector, nvmeq);
 
@@ -1226,26 +1249,6 @@ static const struct block_device_operations nvme_fops = {
 	.compat_ioctl	= nvme_ioctl,
 };
 
-static void nvme_timeout_ios(struct nvme_queue *nvmeq)
-{
-	int depth = nvmeq->q_depth - 1;
-	struct nvme_cmd_info *info = nvme_cmd_info(nvmeq);
-	unsigned long now = jiffies;
-	int cmdid;
-
-	for_each_set_bit(cmdid, nvmeq->cmdid_data, depth) {
-		void *ctx;
-		nvme_completion_fn fn;
-		static struct nvme_completion cqe = { .status = cpu_to_le16(NVME_SC_ABORT_REQ) << 1, };
-
-		if (!time_after(now, info[cmdid].timeout))
-			continue;
-		dev_warn(nvmeq->q_dmadev, "Timing out I/O %d\n", cmdid);
-		ctx = cancel_cmdid(nvmeq, cmdid, &fn);
-		fn(nvmeq->dev, ctx, &cqe);
-	}
-}
-
 static void nvme_resubmit_bios(struct nvme_queue *nvmeq)
 {
 	while (bio_list_peek(&nvmeq->sq_cong)) {
@@ -1539,8 +1542,6 @@ static int nvme_dev_remove(struct nvme_dev *dev)
 	list_del(&dev->node);
 	spin_unlock(&dev_list_lock);
 
-	/* TODO: wait all I/O finished or cancel them */
-
 	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
 		list_del(&ns->list);
 		del_gendisk(ns->disk);
