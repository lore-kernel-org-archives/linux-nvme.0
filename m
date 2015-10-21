From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 21 Oct 2015 13:20:29 -0400
Subject: [PATCH v3 12/12] block, libnvdimm,
 nvme: provide a built-in blk_integrity nop profile
In-Reply-To: <20151021171921.6456.1646.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20151021171921.6456.1646.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <20151021172029.6456.59489.stgit@dwillia2-desk3.amr.corp.intel.com>

The libnvidmm-btt and nvme drivers use blk_integrity to reserve space
for per-sector metadata, but sometimes without protection checksums.
This property is generically useful, so teach the block core to
internally specify a nop profile if one is not provided at registration
time.

Cc: Keith Busch <keith.busch at intel.com>
Cc: Matthew Wilcox <willy at linux.intel.com>
Suggested-by: Christoph Hellwig <hch at lst.de>
[hch: kill the local nvme nop profile as well]
Acked-by: Martin K. Petersen <martin.petersen at oracle.com>
Signed-off-by: Dan Williams <dan.j.williams at intel.com>
---
 block/blk-integrity.c   |   13 ++++++++++++-
 drivers/nvdimm/core.c   |   12 +-----------
 drivers/nvme/host/pci.c |   18 +-----------------
 3 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 5d339ae64d56..d69c5c79f98e 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -384,6 +384,17 @@ static struct kobj_type integrity_ktype = {
 	.sysfs_ops	= &integrity_ops,
 };
 
+static int blk_integrity_nop_fn(struct blk_integrity_iter *iter)
+{
+	return 0;
+}
+
+static struct blk_integrity_profile nop_profile = {
+	.name = "nop",
+	.generate_fn = blk_integrity_nop_fn,
+	.verify_fn = blk_integrity_nop_fn,
+};
+
 /**
  * blk_integrity_register - Register a gendisk as being integrity-capable
  * @disk:	struct gendisk pointer to make integrity-aware
@@ -402,7 +413,7 @@ void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template
 	bi->flags = BLK_INTEGRITY_VERIFY | BLK_INTEGRITY_GENERATE |
 		template->flags;
 	bi->interval_exp = ilog2(queue_logical_block_size(disk->queue));
-	bi->profile = template->profile;
+	bi->profile = template->profile ? template->profile : &nop_profile;
 	bi->tuple_size = template->tuple_size;
 	bi->tag_size = template->tag_size;
 
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index e85848caf8d2..82c49bb87055 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -392,24 +392,14 @@ void nvdimm_bus_unregister(struct nvdimm_bus *nvdimm_bus)
 EXPORT_SYMBOL_GPL(nvdimm_bus_unregister);
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-static int nd_pi_nop_generate_verify(struct blk_integrity_iter *iter)
-{
-	return 0;
-}
-
 int nd_integrity_init(struct gendisk *disk, unsigned long meta_size)
 {
 	struct blk_integrity bi;
-	static struct blk_integrity_profile profile = {
-		.name = "ND-PI-NOP",
-		.generate_fn = nd_pi_nop_generate_verify,
-		.verify_fn = nd_pi_nop_generate_verify,
-	};
 
 	if (meta_size == 0)
 		return 0;
 
-	bi.profile = &profile;
+	bi.profile = NULL;
 	bi.tuple_size = meta_size;
 	bi.tag_size = meta_size;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2fa28680ad0f..9bea542afc4f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -548,22 +548,6 @@ static void nvme_dif_remap(struct request *req,
 	kunmap_atomic(pmap);
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
-struct blk_integrity_profile nvme_meta_noop = {
-	.name			= "NVME_META_NOOP",
-	.generate_fn		= nvme_noop_generate,
-	.verify_fn		= nvme_noop_verify,
-};
-
 static void nvme_init_integrity(struct nvme_ns *ns)
 {
 	struct blk_integrity integrity;
@@ -577,7 +561,7 @@ static void nvme_init_integrity(struct nvme_ns *ns)
 		integrity.profile = &t10_pi_type1_crc;
 		break;
 	default:
-		integrity.profile = &nvme_meta_noop;
+		integrity.profile = NULL;
 		break;
 	}
 	integrity.tuple_size = ns->ms;
