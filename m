From: keith.busch@intel.com (Keith Busch)
Date: Tue, 27 Jan 2015 11:07:01 -0700
Subject: [PATCH] NVMe: Skip namespaces with interleaved meta-data
Message-ID: <1422382021-15350-1-git-send-email-keith.busch@intel.com>

The block layer does not support extended block sizes that require data
buffers interleave metadata in host memory. The driver was allowing
these under the assumption metadata was contained in a separate region,
but that's not necessarily the format, so we'd inadvertently corrupt
data and memory by allowing these namespaces.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
Hi Christoph,

This is another example where we'd have inaccessible namespaces through
block devices. I'd like to be able to use them with passthrough, and
while the block layer can't deal with this format, a userspace program
could. This has more merits for a h/w vendor than a typical end user,
but I'm happy vendors choose Linux for developing.

 drivers/block/nvme-core.c |   46
 +++++++++++++++++++++++++++++++++------------
 include/uapi/linux/nvme.h |    2 ++
 2 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index d826bf3..6bd66f9 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1825,13 +1825,23 @@ static int nvme_getgeo(struct block_device *bd, struct hd_geometry *geo)
 	return 0;
 }
 
+static void nvme_ns_cleanup(struct nvme_ns *ns)
+{
+	if (ns->disk->flags & GENHD_FL_UP)
+		del_gendisk(ns->disk);
+	if (!blk_queue_dying(ns->queue)) {
+		blk_mq_abort_requeue_list(ns->queue);
+		blk_cleanup_queue(ns->queue);
+	}
+}
+
 static int nvme_revalidate_disk(struct gendisk *disk)
 {
 	struct nvme_ns *ns = disk->private_data;
 	struct nvme_dev *dev = ns->dev;
 	struct nvme_id_ns *id;
 	dma_addr_t dma_addr;
-	int lbaf;
+	int lbaf, ms;
 
 	id = dma_alloc_coherent(&dev->pci_dev->dev, 4096, &dma_addr,
 								GFP_KERNEL);
@@ -1845,7 +1855,15 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		goto free;
 
 	lbaf = id->flbas & 0xf;
+	ms = le16_to_cpu(id->lbaf[lbaf].ms);
+
+	if ((id->flbas & NVME_NS_FLBAS_META_EXT) && ms) {
+		nvme_ns_cleanup(ns);
+		return 0;
+	}
+
 	ns->lba_shift = id->lbaf[lbaf].ds;
+	ns->ms = ms;
 
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
@@ -1922,11 +1940,16 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 	struct nvme_ns *ns;
 	struct gendisk *disk;
 	int node = dev_to_node(&dev->pci_dev->dev);
-	int lbaf;
+	int lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
+	int ms = le16_to_cpu(id->lbaf[lbaf].ms);
 
 	if (rt->attributes & NVME_LBART_ATTRIB_HIDE)
 		return NULL;
 
+	/* block layer does not support interleaved memory for extended block formats */
+	if ((id->flbas & NVME_NS_FLBAS_META_EXT) && ms)
+		return NULL;
+
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
 		return NULL;
@@ -1945,9 +1968,8 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 
 	ns->ns_id = nsid;
 	ns->disk = disk;
-	lbaf = id->flbas & 0xf;
 	ns->lba_shift = id->lbaf[lbaf].ds;
-	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
+	ns->ms = ms;
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	if (dev->max_hw_sectors)
 		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
@@ -2424,6 +2446,9 @@ static void nvme_freeze_queues(struct nvme_dev *dev)
 	struct nvme_ns *ns;
 
 	list_for_each_entry(ns, &dev->namespaces, list) {
+		if (blk_queue_dying(ns->queue))
+			continue;
+
 		blk_mq_freeze_queue_start(ns->queue);
 
 		spin_lock(ns->queue->queue_lock);
@@ -2440,6 +2465,9 @@ static void nvme_unfreeze_queues(struct nvme_dev *dev)
 	struct nvme_ns *ns;
 
 	list_for_each_entry(ns, &dev->namespaces, list) {
+		if (blk_queue_dying(ns->queue))
+			continue;
+
 		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
 		blk_mq_unfreeze_queue(ns->queue);
 		blk_mq_start_stopped_hw_queues(ns->queue, true);
@@ -2477,14 +2505,8 @@ static void nvme_dev_remove(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns;
 
-	list_for_each_entry(ns, &dev->namespaces, list) {
-		if (ns->disk->flags & GENHD_FL_UP)
-			del_gendisk(ns->disk);
-		if (!blk_queue_dying(ns->queue)) {
-			blk_mq_abort_requeue_list(ns->queue);
-			blk_cleanup_queue(ns->queue);
-		}
-	}
+	list_for_each_entry(ns, &dev->namespaces, list)
+		nvme_ns_cleanup(ns);
 }
 
 static int nvme_setup_prp_pools(struct nvme_dev *dev)
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index 26386cf..7cc0faa 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -124,6 +124,8 @@ struct nvme_id_ns {
 
 enum {
 	NVME_NS_FEAT_THIN	= 1 << 0,
+	NVME_NS_FLBAS_LBA_MASK	= 0xf,
+	NVME_NS_FLBAS_META_EXT	= 0x10,
 	NVME_LBAF_RP_BEST	= 0,
 	NVME_LBAF_RP_BETTER	= 1,
 	NVME_LBAF_RP_GOOD	= 2,
-- 
1.7.10.4
