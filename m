From: keith.busch@intel.com (Keith Busch)
Date: Mon, 28 Aug 2017 18:03:00 -0400
Subject: [PATCH] nvme: Use metadata for passthrough commands
Message-ID: <1503957780-12905-1-git-send-email-keith.busch@intel.com>

The ioctls' struct allows the user to provide a metadata address and
length for a passthrough command. This patch uses these values that were
previously ignored and deletes the now unused wrapper function.

Note the implementation currently requires a gendisk so will not work
for admin commands.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 21 +++++++--------------
 drivers/nvme/host/nvme.h |  7 -------
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0f3d4bf..df282e4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -704,10 +704,10 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
-int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
-		void __user *ubuffer, unsigned bufflen,
-		void __user *meta_buffer, unsigned meta_len, u32 meta_seed,
-		u32 *result, unsigned timeout)
+static int nvme_submit_user_cmd(struct request_queue *q,
+		struct nvme_command *cmd, void __user *ubuffer,
+		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
+		u32 meta_seed, u32 *result, unsigned timeout)
 {
 	bool write = nvme_is_write(cmd);
 	struct nvme_ns *ns = q->queuedata;
@@ -790,14 +790,6 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 	return ret;
 }
 
-int nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
-		void __user *ubuffer, unsigned bufflen, u32 *result,
-		unsigned timeout)
-{
-	return __nvme_submit_user_cmd(q, cmd, ubuffer, bufflen, NULL, 0, 0,
-			result, timeout);
-}
-
 static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 {
 	struct nvme_ctrl *ctrl = rq->end_io_data;
@@ -1087,7 +1079,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	c.rw.apptag = cpu_to_le16(io.apptag);
 	c.rw.appmask = cpu_to_le16(io.appmask);
 
-	return __nvme_submit_user_cmd(ns->queue, &c,
+	return nvme_submit_user_cmd(ns->queue, &c,
 			(void __user *)(uintptr_t)io.addr, length,
 			metadata, meta_len, io.slba, NULL, 0);
 }
@@ -1125,7 +1117,8 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
-			&cmd.result, timeout);
+			(void __user *)(uintptr_t)cmd.metadata, cmd.metadata,
+			0, &cmd.result, timeout);
 	if (status >= 0) {
 		if (put_user(cmd.result, &ucmd->result))
 			return -EFAULT;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1fc35de..194b4c8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -342,13 +342,6 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		unsigned timeout, int qid, int at_head, int flags);
-int nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
-		void __user *ubuffer, unsigned bufflen, u32 *result,
-		unsigned timeout);
-int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
-		void __user *ubuffer, unsigned bufflen,
-		void __user *meta_buffer, unsigned meta_len, u32 meta_seed,
-		u32 *result, unsigned timeout);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 void nvme_start_keep_alive(struct nvme_ctrl *ctrl);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
-- 
2.5.5
