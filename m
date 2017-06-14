From: hch@lst.de (Christoph Hellwig)
Date: Wed, 14 Jun 2017 08:35:37 +0200
Subject: [PATCH 2/2] nvme-scsi: remove FORMAT UNIT and WRITE BUFFER emulations
In-Reply-To: <20170614063537.1044-1-hch@lst.de>
References: <20170614063537.1044-1-hch@lst.de>
Message-ID: <20170614063537.1044-3-hch@lst.de>

These have been broken for 2 years and no one noticed until now.
Let's kill them off.

Reported-by: Joseph Szczypek <joseph.szczypek at hpe.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/scsi.c | 302 -----------------------------------------------
 1 file changed, 302 deletions(-)

diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index aff3b36d93b6..01158243556a 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -1219,48 +1219,6 @@ static void nvme_trans_fill_read_cap(u8 *response, struct nvme_id_ns *id_ns,
 	}
 }
 
-/* Start Stop Unit Helper Functions */
-
-static int nvme_trans_send_activate_fw_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
-					u8 buffer_id)
-{
-	struct nvme_command c;
-	int nvme_sc;
-
-	memset(&c, 0, sizeof(c));
-	c.common.opcode = nvme_admin_activate_fw;
-	c.common.cdw10[0] = cpu_to_le32(buffer_id | NVME_FWACT_REPL_ACTV);
-
-	nvme_sc = nvme_submit_sync_cmd(ns->queue, &c, NULL, 0);
-	return nvme_trans_status_code(hdr, nvme_sc);
-}
-
-static int nvme_trans_send_download_fw_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
-					u8 opcode, u32 tot_len, u32 offset,
-					u8 buffer_id)
-{
-	int nvme_sc;
-	struct nvme_command c;
-
-	if (hdr->iovec_count > 0) {
-		/* Assuming SGL is not allowed for this command */
-		return nvme_trans_completion(hdr,
-					SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST,
-					SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-	}
-
-	memset(&c, 0, sizeof(c));
-	c.common.opcode = nvme_admin_download_fw;
-	c.dlfw.numd = cpu_to_le32((tot_len/BYTES_TO_DWORDS) - 1);
-	c.dlfw.offset = cpu_to_le32(offset/BYTES_TO_DWORDS);
-
-	nvme_sc = nvme_submit_user_cmd(ns->ctrl->admin_q, &c,
-			hdr->dxferp, tot_len, NULL, 0);
-	return nvme_trans_status_code(hdr, nvme_sc);
-}
-
 /* Mode Select Helper Functions */
 
 static inline void nvme_trans_modesel_get_bd_len(u8 *parm_list, u8 cdb10,
@@ -1420,155 +1378,6 @@ static int nvme_trans_modesel_data(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	return res;
 }
 
-/* Format Unit Helper Functions */
-
-static int nvme_trans_fmt_set_blk_size_count(struct nvme_ns *ns,
-					     struct sg_io_hdr *hdr)
-{
-	int res = 0;
-	int nvme_sc;
-	u8 flbas;
-
-	/*
-	 * SCSI Expects a MODE SELECT would have been issued prior to
-	 * a FORMAT UNIT, and the block size and number would be used
-	 * from the block descriptor in it. If a MODE SELECT had not
-	 * been issued, FORMAT shall use the current values for both.
-	 */
-
-	if (ns->mode_select_num_blocks == 0 || ns->mode_select_block_len == 0) {
-		struct nvme_id_ns *id_ns;
-
-		nvme_sc = nvme_identify_ns(ns->ctrl, ns->ns_id, &id_ns);
-		res = nvme_trans_status_code(hdr, nvme_sc);
-		if (res)
-			return res;
-
-		if (ns->mode_select_num_blocks == 0)
-			ns->mode_select_num_blocks = le64_to_cpu(id_ns->ncap);
-		if (ns->mode_select_block_len == 0) {
-			flbas = (id_ns->flbas) & 0x0F;
-			ns->mode_select_block_len =
-						(1 << (id_ns->lbaf[flbas].ds));
-		}
-
-		kfree(id_ns);
-	}
-
-	return 0;
-}
-
-static int nvme_trans_fmt_get_parm_header(struct sg_io_hdr *hdr, u8 len,
-					u8 format_prot_info, u8 *nvme_pf_code)
-{
-	int res;
-	u8 *parm_list;
-	u8 pf_usage, pf_code;
-
-	parm_list = kmalloc(len, GFP_KERNEL);
-	if (parm_list == NULL) {
-		res = -ENOMEM;
-		goto out;
-	}
-	res = nvme_trans_copy_from_user(hdr, parm_list, len);
-	if (res)
-		goto out_mem;
-
-	if ((parm_list[FORMAT_UNIT_IMMED_OFFSET] &
-				FORMAT_UNIT_IMMED_MASK) != 0) {
-		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-		goto out_mem;
-	}
-
-	if (len == FORMAT_UNIT_LONG_PARM_LIST_LEN &&
-	    (parm_list[FORMAT_UNIT_PROT_INT_OFFSET] & 0x0F) != 0) {
-		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-		goto out_mem;
-	}
-	pf_usage = parm_list[FORMAT_UNIT_PROT_FIELD_USAGE_OFFSET] &
-			FORMAT_UNIT_PROT_FIELD_USAGE_MASK;
-	pf_code = (pf_usage << 2) | format_prot_info;
-	switch (pf_code) {
-	case 0:
-		*nvme_pf_code = 0;
-		break;
-	case 2:
-		*nvme_pf_code = 1;
-		break;
-	case 3:
-		*nvme_pf_code = 2;
-		break;
-	case 7:
-		*nvme_pf_code = 3;
-		break;
-	default:
-		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-		break;
-	}
-
- out_mem:
-	kfree(parm_list);
- out:
-	return res;
-}
-
-static int nvme_trans_fmt_send_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
-				   u8 prot_info)
-{
-	int res;
-	int nvme_sc;
-	struct nvme_id_ns *id_ns;
-	u8 i;
-	u8 nlbaf;
-	u8 selected_lbaf = 0xFF;
-	u32 cdw10 = 0;
-	struct nvme_command c;
-
-	/* Loop thru LBAF's in id_ns to match reqd lbaf, put in cdw10 */
-	nvme_sc = nvme_identify_ns(ns->ctrl, ns->ns_id, &id_ns);
-	res = nvme_trans_status_code(hdr, nvme_sc);
-	if (res)
-		return res;
-
-	nlbaf = id_ns->nlbaf;
-
-	for (i = 0; i < nlbaf; i++) {
-		if (ns->mode_select_block_len == (1 << (id_ns->lbaf[i].ds))) {
-			selected_lbaf = i;
-			break;
-		}
-	}
-	if (selected_lbaf > 0x0F) {
-		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
-				ILLEGAL_REQUEST, SCSI_ASC_INVALID_PARAMETER,
-				SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-	}
-	if (ns->mode_select_num_blocks != le64_to_cpu(id_ns->ncap)) {
-		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
-				ILLEGAL_REQUEST, SCSI_ASC_INVALID_PARAMETER,
-				SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-	}
-
-	cdw10 |= prot_info << 5;
-	cdw10 |= selected_lbaf & 0x0F;
-	memset(&c, 0, sizeof(c));
-	c.format.opcode = nvme_admin_format_nvm;
-	c.format.nsid = cpu_to_le32(ns->ns_id);
-	c.format.cdw10 = cpu_to_le32(cdw10);
-
-	nvme_sc = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, NULL, 0);
-	res = nvme_trans_status_code(hdr, nvme_sc);
-
-	kfree(id_ns);
-	return res;
-}
-
 static inline u32 nvme_trans_io_get_num_cmds(struct sg_io_hdr *hdr,
 					struct nvme_trans_io_cdb *cdb_info,
 					u32 max_blocks)
