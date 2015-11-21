From: hch@lst.de (Christoph Hellwig)
Date: Sat, 21 Nov 2015 08:28:22 +0100
Subject: [PATCH 04/16] NVMe: Simplify metadata setup
In-Reply-To: <1448090914-13121-1-git-send-email-hch@lst.de>
References: <1448090914-13121-1-git-send-email-hch@lst.de>
Message-ID: <1448090914-13121-5-git-send-email-hch@lst.de>

From: Keith Busch <keith.busch@intel.com>

We no longer require the two-pass setup for block integrity.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 379003b..53cf507 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -559,7 +559,6 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	if (ns->lba_shift == 0)
 		ns->lba_shift = 9;
 	bs = 1 << ns->lba_shift;
-
 	/* XXX: PI implementation requires metadata equal t10 pi tuple size */
 	pi_type = ns->ms == sizeof(struct t10_pi_tuple) ?
 					id->dps & NVME_NS_DPS_PI_MASK : 0;
@@ -574,9 +573,8 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	ns->pi_type = pi_type;
 	blk_queue_logical_block_size(ns->queue, bs);
 
-	if (ns->ms && !ns->ext)
+	if (ns->ms && !blk_get_integrity(disk) && !ns->ext)
 		nvme_init_integrity(ns);
-
 	if (ns->ms && !(ns->ms == 8 && ns->pi_type) && !blk_get_integrity(disk))
 		set_capacity(disk, 0);
 	else
@@ -881,7 +879,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	ns->ns_id = nsid;
 	ns->disk = disk;
 	ns->lba_shift = 9; /* set to a default value for 512 until disk is validated */
-	list_add_tail(&ns->list, &ctrl->namespaces);
 
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	if (ctrl->max_hw_sectors) {
@@ -904,36 +901,17 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	disk->flags = GENHD_FL_EXT_DEVT;
 	sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance, nsid);
 
-	/*
-	 * Initialize capacity to 0 until we establish the namespace format and
-	 * setup integrity extentions if necessary. The revalidate_disk after
-	 * add_disk allows the driver to register with integrity if the format
-	 * requires it.
-	 */
-	set_capacity(disk, 0);
 	if (nvme_revalidate_disk(ns->disk))
 		goto out_free_disk;
 
+	list_add_tail(&ns->list, &ctrl->namespaces);
 	kref_get(&ctrl->kref);
-	if (ns->type != NVME_NS_LIGHTNVM) {
+	if (ns->type != NVME_NS_LIGHTNVM)
 		add_disk(ns->disk);
-		if (ns->ms) {
-			struct block_device *bd = bdget_disk(ns->disk, 0);
-			if (!bd)
-				return;
-			if (blkdev_get(bd, FMODE_READ, NULL)) {
-				bdput(bd);
-				return;
-			}
-			blkdev_reread_part(bd);
-			blkdev_put(bd, FMODE_READ);
-		}
-	}
 
 	return;
  out_free_disk:
 	kfree(disk);
-	list_del(&ns->list);
  out_free_queue:
 	blk_cleanup_queue(ns->queue);
  out_free_ns:
-- 
1.9.1
