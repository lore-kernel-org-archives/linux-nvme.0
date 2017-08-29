From: keith.busch@intel.com (Keith Busch)
Date: Tue, 29 Aug 2017 17:46:04 -0400
Subject: [PATCHv2 4/4] nvme: Use metadata for passthrough commands
In-Reply-To: <1504043164-5398-1-git-send-email-keith.busch@intel.com>
References: <1504043164-5398-1-git-send-email-keith.busch@intel.com>
Message-ID: <1504043164-5398-5-git-send-email-keith.busch@intel.com>

The ioctls' struct allows the user to provide a metadata address and
length for a passthrough command. This patch uses these values that were
previously ignored and deletes the now unused wrapper function.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4106e09..05d8545 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -738,7 +738,7 @@ static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 	return ERR_PTR(ret);
 }
 
-static int __nvme_submit_user_cmd(struct request_queue *q,
+static int nvme_submit_user_cmd(struct request_queue *q,
 		struct nvme_command *cmd, void __user *ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, u32 *result, unsigned timeout)
@@ -794,14 +794,6 @@ static int __nvme_submit_user_cmd(struct request_queue *q,
 	return ret;
 }
 
-static int nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
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
@@ -1091,7 +1083,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	c.rw.apptag = cpu_to_le16(io.apptag);
 	c.rw.appmask = cpu_to_le16(io.appmask);
 
-	return __nvme_submit_user_cmd(ns->queue, &c,
+	return nvme_submit_user_cmd(ns->queue, &c,
 			(void __user *)(uintptr_t)io.addr, length,
 			metadata, meta_len, io.slba, NULL, 0);
 }
@@ -1129,7 +1121,8 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
-			&cmd.result, timeout);
+			(void __user *)(uintptr_t)cmd.metadata, cmd.metadata,
+			0, &cmd.result, timeout);
 	if (status >= 0) {
 		if (put_user(cmd.result, &ucmd->result))
 			return -EFAULT;
-- 
2.5.5
