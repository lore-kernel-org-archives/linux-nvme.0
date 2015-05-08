From: hch@lst.de (Christoph Hellwig)
Date: Fri,  8 May 2015 18:00:35 +0200
Subject: [PATCH 10/11] nvme: fail SCSI read/write command with unsupported
 protection bit
In-Reply-To: <1431100836-28112-1-git-send-email-hch@lst.de>
References: <1431100836-28112-1-git-send-email-hch@lst.de>
Message-ID: <1431100836-28112-11-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-scsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index 19b21cc..469a634 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -1899,6 +1899,13 @@ static int nvme_trans_io(struct nvme_ns *ns, struct sg_io_hdr *hdr, u8 is_write,
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
