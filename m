From: linux@rasmusvillemoes.dk (Rasmus Villemoes)
Date: Wed, 30 Sep 2015 21:48:50 +0200
Subject: [PATCH] block: nvme-scsi: use kzalloc in nvme_trans_ext_inq_page()
Message-ID: <1443642530-2573-1-git-send-email-linux@rasmusvillemoes.dk>

This saves a little .text and is consistent with similar allocations
in the rest of the file.

Signed-off-by: Rasmus Villemoes <linux at rasmusvillemoes.dk>
---
 drivers/block/nvme-scsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index e5a63f06fb0f..efe562b81127 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -684,7 +684,7 @@ static int nvme_trans_ext_inq_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	u8 v_sup;
 	u8 luiclr = 0x01;
 
-	inq_response = kmalloc(EXTENDED_INQUIRY_DATA_PAGE_LENGTH, GFP_KERNEL);
+	inq_response = kzalloc(EXTENDED_INQUIRY_DATA_PAGE_LENGTH, GFP_KERNEL);
 	if (inq_response == NULL)
 		return -ENOMEM;
 
@@ -712,7 +712,6 @@ static int nvme_trans_ext_inq_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	v_sup = id_ctrl->vwc;
 	kfree(id_ctrl);
 
-	memset(inq_response, 0, EXTENDED_INQUIRY_DATA_PAGE_LENGTH);
 	inq_response[1] = INQ_EXTENDED_INQUIRY_DATA_PAGE;    /* Page Code */
 	inq_response[2] = 0x00;    /* Page Length MSB */
 	inq_response[3] = 0x3C;    /* Page Length LSB */
-- 
2.1.3
