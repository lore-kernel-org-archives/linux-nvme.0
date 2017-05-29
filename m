From: a.dawn@samsung.com (Arnav Dawn)
Date: Mon, 29 May 2017 19:47:38 +0530
Subject: [PATCH v2 1/2] nvme: Adding support for FW Slot info log
In-Reply-To: <1496067391-26143-1-git-send-email-a.dawn@samsung.com>
References: <1496067391-26143-1-git-send-email-a.dawn@samsung.com>
 <CGME20170529141731epcas5p39667840c01555c7cf49527167535f82c@epcas5p3.samsung.com>
Message-ID: <1496067458-26190-1-git-send-email-a.dawn@samsung.com>

This adds support for FW slot info log to nvme_get_log_page.
The nvme_get_log_page takes log type as parameter. This will also
be used to clear FW slot info log for Fw activation AER.

Signed-off-by: Arnav Dawn <a.dawn at samsung.com>
---
 drivers/nvme/host/core.c | 38 +++++++++++++++++++++++---------------
 drivers/nvme/host/nvme.h |  2 +-
 drivers/nvme/host/scsi.c | 26 ++++++++++++++++++++------
 include/linux/nvme.h     |  7 +++++++
 4 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a609264..01d622e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -713,26 +713,34 @@ int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 	return ret;
 }
 
-int nvme_get_log_page(struct nvme_ctrl *dev, struct nvme_smart_log **log)
+int nvme_get_log_page(struct nvme_ctrl *dev, int log_type, void *log)
 {
 	struct nvme_command c = { };
-	int error;
+	int log_size;
 
-	c.common.opcode = nvme_admin_get_log_page,
-	c.common.nsid = cpu_to_le32(0xFFFFFFFF),
-	c.common.cdw10[0] = cpu_to_le32(
-			(((sizeof(struct nvme_smart_log) / 4) - 1) << 16) |
-			 NVME_LOG_SMART),
+	if (!log)
+		return -EINVAL;
 
-	*log = kmalloc(sizeof(struct nvme_smart_log), GFP_KERNEL);
-	if (!*log)
-		return -ENOMEM;
+	c.common.opcode = nvme_admin_get_log_page;
 
-	error = nvme_submit_sync_cmd(dev->admin_q, &c, *log,
-			sizeof(struct nvme_smart_log));
-	if (error)
-		kfree(*log);
-	return error;
+	switch (log_type) {
+	case NVME_LOG_SMART:
+		log_size = sizeof(struct nvme_smart_log);
+		c.common.nsid = cpu_to_le32(0xFFFFFFFF);
+		c.common.cdw10[0] = cpu_to_le32(
+			(((log_size / 4) - 1) << 16) | NVME_LOG_SMART);
+		break;
+	case NVME_LOG_FW_SLOT:
+		log_size = sizeof(struct nvme_fw_slot_info_log);
+		c.common.nsid = cpu_to_le32(0xFFFFFFFF);
+		c.common.cdw10[0] = cpu_to_le32(
+			(((log_size / 4) - 1) << 16) | NVME_LOG_FW_SLOT);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return nvme_submit_sync_cmd(dev->admin_q, &c, log, log_size);
 }
 
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9d6a070..e78143a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -313,7 +313,7 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id);
 int nvme_identify_ns(struct nvme_ctrl *dev, unsigned nsid,
 		struct nvme_id_ns **id);
-int nvme_get_log_page(struct nvme_ctrl *dev, struct nvme_smart_log **log);
+int nvme_get_log_page(struct nvme_ctrl *dev, int log_type, void *log);
 int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned nsid,
 		      void *buffer, size_t buflen, u32 *result);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index 1f7671e..8118677 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -846,9 +846,15 @@ static int nvme_trans_log_info_exceptions(struct nvme_ns *ns,
 	if (log_response == NULL)
 		return -ENOMEM;
 
-	res = nvme_get_log_page(ns->ctrl, &smart_log);
-	if (res < 0)
+	smart_log = kmalloc(sizeof(struct nvme_smart_log), GFP_KERNEL);
+	if (smart_log == NULL) {
+		res = -ENOMEM;
 		goto out_free_response;
+	}
+
+	res = nvme_get_log_page(ns->ctrl, NVME_LOG_SMART, smart_log);
+	if (res < 0)
+		goto out_free_log;
 
 	if (res != NVME_SC_SUCCESS) {
 		temp_c = LOG_TEMP_UNKNOWN;
@@ -857,7 +863,6 @@ static int nvme_trans_log_info_exceptions(struct nvme_ns *ns,
 				(smart_log->temperature[0]);
 		temp_c = temp_k - KELVIN_TEMP_FACTOR;
 	}
-	kfree(smart_log);
 
 	log_response[0] = LOG_PAGE_INFORMATIONAL_EXCEPTIONS_PAGE;
 	/* Subpage=0x00, Page Length MSB=0 */
@@ -873,6 +878,8 @@ static int nvme_trans_log_info_exceptions(struct nvme_ns *ns,
 	xfer_len = min(alloc_len, LOG_INFO_EXCP_PAGE_LENGTH);
 	res = nvme_trans_copy_to_user(hdr, log_response, xfer_len);
 
+ out_free_log:
+	kfree(smart_log);
  out_free_response:
 	kfree(log_response);
 	return res;
@@ -893,9 +900,15 @@ static int nvme_trans_log_temperature(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	if (log_response == NULL)
 		return -ENOMEM;
 
-	res = nvme_get_log_page(ns->ctrl, &smart_log);
-	if (res < 0)
+	smart_log = kmalloc(sizeof(struct nvme_smart_log), GFP_KERNEL);
+	if (smart_log == NULL) {
+		res = -ENOMEM;
 		goto out_free_response;
+	}
+
+	res = nvme_get_log_page(ns->ctrl, NVME_LOG_SMART, smart_log);
+	if (res < 0)
+		goto out_free_log;
 
 	if (res != NVME_SC_SUCCESS) {
 		temp_c_cur = LOG_TEMP_UNKNOWN;
@@ -904,7 +917,6 @@ static int nvme_trans_log_temperature(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 				(smart_log->temperature[0]);
 		temp_c_cur = temp_k - KELVIN_TEMP_FACTOR;
 	}
-	kfree(smart_log);
 
 	/* Get Features for Temp Threshold */
 	res = nvme_get_features(ns->ctrl, NVME_FEAT_TEMP_THRESH, 0, NULL, 0,
@@ -933,6 +945,8 @@ static int nvme_trans_log_temperature(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	xfer_len = min(alloc_len, LOG_TEMP_PAGE_LENGTH);
 	res = nvme_trans_copy_to_user(hdr, log_response, xfer_len);
 
+ out_free_log:
+	kfree(smart_log);
  out_free_response:
 	kfree(log_response);
 	return res;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b625bac..282fc69 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -337,6 +337,13 @@ struct nvme_smart_log {
 	__u8			rsvd216[296];
 };
 
+struct nvme_fw_slot_info_log {
+	__u8			afi;
+	__u8			rsvd1[7];
+	__le64			frs[7];
+	__u8			rsvd64[448];
+};
+
 enum {
 	NVME_SMART_CRIT_SPARE		= 1 << 0,
 	NVME_SMART_CRIT_TEMPERATURE	= 1 << 1,
-- 
1.9.1
