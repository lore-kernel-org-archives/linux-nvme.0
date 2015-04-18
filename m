From: hch@lst.de (Christoph Hellwig)
Date: Sat, 18 Apr 2015 22:27:37 +0200
Subject: [PATCH 1/8] nvme: remove the unused dma_addr_t arguments to nvme_{get,
 set}_features
In-Reply-To: <1429388864-29648-1-git-send-email-hch@lst.de>
References: <1429388864-29648-1-git-send-email-hch@lst.de>
Message-ID: <1429388864-29648-2-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-core.c | 9 +++------
 drivers/block/nvme-scsi.c | 9 ++++-----
 include/linux/nvme.h      | 4 ++--
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 5187dc5..6f7c343 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1143,27 +1143,25 @@ int nvme_identify(struct nvme_dev *dev, unsigned nsid, unsigned cns,
 }
 
 int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
-					dma_addr_t dma_addr, u32 *result)
+		u32 *result)
 {
 	struct nvme_command c;
 
 	memset(&c, 0, sizeof(c));
 	c.features.opcode = nvme_admin_get_features;
 	c.features.nsid = cpu_to_le32(nsid);
-	c.features.prp1 = cpu_to_le64(dma_addr);
 	c.features.fid = cpu_to_le32(fid);
 
 	return __nvme_submit_sync_cmd(dev->admin_q, &c, result, 0);
 }
 
 int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
-					dma_addr_t dma_addr, u32 *result)
+		u32 *result)
 {
 	struct nvme_command c;
 
 	memset(&c, 0, sizeof(c));
 	c.features.opcode = nvme_admin_set_features;
-	c.features.prp1 = cpu_to_le64(dma_addr);
 	c.features.fid = cpu_to_le32(fid);
 	c.features.dword11 = cpu_to_le32(dword11);
 
@@ -2147,8 +2145,7 @@ static int set_queue_count(struct nvme_dev *dev, int count)
 	u32 result;
 	u32 q_count = (count - 1) | ((count - 1) << 16);
 
-	status = nvme_set_features(dev, NVME_FEAT_NUM_QUEUES, q_count, 0,
-								&result);
+	status = nvme_set_features(dev, NVME_FEAT_NUM_QUEUES, q_count, &result);
 	if (status < 0)
 		return status;
 	if (status > 0) {
diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index f1c90f2..cc57ed5 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -1127,8 +1127,7 @@ static int nvme_trans_log_temperature(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	}
 
 	/* Get Features for Temp Threshold */
-	res = nvme_get_features(dev, NVME_FEAT_TEMP_THRESH, 0, 0,
-								&feature_resp);
+	res = nvme_get_features(dev, NVME_FEAT_TEMP_THRESH, 0, &feature_resp);
 	if (res != NVME_SC_SUCCESS)
 		temp_c_thresh = LOG_TEMP_UNKNOWN;
 	else
@@ -1281,7 +1280,7 @@ static int nvme_trans_fill_caching_page(struct nvme_ns *ns,
 	if (len < MODE_PAGE_CACHING_LEN)
 		return SNTI_INTERNAL_ERROR;
 
-	nvme_sc = nvme_get_features(dev, NVME_FEAT_VOLATILE_WC, 0, 0,
+	nvme_sc = nvme_get_features(dev, NVME_FEAT_VOLATILE_WC, 0,
 								&feature_resp);
 	res = nvme_trans_status_code(hdr, nvme_sc);
 	if (res)
@@ -1541,7 +1540,7 @@ static int nvme_trans_power_state(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 				SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
 		break;
 	}
-	nvme_sc = nvme_set_features(dev, NVME_FEAT_POWER_MGMT, ps_desired, 0,
+	nvme_sc = nvme_set_features(dev, NVME_FEAT_POWER_MGMT, ps_desired,
 				    NULL);
 	res = nvme_trans_status_code(hdr, nvme_sc);
 	if (res)
@@ -1686,7 +1685,7 @@ static int nvme_trans_modesel_get_mp(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	case MODE_PAGE_CACHING:
 		dword11 = ((mode_page[2] & CACHING_MODE_PAGE_WCE_MASK) ? 1 : 0);
 		nvme_sc = nvme_set_features(dev, NVME_FEAT_VOLATILE_WC, dword11,
-					    0, NULL);
+					    NULL);
 		res = nvme_trans_status_code(hdr, nvme_sc);
 		if (res)
 			break;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index de0e49a..d1ebed1 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -162,9 +162,9 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd);
 int nvme_identify(struct nvme_dev *, unsigned nsid, unsigned cns,
 							dma_addr_t dma_addr);
 int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
-			dma_addr_t dma_addr, u32 *result);
+			u32 *result);
 int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
-			dma_addr_t dma_addr, u32 *result);
+			u32 *result);
 
 struct sg_io_hdr;
 
-- 
1.9.1
