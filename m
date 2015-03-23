From: keith.busch@intel.com (Keith Busch)
Date: Mon, 23 Mar 2015 11:57:10 -0600
Subject: [PATCH] NVMe: Persistent Reservation NVMe translations
Message-ID: <1427133430-1208-1-git-send-email-keith.busch@intel.com>

This provides SCSI-to-NVMe translations for persistent reservations.

The ONCS enums are updated to include all the optional commands between
the previous last define up to reservation support.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
Tested with sg3-util's sg_persist. I can't seem to get everyone to
abandon their old scsi tools and adopt native nvme management. :)

If anyone's interested, I can push my emulator implementing reservations
to my qemu tree.

This is done (mostly) in accordance with the translation reference
on nvmexpress.org. There is one errata in that translation regarding
the TransportID for PR IN's read-full-status. I fixed the driver's
implementation to hijack an ieee format, and will circle back with the
committee to get an update in the spec at the next meeting.

Anyway, no rush on this one.

 drivers/block/nvme-core.c |    4 +
 drivers/block/nvme-scsi.c |  452 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h      |    1 +
 include/uapi/linux/nvme.h |   10 +
 4 files changed, 467 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e23be20..ab7c847 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2040,6 +2040,10 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	ns->lba_shift = id->lbaf[lbaf].ds;
 	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
 
+	if (readl(&dev->bar->vs) >= NVME_VS(1, 1))
+		ns->rescap = id->rescap;
+	else
+		ns->rescap = 0;
 	/*
 	 * If identify namespace failed, use default 512 byte block size so
 	 * block layer can use before failing read/write for 0 capacity.
diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index e10196e..5e46caa 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -637,6 +637,10 @@ static int nvme_trans_status_code(struct sg_io_hdr *hdr, int nvme_sc)
 		asc = SCSI_ASC_ACCESS_DENIED_INVALID_LUN_ID;
 		ascq = SCSI_ASCQ_INVALID_LUN_ID;
 		break;
+	case NVME_SC_RESERVATION_CONFLICT:
+		status = SAM_STAT_RESERVATION_CONFLICT;
+		sense_key = asc = ascq = 0;
+		break;
 
 	/* Unspecified/Default */
 	case NVME_SC_CMDID_CONFLICT:
@@ -2916,6 +2920,448 @@ static int nvme_trans_unmap(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	return res;
 }
 
