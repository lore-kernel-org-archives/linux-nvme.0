From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 21 Oct 2015 13:20:18 -0400
Subject: [PATCH v3 10/12] block: move blk_integrity to request_queue
In-Reply-To: <20151021171921.6456.1646.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20151021171921.6456.1646.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <20151021172018.6456.72593.stgit@dwillia2-desk3.amr.corp.intel.com>

A trace like the following proceeds a crash in bio_integrity_process()
when it goes to use an already freed blk_integrity profile.

 BUG: unable to handle kernel paging request at ffff8800d31b10d8
 IP: [<ffff8800d31b10d8>] 0xffff8800d31b10d8
 PGD 2f65067 PUD 21fffd067 PMD 80000000d30001e3
 Oops: 0011 [#1] SMP
 Dumping ftrace buffer:
 ---------------------------------
    ndctl-2222    2.... 44526245us : disk_release: pmem1s
 systemd--2223    4.... 44573945us : bio_integrity_endio: pmem1s
    <...>-409     4.... 44574005us : bio_integrity_process: pmem1s
 ---------------------------------
[..]
  Call Trace:
  [<ffffffff8144e0f9>] ? bio_integrity_process+0x159/0x2d0
  [<ffffffff8144e4f6>] bio_integrity_verify_fn+0x36/0x60
  [<ffffffff810bd2dc>] process_one_work+0x1cc/0x4e0

Given that a request_queue is pinned while i/o is in flight and that a
gendisk is allowed to have a shorter lifetime, move blk_integrity to
request_queue to satisfy requests arriving after the gendisk has been
torn down.

Cc: Christoph Hellwig <hch at lst.de>
Cc: Martin K. Petersen <martin.petersen at oracle.com>
[martin: fix the CONFIG_BLK_DEV_INTEGRITY=n case]
Tested-by: Ross Zwisler <ross.zwisler at linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams at intel.com>
---
 block/blk-integrity.c   |   14 +++++++-------
 drivers/nvme/host/pci.c |    2 +-
 include/linux/blkdev.h  |    6 +++++-
 include/linux/genhd.h   |    1 -
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 4615a3386798..5d339ae64d56 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -142,8 +142,8 @@ EXPORT_SYMBOL(blk_rq_map_integrity_sg);
  */
 int blk_integrity_compare(struct gendisk *gd1, struct gendisk *gd2)
 {
-	struct blk_integrity *b1 = &gd1->integrity;
-	struct blk_integrity *b2 = &gd2->integrity;
+	struct blk_integrity *b1 = &gd1->queue->integrity;
+	struct blk_integrity *b2 = &gd2->queue->integrity;
 
 	if (!b1->profile && !b2->profile)
 		return 0;
@@ -246,7 +246,7 @@ static ssize_t integrity_attr_show(struct kobject *kobj, struct attribute *attr,
 				   char *page)
 {
 	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
-	struct blk_integrity *bi = &disk->integrity;
+	struct blk_integrity *bi = &disk->queue->integrity;
 	struct integrity_sysfs_entry *entry =
 		container_of(attr, struct integrity_sysfs_entry, attr);
 
@@ -258,7 +258,7 @@ static ssize_t integrity_attr_store(struct kobject *kobj,
 				    size_t count)
 {
 	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
-	struct blk_integrity *bi = &disk->integrity;
+	struct blk_integrity *bi = &disk->queue->integrity;
 	struct integrity_sysfs_entry *entry =
 		container_of(attr, struct integrity_sysfs_entry, attr);
 	ssize_t ret = 0;
@@ -397,7 +397,7 @@ static struct kobj_type integrity_ktype = {
  */
 void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template)
 {
-	struct blk_integrity *bi = &disk->integrity;
+	struct blk_integrity *bi = &disk->queue->integrity;
 
 	bi->flags = BLK_INTEGRITY_VERIFY | BLK_INTEGRITY_GENERATE |
 		template->flags;
@@ -420,13 +420,13 @@ EXPORT_SYMBOL(blk_integrity_register);
 void blk_integrity_unregister(struct gendisk *disk)
 {
 	blk_integrity_revalidate(disk);
-	memset(&disk->integrity, 0, sizeof(struct blk_integrity));
+	memset(&disk->queue->integrity, 0, sizeof(struct blk_integrity));
 }
 EXPORT_SYMBOL(blk_integrity_unregister);
 
 void blk_integrity_revalidate(struct gendisk *disk)
 {
-	struct blk_integrity *bi = &disk->integrity;
+	struct blk_integrity *bi = &disk->queue->integrity;
 
 	if (!(disk->flags & GENHD_FL_UP))
 		return;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4757a2c9366e..2fa28680ad0f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -538,7 +538,7 @@ static void nvme_dif_remap(struct request *req,
 	virt = bip_get_seed(bip);
 	phys = nvme_block_nr(ns, blk_rq_pos(req));
 	nlb = (blk_rq_bytes(req) >> ns->lba_shift);
-	ts = ns->disk->integrity.tuple_size;
+	ts = ns->disk->queue->integrity.tuple_size;
 
 	for (i = 0; i < nlb; i++, virt++, phys++) {
 		pi = (struct t10_pi_tuple *)p;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3e0465257d68..cf57884db4b7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -369,6 +369,10 @@ struct request_queue {
 	 */
 	struct kobject mq_kobj;
 
+#ifdef  CONFIG_BLK_DEV_INTEGRITY
+	struct blk_integrity integrity;
+#endif	/* CONFIG_BLK_DEV_INTEGRITY */
+
 #ifdef CONFIG_PM
 	struct device		*dev;
 	int			rpm_status;
@@ -1481,7 +1485,7 @@ extern bool blk_integrity_merge_bio(struct request_queue *, struct request *,
 
 static inline struct blk_integrity *blk_get_integrity(struct gendisk *disk)
 {
-	struct blk_integrity *bi = &disk->integrity;
+	struct blk_integrity *bi = &disk->queue->integrity;
 
 	if (!bi->profile)
 		return NULL;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 82f4911e0ad8..847cc1d91634 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -210,7 +210,6 @@ struct gendisk {
 	atomic_t sync_io;		/* RAID */
 	struct disk_events *ev;
 #ifdef  CONFIG_BLK_DEV_INTEGRITY
-	struct blk_integrity integrity;
 	struct kobject integrity_kobj;
 #endif	/* CONFIG_BLK_DEV_INTEGRITY */
 	int node_id;
