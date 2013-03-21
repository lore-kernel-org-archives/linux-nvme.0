From: keith.busch@intel.com (Keith Busch)
Date: Thu, 21 Mar 2013 11:52:04 -0600
Subject: [PATCH v2 4/7] sd: arbitrary dif meta-data sizes
In-Reply-To: <1363888327-7420-1-git-send-email-keith.busch@intel.com>
References: <1363888327-7420-1-git-send-email-keith.busch@intel.com>
Message-ID: <1363888327-7420-5-git-send-email-keith.busch@intel.com>

Possible block formats with protection information may have larger
meta-data per physical block than an 8byte DIF. The first 8 bytes of
the meta-data region are for DIF data, while the remaining meta-data
is application specific. The size of the integrity buffer is already
allocated large enough for the meta-data size per sector, but accessing
the integrity buffer assumed meta-data region per sector was the size
of the DIF tuple. This patch updates the DIF tuple accesses to take into
account size of the block meta-data.

Cc: Martin K. Petersen <martin.petersen at oracle.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/scsi/sd_dif.c  |   86 ++++++++++++++++++++++++++++++++---------------
 fs/bio-integrity.c     |    8 +++-
 include/linux/blkdev.h |    5 ++-
 3 files changed, 67 insertions(+), 32 deletions(-)

