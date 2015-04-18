From: hch@lst.de (Christoph Hellwig)
Date: Sat, 18 Apr 2015 22:27:39 +0200
Subject: [PATCH 3/8] nvme: fix scsi translation error handling
In-Reply-To: <1429388864-29648-1-git-send-email-hch@lst.de>
References: <1429388864-29648-1-git-send-email-hch@lst.de>
Message-ID: <1429388864-29648-4-git-send-email-hch@lst.de>

Erorr handling for the scsi translation was completely broken, as there
were two different positive error number spaces overlapping.  Fix this
up by removing one of them, and centralizing the generation of the other
positive values in a single place.  Also fix up a few places that didn't
handle the NVMe error codes properly.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-scsi.c | 379 +++++++++++++++-------------------------------
 1 file changed, 126 insertions(+), 253 deletions(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index 07d5d71..5cac123 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -47,9 +47,6 @@
 
 static int sg_version_num = 30534;	/* 2 digits for each component */
 
-#define SNTI_TRANSLATION_SUCCESS			0
-#define SNTI_INTERNAL_ERROR				1
-
 /* VPD Page Codes */
 #define VPD_SUPPORTED_PAGES				0x00
 #define VPD_SERIAL_NUMBER				0x80
@@ -369,8 +366,6 @@ struct nvme_trans_io_cdb {
 static int nvme_trans_copy_to_user(struct sg_io_hdr *hdr, void *from,
 								unsigned long n)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
-	unsigned long not_copied;
 	int i;
 	void *index = from;
 	size_t remaining = n;
@@ -380,29 +375,25 @@ static int nvme_trans_copy_to_user(struct sg_io_hdr *hdr, void *from,
 		struct sg_iovec sgl;
 
 		for (i = 0; i < hdr->iovec_count; i++) {
-			not_copied = copy_from_user(&sgl, hdr->dxferp +
+			if (copy_from_user(&sgl, hdr->dxferp +
 						i * sizeof(struct sg_iovec),
-						sizeof(struct sg_iovec));
-			if (not_copied)
+						sizeof(struct sg_iovec)))
 				return -EFAULT;
 			xfer_len = min(remaining, sgl.iov_len);
-			not_copied = copy_to_user(sgl.iov_base, index,
-								xfer_len);
-			if (not_copied) {
-				res = -EFAULT;
-				break;
-			}
+			if (copy_to_user(sgl.iov_base, index, xfer_len))
+				return -EFAULT;
+
 			index += xfer_len;
 			remaining -= xfer_len;
 			if (remaining == 0)
 				break;
 		}
-		return res;
+		return 0;
 	}
-	not_copied = copy_to_user(hdr->dxferp, from, n);
-	if (not_copied)
-		res = -EFAULT;
-	return res;
+
+	if (copy_to_user(hdr->dxferp, from, n))
+		return -EFAULT;
+	return 0;
 }
 
 /* Copy data from userspace memory */
@@ -410,8 +401,6 @@ static int nvme_trans_copy_to_user(struct sg_io_hdr *hdr, void *from,
 static int nvme_trans_copy_from_user(struct sg_io_hdr *hdr, void *to,
 								unsigned long n)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
-	unsigned long not_copied;
 	int i;
 	void *index = to;
 	size_t remaining = n;
@@ -421,30 +410,24 @@ static int nvme_trans_copy_from_user(struct sg_io_hdr *hdr, void *to,
 		struct sg_iovec sgl;
 
 		for (i = 0; i < hdr->iovec_count; i++) {
-			not_copied = copy_from_user(&sgl, hdr->dxferp +
+			if (copy_from_user(&sgl, hdr->dxferp +
 						i * sizeof(struct sg_iovec),
-						sizeof(struct sg_iovec));
-			if (not_copied)
+						sizeof(struct sg_iovec)))
 				return -EFAULT;
 			xfer_len = min(remaining, sgl.iov_len);
-			not_copied = copy_from_user(index, sgl.iov_base,
-								xfer_len);
-			if (not_copied) {
-				res = -EFAULT;
-				break;
-			}
+			if (copy_from_user(index, sgl.iov_base, xfer_len))
+				return -EFAULT;
 			index += xfer_len;
 			remaining -= xfer_len;
 			if (remaining == 0)
 				break;
 		}
-		return res;
+		return 0;
 	}
 
-	not_copied = copy_from_user(to, hdr->dxferp, n);
-	if (not_copied)
-		res = -EFAULT;
-	return res;
+	if (copy_from_user(to, hdr->dxferp, n))
+		return -EFAULT;
+	return 0;
 }
 
 /* Status/Sense Buffer Writeback */
@@ -452,7 +435,6 @@ static int nvme_trans_copy_from_user(struct sg_io_hdr *hdr, void *to,
 static int nvme_trans_completion(struct sg_io_hdr *hdr, u8 status, u8 sense_key,
 				 u8 asc, u8 ascq)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
 	u8 xfer_len;
 	u8 resp[DESC_FMT_SENSE_DATA_SIZE];
 
@@ -477,25 +459,29 @@ static int nvme_trans_completion(struct sg_io_hdr *hdr, u8 status, u8 sense_key,
 		xfer_len = min_t(u8, hdr->mx_sb_len, DESC_FMT_SENSE_DATA_SIZE);
 		hdr->sb_len_wr = xfer_len;
 		if (copy_to_user(hdr->sbp, resp, xfer_len) > 0)
-			res = -EFAULT;
+			return -EFAULT;
 	}
 
-	return res;
+	return 0;
 }
 
+/*
+ * Take a status code from a lowlevel routine, and if it was a positive NVMe
+ * error code update the sense data based on it.  In either case the passed
+ * in value is returned again, unless an -EFAULT from copy_to_user overrides
+ * it.
+ */
 static int nvme_trans_status_code(struct sg_io_hdr *hdr, int nvme_sc)
 {
 	u8 status, sense_key, asc, ascq;
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 
 	/* For non-nvme (Linux) errors, simply return the error code */
 	if (nvme_sc < 0)
 		return nvme_sc;
 
 	/* Mask DNR, More, and reserved fields */
-	nvme_sc &= 0x7FF;
-
-	switch (nvme_sc) {
+	switch (nvme_sc & 0x7FF) {
 	/* Generic Command Status */
 	case NVME_SC_SUCCESS:
 		status = SAM_STAT_GOOD;
@@ -662,8 +648,7 @@ static int nvme_trans_status_code(struct sg_io_hdr *hdr, int nvme_sc)
 	}
 
 	res = nvme_trans_completion(hdr, status, sense_key, asc, ascq);
-
-	return res;
+	return res ? res : nvme_sc;
 }
 
 /* INQUIRY Helper Functions */
@@ -676,7 +661,7 @@ static int nvme_trans_standard_inquiry_page(struct nvme_ns *ns,
 	dma_addr_t dma_addr;
 	void *mem;
 	struct nvme_id_ns *id_ns;
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 	int nvme_sc;
 	int xfer_len;
 	u8 resp_data_format = 0x02;
@@ -694,19 +679,9 @@ static int nvme_trans_standard_inquiry_page(struct nvme_ns *ns,
 	/* nvme ns identify - use DPS value for PROTECT field */
 	nvme_sc = nvme_identify(dev, ns->ns_id, 0, dma_addr);
 	res = nvme_trans_status_code(hdr, nvme_sc);
-	/*
-	 * If nvme_sc was -ve, res will be -ve here.
-	 * If nvme_sc was +ve, the status would bace been translated, and res
-	 *  can only be 0 or -ve.
-	 *    - If 0 && nvme_sc > 0, then go into next if where res gets nvme_sc
-	 *    - If -ve, return because its a Linux error.
-	 */
 	if (res)
 		goto out_free;
-	if (nvme_sc) {
-		res = nvme_sc;
-		goto out_free;
-	}
+
 	id_ns = mem;
 	(id_ns->dps) ? (protect = 0x01) : (protect = 0);
 
@@ -737,7 +712,6 @@ static int nvme_trans_supported_vpd_pages(struct nvme_ns *ns,
 					struct sg_io_hdr *hdr, u8 *inq_response,
 					int alloc_len)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
 	int xfer_len;
 
 	memset(inq_response, 0, STANDARD_INQUIRY_LENGTH);
@@ -751,9 +725,7 @@ static int nvme_trans_supported_vpd_pages(struct nvme_ns *ns,
 	inq_response[9] = INQ_BDEV_LIMITS_PAGE;
 
 	xfer_len = min(alloc_len, STANDARD_INQUIRY_LENGTH);
-	res = nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
-
-	return res;
+	return nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
 }
 
 static int nvme_trans_unit_serial_page(struct nvme_ns *ns,
@@ -761,7 +733,6 @@ static int nvme_trans_unit_serial_page(struct nvme_ns *ns,
 					int alloc_len)
 {
 	struct nvme_dev *dev = ns->dev;
-	int res = SNTI_TRANSLATION_SUCCESS;
 	int xfer_len;
 
 	memset(inq_response, 0, STANDARD_INQUIRY_LENGTH);
@@ -770,9 +741,7 @@ static int nvme_trans_unit_serial_page(struct nvme_ns *ns,
 	strncpy(&inq_response[4], dev->serial, INQ_SERIAL_NUMBER_LENGTH);
 
 	xfer_len = min(alloc_len, STANDARD_INQUIRY_LENGTH);
-	res = nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
-
-	return res;
+	return nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
 }
 
 static int nvme_trans_device_id_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
@@ -781,7 +750,7 @@ static int nvme_trans_device_id_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	struct nvme_dev *dev = ns->dev;
 	dma_addr_t dma_addr;
 	void *mem;
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 	int nvme_sc;
 	int xfer_len;
 	__be32 tmp_id = cpu_to_be32(ns->ns_id);
@@ -804,10 +773,6 @@ static int nvme_trans_device_id_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		res = nvme_trans_status_code(hdr, nvme_sc);
 		if (res)
 			goto out_free;
-		if (nvme_sc) {
-			res = nvme_sc;
-			goto out_free;
-		}
 
 		if (readl(&dev->bar->vs) >= NVME_VS(1, 2)) {
 			if (bitmap_empty(eui, len * 8)) {
@@ -859,7 +824,7 @@ static int nvme_trans_ext_inq_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 					int alloc_len)
 {
 	u8 *inq_response;
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 	int nvme_sc;
 	struct nvme_dev *dev = ns->dev;
 	dma_addr_t dma_addr;
@@ -893,10 +858,7 @@ static int nvme_trans_ext_inq_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	res = nvme_trans_status_code(hdr, nvme_sc);
 	if (res)
 		goto out_free;
-	if (nvme_sc) {
-		res = nvme_sc;
-		goto out_free;
-	}
+
 	id_ns = mem;
 	spt = spt_lut[(id_ns->dpc) & 0x07] << 3;
 	(id_ns->dps) ? (protect = 0x01) : (protect = 0);
@@ -909,10 +871,7 @@ static int nvme_trans_ext_inq_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	res = nvme_trans_status_code(hdr, nvme_sc);
 	if (res)
 		goto out_free;
-	if (nvme_sc) {
-		res = nvme_sc;
-		goto out_free;
-	}
+
 	id_ctrl = mem;
 	v_sup = id_ctrl->vwc;
 
@@ -961,7 +920,7 @@ static int nvme_trans_bdev_char_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 					int alloc_len)
 {
 	u8 *inq_response;
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 	int xfer_len;
 
 	inq_response = kzalloc(EXTENDED_INQUIRY_DATA_PAGE_LENGTH, GFP_KERNEL);
@@ -990,7 +949,7 @@ static int nvme_trans_bdev_char_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 static int nvme_trans_log_supp_pages(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 					int alloc_len)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 	int xfer_len;
 	u8 *log_response;
 
@@ -1018,7 +977,7 @@ static int nvme_trans_log_supp_pages(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 static int nvme_trans_log_info_exceptions(struct nvme_ns *ns,
 					struct sg_io_hdr *hdr, int alloc_len)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 	int xfer_len;
 	u8 *log_response;
 	struct nvme_command c;
@@ -1084,7 +1043,7 @@ static int nvme_trans_log_info_exceptions(struct nvme_ns *ns,
 static int nvme_trans_log_temperature(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 					int alloc_len)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 	int xfer_len;
 	u8 *log_response;
 	struct nvme_command c;
@@ -1167,7 +1126,7 @@ static int nvme_trans_fill_mode_parm_hdr(u8 *resp, int len, u8 cdb10, u8 llbaa,
 {
 	/* Quick check to make sure I don't stomp on my own memory... */
 	if ((cdb10 && len < 8) || (!cdb10 && len < 4))
-		return SNTI_INTERNAL_ERROR;
+		return -EINVAL;
 
 	if (cdb10) {
 		resp[0] = (mode_data_length & 0xFF00) >> 8;
@@ -1183,13 +1142,13 @@ static int nvme_trans_fill_mode_parm_hdr(u8 *resp, int len, u8 cdb10, u8 llbaa,
 		resp[3] = (blk_desc_len & 0x00FF);
 	}
 
-	return SNTI_TRANSLATION_SUCCESS;
+	return 0;
 }
 
 static int nvme_trans_fill_blk_desc(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 				    u8 *resp, int len, u8 llbaa)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 	int nvme_sc;
 	struct nvme_dev *dev = ns->dev;
 	dma_addr_t dma_addr;
@@ -1199,9 +1158,9 @@ static int nvme_trans_fill_blk_desc(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	u32 lba_length;
 
 	if (llbaa == 0 && len < MODE_PAGE_BLK_DES_LEN)
-		return SNTI_INTERNAL_ERROR;
+		return -EINVAL;
 	else if (llbaa > 0 && len < MODE_PAGE_LLBAA_BLK_DES_LEN)
-		return SNTI_INTERNAL_ERROR;
+		return -EINVAL;
 
 	mem = dma_alloc_coherent(dev->dev, sizeof(struct nvme_id_ns),
 							&dma_addr, GFP_KERNEL);
@@ -1215,10 +1174,7 @@ static int nvme_trans_fill_blk_desc(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	res = nvme_trans_status_code(hdr, nvme_sc);
 	if (res)
 		goto out_dma;
-	if (nvme_sc) {
-		res = nvme_sc;
-		goto out_dma;
-	}
+
 	id_ns = mem;
 	flbas = (id_ns->flbas) & 0x0F;
 	lba_length = (1 << (id_ns->lbaf[flbas].ds));
@@ -1250,7 +1206,7 @@ static int nvme_trans_fill_control_page(struct nvme_ns *ns,
 					int len)
 {
 	if (len < MODE_PAGE_CONTROL_LEN)
-		return SNTI_INTERNAL_ERROR;
+		return -EINVAL;
 
 	resp[0] = MODE_PAGE_CONTROL;
 	resp[1] = MODE_PAGE_CONTROL_LEN_FIELD;
@@ -1264,78 +1220,69 @@ static int nvme_trans_fill_control_page(struct nvme_ns *ns,
 	resp[9] = 0xFF;
 	/* Bytes 10,11: Extended selftest completion time = 0x0000 */
 
-	return SNTI_TRANSLATION_SUCCESS;
+	return 0;
 }
 
 static int nvme_trans_fill_caching_page(struct nvme_ns *ns,
 					struct sg_io_hdr *hdr,
 					u8 *resp, int len)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res = 0;
 	int nvme_sc;
 	struct nvme_dev *dev = ns->dev;
 	u32 feature_resp;
 	u8 vwc;
 
 	if (len < MODE_PAGE_CACHING_LEN)
-		return SNTI_INTERNAL_ERROR;
+		return -EINVAL;
 
 	nvme_sc = nvme_get_features(dev, NVME_FEAT_VOLATILE_WC, 0,
 								&feature_resp);
 	res = nvme_trans_status_code(hdr, nvme_sc);
 	if (res)
-		goto out;
-	if (nvme_sc) {
-		res = nvme_sc;
-		goto out;
-	}
+		return res;
+
 	vwc = feature_resp & 0x00000001;
 
 	resp[0] = MODE_PAGE_CACHING;
 	resp[1] = MODE_PAGE_CACHING_LEN_FIELD;
 	resp[2] = vwc << 2;
-
- out:
-	return res;
+	return 0;
 }
 
 static int nvme_trans_fill_pow_cnd_page(struct nvme_ns *ns,
 					struct sg_io_hdr *hdr, u8 *resp,
 					int len)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
-
 	if (len < MODE_PAGE_POW_CND_LEN)
-		return SNTI_INTERNAL_ERROR;
+		return -EINVAL;
 
 	resp[0] = MODE_PAGE_POWER_CONDITION;
 	resp[1] = MODE_PAGE_POW_CND_LEN_FIELD;
 	/* All other bytes are zero */
 
-	return res;
+	return 0;
 }
 
 static int nvme_trans_fill_inf_exc_page(struct nvme_ns *ns,
 					struct sg_io_hdr *hdr, u8 *resp,
 					int len)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
-
 	if (len < MODE_PAGE_INF_EXC_LEN)
-		return SNTI_INTERNAL_ERROR;
+		return -EINVAL;
 
 	resp[0] = MODE_PAGE_INFO_EXCEP;
 	resp[1] = MODE_PAGE_INF_EXC_LEN_FIELD;
 	resp[2] = 0x88;
 	/* All other bytes are zero */
 
-	return res;
+	return 0;
 }
 
 static int nvme_trans_fill_all_pages(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 				     u8 *resp, int len)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 	u16 mode_pages_offset_1 = 0;
 	u16 mode_pages_offset_2, mode_pages_offset_3, mode_pages_offset_4;
 
@@ -1345,23 +1292,18 @@ static int nvme_trans_fill_all_pages(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 
 	res = nvme_trans_fill_caching_page(ns, hdr, &resp[mode_pages_offset_1],
 					MODE_PAGE_CACHING_LEN);
-	if (res != SNTI_TRANSLATION_SUCCESS)
-		goto out;
+	if (res)
+		return res;
 	res = nvme_trans_fill_control_page(ns, hdr, &resp[mode_pages_offset_2],
 					MODE_PAGE_CONTROL_LEN);
-	if (res != SNTI_TRANSLATION_SUCCESS)
-		goto out;
+	if (res)
+		return res;
 	res = nvme_trans_fill_pow_cnd_page(ns, hdr, &resp[mode_pages_offset_3],
 					MODE_PAGE_POW_CND_LEN);
-	if (res != SNTI_TRANSLATION_SUCCESS)
-		goto out;
-	res = nvme_trans_fill_inf_exc_page(ns, hdr, &resp[mode_pages_offset_4],
+	if (res)
+		return res;
+	return nvme_trans_fill_inf_exc_page(ns, hdr, &resp[mode_pages_offset_4],
 					MODE_PAGE_INF_EXC_LEN);
-	if (res != SNTI_TRANSLATION_SUCCESS)
-		goto out;
-
- out:
-	return res;
 }
 
 static inline int nvme_trans_get_blk_desc_len(u8 dbd, u8 llbaa)
@@ -1382,7 +1324,7 @@ static int nvme_trans_mode_page_create(struct nvme_ns *ns,
 					struct sg_io_hdr *hdr, u8 *, int),
 					u16 mode_pages_tot_len)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 	int xfer_len;
 	u8 *response;
 	u8 dbd, llbaa;
@@ -1411,18 +1353,18 @@ static int nvme_trans_mode_page_create(struct nvme_ns *ns,
 
 	res = nvme_trans_fill_mode_parm_hdr(&response[0], mph_size, cdb10,
 					llbaa, mode_data_length, blk_desc_len);
-	if (res != SNTI_TRANSLATION_SUCCESS)
+	if (res)
 		goto out_free;
 	if (blk_desc_len > 0) {
 		res = nvme_trans_fill_blk_desc(ns, hdr,
 					       &response[blk_desc_offset],
 					       blk_desc_len, llbaa);
-		if (res != SNTI_TRANSLATION_SUCCESS)
+		if (res)
 			goto out_free;
 	}
 	res = mode_page_fill_func(ns, hdr, &response[mode_pages_offset_1],
 					mode_pages_tot_len);
-	if (res != SNTI_TRANSLATION_SUCCESS)
+	if (res)
 		goto out_free;
 
 	xfer_len = min(alloc_len, resp_size);
@@ -1477,7 +1419,7 @@ static void nvme_trans_fill_read_cap(u8 *response, struct nvme_id_ns *id_ns,
 static int nvme_trans_power_state(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 						u8 pc, u8 pcmod, u8 start)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 	int nvme_sc;
 	struct nvme_dev *dev = ns->dev;
 	dma_addr_t dma_addr;
@@ -1497,10 +1439,7 @@ static int nvme_trans_power_state(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	res = nvme_trans_status_code(hdr, nvme_sc);
 	if (res)
 		goto out_dma;
-	if (nvme_sc) {
-		res = nvme_sc;
-		goto out_dma;
-	}
+
 	id_ctrl = mem;
 	lowest_pow_st = max(POWER_STATE_0, (int)(id_ctrl->npss - 1));
 
@@ -1543,10 +1482,7 @@ static int nvme_trans_power_state(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	nvme_sc = nvme_set_features(dev, NVME_FEAT_POWER_MGMT, ps_desired,
 				    NULL);
 	res = nvme_trans_status_code(hdr, nvme_sc);
-	if (res)
-		goto out_dma;
-	if (nvme_sc)
-		res = nvme_sc;
+
  out_dma:
 	dma_free_coherent(dev->dev, sizeof(struct nvme_id_ctrl), mem, dma_addr);
  out:
@@ -1558,24 +1494,20 @@ static int nvme_trans_send_activate_fw_cmd(struct nvme_ns *ns, struct sg_io_hdr
 {
 	struct nvme_command c;
 	int nvme_sc;
-	int res;
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = nvme_admin_activate_fw;
 	c.common.cdw10[0] = cpu_to_le32(buffer_id | NVME_FWACT_REPL_ACTV);
 
 	nvme_sc = nvme_submit_sync_cmd(ns->queue, &c);
-	res = nvme_trans_status_code(hdr, nvme_sc);
-	if (res)
-		return res;
-	return nvme_sc;
+	return nvme_trans_status_code(hdr, nvme_sc);
 }
 
 static int nvme_trans_send_download_fw_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 					u8 opcode, u32 tot_len, u32 offset,
 					u8 buffer_id)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 	int nvme_sc;
 	struct nvme_dev *dev = ns->dev;
 	struct nvme_command c;
@@ -1610,10 +1542,6 @@ static int nvme_trans_send_download_fw_cmd(struct nvme_ns *ns, struct sg_io_hdr
 
 	nvme_sc = nvme_submit_sync_cmd(dev->admin_q, &c);
 	res = nvme_trans_status_code(hdr, nvme_sc);
-	if (res)
-		goto out_unmap;
-	if (nvme_sc)
-		res = nvme_sc;
 
  out_unmap:
 	nvme_unmap_user_pages(dev, DMA_TO_DEVICE, iod);
@@ -1681,7 +1609,7 @@ static void nvme_trans_modesel_save_bd(struct nvme_ns *ns, u8 *parm_list,
 static int nvme_trans_modesel_get_mp(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 					u8 *mode_page, u8 page_code)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res = 0;
 	int nvme_sc;
 	struct nvme_dev *dev = ns->dev;
 	unsigned dword11;
@@ -1692,12 +1620,6 @@ static int nvme_trans_modesel_get_mp(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		nvme_sc = nvme_set_features(dev, NVME_FEAT_VOLATILE_WC, dword11,
 					    NULL);
 		res = nvme_trans_status_code(hdr, nvme_sc);
-		if (res)
-			break;
-		if (nvme_sc) {
-			res = nvme_sc;
-			break;
-		}
 		break;
 	case MODE_PAGE_CONTROL:
 		break;
@@ -1709,8 +1631,6 @@ static int nvme_trans_modesel_get_mp(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 						ILLEGAL_REQUEST,
 						SCSI_ASC_INVALID_PARAMETER,
 						SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-			if (!res)
-				res = SNTI_INTERNAL_ERROR;
 			break;
 		}
 		break;
@@ -1718,8 +1638,6 @@ static int nvme_trans_modesel_get_mp(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
 					ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
 					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-		if (!res)
-			res = SNTI_INTERNAL_ERROR;
 		break;
 	}
 
@@ -1730,7 +1648,7 @@ static int nvme_trans_modesel_data(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 					u8 *cmd, u16 parm_list_len, u8 pf,
 					u8 sp, u8 cdb10)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 	u8 *parm_list;
 	u16 bd_len;
 	u8 llbaa = 0;
@@ -1746,7 +1664,7 @@ static int nvme_trans_modesel_data(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	}
 
 	res = nvme_trans_copy_from_user(hdr, parm_list, parm_list_len);
-	if (res != SNTI_TRANSLATION_SUCCESS)
+	if (res)
 		goto out_mem;
 
 	nvme_trans_modesel_get_bd_len(parm_list, cdb10, &bd_len, &llbaa);
@@ -1784,7 +1702,7 @@ static int nvme_trans_modesel_data(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		mp_size = parm_list[index + 1] + 2;
 		res = nvme_trans_modesel_get_mp(ns, hdr, &parm_list[index],
 								page_code);
-		if (res != SNTI_TRANSLATION_SUCCESS)
+		if (res)
 			break;
 		index += mp_size;
 	} while (index < parm_list_len);
@@ -1800,7 +1718,7 @@ static int nvme_trans_modesel_data(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 static int nvme_trans_fmt_set_blk_size_count(struct nvme_ns *ns,
 					     struct sg_io_hdr *hdr)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res = 0;
 	int nvme_sc;
 	struct nvme_dev *dev = ns->dev;
 	dma_addr_t dma_addr;
@@ -1827,10 +1745,7 @@ static int nvme_trans_fmt_set_blk_size_count(struct nvme_ns *ns,
 		res = nvme_trans_status_code(hdr, nvme_sc);
 		if (res)
 			goto out_dma;
-		if (nvme_sc) {
-			res = nvme_sc;
-			goto out_dma;
-		}
+
 		id_ns = mem;
 
 		if (ns->mode_select_num_blocks == 0)
@@ -1851,7 +1766,7 @@ static int nvme_trans_fmt_set_blk_size_count(struct nvme_ns *ns,
 static int nvme_trans_fmt_get_parm_header(struct sg_io_hdr *hdr, u8 len,
 					u8 format_prot_info, u8 *nvme_pf_code)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 	u8 *parm_list;
 	u8 pf_usage, pf_code;
 
@@ -1861,7 +1776,7 @@ static int nvme_trans_fmt_get_parm_header(struct sg_io_hdr *hdr, u8 len,
 		goto out;
 	}
 	res = nvme_trans_copy_from_user(hdr, parm_list, len);
-	if (res != SNTI_TRANSLATION_SUCCESS)
+	if (res)
 		goto out_mem;
 
 	if ((parm_list[FORMAT_UNIT_IMMED_OFFSET] &
@@ -1911,7 +1826,7 @@ static int nvme_trans_fmt_get_parm_header(struct sg_io_hdr *hdr, u8 len,
 static int nvme_trans_fmt_send_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 				   u8 prot_info)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 	int nvme_sc;
 	struct nvme_dev *dev = ns->dev;
 	dma_addr_t dma_addr;
@@ -1935,10 +1850,7 @@ static int nvme_trans_fmt_send_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	res = nvme_trans_status_code(hdr, nvme_sc);
 	if (res)
 		goto out_dma;
-	if (nvme_sc) {
-		res = nvme_sc;
-		goto out_dma;
-	}
+
 	id_ns = mem;
 	flbas = (id_ns->flbas) & 0x0F;
 	nlbaf = id_ns->nlbaf;
@@ -1969,10 +1881,6 @@ static int nvme_trans_fmt_send_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 
 	nvme_sc = nvme_submit_sync_cmd(dev->admin_q, &c);
 	res = nvme_trans_status_code(hdr, nvme_sc);
-	if (res)
-		goto out_dma;
-	if (nvme_sc)
-		res = nvme_sc;
 
  out_dma:
 	dma_free_coherent(dev->dev, sizeof(struct nvme_id_ns), mem, dma_addr);
@@ -2058,8 +1966,7 @@ static u16 nvme_trans_io_get_control(struct nvme_ns *ns,
 static int nvme_trans_do_nvme_io(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 				struct nvme_trans_io_cdb *cdb_info, u8 is_write)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
-	int nvme_sc;
+	int nvme_sc = NVME_SC_SUCCESS;
 	struct nvme_dev *dev = ns->dev;
 	u32 num_cmds;
 	struct nvme_iod *iod;
@@ -2116,18 +2023,16 @@ static int nvme_trans_do_nvme_io(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		iod = nvme_map_user_pages(dev,
 			(is_write) ? DMA_TO_DEVICE : DMA_FROM_DEVICE,
 			(unsigned long)next_mapping_addr, unit_len);
-		if (IS_ERR(iod)) {
-			res = PTR_ERR(iod);
-			goto out;
-		}
+		if (IS_ERR(iod))
+			return PTR_ERR(iod);
+
 		retcode = nvme_setup_prps(dev, iod, unit_len, GFP_KERNEL);
 		if (retcode != unit_len) {
 			nvme_unmap_user_pages(dev,
 				(is_write) ? DMA_TO_DEVICE : DMA_FROM_DEVICE,
 				iod);
 			nvme_free_iod(dev, iod);
-			res = -ENOMEM;
-			goto out;
+			return -ENOMEM;
 		}
 		c.rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
 		c.rw.prp2 = cpu_to_le64(iod->first_dma);
@@ -2135,23 +2040,18 @@ static int nvme_trans_do_nvme_io(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		nvme_offset += unit_num_blocks;
 
 		nvme_sc = nvme_submit_sync_cmd(ns->queue, &c);
-		if (nvme_sc != NVME_SC_SUCCESS) {
-			nvme_unmap_user_pages(dev,
-				(is_write) ? DMA_TO_DEVICE : DMA_FROM_DEVICE,
-				iod);
-			nvme_free_iod(dev, iod);
-			res = nvme_trans_status_code(hdr, nvme_sc);
-			goto out;
-		}
+
 		nvme_unmap_user_pages(dev,
 				(is_write) ? DMA_TO_DEVICE : DMA_FROM_DEVICE,
 				iod);
 		nvme_free_iod(dev, iod);
+
+
+		if (nvme_sc != NVME_SC_SUCCESS)
+			break;
 	}
-	res = nvme_trans_status_code(hdr, NVME_SC_SUCCESS);
 
- out:
-	return res;
+	return nvme_trans_status_code(hdr, nvme_sc);
 }
 
 
@@ -2160,7 +2060,7 @@ static int nvme_trans_do_nvme_io(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 static int nvme_trans_io(struct nvme_ns *ns, struct sg_io_hdr *hdr, u8 is_write,
 							u8 *cmd)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res = 0;
 	struct nvme_trans_io_cdb cdb_info;
 	u8 opcode = cmd[0];
 	u64 xfer_bytes;
@@ -2189,7 +2089,7 @@ static int nvme_trans_io(struct nvme_ns *ns, struct sg_io_hdr *hdr, u8 is_write,
 		break;
 	default:
 		/* Will never really reach here */
-		res = SNTI_INTERNAL_ERROR;
+		res = -EIO;
 		goto out;
 	}
 
@@ -2231,7 +2131,7 @@ static int nvme_trans_io(struct nvme_ns *ns, struct sg_io_hdr *hdr, u8 is_write,
 
 	/* Send NVMe IO Command(s) */
 	res = nvme_trans_do_nvme_io(ns, hdr, &cdb_info, is_write);
-	if (res != SNTI_TRANSLATION_SUCCESS)
+	if (res)
 		goto out;
 
  out:
@@ -2241,7 +2141,7 @@ static int nvme_trans_io(struct nvme_ns *ns, struct sg_io_hdr *hdr, u8 is_write,
 static int nvme_trans_inquiry(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 							u8 *cmd)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res = 0;
 	u8 evpd;
 	u8 page_code;
 	int alloc_len;
@@ -2309,7 +2209,7 @@ static int nvme_trans_inquiry(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 static int nvme_trans_log_sense(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 							u8 *cmd)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 	u16 alloc_len;
 	u8 sp;
 	u8 pc;
@@ -2356,7 +2256,6 @@ static int nvme_trans_log_sense(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 static int nvme_trans_mode_select(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 							u8 *cmd)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
 	u8 cdb10 = 0;
 	u16 parm_list_len;
 	u8 page_format;
@@ -2382,17 +2281,17 @@ static int nvme_trans_mode_select(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		 * According to SPC-4 r24, a paramter list length field of 0
 		 * shall not be considered an error
 		 */
-		res = nvme_trans_modesel_data(ns, hdr, cmd, parm_list_len,
+		return nvme_trans_modesel_data(ns, hdr, cmd, parm_list_len,
 						page_format, save_pages, cdb10);
 	}
 
-	return res;
+	return 0;
 }
 
 static int nvme_trans_mode_sense(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 							u8 *cmd)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res = 0;
 	u16 alloc_len;
 	u8 cdb10 = 0;
 	u8 page_code;
@@ -2462,7 +2361,7 @@ static int nvme_trans_mode_sense(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 static int nvme_trans_read_capacity(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 							u8 *cmd)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 	int nvme_sc;
 	u32 alloc_len = READ_CAP_10_RESP_SIZE;
 	u32 resp_size = READ_CAP_10_RESP_SIZE;
@@ -2491,10 +2390,7 @@ static int nvme_trans_read_capacity(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	res = nvme_trans_status_code(hdr, nvme_sc);
 	if (res)
 		goto out_dma;
-	if (nvme_sc) {
-		res = nvme_sc;
-		goto out_dma;
-	}
+
 	id_ns = mem;
 
 	response = kzalloc(resp_size, GFP_KERNEL);
@@ -2517,7 +2413,7 @@ static int nvme_trans_read_capacity(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 static int nvme_trans_report_luns(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 							u8 *cmd)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 	int nvme_sc;
 	u32 alloc_len, xfer_len, resp_size;
 	u8 select_report;
@@ -2552,10 +2448,7 @@ static int nvme_trans_report_luns(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		res = nvme_trans_status_code(hdr, nvme_sc);
 		if (res)
 			goto out_dma;
-		if (nvme_sc) {
-			res = nvme_sc;
-			goto out_dma;
-		}
+
 		id_ctrl = mem;
 		ll_length = le32_to_cpu(id_ctrl->nn) * LUN_ENTRY_SIZE;
 		resp_size = ll_length + LUN_DATA_HEADER_SIZE;
@@ -2601,7 +2494,7 @@ static int nvme_trans_report_luns(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 static int nvme_trans_request_sense(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 							u8 *cmd)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 	u8 alloc_len, xfer_len, resp_size;
 	u8 desc_format;
 	u8 *response;
@@ -2660,7 +2553,6 @@ static int nvme_trans_security_protocol(struct nvme_ns *ns,
 static int nvme_trans_start_stop(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 							u8 *cmd)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
 	int nvme_sc;
 	struct nvme_command c;
 	u8 immed, pcmod, pc, no_flush, start;
@@ -2678,7 +2570,7 @@ static int nvme_trans_start_stop(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	start &= START_STOP_UNIT_CDB_START_MASK;
 
 	if (immed != 0) {
-		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
+		return nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
 					ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
 					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
 	} else {
@@ -2689,26 +2581,16 @@ static int nvme_trans_start_stop(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 			c.common.nsid = cpu_to_le32(ns->ns_id);
 
 			nvme_sc = nvme_submit_sync_cmd(ns->queue, &c);
-			res = nvme_trans_status_code(hdr, nvme_sc);
-			if (res)
-				goto out;
-			if (nvme_sc) {
-				res = nvme_sc;
-				goto out;
-			}
+			return nvme_trans_status_code(hdr, nvme_sc);
 		}
 		/* Setup the expected power state transition */
-		res = nvme_trans_power_state(ns, hdr, pc, pcmod, start);
+		return nvme_trans_power_state(ns, hdr, pc, pcmod, start);
 	}
-
- out:
-	return res;
 }
 
 static int nvme_trans_synchronize_cache(struct nvme_ns *ns,
 					struct sg_io_hdr *hdr, u8 *cmd)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
 	int nvme_sc;
 	struct nvme_command c;
 
@@ -2717,20 +2599,13 @@ static int nvme_trans_synchronize_cache(struct nvme_ns *ns,
 	c.common.nsid = cpu_to_le32(ns->ns_id);
 
 	nvme_sc = nvme_submit_sync_cmd(ns->queue, &c);
-	res = nvme_trans_status_code(hdr, nvme_sc);
-	if (res)
-		goto out;
-	if (nvme_sc)
-		res = nvme_sc;
-
- out:
-	return res;
+	return nvme_trans_status_code(hdr, nvme_sc);
 }
 
 static int nvme_trans_format_unit(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 							u8 *cmd)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res;
 	u8 parm_hdr_len = 0;
 	u8 nvme_pf_code = 0;
 	u8 format_prot_info, long_list, format_data;
@@ -2768,7 +2643,7 @@ static int nvme_trans_format_unit(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	if (parm_hdr_len > 0) {
 		res = nvme_trans_fmt_get_parm_header(hdr, parm_hdr_len,
 					format_prot_info, &nvme_pf_code);
-		if (res != SNTI_TRANSLATION_SUCCESS)
+		if (res)
 			goto out;
 	}
 
@@ -2777,7 +2652,7 @@ static int nvme_trans_format_unit(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 
 	/* Determine Block size and count and send format command */
 	res = nvme_trans_fmt_set_blk_size_count(ns, hdr);
-	if (res != SNTI_TRANSLATION_SUCCESS)
+	if (res)
 		goto out;
 
 	res = nvme_trans_fmt_send_cmd(ns, hdr, nvme_pf_code);
@@ -2790,23 +2665,20 @@ static int nvme_trans_test_unit_ready(struct nvme_ns *ns,
 					struct sg_io_hdr *hdr,
 					u8 *cmd)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
 	struct nvme_dev *dev = ns->dev;
 
 	if (!(readl(&dev->bar->csts) & NVME_CSTS_RDY))
-		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
+		return nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
 					    NOT_READY, SCSI_ASC_LUN_NOT_READY,
 					    SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
 	else
-		res = nvme_trans_completion(hdr, SAM_STAT_GOOD, NO_SENSE, 0, 0);
-
-	return res;
+		return nvme_trans_completion(hdr, SAM_STAT_GOOD, NO_SENSE, 0, 0);
 }
 
 static int nvme_trans_write_buffer(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 							u8 *cmd)
 {
-	int res = SNTI_TRANSLATION_SUCCESS;
+	int res = 0;
 	u32 buffer_offset, parm_list_length;
 	u8 buffer_id, mode;
 
@@ -2836,7 +2708,7 @@ static int nvme_trans_write_buffer(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		res = nvme_trans_send_download_fw_cmd(ns, hdr, nvme_admin_download_fw,
 						parm_list_length, buffer_offset,
 						buffer_id);
-		if (res != SNTI_TRANSLATION_SUCCESS)
+		if (res)
 			goto out;
 		res = nvme_trans_send_activate_fw_cmd(ns, hdr, buffer_id);
 		break;
@@ -2892,7 +2764,7 @@ static int nvme_trans_unmap(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		return -ENOMEM;
 
 	res = nvme_trans_copy_from_user(hdr, plist, list_len);
-	if (res != SNTI_TRANSLATION_SUCCESS)
+	if (res)
 		goto out;
 
 	ndesc = be16_to_cpu(plist->unmap_blk_desc_data_len) >> 4;
@@ -3037,15 +2909,16 @@ int nvme_sg_io(struct nvme_ns *ns, struct sg_io_hdr __user *u_hdr)
 	if (hdr.cmd_len > BLK_MAX_CDB)
 		return -EINVAL;
 
+	/*
+	 * A positive return code means a NVMe status, which has been
+	 * translated to sense data.
+	 */
 	retcode = nvme_scsi_translate(ns, &hdr);
 	if (retcode < 0)
 		return retcode;
-	if (retcode > 0)
-		retcode = SNTI_TRANSLATION_SUCCESS;
 	if (copy_to_user(u_hdr, &hdr, sizeof(sg_io_hdr_t)) > 0)
 		return -EFAULT;
-
-	return retcode;
+	return 0;
 }
 
 int nvme_sg_get_version_num(int __user *ip)
-- 
1.9.1
