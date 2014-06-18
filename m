From: daniel.mcleran@intel.com (Dan McLeran)
Date: Wed, 18 Jun 2014 03:03:08 -0600
Subject: [PATCH] NVMe: Fail SCSI->NVMe translation for UNMAP when anchor is set
Message-ID: <1403082188-4852-1-git-send-email-daniel.mcleran@intel.com>

SCSI UNMAP should fail if the host sends down the command with Anchor set. The
current code does not check this condition. This patch checks Anchor and fails
Scsi->NVMe translation if Anchor is set.

Signed-off-by: Dan McLeran <daniel.mcleran at intel.com>
---
 drivers/block/nvme-scsi.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index a4cd6d6..5bcbe04 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -96,6 +96,8 @@ static int sg_version_num = 30534;	/* 2 digits for each component */
 #define FORMAT_UNIT_PROT_INT_OFFSET			3
 #define FORMAT_UNIT_PROT_FIELD_USAGE_OFFSET		0
 #define FORMAT_UNIT_PROT_FIELD_USAGE_MASK		0x07
+#define UNMAP_CDB_PARAM_ANCHOR_OFFSET			1
+#define UNMAP_CDB_PARAM_ANCHOR_MASK				0x1
 #define UNMAP_CDB_PARAM_LIST_LENGTH_OFFSET		7
 
 /* Misc. defines */
@@ -2855,6 +2857,7 @@ static int nvme_trans_unmap(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	struct nvme_dsm_range *range;
 	struct nvme_command c;
 	int i, nvme_sc, res = -ENOMEM;
+	u8 anchor;
 	u16 ndesc, list_len;
 	dma_addr_t dma_addr;
 
@@ -2870,6 +2873,15 @@ static int nvme_trans_unmap(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	if (res != SNTI_TRANSLATION_SUCCESS)
 		goto out;
 
+	anchor = GET_U8_FROM_CDB(cmd, UNMAP_CDB_PARAM_ANCHOR_OFFSET);
+	anchor &= UNMAP_CDB_PARAM_ANCHOR_MASK;
+	if (anchor != 0) {
+		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
+				ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
+				SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+		goto out;
+	}
+
 	ndesc = be16_to_cpu(plist->unmap_blk_desc_data_len) >> 4;
 	if (!ndesc || ndesc > 256) {
 		res = -EINVAL;
-- 
1.7.10.4
