From: cascardo@canonical.com (Thadeu Lima de Souza Cascardo)
Date: Thu,  1 Nov 2018 20:29:55 -0300
Subject: [PATCH v2] nvme: create 'paths' entries for hidden controllers
Message-ID: <20181101232955.19329-1-cascardo@canonical.com>

When using initramfs-tools with only the necessary dependencies to mount
the root filesystem, it will fail to include nvme drivers for a root on a
multipath nvme. That happens because the slaves relationship is not
present.

As discussed in [1], using slaves will break lsblk, because the slaves are
hidden from userspace, that is, they have no real block device, just an
entry under sysfs.

Introducing the paths subdir and using that on initramfs-tools makes it
possible to now boot a system with nvme multipath as root.

[1] https://www.spinics.net/lists/stable/msg222779.html

Cc: Christoph Hellwig <hch at lst.de>
Cc: Potnuri Bharat Teja <bharat at chelsio.com>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Hannes Reinecke <hare at suse.com>
Cc: Martin K. Petersen <martin.petersen at oracle.com>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo at canonical.com>
---
 Documentation/ABI/testing/sysfs-block-nvme | 10 ++++++++
 drivers/nvme/host/core.c                   |  2 ++
 drivers/nvme/host/multipath.c              | 29 ++++++++++++++++++++--
 drivers/nvme/host/nvme.h                   |  9 +++++++
 4 files changed, 48 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-block-nvme

diff --git a/Documentation/ABI/testing/sysfs-block-nvme b/Documentation/ABI/testing/sysfs-block-nvme
new file mode 100644
index 000000000000..3fe51b7be1e1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-block-nvme
@@ -0,0 +1,10 @@
+What:		/sys/block/nvme*/paths
+Date:		Oct, 2019
+KernelVersion:	v4.21
+Contact:	Thadeu Lima de Souza Cascardo <cascardo at canonical.com>
+Description:
+		This is a directory containing symlinks to other block
+		devices, when the block device is a nvme multipath
+		device.
+Users:		initramfs-tools
+
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9e4a30b05bd2..06be47e878f5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3115,6 +3115,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups);
 
 	nvme_mpath_add_disk(ns, id);
+	nvme_mpath_add_disk_links(ns);
 	nvme_fault_inject_init(ns);
 	kfree(id);
 
@@ -3138,6 +3139,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	nvme_fault_inject_fini(ns);
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
+		nvme_mpath_remove_disk_links(ns);
 		del_gendisk(ns->disk);
 		blk_cleanup_queue(ns->queue);
 		if (blk_get_integrity(ns->disk))
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 5e3cc8c59a39..65dabe7d6d7c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -317,9 +317,12 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 	if (!head->disk)
 		return;
 
-	if (!(head->disk->flags & GENHD_FL_UP))
+	if (!(head->disk->flags & GENHD_FL_UP)) {
+		struct kobject *hd_kobj = &disk_to_dev(head->disk)->kobj;
 		device_add_disk(&head->subsys->dev, head->disk,
 				nvme_ns_id_attr_groups);
+		head->path_dir = kobject_create_and_add("paths", hd_kobj);
+	}
 
 	if (nvme_path_is_optimized(ns)) {
 		int node, srcu_idx;
@@ -530,6 +533,19 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 	}
 }
 
+void nvme_mpath_add_disk_links(struct nvme_ns *ns)
+{
+	struct kobject *path_disk_kobj;
+
+	if (!ns->head->disk)
+		return;
+
+	path_disk_kobj = &disk_to_dev(ns->disk)->kobj;
+	if (sysfs_create_link(ns->head->path_dir, path_disk_kobj,
+			kobject_name(path_disk_kobj)))
+		return;
+}
+
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
@@ -541,9 +557,19 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	kblockd_schedule_work(&head->requeue_work);
 	flush_work(&head->requeue_work);
 	blk_cleanup_queue(head->disk->queue);
+	kobject_put(head->path_dir);
 	put_disk(head->disk);
 }
 
+void nvme_mpath_remove_disk_links(struct nvme_ns *ns)
+{
+	if (!ns->head->disk)
+		return;
+
+	sysfs_remove_link(ns->head->path_dir,
+			kobject_name(&disk_to_dev(ns->disk)->kobj));
+}
+
 int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
 	int error;
@@ -593,4 +619,3 @@ void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 {
 	kfree(ctrl->ana_log_buf);
 }
-
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9fefba039d1e..6093649d4696 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -287,6 +287,7 @@ struct nvme_ns_head {
 	int			instance;
 #ifdef CONFIG_NVME_MULTIPATH
 	struct gendisk		*disk;
+	struct kobject		*path_dir;
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
@@ -471,6 +472,8 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
+void nvme_mpath_add_disk_links(struct nvme_ns *ns);
+void nvme_mpath_remove_disk_links(struct nvme_ns *ns);
 int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
 void nvme_mpath_stop(struct nvme_ctrl *ctrl);
@@ -521,6 +524,12 @@ static inline void nvme_mpath_add_disk(struct nvme_ns *ns,
 static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 }
+static inline void nvme_mpath_add_disk_links(struct nvme_ns *ns)
+{
+}
+static inline void nvme_mpath_remove_disk_links(struct nvme_ns *ns)
+{
+}
 static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
 }
-- 
2.19.1
