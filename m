From: hare@suse.de (Hannes Reinecke)
Date: Tue,  4 Nov 2014 08:12:47 +0100
Subject: [PATCH] nvme: fixup compiler warning
Message-ID: <1415085167-128130-1-git-send-email-hare@suse.de>

gcc complains about a variable not initialized properly.

Cc: Matthew Wilcox <willy at linux.intel.com>
Signed-off-by: Hannes Reinecke <hare at suse.de>
---
 drivers/block/nvme-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e2bb8af..ff37b9f 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -571,7 +571,7 @@ static int nvme_split_and_submit(struct bio *bio, struct nvme_queue *nvmeq,
 static int nvme_map_bio(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 		struct bio *bio, enum dma_data_direction dma_dir, int psegs)
 {
-	struct bio_vec bvec, bvprv;
+	struct bio_vec bvec, bvprv = {.bv_offset = 0, .bv_len = 0};
 	struct bvec_iter iter;
 	struct scatterlist *sg = NULL;
 	int length = 0, nsegs = 0, split_len = bio->bi_iter.bi_size;
-- 
1.8.5.2
