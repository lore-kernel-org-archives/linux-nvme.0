From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 21 Apr 2015 13:32:17 -0700
Subject: [PATCH 9/8] nvme: fix kernel memory corruption with short INQUIRY
 buffers
In-Reply-To: <1429388864-29648-1-git-send-email-hch@lst.de>
References: <1429388864-29648-1-git-send-email-hch@lst.de>
Message-ID: <20150421203217.GA30340@infradead.org>

If userspace asks for less than 36 byte INQUIRY buffers the SCSI
translation layer will happily write pas the end of the allocation.

This is fairly easily reproducible by running the libiscsi test
suite and then starting an xfstests run.

Fixes: 4f1982 ("NVMe: Update SCSI Inquiry VPD 83h translation")
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-scsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index cf2b6c0..b92ff76 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -2005,7 +2005,8 @@ static int nvme_trans_inquiry(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	page_code = cmd[2];
 	alloc_len = get_unaligned_be16(&cmd[3]);
 
-	inq_response = kmalloc(alloc_len, GFP_KERNEL);
+	inq_response = kmalloc(max(alloc_len, STANDARD_INQUIRY_LENGTH),
+				GFP_KERNEL);
 	if (inq_response == NULL) {
 		res = -ENOMEM;
 		goto out_mem;
-- 
1.9.1
