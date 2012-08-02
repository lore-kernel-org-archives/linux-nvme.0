From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 2 Aug 2012 15:20:14 -0400
Subject: [PATCH] Cancel outstanding IOs on queue deletion
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B916291FB1@FMSMSX105.amr.corp.intel.com>
References: <20120802175546.GD4325@linux.intel.com>
 <B58D82457FDA0744A320A2FC5AC253B916291FB1@FMSMSX105.amr.corp.intel.com>
Message-ID: <20120802192014.GE4325@linux.intel.com>

On Thu, Aug 02, 2012@06:51:35PM +0000, Busch, Keith wrote:
> nvme_timeout_ios cancels an io only if it has timed out, but I think
> you want to unconditionally cancel them out when freeing the queue. Also,
> should you hold the q_lock when calling this function?

Good points.  Here's v2.  I don't particularly like the 'immediately'
parameter; better naming would be appreciated.  I don't think there's
really a good alternative to adding a parameter though; this function
is almost exactly what we want except for the timeout check.

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 3278fbd..ed3c171 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -868,11 +869,37 @@ static int nvme_set_features(struct nvme_dev *dev, unsigned fid,
 	return nvme_submit_admin_cmd(dev, &c, result);
 }
 
+static void nvme_timeout_ios(struct nvme_queue *nvmeq, bool immediately)
+{
+	int depth = nvmeq->q_depth - 1;
+	struct nvme_cmd_info *info = nvme_cmd_info(nvmeq);
+	unsigned long now = jiffies;
+	int cmdid;
+
+	for_each_set_bit(cmdid, nvmeq->cmdid_data, depth) {
+		void *ctx;
+		nvme_completion_fn fn;
+		static struct nvme_completion cqe = {
+			.status = cpu_to_le16(NVME_SC_ABORT_REQ) << 1,
+		};
+
+		if (!immediately && !time_after(now, info[cmdid].timeout))
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
 
+	spin_lock_irq(&nvmeq->q_lock);
+	nvme_timeout_ios(nvmeq, true);
+	spin_unlock_irq(&nvmeq->q_lock);
+
 	irq_set_affinity_hint(vector, NULL);
 	free_irq(vector, nvmeq);
 
@@ -1226,26 +1253,6 @@ static const struct block_device_operations nvme_fops = {
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
@@ -1277,7 +1284,7 @@ static int nvme_kthread(void *data)
 				spin_lock_irq(&nvmeq->q_lock);
 				if (nvme_process_cq(nvmeq))
 					printk("process_cq did something\n");
-				nvme_timeout_ios(nvmeq);
+				nvme_timeout_ios(nvmeq, false);
 				nvme_resubmit_bios(nvmeq);
 				spin_unlock_irq(&nvmeq->q_lock);
 			}
@@ -1539,8 +1546,6 @@ static int nvme_dev_remove(struct nvme_dev *dev)
 	list_del(&dev->node);
 	spin_unlock(&dev_list_lock);
 
-	/* TODO: wait all I/O finished or cancel them */
-
 	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
 		list_del(&ns->list);
 		del_gendisk(ns->disk);
