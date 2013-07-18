From: keith.busch@intel.com (Keith Busch)
Date: Thu, 18 Jul 2013 12:13:51 -0600
Subject: [PATCH] NVMe: Fix checkpatch issues
Message-ID: <1374171231-24123-1-git-send-email-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7de80bb..7439499 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -452,10 +452,8 @@ static void nvme_bio_pair_endio(struct bio *bio, int err)
 
 	if (atomic_dec_and_test(&bp->cnt)) {
 		bio_endio(bp->parent, bp->err);
-		if (bp->bv1)
-			kfree(bp->bv1);
-		if (bp->bv2)
-			kfree(bp->bv2);
+		kfree(bp->bv1);
+		kfree(bp->bv2);
 		kfree(bp);
 	}
 }
@@ -1349,7 +1347,8 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	c.rw.appmask = cpu_to_le16(io.appmask);
 
 	if (meta_len) {
-		meta_iod = nvme_map_user_pages(dev, io.opcode & 1, io.metadata, meta_len);
+		meta_iod = nvme_map_user_pages(dev, io.opcode & 1, io.metadata,
+								meta_len);
 		if (IS_ERR(meta_iod)) {
 			status = PTR_ERR(meta_iod);
 			meta_iod = NULL;
-- 
1.7.0.4
