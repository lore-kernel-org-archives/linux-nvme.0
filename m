From: hch@lst.de (Christoph Hellwig)
Date: Fri, 22 May 2015 11:12:40 +0200
Subject: [PATCH 3/9] nvme: split nvme_trans_send_fw_cmd
In-Reply-To: <1432285966-31770-1-git-send-email-hch@lst.de>
References: <1432285966-31770-1-git-send-email-hch@lst.de>
Message-ID: <1432285966-31770-4-git-send-email-hch@lst.de>

This function handles two totally different opcodes, so split it.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-scsi.c | 93 ++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 46 deletions(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index f1c90f2..60415b5 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -1554,10 +1554,25 @@ static int nvme_trans_power_state(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	return res;
 }
 
-/* Write Buffer Helper Functions */
-/* Also using this for Format Unit with hdr passed as NULL, and buffer_id, 0 */
+static int nvme_trans_send_activate_fw_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
+					u8 buffer_id)
+{
+	struct nvme_command c;
+	int nvme_sc;
+	int res;
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = nvme_admin_activate_fw;
+	c.common.cdw10[0] = cpu_to_le32(buffer_id | NVME_FWACT_REPL_ACTV);
+
+	nvme_sc = nvme_submit_sync_cmd(ns->queue, &c);
+	res = nvme_trans_status_code(hdr, nvme_sc);
+	if (res)
+		return res;
+	return nvme_sc;
+}
 
-static int nvme_trans_send_fw_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
+static int nvme_trans_send_download_fw_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 					u8 opcode, u32 tot_len, u32 offset,
 					u8 buffer_id)
 {
@@ -1569,38 +1584,31 @@ static int nvme_trans_send_fw_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	unsigned length;
 
 	memset(&c, 0, sizeof(c));
-	c.common.opcode = opcode;
-	if (opcode == nvme_admin_download_fw) {
-		if (hdr->iovec_count > 0) {
-			/* Assuming SGL is not allowed for this command */
-			res = nvme_trans_completion(hdr,
-						SAM_STAT_CHECK_CONDITION,
-						ILLEGAL_REQUEST,
-						SCSI_ASC_INVALID_CDB,
-						SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-			goto out;
-		}
-		iod = nvme_map_user_pages(dev, DMA_TO_DEVICE,
-				(unsigned long)hdr->dxferp, tot_len);
-		if (IS_ERR(iod)) {
-			res = PTR_ERR(iod);
-			goto out;
-		}
-		length = nvme_setup_prps(dev, iod, tot_len, GFP_KERNEL);
-		if (length != tot_len) {
-			res = -ENOMEM;
-			goto out_unmap;
-		}
+	c.common.opcode = nvme_admin_download_fw;
 
-		c.dlfw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
-		c.dlfw.prp2 = cpu_to_le64(iod->first_dma);
-		c.dlfw.numd = cpu_to_le32((tot_len/BYTES_TO_DWORDS) - 1);
-		c.dlfw.offset = cpu_to_le32(offset/BYTES_TO_DWORDS);
-	} else if (opcode == nvme_admin_activate_fw) {
-		u32 cdw10 = buffer_id | NVME_FWACT_REPL_ACTV;
-		c.common.cdw10[0] = cpu_to_le32(cdw10);
+	if (hdr->iovec_count > 0) {
+		/* Assuming SGL is not allowed for this command */
+		return nvme_trans_completion(hdr,
+					SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
+					SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+	}
+	iod = nvme_map_user_pages(dev, DMA_TO_DEVICE,
+			(unsigned long)hdr->dxferp, tot_len);
+	if (IS_ERR(iod))
+		return PTR_ERR(iod);
+	length = nvme_setup_prps(dev, iod, tot_len, GFP_KERNEL);
+	if (length != tot_len) {
+		res = -ENOMEM;
+		goto out_unmap;
 	}
 
+	c.dlfw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
+	c.dlfw.prp2 = cpu_to_le64(iod->first_dma);
+	c.dlfw.numd = cpu_to_le32((tot_len/BYTES_TO_DWORDS) - 1);
+	c.dlfw.offset = cpu_to_le32(offset/BYTES_TO_DWORDS);
+
 	nvme_sc = nvme_submit_sync_cmd(dev->admin_q, &c);
 	res = nvme_trans_status_code(hdr, nvme_sc);
 	if (res)
@@ -1609,11 +1617,8 @@ static int nvme_trans_send_fw_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		res = nvme_sc;
 
  out_unmap:
-	if (opcode == nvme_admin_download_fw) {
-		nvme_unmap_user_pages(dev, DMA_TO_DEVICE, iod);
-		nvme_free_iod(dev, iod);
-	}
- out:
+	nvme_unmap_user_pages(dev, DMA_TO_DEVICE, iod);
+	nvme_free_iod(dev, iod);
 	return res;
 }
 
@@ -2769,7 +2774,7 @@ static int nvme_trans_format_unit(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	}
 
 	/* Attempt to activate any previously downloaded firmware image */
-	res = nvme_trans_send_fw_cmd(ns, hdr, nvme_admin_activate_fw, 0, 0, 0);
+	res = nvme_trans_send_activate_fw_cmd(ns, hdr, 0);
 
 	/* Determine Block size and count and send format command */
 	res = nvme_trans_fmt_set_blk_size_count(ns, hdr);
@@ -2829,24 +2834,20 @@ static int nvme_trans_write_buffer(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 
 	switch (mode) {
 	case DOWNLOAD_SAVE_ACTIVATE:
-		res = nvme_trans_send_fw_cmd(ns, hdr, nvme_admin_download_fw,
+		res = nvme_trans_send_download_fw_cmd(ns, hdr, nvme_admin_download_fw,
 						parm_list_length, buffer_offset,
 						buffer_id);
 		if (res != SNTI_TRANSLATION_SUCCESS)
 			goto out;
-		res = nvme_trans_send_fw_cmd(ns, hdr, nvme_admin_activate_fw,
-						parm_list_length, buffer_offset,
-						buffer_id);
+		res = nvme_trans_send_activate_fw_cmd(ns, hdr, buffer_id);
 		break;
 	case DOWNLOAD_SAVE_DEFER_ACTIVATE:
-		res = nvme_trans_send_fw_cmd(ns, hdr, nvme_admin_download_fw,
+		res = nvme_trans_send_download_fw_cmd(ns, hdr, nvme_admin_download_fw,
 						parm_list_length, buffer_offset,
 						buffer_id);
 		break;
 	case ACTIVATE_DEFERRED_MICROCODE:
-		res = nvme_trans_send_fw_cmd(ns, hdr, nvme_admin_activate_fw,
-						parm_list_length, buffer_offset,
-						buffer_id);
+		res = nvme_trans_send_activate_fw_cmd(ns, hdr, buffer_id);
 		break;
 	default:
 		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
-- 
1.9.1