+static u8 nvme_scsi_to_rtype(u8 rtype)
+{
+	switch(rtype) {
+	case 1:  return 1;
+	case 3:  return 2;
+	case 5:  return 3;
+	case 6:  return 4;
+	case 7:  return 5;
+	case 8:  return 6;
+	default: return 0;
+	}
+}
+
+static u8 nvme_rtype_to_scsi(u8 rtype)
+{
+	switch(rtype) {
+	case 1:  return 1;
+	case 2:  return 3;
+	case 3:  return 5;
+	case 4:  return 6;
+	case 5:  return 7;
+	case 6:  return 8;
+	default: return 0;
+	}
+}
+
+struct scsi_read_keys {
+	__be32 prgeneration;
+	__be32 additional_len;
+	__be64 keys[];
+};
+
+static int nvme_trans_read_resv_keys(struct nvme_ns *ns, struct sg_io_hdr *hdr,
+							u8 *cmd)
+{
+	struct nvme_dev *dev = ns->dev;
+	int i, regctl, nvme_sc, res = -ENOMEM;
+	struct nvme_reservation_status *resv_status;
+	struct scsi_read_keys *keys;
+	struct nvme_command c;
+	dma_addr_t dma_addr;
+
+	resv_status = dma_zalloc_coherent(&dev->pci_dev->dev, 4096, &dma_addr,
+								GFP_KERNEL);
+	if (!resv_status)
+		return -ENOMEM;
+
+	keys = kzalloc(4096, GFP_KERNEL);
+	if (!keys)
+		goto out;
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = nvme_cmd_resv_report;
+	c.common.nsid = cpu_to_le32(ns->ns_id);
+	c.common.prp1 = cpu_to_le64(dma_addr);
+	c.common.cdw10[0] = cpu_to_le32(1023);
+
+	nvme_sc = nvme_submit_io_cmd(dev, ns, &c, NULL);
+	res = nvme_trans_status_code(hdr, nvme_sc);
+	if (nvme_sc != NVME_SC_SUCCESS)
+		goto out;
+
+	regctl = resv_status->regctl[0] | (resv_status->regctl[1] << 8);
+	keys->prgeneration = cpu_to_be32(le32_to_cpu(resv_status->gen));
+	keys->additional_len = cpu_to_be32(regctl * 8);
+	for (i = 0; i < regctl; i++) {
+		keys->keys[i] = cpu_to_be64(le32_to_cpu(
+					resv_status->regctl_ds[i].rkey));
+	}
+	res = nvme_trans_copy_to_user(hdr, keys, 16 + regctl * 8);
+ out:
+	kfree(keys);
+	dma_free_coherent(&dev->pci_dev->dev, 4096, resv_status, dma_addr);
+	return res;
+}
+
+struct scsi_read_reservation {
+	__be32 prgeneration;
+	__be32 additional_len;
+	__be64 resv_key;
+	__u32  obsolete;
+	__u8   rsvd20;
+	__u8   type;
+	__u8   rsvd22[2];
+};
+
+static int nvme_trans_read_reservation(struct nvme_ns *ns,
+					struct sg_io_hdr *hdr, u8 *cmd)
+{
+	struct nvme_dev *dev = ns->dev;
+	int i, regctl, addlen, nvme_sc, res = -ENOMEM;
+	struct nvme_reservation_status *resv_status;
+	struct scsi_read_reservation *resv;
+	struct nvme_command c;
+	dma_addr_t dma_addr;
+
+	resv_status = dma_zalloc_coherent(&dev->pci_dev->dev, 4096, &dma_addr,
+								GFP_KERNEL);
+	if (!resv_status)
+		return -ENOMEM;
+
+	resv = kzalloc(sizeof(*resv), GFP_KERNEL);
+	if (!resv)
+		goto out;
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = nvme_cmd_resv_report;
+	c.common.nsid = cpu_to_le32(ns->ns_id);
+	c.common.prp1 = cpu_to_le64(dma_addr);
+	c.common.cdw10[0] = cpu_to_le32(1023);
+
+	nvme_sc = nvme_submit_io_cmd(dev, ns, &c, NULL);
+	res = nvme_trans_status_code(hdr, nvme_sc);
+	if (nvme_sc != NVME_SC_SUCCESS)
+		goto out;
+
+	addlen = resv_status->rtype ? 16 : 0;
+	regctl = resv_status->regctl[0] | (resv_status->regctl[1] << 8);
+	resv->prgeneration = cpu_to_be32(le32_to_cpu(resv_status->gen));
+	resv->additional_len = cpu_to_be32(addlen);
+
+	if (!addlen)
+		goto done;
+	for (i = 0; i < regctl; i++) {
+		if (resv_status->regctl_ds[i].rcsts & 1) {
+			resv->type = nvme_rtype_to_scsi(resv_status->rtype);
+			resv->resv_key = cpu_to_be64(le64_to_cpu(
+					resv_status->regctl_ds[i].rkey));
+			break;
+		}
+	}
+ done:
+	res = nvme_trans_copy_to_user(hdr, resv, 16 + addlen);
+ out:
+	kfree(resv);
+	dma_free_coherent(&dev->pci_dev->dev, 4096, resv_status, dma_addr);
+	return res;
+
+}
+
+struct scsi_resv_report_caps {
+	__be32 len;
+	__u8   caps[2];
+	__be16 type_mask;
+	__u8   rsvd[2];
+};
+
+static int nvme_trans_report_resv_caps(struct nvme_ns *ns,
+				struct sg_io_hdr *hdr, u8 *cmd)
+{
+	struct scsi_resv_report_caps caps;
+	int res;
+	u32 feature_resp;
+	u16 type_mask = 0;
+	u8 cap[2];
+
+	cap[0] = 1 << 2;
+	cap[1] = 1 << 7;
+
+	if (ns->rescap & NVME_NS_RESCAP_PTPL)
+		cap[0] |= 1;
+	if (ns->rescap & NVME_NS_RESCAP_WR_EX)
+		type_mask |= 1 << 1;
+	if (ns->rescap & NVME_NS_RESCAP_EX_AC)
+		type_mask |= 1 << 3;
+	if (ns->rescap & NVME_NS_RESCAP_WR_EX_RO)
+		type_mask |= 1 << 5;
+	if (ns->rescap & NVME_NS_RESCAP_EX_AC_RO)
+		type_mask |= 1 << 6;
+	if (ns->rescap & NVME_NS_RESCAP_WR_EX_AR)
+		type_mask |= 1 << 7;
+	if (ns->rescap & NVME_NS_RESCAP_EX_AC_AR)
+		type_mask |= 1 << 8;
+
+	res = nvme_get_features(ns->dev, NVME_FEAT_RESV_PERSIST, ns->ns_id, 0,
+								&feature_resp);
+	if (res == NVME_SC_SUCCESS)
+		cap[1] |= feature_resp & 1;
+	caps.len = 8;
+	caps.caps[0] = cap[0];
+	caps.caps[1] = cap[1];
+	caps.type_mask = cpu_to_be16(type_mask);
+
+	res = nvme_trans_copy_to_user(hdr, &caps, sizeof(caps));
+	return res;
+}
+
+struct scsi_full_stats_desc {
+	__be64 key;
+	__u32  rsvd8;
+	__u8   flags;
+	__u8   type;
+	__u8   rsvd14[4];
+	__be16 rel_tgt_port_id;
+	__be32 additional_len;
+	__u8   transport_id[24]; /* 24 for NVMe */
+};
+
+struct scsi_rsvd_full_status {
+	__be32 prgeneration;
+	__be32 additional_len;
+	struct scsi_full_stats_desc descs[];
+};
+
+static int nvme_trans_read_full_status(struct nvme_ns *ns, struct sg_io_hdr *hdr,
+							u8 *cmd)
+{
+	struct nvme_dev *dev = ns->dev;
+	int i, regctl, addlen, nvme_sc, res;
+	struct nvme_reservation_status *resv_status;
+	struct scsi_rsvd_full_status *full_status;
+	struct nvme_command c;
+	dma_addr_t dma_addr;
+	u8 hostid[24];
+
+	resv_status = dma_zalloc_coherent(&dev->pci_dev->dev, 4096, &dma_addr,
+								GFP_KERNEL);
+	if (!resv_status)
+		return -ENOMEM;
+
+	full_status = kzalloc(4096, GFP_KERNEL);
+	if (!full_status)
+		goto out;
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = nvme_cmd_resv_report;
+	c.common.nsid = cpu_to_le32(ns->ns_id);
+	c.common.prp1 = cpu_to_le64(dma_addr);
+	c.common.cdw10[0] = cpu_to_le32(1023);
+
+	nvme_sc = nvme_submit_io_cmd(dev, ns, &c, NULL);
+	res = nvme_trans_status_code(hdr, nvme_sc);
+	if (nvme_sc != NVME_SC_SUCCESS)
+		goto out;
+
+	regctl = resv_status->regctl[0] | (resv_status->regctl[1] << 8);
+	addlen = regctl * sizeof(struct scsi_full_stats_desc);
+	full_status->prgeneration = cpu_to_be32(le32_to_cpu(resv_status->gen));
+	full_status->additional_len = cpu_to_be32(addlen);
+
+	memset(hostid, 0, sizeof(hostid));
+	hostid[0] = 3;
+	for (i = 0; i < regctl; i++) {
+		full_status->descs[i].key = cpu_to_be64(le64_to_cpu(
+				resv_status->regctl_ds[i].rkey));
+		full_status->descs[i].flags =
+				(resv_status->regctl_ds[i].rcsts & 1) | 1 << 2;
+		full_status->descs[i].type =
+			resv_status->regctl_ds[i].rcsts & 1 ?
+				nvme_rtype_to_scsi(resv_status->rtype) : 0;
+		full_status->descs[i].rel_tgt_port_id =
+				cpu_to_be16(le16_to_cpu(
+					resv_status->regctl_ds[i].cntlid));
+		full_status->descs[i].additional_len = cpu_to_be32(24);
+		memcpy(&hostid[8], (u8 *)&resv_status->regctl_ds[i].hostid, 8);
+		memcpy(full_status->descs[i].transport_id, hostid, sizeof(hostid));
+	}
+	res = nvme_trans_copy_to_user(hdr, full_status, 8 + addlen);
+ out:
+	kfree(full_status);
+	dma_free_coherent(&dev->pci_dev->dev, 4096, resv_status, dma_addr);
+	return res;
+}
+
+static int nvme_trans_prin(struct nvme_ns *ns, struct sg_io_hdr *hdr,
+							u8 *cmd)
+{
+	struct nvme_dev *dev = ns->dev;
+
+	if (!(dev->oncs & NVME_CTRL_ONCS_RESERVATIONS))
+		return nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
+				ILLEGAL_REQUEST, SCSI_ASC_ILLEGAL_COMMAND,
+				SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+	switch (cmd[1] & 0x1f) {
+	case 0: return nvme_trans_read_resv_keys(ns, hdr, cmd);
+	case 1: return nvme_trans_read_reservation(ns, hdr, cmd);
+	case 2: return nvme_trans_report_resv_caps(ns, hdr, cmd);
+	case 3: return nvme_trans_read_full_status(ns, hdr, cmd);
+	default:
+		return nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+	}
+}
+
+struct scsi_prout_parm_list {
+	__be64 rkey;
+	__be64 sarkey;
+	__u32  obsolete;
+	__u8   flags;
+	__u8   rsvd[3];
+};
+
+static int nvme_resv_register(struct nvme_ns *ns, struct sg_io_hdr *hdr,
+					u8 *cmd, bool iekey, bool move)
+{
+	struct nvme_dev *dev = ns->dev;
+	struct scsi_prout_parm_list parms;
+	int nvme_sc, res;
+	struct nvme_command c;
+	__le64 resv_keys[2];
+	u32 dw10 = iekey ? 1 << 3 : 0;
+	dma_addr_t dma_addr;
+
+	resv_keys[0] = 0;
+	resv_keys[1] = 0;
+
+	res = nvme_trans_copy_from_user(hdr, &parms, sizeof(parms));
+	if (res != SNTI_TRANSLATION_SUCCESS)
+		return res;
+	if (parms.flags & (1 << 3))
+		return nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST, SCSI_ASC_INVALID_PARAMETER,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+	if (move) {
+		resv_keys[0] = cpu_to_le64(be64_to_cpu(parms.rkey));
+		resv_keys[1] = cpu_to_le64(be64_to_cpu(parms.sarkey));
+		dw10 |= 2;
+	} else {
+		dw10 |= parms.flags & 1 ? (3 << 30) : (2 << 30);
+		if (bitmap_empty((unsigned long *)&parms.sarkey, 64)) {
+			resv_keys[0] = cpu_to_le64(be64_to_cpu(parms.rkey));
+			dw10 |= 1;
+		} else
+			resv_keys[1] = cpu_to_le64(be64_to_cpu(parms.sarkey));
+	}
+
+	dma_addr = dma_map_single(&ns->dev->pci_dev->dev, resv_keys,
+					sizeof(resv_keys), DMA_TO_DEVICE);
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = nvme_cmd_resv_register;
+	c.common.nsid = ns->ns_id;
+	c.common.prp1 = dma_addr;
+	c.common.cdw10[0] = cpu_to_le32(dw10);
+
+	nvme_sc = nvme_submit_io_cmd(dev, ns, &c, NULL);
+	res = nvme_trans_status_code(hdr, nvme_sc);
+
+	dma_unmap_single(&ns->dev->pci_dev->dev, dma_addr, sizeof(resv_keys),
+					DMA_TO_DEVICE);
+	return res;
+}
+
+static int nvme_resv_acquire(struct nvme_ns *ns, struct sg_io_hdr *hdr, u8 *cmd,
+							u8 racqa)
+{
+	struct nvme_dev *dev = ns->dev;
+	struct nvme_command c;
+	int nvme_sc, res;
+	struct scsi_prout_parm_list parms;
+	__le64 resv_keys[2];
+	dma_addr_t dma_addr;
+	u8 rtype = nvme_scsi_to_rtype(cmd[2] & 0xf);
+	u32 dw10 = racqa | ((u32)rtype << 8);
+
+	res = nvme_trans_copy_from_user(hdr, &parms, sizeof(parms));
+	if (res != SNTI_TRANSLATION_SUCCESS)
+		return res;
+	if (parms.flags & (1 << 3))
+		return nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST, SCSI_ASC_INVALID_PARAMETER,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+	resv_keys[0] = cpu_to_le64(be64_to_cpu(parms.rkey));
+	resv_keys[1] = cpu_to_le64(be64_to_cpu(parms.sarkey));
+
+	dma_addr = dma_map_single(&ns->dev->pci_dev->dev, resv_keys,
+					sizeof(resv_keys), DMA_TO_DEVICE);
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = nvme_cmd_resv_acquire;
+	c.common.nsid = ns->ns_id;
+	c.common.prp1 = dma_addr;
+	c.common.cdw10[0] = cpu_to_le32(dw10);
+
+	nvme_sc = nvme_submit_io_cmd(dev, ns, &c, NULL);
+	res = nvme_trans_status_code(hdr, nvme_sc);
+
+	dma_unmap_single(&ns->dev->pci_dev->dev, dma_addr, sizeof(resv_keys),
+					DMA_TO_DEVICE);
+	return res;
+}
+
+static int nvme_resv_release(struct nvme_ns *ns, struct sg_io_hdr *hdr, u8 *cmd,
+								u8 rrela)
+{
+	struct nvme_dev *dev = ns->dev;
+	struct nvme_command c;
+	int nvme_sc, res;
+	struct scsi_prout_parm_list parms;
+	__le64 crkey;
+	dma_addr_t dma_addr;
+	u8 rtype = nvme_scsi_to_rtype(cmd[2] & 0xf);
+	u32 dw10 = rrela | ((u32)rtype << 8);
+
+	res = nvme_trans_copy_from_user(hdr, &parms, sizeof(parms));
+	if (res != SNTI_TRANSLATION_SUCCESS)
+		return res;
+	if (parms.flags & (1 << 3))
+		return nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST, SCSI_ASC_INVALID_PARAMETER,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+	crkey = cpu_to_le64(be64_to_cpu(parms.rkey));
+	dma_addr = dma_map_single(&ns->dev->pci_dev->dev, &crkey,
+					sizeof(crkey), DMA_TO_DEVICE);
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = nvme_cmd_resv_release;
+	c.common.nsid = ns->ns_id;
+	c.common.prp1 = dma_addr;
+	c.common.cdw10[0] = cpu_to_le32(dw10);
+
+	nvme_sc = nvme_submit_io_cmd(dev, ns, &c, NULL);
+	res = nvme_trans_status_code(hdr, nvme_sc);
+
+	dma_unmap_single(&ns->dev->pci_dev->dev, dma_addr, sizeof(crkey),
+					DMA_TO_DEVICE);
+	return res;
+}
+
+static int nvme_trans_prout(struct nvme_ns *ns, struct sg_io_hdr *hdr,
+							u8 *cmd)
+{
+	struct nvme_dev *dev = ns->dev;
+
+	if (!(dev->oncs & NVME_CTRL_ONCS_RESERVATIONS))
+		return nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
+				ILLEGAL_REQUEST, SCSI_ASC_ILLEGAL_COMMAND,
+				SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+	switch (cmd[1] & 0x1f) {
+	case 0: return nvme_resv_register(ns, hdr, cmd, false, false);
+	case 6: return nvme_resv_register(ns, hdr, cmd, true, false);
+	case 7: return nvme_resv_register(ns, hdr, cmd, false, true);
+	case 1: return nvme_resv_acquire(ns, hdr, cmd, 0);
+	case 4: return nvme_resv_acquire(ns, hdr, cmd, 1);
+	case 5: return nvme_resv_acquire(ns, hdr, cmd, 2);
+	case 2: return nvme_resv_release(ns, hdr, cmd, 0);
+	case 3: return nvme_resv_release(ns, hdr, cmd, 1);
+	default:
+		return nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+	}
+}
+
 static int nvme_scsi_translate(struct nvme_ns *ns, struct sg_io_hdr *hdr)
 {
 	u8 cmd[BLK_MAX_CDB];
@@ -3001,6 +3447,12 @@ static int nvme_scsi_translate(struct nvme_ns *ns, struct sg_io_hdr *hdr)
 	case UNMAP:
 		retcode = nvme_trans_unmap(ns, hdr, cmd);
 		break;
+	case PERSISTENT_RESERVE_IN:
+		retcode = nvme_trans_prin(ns, hdr, cmd);
+		break;
+	case PERSISTENT_RESERVE_OUT:
+		retcode = nvme_trans_prout(ns, hdr, cmd);
+		break;
 	default:
  out:
 		retcode = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 0adad4a..7c51f8f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -119,6 +119,7 @@ struct nvme_ns {
 	int lba_shift;
 	int ms;
 	int pi_type;
+	u8 rescap;
 	u64 mode_select_num_blocks;
 	u32 mode_select_block_len;
 };
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index aef9a81..50d28fc 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -89,6 +89,9 @@ enum {
 	NVME_CTRL_ONCS_COMPARE			= 1 << 0,
 	NVME_CTRL_ONCS_WRITE_UNCORRECTABLE	= 1 << 1,
 	NVME_CTRL_ONCS_DSM			= 1 << 2,
+	NVME_CTRL_ONCS_WRITE_ZEROS		= 1 << 3,
+	NVME_CTRL_ONCS_SAVE_SET_FEATURES	= 1 << 4,
+	NVME_CTRL_ONCS_RESERVATIONS		= 1 << 5,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 };
 
@@ -146,6 +149,13 @@ enum {
 	NVME_NS_DPS_PI_TYPE1	= 1,
 	NVME_NS_DPS_PI_TYPE2	= 2,
 	NVME_NS_DPS_PI_TYPE3	= 3,
+	NVME_NS_RESCAP_PTPL	= 1 << 0,
+	NVME_NS_RESCAP_WR_EX	= 1 << 1,
+	NVME_NS_RESCAP_EX_AC	= 1 << 2,
+	NVME_NS_RESCAP_WR_EX_RO	= 1 << 3,
+	NVME_NS_RESCAP_EX_AC_RO	= 1 << 4,
+	NVME_NS_RESCAP_WR_EX_AR	= 1 << 5,
+	NVME_NS_RESCAP_EX_AC_AR	= 1 << 6,
 };
 
 struct nvme_smart_log {
-- 
1.7.10.4
