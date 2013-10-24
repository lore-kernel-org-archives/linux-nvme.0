From: keith.busch@intel.com (Keith Busch)
Date: Thu, 24 Oct 2013 11:53:53 -0600
Subject: [PATCHv2 2/2] NVMe: Abort timed out commands
In-Reply-To: <1382637233-26017-1-git-send-email-keith.busch@intel.com>
References: <1382637233-26017-1-git-send-email-keith.busch@intel.com>
Message-ID: <1382637233-26017-3-git-send-email-keith.busch@intel.com>

Send an abort request if the command times out. If the command times out
yet again, or if it is an admin command that is timed out, schedule the
controller to be reset. If the device hasn't been initialized, cancel
the command as before.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   63 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/nvme.h      |    1 +
 include/uapi/linux/nvme.h |   11 ++++++++
 3 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index a278d19..71a952e 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -81,6 +81,7 @@ struct nvme_queue {
 	u16 sq_head;
 	u16 sq_tail;
 	u16 cq_head;
+	u16 qid;
 	u8 cq_phase;
 	u8 cqe_seen;
 	u8 q_suspended;
@@ -98,6 +99,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_delete_queue) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_features) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != 4096);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != 4096);
@@ -112,6 +114,7 @@ struct nvme_cmd_info {
 	nvme_completion_fn fn;
 	void *ctx;
 	unsigned long timeout;
+	int aborted;
 };
 
 static struct nvme_cmd_info *nvme_cmd_info(struct nvme_queue *nvmeq)
@@ -173,6 +176,7 @@ static int alloc_cmdid_killable(struct nvme_queue *nvmeq, void *ctx,
 #define CMD_CTX_COMPLETED	(0x310 + CMD_CTX_BASE)
 #define CMD_CTX_INVALID		(0x314 + CMD_CTX_BASE)
 #define CMD_CTX_FLUSH		(0x318 + CMD_CTX_BASE)
+#define CMD_CTX_ABORT		(0x31C + CMD_CTX_BASE)
 
 static void special_completion(struct nvme_dev *dev, void *ctx,
 						struct nvme_completion *cqe)
@@ -181,6 +185,10 @@ static void special_completion(struct nvme_dev *dev, void *ctx,
 		return;
 	if (ctx == CMD_CTX_FLUSH)
 		return;
+	if (ctx == CMD_CTX_ABORT) {
+		++dev->abort_limit;
+		return;
+	}
 	if (ctx == CMD_CTX_COMPLETED) {
 		dev_warn(&dev->pci_dev->dev,
 				"completed id %d twice on queue %d\n",
@@ -1003,6 +1011,53 @@ int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
 }
 
 /**
+ * nvme_abort_cmd - Attempt aborting a command
+ * @cmdid: Command id of a timed out IO
+ * @queue: The queue with timed out IO
+ *
+ * Schedule controller reset if the command was already aborted once before and
+ * still hasn't been returned to the driver, or if this is the admin queue.
+ */
+static void nvme_abort_cmd(int cmdid, struct nvme_queue *nvmeq)
+{
+	int a_cmdid;
+	struct nvme_command cmd;
+	struct nvme_dev *dev = nvmeq->dev;
+	struct nvme_cmd_info *info = nvme_cmd_info(nvmeq);
+
+	if (!nvmeq->qid || info[cmdid].aborted) {
+		dev_warn(&dev->pci_dev->dev,
+			"I/O %d QID %d timeout, reset controller\n", cmdid,
+								nvmeq->qid);
+		list_del_init(&dev->node);
+		queue_work(nvme_workq, &dev->ws);
+		return;
+	}
+
+	if (!dev->abort_limit)
+		return;
+
+	a_cmdid = alloc_cmdid(dev->queues[0], CMD_CTX_ABORT, special_completion,
+								ADMIN_TIMEOUT);
+	if (a_cmdid < 0)
+		return;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.abort.opcode = nvme_admin_abort_cmd;
+	cmd.abort.cid = cmdid;
+	cmd.abort.sqid = nvmeq->qid;
+	cmd.abort.command_id = a_cmdid;
+
+	--dev->abort_limit;
+	info[cmdid].aborted = 1;
+	info[cmdid].timeout = jiffies + ADMIN_TIMEOUT;
+
+	dev_warn(nvmeq->q_dmadev, "Aborting I/O %d QID %d\n", cmdid,
+							nvmeq->qid);
+	nvme_submit_cmd(dev->queues[0], &cmd);
+}
+
+/**
  * nvme_cancel_ios - Cancel outstanding I/Os
  * @queue: The queue to cancel I/Os on
  * @timeout: True to only cancel I/Os which have timed out
@@ -1025,7 +1080,12 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 			continue;
 		if (info[cmdid].ctx == CMD_CTX_CANCELLED)
 			continue;
-		dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d\n", cmdid);
+		if (timeout && nvmeq->dev->is_initialised) {
+			nvme_abort_cmd(cmdid, nvmeq);
+			continue;
+		}
+		dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d QID %d\n", cmdid,
+								nvmeq->qid);
 		ctx = cancel_cmdid(nvmeq, cmdid, &fn);
 		fn(nvmeq->dev, ctx, &cqe);
 	}
@@ -1117,6 +1177,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	nvmeq->q_db = &dev->dbs[qid << (dev->db_stride + 1)];
 	nvmeq->q_depth = depth;
 	nvmeq->cq_vector = vector;
+	nvmeq->qid = qid;
 	nvmeq->q_suspended = 1;
 	dev->queue_count++;
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index fe5421b..4306c5e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -96,6 +96,7 @@ struct nvme_dev {
 	u32 max_hw_sectors;
 	u32 stripe_size;
 	u16 oncs;
+	u16 abort_limit;
 };
 
 /*
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index 989c04e..f009c15 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -350,6 +350,16 @@ struct nvme_delete_queue {
 	__u32			rsvd11[5];
 };
 
+struct nvme_abort_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__u32			rsvd1[9];
+	__le16			sqid;
+	__le16			cid;
+	__u32			rsvd11[5];
+};
+
 struct nvme_download_firmware {
 	__u8			opcode;
 	__u8			flags;
@@ -384,6 +394,7 @@ struct nvme_command {
 		struct nvme_download_firmware dlfw;
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
+		struct nvme_abort_cmd abort;
 	};
 };
 
-- 
1.7.10.4