@@ -2152,111 +1961,6 @@ static int nvme_trans_synchronize_cache(struct nvme_ns *ns,
 	return nvme_trans_status_code(hdr, nvme_sc);
 }
 
-static int nvme_trans_format_unit(struct nvme_ns *ns, struct sg_io_hdr *hdr,
-							u8 *cmd)
-{
-	int res;
-	u8 parm_hdr_len = 0;
-	u8 nvme_pf_code = 0;
-	u8 format_prot_info, long_list, format_data;
-
-	format_prot_info = (cmd[1] & 0xc0) >> 6;
-	long_list = cmd[1] & 0x20;
-	format_data = cmd[1] & 0x10;
-
-	if (format_data != 0) {
-		if (format_prot_info != 0) {
-			if (long_list == 0)
-				parm_hdr_len = FORMAT_UNIT_SHORT_PARM_LIST_LEN;
-			else
-				parm_hdr_len = FORMAT_UNIT_LONG_PARM_LIST_LEN;
-		}
-	} else if (format_data == 0 && format_prot_info != 0) {
-		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-		goto out;
-	}
-
-	/* Get parm header from data-in/out buffer */
-	/*
-	 * According to the translation spec, the only fields in the parameter
-	 * list we are concerned with are in the header. So allocate only that.
-	 */
-	if (parm_hdr_len > 0) {
-		res = nvme_trans_fmt_get_parm_header(hdr, parm_hdr_len,
-					format_prot_info, &nvme_pf_code);
-		if (res)
-			goto out;
-	}
-
-	/* Attempt to activate any previously downloaded firmware image */
-	res = nvme_trans_send_activate_fw_cmd(ns, hdr, 0);
-
-	/* Determine Block size and count and send format command */
-	res = nvme_trans_fmt_set_blk_size_count(ns, hdr);
-	if (res)
-		goto out;
-
-	res = nvme_trans_fmt_send_cmd(ns, hdr, nvme_pf_code);
-
- out:
-	return res;
-}
-
-static int nvme_trans_write_buffer(struct nvme_ns *ns, struct sg_io_hdr *hdr,
-							u8 *cmd)
-{
-	int res = 0;
-	u32 buffer_offset, parm_list_length;
-	u8 buffer_id, mode;
-
-	parm_list_length = get_unaligned_be24(&cmd[6]);
-	if (parm_list_length % BYTES_TO_DWORDS != 0) {
-		/* NVMe expects Firmware file to be a whole number of DWORDS */
-		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-		goto out;
-	}
-	buffer_id = cmd[2];
-	if (buffer_id > NVME_MAX_FIRMWARE_SLOT) {
-		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-		goto out;
-	}
-	mode = cmd[1] & 0x1f;
-	buffer_offset = get_unaligned_be24(&cmd[3]);
-
-	switch (mode) {
-	case DOWNLOAD_SAVE_ACTIVATE:
-		res = nvme_trans_send_download_fw_cmd(ns, hdr, nvme_admin_download_fw,
-						parm_list_length, buffer_offset,
-						buffer_id);
-		if (res)
-			goto out;
-		res = nvme_trans_send_activate_fw_cmd(ns, hdr, buffer_id);
-		break;
-	case DOWNLOAD_SAVE_DEFER_ACTIVATE:
-		res = nvme_trans_send_download_fw_cmd(ns, hdr, nvme_admin_download_fw,
-						parm_list_length, buffer_offset,
-						buffer_id);
-		break;
-	case ACTIVATE_DEFERRED_MICROCODE:
-		res = nvme_trans_send_activate_fw_cmd(ns, hdr, buffer_id);
-		break;
-	default:
-		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-		break;
-	}
-
- out:
-	return res;
-}
-
 struct scsi_unmap_blk_desc {
 	__be64	slba;
 	__be32	nlb;
@@ -2396,12 +2100,6 @@ static int nvme_scsi_translate(struct nvme_ns *ns, struct sg_io_hdr *hdr)
 	case SYNCHRONIZE_CACHE:
 		retcode = nvme_trans_synchronize_cache(ns, hdr);
 		break;
-	case FORMAT_UNIT:
-		retcode = nvme_trans_format_unit(ns, hdr, cmd);
-		break;
-	case WRITE_BUFFER:
-		retcode = nvme_trans_write_buffer(ns, hdr, cmd);
-		break;
 	case UNMAP:
 		retcode = nvme_trans_unmap(ns, hdr, cmd);
 		break;
-- 
2.11.0
