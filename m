From: indraneel.m@samsung.com (Indraneel Mukherjee)
Date: Wed, 28 May 2014 18:28:23 +0530
Subject: [PATCH] Fix log page buffer size passed in GetLogPage(CDW10.NUMD).
Message-ID: <1401281903-25143-1-git-send-email-indraneel.m@samsung.com>


diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index da3b252..0d9805b 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -1014,8 +1014,8 @@ static int nvme_trans_log_info_exceptions(struct nvme_ns *ns,
 	c.common.opcode = nvme_admin_get_log_page;
 	c.common.nsid = cpu_to_le32(0xFFFFFFFF);
 	c.common.prp1 = cpu_to_le64(dma_addr);
-	c.common.cdw10[0] = cpu_to_le32(((sizeof(struct nvme_smart_log) /
-			BYTES_TO_DWORDS) << 16) | NVME_GET_SMART_LOG_PAGE);
+	c.common.cdw10[0] = cpu_to_le32((((sizeof(struct nvme_smart_log) /
+			BYTES_TO_DWORDS)-1) << 16) | NVME_GET_SMART_LOG_PAGE);
 	res = nvme_submit_admin_cmd(dev, &c, NULL);
 	if (res != NVME_SC_SUCCESS) {
 		temp_c = LOG_TEMP_UNKNOWN;
@@ -1082,8 +1082,8 @@ static int nvme_trans_log_temperature(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	c.common.opcode = nvme_admin_get_log_page;
 	c.common.nsid = cpu_to_le32(0xFFFFFFFF);
 	c.common.prp1 = cpu_to_le64(dma_addr);
-	c.common.cdw10[0] = cpu_to_le32(((sizeof(struct nvme_smart_log) /
-			BYTES_TO_DWORDS) << 16) | NVME_GET_SMART_LOG_PAGE);
+	c.common.cdw10[0] = cpu_to_le32((((sizeof(struct nvme_smart_log) /
+			BYTES_TO_DWORDS)-1) << 16) | NVME_GET_SMART_LOG_PAGE);
 	res = nvme_submit_admin_cmd(dev, &c, NULL);
 	if (res != NVME_SC_SUCCESS) {
 		temp_c_cur = LOG_TEMP_UNKNOWN;
-- 
1.8.3.2
