From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Fri, 14 Jun 2019 00:20:36 +0900
Subject: [PATCH v4 1/3] nvme: Export get and set features
In-Reply-To: <1560439238-4054-1-git-send-email-akinobu.mita@gmail.com>
References: <1560439238-4054-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1560439238-4054-2-git-send-email-akinobu.mita@gmail.com>

From: Keith Busch <keith.busch@intel.com>

Future use intends to make use of both, so export these functions. And
since their implementation is identical except for the opcode, provide a
new function that implement both.

[akinobu.mita at gmail.com>: fix line over 80 characters]
Signed-off-by: Keith Busch <keith.busch at intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/core.c | 24 +++++++++++++++++++++---
 drivers/nvme/host/nvme.h |  6 ++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 120fb59..7e3c786 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1113,15 +1113,15 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
 	return id;
 }
 
-static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
-		      void *buffer, size_t buflen, u32 *result)
+static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
+		unsigned int dword11, void *buffer, size_t buflen, u32 *result)
 {
 	struct nvme_command c;
 	union nvme_result res;
 	int ret;
 
 	memset(&c, 0, sizeof(c));
-	c.features.opcode = nvme_admin_set_features;
+	c.features.opcode = op;
 	c.features.fid = cpu_to_le32(fid);
 	c.features.dword11 = cpu_to_le32(dword11);
 
@@ -1132,6 +1132,24 @@ static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword
 	return ret;
 }
 
+int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
+		      unsigned int dword11, void *buffer, size_t buflen,
+		      u32 *result)
+{
+	return nvme_features(dev, nvme_admin_set_features, fid, dword11, buffer,
+			     buflen, result);
+}
+EXPORT_SYMBOL_GPL(nvme_set_features);
+
+int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
+		      unsigned int dword11, void *buffer, size_t buflen,
+		      u32 *result)
+{
+	return nvme_features(dev, nvme_admin_get_features, fid, dword11, buffer,
+			     buflen, result);
+}
+EXPORT_SYMBOL_GPL(nvme_get_features);
+
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 {
 	u32 q_count = (*count - 1) | ((*count - 1) << 16);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 55553d2..038b893 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -459,6 +459,12 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		unsigned timeout, int qid, int at_head,
 		blk_mq_req_flags_t flags, bool poll);
+int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
+		      unsigned int dword11, void *buffer, size_t buflen,
+		      u32 *result);
+int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
+		      unsigned int dword11, void *buffer, size_t buflen,
+		      u32 *result);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
-- 
2.7.4
