From: hch@lst.de (Christoph Hellwig)
Date: Sat, 18 Apr 2015 22:27:44 +0200
Subject: [PATCH 8/8] nvme: fail SCSI read/write command with unsupported
 protection bit
In-Reply-To: <1429388864-29648-1-git-send-email-hch@lst.de>
References: <1429388864-29648-1-git-send-email-hch@lst.de>
Message-ID: <1429388864-29648-9-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-scsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index d693228..cf2b6c0 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -1900,6 +1900,13 @@ static int nvme_trans_io(struct nvme_ns *ns, struct sg_io_hdr *hdr, u8 is_write,
 	default:
 		cdb_info.fua = cmd[1] & 0x8;
 		cdb_info.prot_info = (cmd[1] & 0xe0) >> 5;
+		if (cdb_info.prot_info && !ns->pi_type) {
+			return nvme_trans_completion(hdr,
+					SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
+					SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+		}
 	}
 
 	switch (opcode) {
-- 
1.9.1
