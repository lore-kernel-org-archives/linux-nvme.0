From: keith.busch@intel.com (Keith Busch)
Date: Tue, 29 Aug 2017 17:46:03 -0400
Subject: [PATCHv2 3/4] nvme: Make nvme user functions static
In-Reply-To: <1504043164-5398-1-git-send-email-keith.busch@intel.com>
References: <1504043164-5398-1-git-send-email-keith.busch@intel.com>
Message-ID: <1504043164-5398-4-git-send-email-keith.busch@intel.com>

These functions are used only locally in the nvme core.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 10 +++++-----
 drivers/nvme/host/nvme.h |  7 -------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a28f181..4106e09 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -738,10 +738,10 @@ static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 	return ERR_PTR(ret);
 }
 
-int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
-		void __user *ubuffer, unsigned bufflen,
-		void __user *meta_buffer, unsigned meta_len, u32 meta_seed,
-		u32 *result, unsigned timeout)
+static int __nvme_submit_user_cmd(struct request_queue *q,
+		struct nvme_command *cmd, void __user *ubuffer,
+		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
+		u32 meta_seed, u32 *result, unsigned timeout)
 {
 	bool write = nvme_is_write(cmd);
 	struct nvme_ns *ns = q->queuedata;
@@ -794,7 +794,7 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 	return ret;
 }
 
-int nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
+static int nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void __user *ubuffer, unsigned bufflen, u32 *result,
 		unsigned timeout)
 {
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
