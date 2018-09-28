From: cascardo@canonical.com (Thadeu Lima de Souza Cascardo)
Date: Fri, 28 Sep 2018 16:17:20 -0300
Subject: [PATCH] nvme: create 'paths' entries for hidden controllers
Message-ID: <20180928191720.3461-1-cascardo@canonical.com>

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
 drivers/nvme/host/core.c      |  2 ++
 drivers/nvme/host/multipath.c | 28 ++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  9 +++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 456d37a02ea3..6958e8cab92c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3056,6 +3056,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 			ns->disk->disk_name);
 
 	nvme_mpath_add_disk(ns->head);
+	nvme_mpath_add_disk_links(ns);
 	nvme_fault_inject_init(ns);
 	return;
  out_unlink_ns:
@@ -3077,6 +3078,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	nvme_fault_inject_fini(ns);
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
+		nvme_mpath_remove_disk_links(ns);
 		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
 					&nvme_ns_id_attr_group);
 		if (ns->ndev)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 348aa405b641..70a4a0611550 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -220,15 +220,29 @@ void nvme_mpath_add_disk(struct nvme_ns_head *head)
 
 	mutex_lock(&head->subsys->lock);
 	if (!(head->disk->flags & GENHD_FL_UP)) {
+		struct kobject *hd_kobj = &disk_to_dev(head->disk)->kobj;
 		device_add_disk(&head->subsys->dev, head->disk);
-		if (sysfs_create_group(&disk_to_dev(head->disk)->kobj,
-				&nvme_ns_id_attr_group))
+		head->path_dir = kobject_create_and_add("paths", hd_kobj);
+		if (sysfs_create_group(hd_kobj, &nvme_ns_id_attr_group))
 			pr_warn("%s: failed to create sysfs group for identification\n",
 				head->disk->disk_name);
 	}
 	mutex_unlock(&head->subsys->lock);
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
@@ -241,5 +255,15 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	kblockd_schedule_work(&head->requeue_work);
 	flush_work(&head->requeue_work);
 	blk_cleanup_queue(head->disk->queue);
+	kobject_put(head->path_dir);
 	put_disk(head->disk);
 }
+
+void nvme_mpath_remove_disk_links(struct nvme_ns *ns)
+{
+	if (!ns->head->disk)
+		return;
+
+	sysfs_remove_link(ns->head->path_dir,
+			kobject_name(&disk_to_dev(ns->disk)->kobj));
+}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 07452adef110..8371f98b657e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -265,6 +265,7 @@ struct nvme_ns_ids {
 struct nvme_ns_head {
 #ifdef CONFIG_NVME_MULTIPATH
 	struct gendisk		*disk;
+	struct kobject		*path_dir;
 	struct nvme_ns __rcu	*current_path;
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
@@ -456,7 +457,9 @@ void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns_head *head);
+void nvme_mpath_add_disk_links(struct nvme_ns *ns);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
+void nvme_mpath_remove_disk_links(struct nvme_ns *ns);
 
 static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
@@ -503,6 +506,12 @@ static inline void nvme_mpath_add_disk(struct nvme_ns_head *head)
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
2.17.1