diff --git a/drivers/scsi/sd_dif.c b/drivers/scsi/sd_dif.c
index aae5507..1735513 100644
--- a/drivers/scsi/sd_dif.c
+++ b/drivers/scsi/sd_dif.c
@@ -56,16 +56,19 @@ static __u16 sd_dif_ip_fn(void *data, unsigned int len)
 static void sd_dif_type1_generate(struct blk_integrity_exchg *bix, csum_fn *fn)
 {
 	void *buf = bix->data_buf;
-	struct sd_dif_tuple *sdt = bix->prot_buf;
+	void *tuple = bix->prot_buf;
 	sector_t sector = bix->sector;
+	struct sd_dif_tuple *sdt;
 	unsigned int i;
 
-	for (i = 0 ; i < bix->data_size ; i += bix->sector_size, sdt++) {
+	for (i = 0 ; i < bix->data_size ; i += bix->sector_size) {
+		sdt = tuple;
 		sdt->guard_tag = fn(buf, bix->sector_size);
 		sdt->ref_tag = cpu_to_be32(sector & 0xffffffff);
 		sdt->app_tag = 0;
 
 		buf += bix->sector_size;
+		tuple += bix->tuple_size;
 		sector++;
 	}
 }
@@ -84,11 +87,15 @@ static int sd_dif_type1_verify(struct blk_integrity_exchg *bix, csum_fn *fn)
 {
 	void *buf = bix->data_buf;
 	void *end = buf + bix->data_size;
-	struct sd_dif_tuple *sdt = bix->prot_buf;
+	void *tuple = bix->prot_buf;
+	struct sd_dif_tuple *sdt;
 	sector_t sector = bix->sector;
 	__u16 csum;
 
-	for (; buf < end; buf += bix->sector_size, sdt++, sector++) {
+	for (; buf < end; buf += bix->sector_size, tuple += bix->tuple_size,
+								sector++) {
+		sdt = tuple;
+
 		/* Unwritten sectors */
 		if (sdt->app_tag == 0xffff)
 			continue;
@@ -128,25 +135,31 @@ static int sd_dif_type1_verify_ip(struct blk_integrity_exchg *bix)
 /*
  * Functions for interleaving and deinterleaving application tags
  */
-static void sd_dif_type1_set_tag(void *prot, void *tag_buf, unsigned int sectors)
+static void sd_dif_type1_set_tag(void *prot, void *tag_buf, unsigned int sectors,
+							unsigned short tuple_size)
 {
-	struct sd_dif_tuple *sdt = prot;
+	void *tuple = prot;
 	u8 *tag = tag_buf;
+	struct sd_dif_tuple *sdt;
 	unsigned int i, j;
 
-	for (i = 0, j = 0 ; i < sectors ; i++, j += 2, sdt++) {
+	for (i = 0, j = 0 ; i < sectors ; i++, j += 2, tuple += tuple_size) {
+		sdt = tuple;
 		sdt->app_tag = tag[j] << 8 | tag[j+1];
 		BUG_ON(sdt->app_tag == 0xffff);
 	}
 }
 
-static void sd_dif_type1_get_tag(void *prot, void *tag_buf, unsigned int sectors)
+static void sd_dif_type1_get_tag(void *prot, void *tag_buf, unsigned int sectors,
+							unsigned short tuple_size)
 {
-	struct sd_dif_tuple *sdt = prot;
+	void *tuple = prot;
 	u8 *tag = tag_buf;
+	struct sd_dif_tuple *sdt;
 	unsigned int i, j;
 
-	for (i = 0, j = 0 ; i < sectors ; i++, j += 2, sdt++) {
+	for (i = 0, j = 0 ; i < sectors ; i++, j += 2, tuple += tuple_size) {
+		sdt = tuple;
 		tag[j] = (sdt->app_tag & 0xff00) >> 8;
 		tag[j+1] = sdt->app_tag & 0xff;
 	}
@@ -180,15 +193,18 @@ static struct blk_integrity dif_type1_integrity_ip = {
 static void sd_dif_type3_generate(struct blk_integrity_exchg *bix, csum_fn *fn)
 {
 	void *buf = bix->data_buf;
-	struct sd_dif_tuple *sdt = bix->prot_buf;
+	void *tuple = bix->prot_buf;
+	struct sd_dif_tuple *sdt;
 	unsigned int i;
 
-	for (i = 0 ; i < bix->data_size ; i += bix->sector_size, sdt++) {
+	for (i = 0 ; i < bix->data_size ; i += bix->sector_size) {
+		sdt = tuple;
 		sdt->guard_tag = fn(buf, bix->sector_size);
 		sdt->ref_tag = 0;
 		sdt->app_tag = 0;
 
 		buf += bix->sector_size;
+		tuple += bix->tuple_size;
 	}
 }
 
@@ -206,11 +222,15 @@ static int sd_dif_type3_verify(struct blk_integrity_exchg *bix, csum_fn *fn)
 {
 	void *buf = bix->data_buf;
 	void *end = buf + bix->data_size;
-	struct sd_dif_tuple *sdt = bix->prot_buf;
+	void *tuple = bix->prot_buf;
 	sector_t sector = bix->sector;
+	struct sd_dif_tuple *sdt;
 	__u16 csum;
 
-	for (; buf < end; buf += bix->sector_size, sdt++, sector++) {
+	for (; buf < end; buf += bix->sector_size, tuple += bix->tuple_size,
+								sector++) {
+		sdt = tuple;
+
 		/* Unwritten sectors */
 		if (sdt->app_tag == 0xffff && sdt->ref_tag == 0xffffffff)
 			continue;
@@ -239,26 +259,32 @@ static int sd_dif_type3_verify_ip(struct blk_integrity_exchg *bix)
 	return sd_dif_type3_verify(bix, sd_dif_ip_fn);
 }
 
-static void sd_dif_type3_set_tag(void *prot, void *tag_buf, unsigned int sectors)
+static void sd_dif_type3_set_tag(void *prot, void *tag_buf, unsigned int sectors,
+							unsigned short tuple_size)
 {
-	struct sd_dif_tuple *sdt = prot;
+	void *tuple = prot;
 	u8 *tag = tag_buf;
+	struct sd_dif_tuple *sdt;
 	unsigned int i, j;
 
-	for (i = 0, j = 0 ; i < sectors ; i++, j += 6, sdt++) {
+	for (i = 0, j = 0 ; i < sectors ; i++, j += 6, tuple += tuple_size) {
+		sdt = tuple;
 		sdt->app_tag = tag[j] << 8 | tag[j+1];
 		sdt->ref_tag = tag[j+2] << 24 | tag[j+3] << 16 |
 			tag[j+4] << 8 | tag[j+5];
 	}
 }
 
-static void sd_dif_type3_get_tag(void *prot, void *tag_buf, unsigned int sectors)
+static void sd_dif_type3_get_tag(void *prot, void *tag_buf, unsigned int sectors,
+							unsigned short tuple_size)
 {
-	struct sd_dif_tuple *sdt = prot;
+	void *tuple = prot;
 	u8 *tag = tag_buf;
+	struct sd_dif_tuple *sdt;
 	unsigned int i, j;
 
-	for (i = 0, j = 0 ; i < sectors ; i++, j += 2, sdt++) {
+	for (i = 0, j = 0 ; i < sectors ; i++, j += 2, tuple += tuple_size) {
+		sdt = tuple;
 		tag[j] = (sdt->app_tag & 0xff00) >> 8;
 		tag[j+1] = sdt->app_tag & 0xff;
 		tag[j+2] = (sdt->ref_tag & 0xff000000) >> 24;
@@ -355,14 +381,15 @@ void sd_dif_config_host(struct scsi_disk *sdkp)
 void sd_dif_prepare(struct request *rq, sector_t hw_sector,
 		    unsigned int sector_sz)
 {
-	const int tuple_sz = sizeof(struct sd_dif_tuple);
 	struct bio *bio;
 	struct scsi_disk *sdkp;
 	struct sd_dif_tuple *sdt;
+	struct blk_integrity *bi;
 	unsigned int i, j;
 	u32 phys, virt;
 
 	sdkp = rq->bio->bi_bdev->bd_disk->private_data;
+	bi = bdev_get_integrity(rq->bio->bi_bdev);
 
 	if (sdkp->protection_type == SD_DIF_TYPE3_PROTECTION)
 		return;
@@ -380,14 +407,15 @@ void sd_dif_prepare(struct request *rq, sector_t hw_sector,
 				(__ffs(sector_sz) - 9)) & 0xffffffff;
 
 		bip_for_each_vec(iv, bio->bi_integrity, i) {
-			sdt = kmap_atomic(iv->bv_page)
+			void *tuple = kmap_atomic(iv->bv_page)
 				+ iv->bv_offset;
 
-			for (j = 0 ; j < iv->bv_len ; j += tuple_sz, sdt++) {
-
+			for (j = 0 ; j < iv->bv_len ; j += bi->tuple_size) {
+				sdt = tuple;
 				if (be32_to_cpu(sdt->ref_tag) == virt)
 					sdt->ref_tag = cpu_to_be32(phys);
 
+				tuple += bi->tuple_size;
 				virt++;
 				phys++;
 			}
@@ -405,14 +433,15 @@ void sd_dif_prepare(struct request *rq, sector_t hw_sector,
  */
 void sd_dif_complete(struct scsi_cmnd *scmd, unsigned int good_bytes)
 {
-	const int tuple_sz = sizeof(struct sd_dif_tuple);
 	struct scsi_disk *sdkp;
 	struct bio *bio;
 	struct sd_dif_tuple *sdt;
+	struct blk_integrity *bi;
 	unsigned int i, j, sectors, sector_sz;
 	u32 phys, virt;
 
 	sdkp = scsi_disk(scmd->request->rq_disk);
+	bi = bdev_get_integrity(scmd->request->bio->bi_bdev);
 
 	if (sdkp->protection_type == SD_DIF_TYPE3_PROTECTION || good_bytes == 0)
 		return;
@@ -429,11 +458,11 @@ void sd_dif_complete(struct scsi_cmnd *scmd, unsigned int good_bytes)
 					(__ffs(sector_sz) - 9)) & 0xffffffff;
 
 		bip_for_each_vec(iv, bio->bi_integrity, i) {
-			sdt = kmap_atomic(iv->bv_page)
+			void *tuple = kmap_atomic(iv->bv_page)
 				+ iv->bv_offset;
 
-			for (j = 0 ; j < iv->bv_len ; j += tuple_sz, sdt++) {
-
+			for (j = 0 ; j < iv->bv_len ; j += bi->tuple_size) {
+				sdt = tuple;
 				if (sectors == 0) {
 					kunmap_atomic(sdt);
 					return;
@@ -442,6 +471,7 @@ void sd_dif_complete(struct scsi_cmnd *scmd, unsigned int good_bytes)
 				if (be32_to_cpu(sdt->ref_tag) == phys)
 					sdt->ref_tag = cpu_to_be32(virt);
 
+				tuple += bi->tuple_size;
 				virt++;
 				phys++;
 				sectors--;
diff --git a/fs/bio-integrity.c b/fs/bio-integrity.c
index b4ab7da..81b0ddf 100644
--- a/fs/bio-integrity.c
+++ b/fs/bio-integrity.c
@@ -273,9 +273,11 @@ int bio_integrity_tag(struct bio *bio, void *tag_buf, unsigned int len, int set)
 	}
 
 	if (set)
-		bi->set_tag_fn(bip->bip_buf, tag_buf, nr_sectors);
+		bi->set_tag_fn(bip->bip_buf, tag_buf, nr_sectors,
+							bi->tuple_size);
 	else
-		bi->get_tag_fn(bip->bip_buf, tag_buf, nr_sectors);
+		bi->get_tag_fn(bip->bip_buf, tag_buf, nr_sectors,
+							bi->tuple_size);
 
 	return 0;
 }
@@ -338,6 +340,7 @@ static void bio_integrity_generate(struct bio *bio)
 	total = 0;
 	bix.disk_name = bio->bi_bdev->bd_disk->disk_name;
 	bix.sector_size = bi->sector_size;
+	bix.tuple_size = bi->tuple_size;
 
 	bio_for_each_segment(bv, bio, i) {
 		void *kaddr = kmap_atomic(bv->bv_page);
@@ -480,6 +483,7 @@ static int bio_integrity_verify(struct bio *bio)
 	ret = total = 0;
 	bix.disk_name = bio->bi_bdev->bd_disk->disk_name;
 	bix.sector_size = bi->sector_size;
+	bix.tuple_size = bi->tuple_size;
 
 	bio_for_each_segment(bv, bio, i) {
 		void *kaddr = kmap_atomic(bv->bv_page);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1756001..70eccab 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1325,13 +1325,14 @@ struct blk_integrity_exchg {
 	sector_t		sector;
 	unsigned int		data_size;
 	unsigned short		sector_size;
+	unsigned short		tuple_size;
 	const char		*disk_name;
 };
 
 typedef void (integrity_gen_fn) (struct blk_integrity_exchg *);
 typedef int (integrity_vrfy_fn) (struct blk_integrity_exchg *);
-typedef void (integrity_set_tag_fn) (void *, void *, unsigned int);
-typedef void (integrity_get_tag_fn) (void *, void *, unsigned int);
+typedef void (integrity_set_tag_fn) (void *, void *, unsigned int, unsigned short);
+typedef void (integrity_get_tag_fn) (void *, void *, unsigned int, unsigned short);
 
 struct blk_integrity {
 	integrity_gen_fn	*generate_fn;
-- 
1.7.0.4
