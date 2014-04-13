From: matthew.r.wilcox@intel.com (Matthew Wilcox)
Date: Sun, 13 Apr 2014 13:12:13 -0400
Subject: [PATCH] NVMe: Change how aborts are handled
Message-ID: <1397409133-18140-1-git-send-email-matthew.r.wilcox@intel.com>

Instead of keeping a bit per command in the nvme_cmd_info (which
grows the nvme_queue by 4k), encode the fact that the command has been
aborted using special CMD_CTX_ values.  Give the abort command its own
handler instead of using special_completion for it.  Factor out
set_cmdid_special() from free_cmdid() and cancel_cmdid, then use it
to transition from ABORTED to ABORT_COMPLETED.

There are two new states for commands; CMD_CTX_ABORTED (indicating
that an abort has been sent) and CMD_CTX_ABORT_COMPLETED, indicating
that a completion arrived after the abort was sent.  We've already told
the caller at that point that their command was aborted, so that's no
help to them, but we have to handle the case where a controller returns
(abort failed, original succeeded) in either order.

This commit also fixes a bug where command IDs could be reused after an
abort was sent, but before the original command had completed.

Signed-off-by: Matthew Wilcox <matthew.r.wilcox at intel.com>
---
 drivers/block/nvme-core.c | 159 +++++++++++++++++++++++++++++-----------------
 1 file changed, 101 insertions(+), 58 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 074e982..1afd315 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -126,14 +126,13 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
 }
 
