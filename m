From: keith.busch@intel.com (Keith Busch)
Date: Wed, 15 Jul 2015 22:28:32 +0000 (UTC)
Subject: [PATCH] NVMe: Reread partitions on metadata formats
In-Reply-To: <55A6D251.9050801@fb.com>
References: <1436896668-27373-1-git-send-email-keith.busch@intel.com>
 <55A559B5.2000303@fb.com>
 <CAA9_cmc2Kb=XRwPpOijT+T_1-qfPH-h7LeM0AGSP6ZOW72MjwQ@mail.gmail.com>
 <55A6D251.9050801@fb.com>
Message-ID: <alpine.LNX.2.00.1507152142070.15930@localhost.lm.intel.com>

On Wed, 15 Jul 2015, Jens Axboe wrote:
> On 07/14/2015 09:48 PM, Dan Williams wrote:
>> NVDIMM namespaces with metadata space will run into this same problem.
>> Why not make revalidate_disk re-read partitions?
>
> Yeah that's a good point, we should try that. I'll queue up Keith's fix for 
> now since it's fixing a real bug, then we can revisit and kill it later.

Should we make it so a driver can register with blk-integrity prior to
calling add_disk()? The other thread on this issue sounded like that'd
be better and removes the extra driver complexity to call blk_reread_part
or revalidate after add_disk.

Here's a patch for that and the resulting nvme driver. It works the same
as today if registered after add_disk(), but safe to call prior. If
called prior, add_disk() handles the queue and backing info settings
for integrity, and adds the kobj.

---
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index f548b64..d5d1bb9 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -426,17 +426,19 @@ int blk_integrity_register(struct gendisk *disk, struct blk_integrity *template)
  		if (!bi)
  			return -1;

-		if (kobject_init_and_add(&bi->kobj, &integrity_ktype,
+		if ((disk->flags & GENHD_FL_UP)) {
+			if (kobject_init_and_add(&bi->kobj, &integrity_ktype,
  					 &disk_to_dev(disk)->kobj,
  					 "%s", "integrity")) {
-			kmem_cache_free(integrity_cachep, bi);
-			return -1;
-		}
-
-		kobject_uevent(&bi->kobj, KOBJ_ADD);
+				kmem_cache_free(integrity_cachep, bi);
+				return -1;
+			}
+			kobject_uevent(&bi->kobj, KOBJ_ADD);
+			bi->interval = queue_logical_block_size(disk->queue);
+		} else
+			kobject_init(&bi->kobj, &integrity_ktype);

  		bi->flags |= BLK_INTEGRITY_VERIFY | BLK_INTEGRITY_GENERATE;
-		bi->interval = queue_logical_block_size(disk->queue);
  		disk->integrity = bi;
  	} else
  		bi = disk->integrity;
@@ -452,8 +454,8 @@ int blk_integrity_register(struct gendisk *disk, struct blk_integrity *template)
  	} else
  		bi->name = bi_unsupported_name;

-	disk->queue->backing_dev_info.capabilities |= BDI_CAP_STABLE_WRITES;
-
+	if (disk->flags & GENHD_FL_UP)
+		disk->queue->backing_dev_info.capabilities |= BDI_CAP_STABLE_WRITES;
  	return 0;
  }
  EXPORT_SYMBOL(blk_integrity_register);
diff --git a/block/genhd.c b/block/genhd.c
index 59a1395..a6f731d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -582,6 +582,7 @@ exit:
   */
  void add_disk(struct gendisk *disk)
  {
+	struct blk_integrity *bi = disk->integrity;
  	struct backing_dev_info *bdi;
  	dev_t devt;
  	int retval;
@@ -616,6 +617,10 @@ void add_disk(struct gendisk *disk)

  	blk_register_region(disk_devt(disk), disk->minors, NULL,
  			    exact_match, exact_lock, disk);
+	if (bi) {
+		bi->interval = queue_logical_block_size(disk->queue);
+		bdi->capabilities |= BDI_CAP_STABLE_WRITES;
+	}
  	register_disk(disk);
  	blk_register_queue(disk);

@@ -630,6 +635,10 @@ void add_disk(struct gendisk *disk)
  	WARN_ON(retval);

  	disk_add_events(disk);
+
+	if (bi && kobject_add(&bi->kobj, &disk_to_dev(disk)->kobj,
+						"%s", "integrity"))
+		blk_integrity_unregister(disk);
  }
  EXPORT_SYMBOL(add_disk);

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e9127ad..d9792b7 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1989,8 +1989,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
  	ns->pi_type = pi_type;
  	blk_queue_logical_block_size(ns->queue, bs);

-	if (ns->ms && !blk_get_integrity(disk) && (disk->flags & GENHD_FL_UP) &&
-								!ns->ext)
+	if (ns->ms && !blk_get_integrity(disk) && !ns->ext)
  		nvme_init_integrity(ns);

  	if (ns->ms && !blk_get_integrity(disk))
@@ -2134,28 +2133,9 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
  	disk->flags = GENHD_FL_EXT_DEVT;
  	sprintf(disk->disk_name, "nvme%dn%d", dev->instance, nsid);

-	/*
-	 * Initialize capacity to 0 until we establish the namespace format and
-	 * setup integrity extentions if necessary. The revalidate_disk after
-	 * add_disk allows the driver to register with integrity if the format
-	 * requires it.
-	 */
-	set_capacity(disk, 0);
  	if (nvme_revalidate_disk(ns->disk))
  		goto out_free_disk;
-
  	add_disk(ns->disk);
-	if (ns->ms) {
-		struct block_device *bd = bdget_disk(ns->disk, 0);
-		if (!bd)
-			return;
-		if (blkdev_get(bd, FMODE_READ, NULL)) {
-			bdput(bd);
-			return;
-		}
-		blkdev_reread_part(bd);
-		blkdev_put(bd, FMODE_READ);
-	}
  	return;
   out_free_disk:
  	kfree(disk);
--
