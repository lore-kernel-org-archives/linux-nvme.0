From: hch@lst.de (Christoph Hellwig)
Date: Wed,  7 Mar 2018 14:13:58 +0100
Subject: [PATCH] Revert "nvme: create 'slaves' and 'holders' entries for
 hidden controllers"
Message-ID: <20180307131358.20275-1-hch@lst.de>

This reverts commit e9a48034d7d1318ece7d4a235838a86c94db9d68.

The slaves and holders link for the hidden gendisks confuse lsblk so that
it errors out on, or doesn't report the nvme multipath devices.  Given
that we don't need holder relationships for something that can't even be
directly accessed we should just stop creating those links.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reported-by: Potnuri Bharat Teja <bharat at chelsio.com>
Cc: stable at vger.kernel.org
---
 drivers/nvme/host/core.c      |  2 --
 drivers/nvme/host/multipath.c | 30 ------------------------------
 drivers/nvme/host/nvme.h      |  8 --------
 3 files changed, 40 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 817e5e2766da..7aeca5db7916 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3033,7 +3033,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 			ns->disk->disk_name);
 
 	nvme_mpath_add_disk(ns->head);
-	nvme_mpath_add_disk_links(ns);
 	return;
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
@@ -3053,7 +3052,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 		return;
 
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
-		nvme_mpath_remove_disk_links(ns);
 		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
 					&nvme_ns_id_attr_group);
 		if (ns->ndev)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index b7e5c6db4d92..060f69e03427 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -210,25 +210,6 @@ void nvme_mpath_add_disk(struct nvme_ns_head *head)
 	mutex_unlock(&head->subsys->lock);
 }
 
-void nvme_mpath_add_disk_links(struct nvme_ns *ns)
-{
-	struct kobject *slave_disk_kobj, *holder_disk_kobj;
-
-	if (!ns->head->disk)
-		return;
-
-	slave_disk_kobj = &disk_to_dev(ns->disk)->kobj;
-	if (sysfs_create_link(ns->head->disk->slave_dir, slave_disk_kobj,
-			kobject_name(slave_disk_kobj)))
-		return;
-
-	holder_disk_kobj = &disk_to_dev(ns->head->disk)->kobj;
-	if (sysfs_create_link(ns->disk->part0.holder_dir, holder_disk_kobj,
-			kobject_name(holder_disk_kobj)))
-		sysfs_remove_link(ns->head->disk->slave_dir,
-			kobject_name(slave_disk_kobj));
-}
-
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
@@ -243,14 +224,3 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	blk_cleanup_queue(head->disk->queue);
 	put_disk(head->disk);
 }
-
-void nvme_mpath_remove_disk_links(struct nvme_ns *ns)
-{
-	if (!ns->head->disk)
-		return;
-
-	sysfs_remove_link(ns->disk->part0.holder_dir,
-			kobject_name(&disk_to_dev(ns->head->disk)->kobj));
-	sysfs_remove_link(ns->head->disk->slave_dir,
-			kobject_name(&disk_to_dev(ns->disk)->kobj));
-}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0521e4707d1c..d733b14ede9d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -410,9 +410,7 @@ bool nvme_req_needs_failover(struct request *req, blk_status_t error);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns_head *head);
-void nvme_mpath_add_disk_links(struct nvme_ns *ns);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
-void nvme_mpath_remove_disk_links(struct nvme_ns *ns);
 
 static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
@@ -454,12 +452,6 @@ static inline void nvme_mpath_add_disk(struct nvme_ns_head *head)
 static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 }
-static inline void nvme_mpath_add_disk_links(struct nvme_ns *ns)
-{
-}
-static inline void nvme_mpath_remove_disk_links(struct nvme_ns *ns)
-{
-}
 static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
 }
-- 
2.14.2
