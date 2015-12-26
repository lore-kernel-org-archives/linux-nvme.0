From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Sat, 26 Dec 2015 19:19:03 +0100
Subject: [PATCH] nvme: consolidate kmallc + memset 0 into kzalloc
Message-ID: <1451153943-8725-1-git-send-email-hofrat@osadl.org>

This is an API consolidation only. The use of kmalloc + memset to 0
here should be equivalent to kzalloc.

Signed-off-by: Nicholas Mc Guire <hofrat at osadl.org>
---

Found by coccinelle script (relaxed version of
scripts/coccinelle/api/alloc/kzalloc-simple.cocci)

Patch was compile tested with: x86_64_defconfig
CONFIG_BLK_DEV_NVME=m

Patch is against linux-next (localversion-next is -next-20151222)

 drivers/nvme/host/scsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index e947e29..8f447e3 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -715,7 +715,7 @@ static int nvme_trans_ext_inq_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	u8 v_sup;
 	u8 luiclr = 0x01;
 
-	inq_response = kmalloc(EXTENDED_INQUIRY_DATA_PAGE_LENGTH, GFP_KERNEL);
+	inq_response = kzalloc(EXTENDED_INQUIRY_DATA_PAGE_LENGTH, GFP_KERNEL);
 	if (inq_response == NULL)
 		return -ENOMEM;
 
@@ -743,7 +743,6 @@ static int nvme_trans_ext_inq_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	v_sup = id_ctrl->vwc;
 	kfree(id_ctrl);
 
-	memset(inq_response, 0, EXTENDED_INQUIRY_DATA_PAGE_LENGTH);
 	inq_response[1] = INQ_EXTENDED_INQUIRY_DATA_PAGE;    /* Page Code */
 	inq_response[2] = 0x00;    /* Page Length MSB */
 	inq_response[3] = 0x3C;    /* Page Length LSB */
-- 
2.1.4
