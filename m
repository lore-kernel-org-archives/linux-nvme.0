From: hch@lst.de (Christoph Hellwig)
Date: Mon, 14 May 2018 09:56:38 +0200
Subject: [PATCH 03/11] nvme: add support for the log specific field
In-Reply-To: <20180514075646.28823-1-hch@lst.de>
References: <20180514075646.28823-1-hch@lst.de>
Message-ID: <20180514075646.28823-4-hch@lst.de>

NVMe 1.3 added a new log specific field to the get log page CQ
defintion.  Add the field and support passing it to nvme_get_log_ext.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c     | 6 +++---
 drivers/nvme/host/lightnvm.c | 2 +-
 drivers/nvme/host/nvme.h     | 2 +-
 include/linux/nvme.h         | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0308d5ac7bde..b4d55d2455ad 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2226,8 +2226,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 }
 
 int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-		     u8 log_page, void *log,
-		     size_t size, u64 offset)
+		u8 log_page, u8 lsp, void *log, size_t size, u64 offset)
 {
 	struct nvme_command c = { };
 	unsigned long dwlen = size / 4 - 1;
@@ -2240,6 +2239,7 @@ int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		c.get_log_page.nsid = cpu_to_le32(NVME_NSID_ALL);
 
 	c.get_log_page.lid = log_page;
+	c.get_log_page.lsp = lsp;
 	c.get_log_page.numdl = cpu_to_le16(dwlen & ((1 << 16) - 1));
 	c.get_log_page.numdu = cpu_to_le16(dwlen >> 16);
 	c.get_log_page.lpol = cpu_to_le32(lower_32_bits(offset));
@@ -2251,7 +2251,7 @@ int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 static int nvme_get_log(struct nvme_ctrl *ctrl, u8 log_page, void *log,
 			size_t size)
 {
-	return nvme_get_log_ext(ctrl, NULL, log_page, log, size, 0);
+	return nvme_get_log_ext(ctrl, NULL, log_page, 0, log, size, 0);
 }
 
 static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 41279da799ed..216c6b0a9554 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -598,7 +598,7 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	while (left) {
 		len = min_t(unsigned int, left, ctrl->max_hw_sectors << 9);
 
-		ret = nvme_get_log_ext(ctrl, ns, NVME_NVM_LOG_REPORT_CHUNK,
+		ret = nvme_get_log_ext(ctrl, ns, NVME_NVM_LOG_REPORT_CHUNK, 0,
 				dev_meta, len, offset);
 		if (ret) {
 			dev_err(ctrl->device, "Get REPORT CHUNK log error\n");
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7ded7a51c430..0e48ad5eb159 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -430,7 +430,7 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 
 int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-		u8 log_page, void *log, size_t size, u64 offset);
+		u8 log_page, u8 lsp, void *log, size_t size, u64 offset);
 
 extern const struct attribute_group nvme_ns_id_attr_group;
 extern const struct block_device_operations nvme_ns_head_ops;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 3aa9996fcb3b..3dd3cd6d0564 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -908,7 +908,7 @@ struct nvme_get_log_page_command {
 	__u64			rsvd2[2];
 	union nvme_data_ptr	dptr;
 	__u8			lid;
-	__u8			rsvd10;
+	__u8			lsp; /* upper 4 bits reserved */
 	__le16			numdl;
 	__le16			numdu;
 	__u16			rsvd11;
-- 
2.17.0
