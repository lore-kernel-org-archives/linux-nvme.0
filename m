From: keith.busch@intel.com (Keith Busch)
Date: Fri, 22 Aug 2014 13:53:40 -0600 (MDT)
Subject: [PATCH] fs/block_dev.c: Use hd_part to find block inodes
In-Reply-To: <20140822174848.GA11819@infradead.org>
References: <1408724896-3671-1-git-send-email-keith.busch@intel.com>
 <20140822174848.GA11819@infradead.org>
Message-ID: <alpine.LRH.2.03.1408221341280.4696@AMR>

On Fri, 22 Aug 2014, Christoph Hellwig wrote:
> On Fri, Aug 22, 2014@10:28:16AM -0600, Keith Busch wrote:
>> When using the GENHD_FL_EXT_DEVT disk flags, a newly added device may
>> be assigned the same major/minor as one that was previously removed but
>> opened, and the pesky userspace refuses to close it!
>
> Which means life time rules for those dev_t allocations are broken.
> Please fix it to not release the dev_t until the device isn't referenced
> at all.

Okay, thanks. So a proper fix would not let extended devt minors get
reused while still referenced, so we can't release it unconditionally
from del_gendisk(). I think the following does that, but I had to add
a reference counter to gendisk.

---
diff --git a/block/genhd.c b/block/genhd.c
index 791f419..a41478a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -453,6 +453,12 @@ void blk_free_devt(dev_t devt)
  	}
  }

+static void free_ext_dev(struct kref *kref)
+{
+	struct gendisk *disk = container_of(kref, struct gendisk, kref);
+	blk_free_devt(disk_to_dev(disk)->devt);
+}
+
  static char *bdevt_str(dev_t devt, char *buf)
  {
  	if (MAJOR(devt) <= 0xff && MINOR(devt) <= 0xff) {
@@ -665,7 +671,6 @@ void del_gendisk(struct gendisk *disk)
  		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
  	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
  	device_del(disk_to_dev(disk));
-	blk_free_devt(disk_to_dev(disk)->devt);
  }
  EXPORT_SYMBOL(del_gendisk);

@@ -1283,6 +1288,7 @@ struct gendisk *alloc_disk_node(int minors, int node_id)
  		disk_to_dev(disk)->class = &block_class;
  		disk_to_dev(disk)->type = &disk_type;
  		device_initialize(disk_to_dev(disk));
+		kref_init(&disk->kref);
  	}
  	return disk;
  }
@@ -1303,6 +1309,7 @@ struct kobject *get_disk(struct gendisk *disk)
  		module_put(owner);
  		return NULL;
  	}
+	kref_get(&disk->kref);
  	return kobj;

  }
@@ -1311,8 +1318,10 @@ EXPORT_SYMBOL(get_disk);

  void put_disk(struct gendisk *disk)
  {
-	if (disk)
+	if (disk) {
+		kref_put(&disk->kref, free_ext_dev);
  		kobject_put(&disk_to_dev(disk)->kobj);
+	}
  }

  EXPORT_SYMBOL(put_disk);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index ec274e0..d51b099 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -200,6 +200,7 @@ struct gendisk {
  	struct blk_integrity *integrity;
  #endif
  	int node_id;
+	struct kref kref;
  };

  static inline struct gendisk *part_to_disk(struct hd_struct *part)
--
