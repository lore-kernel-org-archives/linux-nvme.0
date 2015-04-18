From: hch@lst.de (Christoph Hellwig)
Date: Sat, 18 Apr 2015 22:27:42 +0200
Subject: [PATCH 6/8] nvme: handle invalid SCSI LBAs correctly
In-Reply-To: <1429388864-29648-1-git-send-email-hch@lst.de>
References: <1429388864-29648-1-git-send-email-hch@lst.de>
Message-ID: <1429388864-29648-7-git-send-email-hch@lst.de>

Trap LBAs behind the end of the device and return the correct
sense code.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-scsi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index d1b7627..5feaa68 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -1879,6 +1879,7 @@ static int nvme_trans_do_nvme_io(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 static int nvme_trans_io(struct nvme_ns *ns, struct sg_io_hdr *hdr, u8 is_write,
 							u8 *cmd)
 {
+	sector_t dev_blocks = get_capacity(ns->disk);
 	int res = 0;
 	struct nvme_trans_io_cdb cdb_info = { 0, };
 	u8 opcode = cmd[0];
@@ -1962,6 +1963,15 @@ static int nvme_trans_io(struct nvme_ns *ns, struct sg_io_hdr *hdr, u8 is_write,
 		goto out;
 	}
 
+	/* Reject IO beyong EOL */
+	if (dev_blocks < cdb_info.xfer_len ||
+	    dev_blocks - cdb_info.xfer_len < cdb_info.lba) {
+		return nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
+					SCSI_ASC_ILLEGAL_BLOCK,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+	}
+
 	/* Check for 0 length transfer - it is not illegal */
 	if (cdb_info.xfer_len == 0)
 		goto out;
-- 
1.9.1
