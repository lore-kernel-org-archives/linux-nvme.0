From: a.dawn@samsung.com (Arnav Dawn)
Date: Sat, 10 Jun 2017 12:36:29 +0530
Subject: [PATCH V3 1/2] nvme: Rename and move get_log_page to nvme/scsi
In-Reply-To: <1497078344-5509-1-git-send-email-a.dawn@samsung.com>
References: <1497078344-5509-1-git-send-email-a.dawn@samsung.com>
 <CGME20170610070633epcas1p13f5f65526689a9891c91379b17e195d2@epcas1p1.samsung.com>
Message-ID: <1497078389-5582-1-git-send-email-a.dawn@samsung.com>

This patch renames "nvme_get_log_page" to more appropriate
"nvme_get_smart_log_page" and moves it to nvme/scsi as
it is only being used there.

Signed-off-by: Arnav Dawn <a.dawn at samsung.com>
---
 drivers/nvme/host/core.c | 22 ----------------------
 drivers/nvme/host/nvme.h |  1 -
 drivers/nvme/host/scsi.c | 27 +++++++++++++++++++++++++--
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4e193b9..9591c47 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -706,28 +706,6 @@ int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 	return ret;
 }
 
-int nvme_get_log_page(struct nvme_ctrl *dev, struct nvme_smart_log **log)
-{
-	struct nvme_command c = { };
-	int error;
-
-	c.common.opcode = nvme_admin_get_log_page,
-	c.common.nsid = cpu_to_le32(0xFFFFFFFF),
-	c.common.cdw10[0] = cpu_to_le32(
-			(((sizeof(struct nvme_smart_log) / 4) - 1) << 16) |
-			 NVME_LOG_SMART),
-
-	*log = kmalloc(sizeof(struct nvme_smart_log), GFP_KERNEL);
-	if (!*log)
-		return -ENOMEM;
-
-	error = nvme_submit_sync_cmd(dev->admin_q, &c, *log,
-			sizeof(struct nvme_smart_log));
-	if (error)
-		kfree(*log);
-	return error;
-}
-
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 {
 	u32 q_count = (*count - 1) | ((*count - 1) << 16);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 22ee60b..ccea410 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -313,7 +313,6 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id);
 int nvme_identify_ns(struct nvme_ctrl *dev, unsigned nsid,
 		struct nvme_id_ns **id);
-int nvme_get_log_page(struct nvme_ctrl *dev, struct nvme_smart_log **log);
 int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned nsid,
 		      void *buffer, size_t buflen, u32 *result);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index 1f7671e..50873bb8 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -832,6 +832,29 @@ static int nvme_trans_log_supp_pages(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	return res;
 }
 
+static int nvme_get_smart_log_page(struct nvme_ctrl *dev,
+					struct nvme_smart_log **log)
+{
+	struct nvme_command c = { };
+	int error;
+
+	c.common.opcode = nvme_admin_get_log_page,
+	c.common.nsid = cpu_to_le32(0xFFFFFFFF),
+	c.common.cdw10[0] = cpu_to_le32(
+			(((sizeof(struct nvme_smart_log) / 4) - 1) << 16) |
+			 NVME_LOG_SMART),
+
+	*log = kmalloc(sizeof(struct nvme_smart_log), GFP_KERNEL);
+	if (!*log)
+		return -ENOMEM;
+
+	error = nvme_submit_sync_cmd(dev->admin_q, &c, *log,
+			sizeof(struct nvme_smart_log));
+	if (error)
+		kfree(*log);
+	return error;
+}
+
 static int nvme_trans_log_info_exceptions(struct nvme_ns *ns,
 					struct sg_io_hdr *hdr, int alloc_len)
 {
@@ -846,7 +869,7 @@ static int nvme_trans_log_info_exceptions(struct nvme_ns *ns,
 	if (log_response == NULL)
 		return -ENOMEM;
 
-	res = nvme_get_log_page(ns->ctrl, &smart_log);
+	res = nvme_get_smart_log_page(ns->ctrl, &smart_log);
 	if (res < 0)
 		goto out_free_response;
 
@@ -893,7 +916,7 @@ static int nvme_trans_log_temperature(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	if (log_response == NULL)
 		return -ENOMEM;
 
-	res = nvme_get_log_page(ns->ctrl, &smart_log);
+	res = nvme_get_smart_log_page(ns->ctrl, &smart_log);
 	if (res < 0)
 		goto out_free_response;
 
-- 
1.9.1
