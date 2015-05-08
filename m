From: hch@lst.de (Christoph Hellwig)
Date: Fri,  8 May 2015 18:00:34 +0200
Subject: [PATCH 09/11] nvme: report the DPOFUA in MODE_SENSE
In-Reply-To: <1431100836-28112-1-git-send-email-hch@lst.de>
References: <1431100836-28112-1-git-send-email-hch@lst.de>
Message-ID: <1431100836-28112-10-git-send-email-hch@lst.de>

NVMe device always support the FUA bit, and the SCSI translations
accepts the DPO bit, which doesn't have much of a meaning for us.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-scsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index 56f2790..19b21cc 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -998,14 +998,14 @@ static int nvme_trans_fill_mode_parm_hdr(u8 *resp, int len, u8 cdb10, u8 llbaa,
 	if (cdb10) {
 		resp[0] = (mode_data_length & 0xFF00) >> 8;
 		resp[1] = (mode_data_length & 0x00FF);
-		/* resp[2] and [3] are zero */
+		resp[3] = 0x10 /* DPOFUA */;
 		resp[4] = llbaa;
 		resp[5] = RESERVED_FIELD;
 		resp[6] = (blk_desc_len & 0xFF00) >> 8;
 		resp[7] = (blk_desc_len & 0x00FF);
 	} else {
 		resp[0] = (mode_data_length & 0x00FF);
-		/* resp[1] and [2] are zero */
+		resp[2] = 0x10 /* DPOFUA */;
 		resp[3] = (blk_desc_len & 0x00FF);
 	}
 
-- 
1.9.1
