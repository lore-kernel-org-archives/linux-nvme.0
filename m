From: hch@lst.de (Christoph Hellwig)
Date: Fri,  8 May 2015 18:00:26 +0200
Subject: [PATCH 01/11] nvme: fix kernel memory corruption with short INQUIRY
 buffers
In-Reply-To: <1431100836-28112-1-git-send-email-hch@lst.de>
References: <1431100836-28112-1-git-send-email-hch@lst.de>
Message-ID: <1431100836-28112-2-git-send-email-hch@lst.de>

If userspace asks for an INQUIRY buffer smaller than 36 bytes, the SCSI
translation layer will happily write past the end of the INQUIRY buffer
allocation.

This is fairly easily reproducible by running the libiscsi test
suite and then starting an xfstests run.

Fixes: 4f1982 ("NVMe: Update SCSI Inquiry VPD 83h translation")
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-scsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index 6b736b0..aea2498 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -2256,7 +2256,8 @@ static int nvme_trans_inquiry(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	page_code = GET_INQ_PAGE_CODE(cmd);
 	alloc_len = GET_INQ_ALLOC_LENGTH(cmd);
 
-	inq_response = kmalloc(alloc_len, GFP_KERNEL);
+	inq_response = kmalloc(max(alloc_len, STANDARD_INQUIRY_LENGTH),
+				GFP_KERNEL);
 	if (inq_response == NULL) {
 		res = -ENOMEM;
 		goto out_mem;
-- 
1.9.1
