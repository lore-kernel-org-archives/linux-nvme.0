From: keith.busch@intel.com (Keith Busch)
Date: Mon, 23 Feb 2015 09:16:21 -0700
Subject: [PATCH] NVMe: Fix for BLK_DEV_INTEGRITY not set
Message-ID: <1424708181-29579-1-git-send-email-keith.busch@intel.com>

Need to define and use appropriate functions for when BLK_DEV_INTEGRITY
is not set.

Reported-by: Fengguang Wu <fengguang.wu at intel.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   99 ++++++++++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 41 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b64bccb..ceb32dd 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -482,6 +482,7 @@ static int nvme_error_status(u16 status)
 	}
 }
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
 static void nvme_dif_prep(u32 p, u32 v, struct t10_pi_tuple *pi)
 {
 	if (be32_to_cpu(pi->ref_tag) == v)
@@ -538,6 +539,58 @@ static void nvme_dif_remap(struct request *req,
 	kunmap_atomic(pmap);
 }
 
+static int nvme_noop_verify(struct blk_integrity_iter *iter)
+{
+	return 0;
+}
+
+static int nvme_noop_generate(struct blk_integrity_iter *iter)
+{
+	return 0;
+}
+
+struct blk_integrity nvme_meta_noop = {
+	.name			= "NVME_META_NOOP",
+	.generate_fn		= nvme_noop_generate,
+	.verify_fn		= nvme_noop_verify,
+};
+
+static void nvme_init_integrity(struct nvme_ns *ns)
+{
+	struct blk_integrity integrity;
+
+	switch (ns->pi_type) {
+	case NVME_NS_DPS_PI_TYPE3:
+		integrity = t10_pi_type3_crc;
+		break;
+	case NVME_NS_DPS_PI_TYPE1:
+	case NVME_NS_DPS_PI_TYPE2:
+		integrity = t10_pi_type1_crc;
+		break;
+	default:
+		integrity = nvme_meta_noop;
+		break;
+	}
+	integrity.tuple_size = ns->ms;
+	blk_integrity_register(ns->disk, &integrity);
+	blk_queue_max_integrity_segments(ns->queue, 1);
+}
+#else /* CONFIG_BLK_DEV_INTEGRITY */
+static void nvme_dif_remap(struct request *req,
+			void (*dif_swap)(u32 p, u32 v, struct t10_pi_tuple *pi))
+{
+}
+static void nvme_dif_prep(u32 p, u32 v, struct t10_pi_tuple *pi)
+{
+}
+static void nvme_dif_complete(u32 p, u32 v, struct t10_pi_tuple *pi)
+{
+}
+static void nvme_init_integrity(struct nvme_ns *ns)
+{
+}
+#endif
+
 static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
@@ -1959,43 +2012,6 @@ static void nvme_config_discard(struct nvme_ns *ns)
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
 }
 
-static int nvme_noop_verify(struct blk_integrity_iter *iter)
-{
-	return 0;
-}
-
-static int nvme_noop_generate(struct blk_integrity_iter *iter)
-{
-	return 0;
-}
-
-struct blk_integrity nvme_meta_noop = {
-	.name			= "NVME_META_NOOP",
-	.generate_fn		= nvme_noop_generate,
-	.verify_fn		= nvme_noop_verify,
-};
-
-static void nvme_init_integrity(struct nvme_ns *ns)
-{
-	struct blk_integrity integrity;
-
-	switch (ns->pi_type) {
-	case NVME_NS_DPS_PI_TYPE3:
-		integrity = t10_pi_type3_crc;
-		break;
-	case NVME_NS_DPS_PI_TYPE1:
-	case NVME_NS_DPS_PI_TYPE2:
-		integrity = t10_pi_type1_crc;
-		break;
-	default:
-		integrity = nvme_meta_noop;
-		break;
-	}
-	integrity.tuple_size = ns->ms;
-	blk_integrity_register(ns->disk, &integrity);
-	blk_queue_max_integrity_segments(ns->queue, 1);
-}
-
 static int nvme_revalidate_disk(struct gendisk *disk)
 {
 	struct nvme_ns *ns = disk->private_data;
@@ -2036,7 +2052,8 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	pi_type = ns->ms == sizeof(struct t10_pi_tuple) ?
 					id->dps & NVME_NS_DPS_PI_MASK : 0;
 
-	if (disk->integrity && (ns->pi_type != pi_type || ns->ms != old_ms ||
+	if (blk_get_integrity(disk) && (ns->pi_type != pi_type ||
+				ns->ms != old_ms ||
 				bs != queue_logical_block_size(disk->queue) ||
 				(ns->ms && id->flbas & NVME_NS_FLBAS_META_EXT)))
 		blk_integrity_unregister(disk);
@@ -2044,11 +2061,11 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	ns->pi_type = pi_type;
 	blk_queue_logical_block_size(ns->queue, bs);
 
-	if (ns->ms && !disk->integrity && (disk->flags & GENHD_FL_UP) &&
+	if (ns->ms && !blk_get_integrity(disk) && (disk->flags & GENHD_FL_UP) &&
 				!(id->flbas & NVME_NS_FLBAS_META_EXT))
 		nvme_init_integrity(ns);
 
-	if (id->ncap == 0 || (ns->ms && !disk->integrity))
+	if (id->ncap == 0 || (ns->ms && !blk_get_integrity(disk)))
 		set_capacity(disk, 0);
 	else
 		set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
@@ -2652,7 +2669,7 @@ static void nvme_dev_remove(struct nvme_dev *dev)
 
 	list_for_each_entry(ns, &dev->namespaces, list) {
 		if (ns->disk->flags & GENHD_FL_UP) {
-			if (ns->disk->integrity)
+			if (blk_get_integrity(ns->disk))
 				blk_integrity_unregister(ns->disk);
 			del_gendisk(ns->disk);
 		}
-- 
1.7.10.4
