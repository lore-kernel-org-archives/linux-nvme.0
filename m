From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Sep 2016 20:23:09 -0700
Subject: [PATCH 18/18] add missing endianess conversions in lnvm_do_set_bbtbl
In-Reply-To: <1474600989-16657-1-git-send-email-hch@lst.de>
References: <1474600989-16657-1-git-send-email-hch@lst.de>
Message-ID: <1474600989-16657-19-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 nvme-lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-lightnvm.c b/nvme-lightnvm.c
index 1575366..2c6b5d2 100644
--- a/nvme-lightnvm.c
+++ b/nvme-lightnvm.c
@@ -432,7 +432,7 @@ int lnvm_do_set_bbtbl(int fd, int nsid,
 	if (chid >= nvm_id.groups[0].num_ch ||
 					lunid >= nvm_id.groups[0].num_lun ||
 					plnid >= nvm_id.groups[0].num_pln ||
-					blkid >= nvm_id.groups[0].num_blk) {
+					blkid >= le16_to_cpu(nvm_id.groups[0].num_blk)) {
 		fprintf(stderr, "Out of bound channel id, LUN id, plane id, or"\
 				"block id\n");
 		return -EINVAL;
-- 
2.1.4