-typedef void (*nvme_completion_fn)(struct nvme_queue *, void *,
+typedef bool (*nvme_completion_fn)(struct nvme_queue *, void *,
 						struct nvme_completion *);
 
 struct nvme_cmd_info {
 	nvme_completion_fn fn;
 	void *ctx;
 	unsigned long timeout;
-	int aborted;
 };
 
 static struct nvme_cmd_info *nvme_cmd_info(struct nvme_queue *nvmeq)
@@ -177,7 +176,6 @@ static int alloc_cmdid(struct nvme_queue *nvmeq, void *ctx,
 	info[cmdid].fn = handler;
 	info[cmdid].ctx = ctx;
 	info[cmdid].timeout = jiffies + timeout;
-	info[cmdid].aborted = 0;
 	return cmdid;
 }
 
@@ -196,42 +194,76 @@ static int alloc_cmdid_killable(struct nvme_queue *nvmeq, void *ctx,
 #define CMD_CTX_COMPLETED	(0x310 + CMD_CTX_BASE)
 #define CMD_CTX_INVALID		(0x314 + CMD_CTX_BASE)
 #define CMD_CTX_FLUSH		(0x318 + CMD_CTX_BASE)
-#define CMD_CTX_ABORT		(0x31C + CMD_CTX_BASE)
+#define CMD_CTX_ABORTED		(0x31C + CMD_CTX_BASE)
+#define CMD_CTX_ABORT_COMPLETED	(0x320 + CMD_CTX_BASE)
 
-static void special_completion(struct nvme_queue *nvmeq, void *ctx,
+static bool special_completion(struct nvme_queue *, void *,
+				struct nvme_completion *);
+
+static void *set_cmdid_special(struct nvme_queue *nvmeq, int cmdid,
+				nvme_completion_fn *fn, void *new_ctx)
+{
+	void *ctx;
+	struct nvme_cmd_info *info = nvme_cmd_info(nvmeq);
+	if (fn)
+		*fn = info[cmdid].fn;
+	ctx = info[cmdid].ctx;
+	info[cmdid].fn = special_completion;
+	info[cmdid].ctx = new_ctx;
+	info[cmdid].timeout = jiffies + ADMIN_TIMEOUT;
+	return ctx;
+}
+
+static bool is_aborted_and_completed(struct nvme_queue *nvmeq, int cmdid)
+{
+	struct nvme_cmd_info *info = nvme_cmd_info(nvmeq);
+	return info[cmdid].ctx == CMD_CTX_ABORT_COMPLETED;
+}
+
+static bool was_abort_sent(struct nvme_queue *nvmeq, int cmdid)
+{
+	struct nvme_cmd_info *info = nvme_cmd_info(nvmeq);
+	return (info[cmdid].ctx == CMD_CTX_ABORT_COMPLETED) ||
+		(info[cmdid].ctx == CMD_CTX_ABORTED);
+}
+
+static bool special_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
-	if (ctx == CMD_CTX_CANCELLED)
-		return;
 	if (ctx == CMD_CTX_FLUSH)
-		return;
-	if (ctx == CMD_CTX_ABORT) {
-		++nvmeq->dev->abort_limit;
-		return;
+		return true;
+	if (ctx == CMD_CTX_CANCELLED)
+		return true;
+	if (ctx == CMD_CTX_ABORTED) {
+		set_cmdid_special(nvmeq, cqe->command_id, NULL,
+					CMD_CTX_ABORT_COMPLETED);
+		return false;
 	}
-	if (ctx == CMD_CTX_COMPLETED) {
+	if (ctx == CMD_CTX_COMPLETED || ctx == CMD_CTX_ABORT_COMPLETED) {
 		dev_warn(nvmeq->q_dmadev,
 				"completed id %d twice on queue %d\n",
 				cqe->command_id, le16_to_cpup(&cqe->sq_id));
-		return;
+		return false;
 	}
 	if (ctx == CMD_CTX_INVALID) {
 		dev_warn(nvmeq->q_dmadev,
 				"invalid id %d completed on queue %d\n",
 				cqe->command_id, le16_to_cpup(&cqe->sq_id));
-		return;
+		return false;
 	}
 
 	dev_warn(nvmeq->q_dmadev, "Unknown special completion %p\n", ctx);
+	return true;
 }
 
-static void async_completion(struct nvme_queue *nvmeq, void *ctx,
+static bool async_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
 	struct async_cmd_info *cmdinfo = ctx;
 	cmdinfo->result = le32_to_cpup(&cqe->result);
 	cmdinfo->status = le16_to_cpup(&cqe->status) >> 1;
 	queue_kthread_work(cmdinfo->worker, &cmdinfo->work);
+	return true;
 }
 
 /*
@@ -241,18 +273,13 @@ static void *free_cmdid(struct nvme_queue *nvmeq, int cmdid,
 						nvme_completion_fn *fn)
 {
 	void *ctx;
-	struct nvme_cmd_info *info = nvme_cmd_info(nvmeq);
 
 	if (cmdid >= nvmeq->q_depth) {
 		*fn = special_completion;
 		return CMD_CTX_INVALID;
 	}
-	if (fn)
-		*fn = info[cmdid].fn;
-	ctx = info[cmdid].ctx;
-	info[cmdid].fn = special_completion;
-	info[cmdid].ctx = CMD_CTX_COMPLETED;
-	clear_bit(cmdid, nvmeq->cmdid_data);
+
+	ctx = set_cmdid_special(nvmeq, cmdid, fn, CMD_CTX_COMPLETED);
 	wake_up(&nvmeq->sq_full);
 	return ctx;
 }
@@ -260,14 +287,7 @@ static void *free_cmdid(struct nvme_queue *nvmeq, int cmdid,
 static void *cancel_cmdid(struct nvme_queue *nvmeq, int cmdid,
 						nvme_completion_fn *fn)
 {
-	void *ctx;
-	struct nvme_cmd_info *info = nvme_cmd_info(nvmeq);
-	if (fn)
-		*fn = info[cmdid].fn;
-	ctx = info[cmdid].ctx;
-	info[cmdid].fn = special_completion;
-	info[cmdid].ctx = CMD_CTX_CANCELLED;
-	return ctx;
+	return set_cmdid_special(nvmeq, cmdid, fn, CMD_CTX_CANCELLED);
 }
 
 static struct nvme_queue *raw_nvmeq(struct nvme_dev *dev, int qid)
@@ -404,7 +424,7 @@ static void nvme_end_io_acct(struct bio *bio, unsigned long start_time)
 	part_stat_unlock();
 }
 
-static void bio_completion(struct nvme_queue *nvmeq, void *ctx,
+static bool bio_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
 	struct nvme_iod *iod = ctx;
@@ -420,7 +440,7 @@ static void bio_completion(struct nvme_queue *nvmeq, void *ctx,
 							&nvmeq->sq_cong_wait);
 			list_add_tail(&iod->node, &nvmeq->iod_bio);
 			wake_up(&nvmeq->sq_full);
-			return;
+			return true;
 		}
 	}
 	if (iod->nents) {
@@ -433,6 +453,7 @@ static void bio_completion(struct nvme_queue *nvmeq, void *ctx,
 		bio_endio(bio, -EIO);
 	else
 		bio_endio(bio, 0);
+	return true;
 }
 
 /* length is in bytes.  gfp flags indicates whether we may sleep. */
@@ -764,7 +785,8 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 		}
 
 		ctx = free_cmdid(nvmeq, cqe.command_id, &fn);
-		fn(nvmeq, ctx, &cqe);
+		if (fn(nvmeq, ctx, &cqe))
+			clear_bit(cqe.command_id, nvmeq->cmdid_data);
 	}
 
 	/* If the controller ignores the cq head doorbell and continuously
@@ -844,13 +866,14 @@ struct sync_cmd_info {
 	int status;
 };
 
-static void sync_completion(struct nvme_queue *nvmeq, void *ctx,
+static bool sync_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
 	struct sync_cmd_info *cmdinfo = ctx;
 	cmdinfo->result = le32_to_cpup(&cqe->result);
 	cmdinfo->status = le16_to_cpup(&cqe->status) >> 1;
 	wake_up_process(cmdinfo->task);
+	return true;
 }
 
 /*
@@ -1049,6 +1072,37 @@ int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
 	return nvme_submit_admin_cmd(dev, &c, result);
 }
 
+static void abort_cmdid(struct nvme_queue *nvmeq, u16 cmdid)
+{
+	void *ctx;
+	nvme_completion_fn fn;
+	static struct nvme_completion cqe = {
+		.status = cpu_to_le16(NVME_SC_ABORT_REQ << 1),
+	};
+
+	ctx = cancel_cmdid(nvmeq, cmdid, &fn);
+	if (fn(nvmeq, ctx, &cqe))
+		clear_bit(cmdid, nvmeq->cmdid_data);
+}
+
+static bool abort_completion(struct nvme_queue *adminq, void *ctx,
+						struct nvme_completion *cqe)
+{
+	struct nvme_dev *dev = adminq->dev;
+	unsigned qid = (unsigned long)ctx >> 16;
+	int cmdid = (unsigned long)ctx & 0xffff;
+
+	struct nvme_queue *ioq = lock_nvmeq(dev, qid);
+	if ((cqe->result & 1) || is_aborted_and_completed(ioq, cmdid)) {
+		free_cmdid(ioq, cmdid, NULL);
+	} else {
+		cancel_cmdid(ioq, cmdid, NULL);
+	}
+	unlock_nvmeq(ioq);
+	++dev->abort_limit;
+	return true;
+}
+
 /**
  * nvme_abort_cmd - Attempt aborting a command
  * @cmdid: Command id of a timed out IO
@@ -1062,16 +1116,15 @@ static void nvme_abort_cmd(int cmdid, struct nvme_queue *nvmeq)
 	int a_cmdid;
 	struct nvme_command cmd;
 	struct nvme_dev *dev = nvmeq->dev;
-	struct nvme_cmd_info *info = nvme_cmd_info(nvmeq);
 	struct nvme_queue *adminq;
+	void *ctx;
 
-	if (!nvmeq->qid || info[cmdid].aborted) {
+	if (nvmeq->qid == 0) {
 		if (work_busy(&dev->reset_work))
 			return;
 		list_del_init(&dev->node);
 		dev_warn(&dev->pci_dev->dev,
-			"I/O %d QID %d timeout, reset controller\n", cmdid,
-								nvmeq->qid);
+			"Admin command %d timeout, reset controller\n", cmdid);
 		dev->reset_workfn = nvme_reset_failed_dev;
 		queue_work(nvme_workq, &dev->reset_work);
 		return;
@@ -1079,10 +1132,13 @@ static void nvme_abort_cmd(int cmdid, struct nvme_queue *nvmeq)
 
 	if (!dev->abort_limit)
 		return;
+	/* No point aborting an already-aborted command */
+	if (was_abort_sent(nvmeq, cmdid))
+		return;
 
+	ctx = (void *)(((unsigned long)nvmeq->qid << 16) | cmdid);
 	adminq = rcu_dereference(dev->queues[0]);
-	a_cmdid = alloc_cmdid(adminq, CMD_CTX_ABORT, special_completion,
-								ADMIN_TIMEOUT);
+	a_cmdid = alloc_cmdid(adminq, ctx, abort_completion, ADMIN_TIMEOUT);
 	if (a_cmdid < 0)
 		return;
 
@@ -1093,9 +1149,6 @@ static void nvme_abort_cmd(int cmdid, struct nvme_queue *nvmeq)
 	cmd.abort.command_id = a_cmdid;
 
 	--dev->abort_limit;
-	info[cmdid].aborted = 1;
-	info[cmdid].timeout = jiffies + ADMIN_TIMEOUT;
-
 	dev_warn(nvmeq->q_dmadev, "Aborting I/O %d QID %d\n", cmdid,
 							nvmeq->qid);
 	nvme_submit_cmd(adminq, &cmd);
@@ -1114,24 +1167,14 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 	int cmdid;
 
 	for_each_set_bit(cmdid, nvmeq->cmdid_data, depth) {
-		void *ctx;
-		nvme_completion_fn fn;
-		static struct nvme_completion cqe = {
-			.status = cpu_to_le16(NVME_SC_ABORT_REQ << 1),
-		};
-
 		if (timeout && !time_after(now, info[cmdid].timeout))
 			continue;
-		if (info[cmdid].ctx == CMD_CTX_CANCELLED)
-			continue;
-		if (timeout && nvmeq->dev->initialized) {
+		if (timeout && nvmeq->dev->initialized)
 			nvme_abort_cmd(cmdid, nvmeq);
-			continue;
-		}
-		dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d QID %d\n", cmdid,
-								nvmeq->qid);
-		ctx = cancel_cmdid(nvmeq, cmdid, &fn);
-		fn(nvmeq, ctx, &cqe);
+		else
+			dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d QID %d\n",
+							cmdid, nvmeq->qid);
+		abort_cmdid(nvmeq, cmdid);
 	}
 }
 
-- 
1.9.1
