From: keith.busch@intel.com (Keith Busch)
Date: Thu, 21 Mar 2013 11:52:03 -0600
Subject: [PATCH v2 3/7] sd: hw sector size calculation
In-Reply-To: <1363888327-7420-1-git-send-email-keith.busch@intel.com>
References: <1363888327-7420-1-git-send-email-keith.busch@intel.com>
Message-ID: <1363888327-7420-4-git-send-email-keith.busch@intel.com>

Fixes the calculating the number of sectors and starting sector related
to protection information. The calculation uses shifting and requires the
sector sizes be a power of 2 >= 512, which I think is true for all drives.

Cc: Martin K. Petersen <martin.petersen at oracle.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>

I try to avoid full divides in an IO path if possible hence the shift
operations, but if this is too obscure or there are valid block formats
where this wouldn't work, happy to change it to something else.
---
 drivers/scsi/sd_dif.c |   12 ++++++------
 fs/bio-integrity.c    |   11 ++++-------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/sd_dif.c b/drivers/scsi/sd_dif.c
index 7cf0a39..aae5507 100644
--- a/drivers/scsi/sd_dif.c
+++ b/drivers/scsi/sd_dif.c
@@ -376,7 +376,8 @@ void sd_dif_prepare(struct request *rq, sector_t hw_sector,
 		if (bio_flagged(bio, BIO_MAPPED_INTEGRITY))
 			break;
 
-		virt = bio->bi_integrity->bip_sector & 0xffffffff;
+		virt = (bio->bi_integrity->bip_sector >>
+				(__ffs(sector_sz) - 9)) & 0xffffffff;
 
 		bip_for_each_vec(iv, bio->bi_integrity, i) {
 			sdt = kmap_atomic(iv->bv_page)
@@ -419,14 +420,13 @@ void sd_dif_complete(struct scsi_cmnd *scmd, unsigned int good_bytes)
 	sector_sz = scmd->device->sector_size;
 	sectors = good_bytes / sector_sz;
 
-	phys = blk_rq_pos(scmd->request) & 0xffffffff;
-	if (sector_sz == 4096)
-		phys >>= 3;
-
+	phys = (blk_rq_pos(scmd->request) >> (__ffs(sector_sz) - 9)) &
+								0xffffffff;
 	__rq_for_each_bio(bio, scmd->request) {
 		struct bio_vec *iv;
 
-		virt = bio->bi_integrity->bip_sector & 0xffffffff;
+		virt = (bio->bi_integrity->bip_sector >>
+					(__ffs(sector_sz) - 9)) & 0xffffffff;
 
 		bip_for_each_vec(iv, bio->bi_integrity, i) {
 			sdt = kmap_atomic(iv->bv_page)
diff --git a/fs/bio-integrity.c b/fs/bio-integrity.c
index a3f28f3..b4ab7da 100644
--- a/fs/bio-integrity.c
+++ b/fs/bio-integrity.c
@@ -231,11 +231,7 @@ EXPORT_SYMBOL(bio_integrity_enabled);
 static inline unsigned int bio_integrity_hw_sectors(struct blk_integrity *bi,
 						    unsigned int sectors)
 {
-	/* At this point there are only 512b or 4096b DIF/EPP devices */
-	if (bi->sector_size == 4096)
-		return sectors >>= 3;
-
-	return sectors;
+	return sectors >> (__ffs(bi->sector_size) - 9);
 }
 
 /**
@@ -335,7 +331,7 @@ static void bio_integrity_generate(struct bio *bio)
 	struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
 	struct blk_integrity_exchg bix;
 	struct bio_vec *bv;
-	sector_t sector = bio->bi_sector;
+	sector_t sector = bio->bi_sector >> (__ffs(bi->sector_size) - 9);
 	unsigned int i, sectors, total;
 	void *prot_buf = bio->bi_integrity->bip_buf;
 
@@ -476,7 +472,8 @@ static int bio_integrity_verify(struct bio *bio)
 	struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
 	struct blk_integrity_exchg bix;
 	struct bio_vec *bv;
-	sector_t sector = bio->bi_integrity->bip_sector;
+	sector_t sector = bio->bi_integrity->bip_sector >>
+						(__ffs(bi->sector_size) - 9);
 	unsigned int i, sectors, total, ret;
 	void *prot_buf = bio->bi_integrity->bip_buf;
 
-- 
1.7.0.4
