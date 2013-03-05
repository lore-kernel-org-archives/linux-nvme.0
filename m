From: y@dcgshare.lm.intel.com (y@dcgshare.lm.intel.com)
Date: Mon,  4 Mar 2013 17:24:21 -0700
Subject: [PATCH 2/4] fs: Starting sector size calculation
In-Reply-To: <y>
References: <y>
Message-ID: <1362443063-18994-3-git-send-email-y>

From: Keith Busch <keith.busch@intel.com>

Use the block device sector size to calculate the starting sector when
generating and verifying the data integrity.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 fs/bio-integrity.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/bio-integrity.c b/fs/bio-integrity.c
index a3f28f3..cf135df 100644
--- a/fs/bio-integrity.c
+++ b/fs/bio-integrity.c
@@ -335,7 +335,7 @@ static void bio_integrity_generate(struct bio *bio)
 	struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
 	struct blk_integrity_exchg bix;
 	struct bio_vec *bv;
-	sector_t sector = bio->bi_sector;
+	sector_t sector = (bio->bi_sector << 9) / bi->sector_size;
 	unsigned int i, sectors, total;
 	void *prot_buf = bio->bi_integrity->bip_buf;
 
@@ -476,7 +476,7 @@ static int bio_integrity_verify(struct bio *bio)
 	struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
 	struct blk_integrity_exchg bix;
 	struct bio_vec *bv;
-	sector_t sector = bio->bi_integrity->bip_sector;
+	sector_t sector = (bio->bi_sector << 9) / bi->sector_size;
 	unsigned int i, sectors, total, ret;
 	void *prot_buf = bio->bi_integrity->bip_buf;
 
-- 
1.7.0.4
