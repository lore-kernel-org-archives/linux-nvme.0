From: hare@suse.de (Hannes Reinecke)
Date: Mon, 16 Jul 2018 12:37:21 +0200
Subject: [PATCH] nvme: register ns_id attributes as default sysfs groups
Message-ID: <20180716103721.96363-1-hare@suse.de>

We should be registering the ns_id attributes as default sysfs groups,
otherwise we have a race condition between nvme_mpath_add_disk() and
nvme_mpath_remove_disk() which will lead to a kobject warning during
rapid connect/disconnect cycles.

Reported-by: James Smart <james.smart at broadcom.com>
Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c      | 15 +++++++++------
 drivers/nvme/host/multipath.c | 10 ++++------
 drivers/nvme/host/nvme.h      |  2 +-
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 46df030b2c3f..f0c4841ce3df 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2695,6 +2695,11 @@ const struct attribute_group nvme_ns_id_attr_group = {
 	.is_visible	= nvme_ns_id_attrs_are_visible,
 };
 
+const struct attribute_group *nvme_ns_id_attr_groups[] = {
+	&nvme_ns_id_attr_group,
+	NULL,
+};
+
 #define nvme_show_str_function(field)						\
 static ssize_t  field##_show(struct device *dev,				\
 			    struct device_attribute *attr, char *buf)		\
@@ -3002,6 +3007,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	struct nvme_ns *ns;
 	struct gendisk *disk;
 	struct nvme_id_ns *id;
+	struct device *dev;
 	char disk_name[DISK_NAME_LEN];
 	int node = dev_to_node(ctrl->dev), flags = GENHD_FL_EXT_DEVT;
 
@@ -3062,11 +3068,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	kfree(id);
 
+	dev = disk_to_dev(ns->disk);
+	WARN_ON(dev->groups);
+	dev->groups = nvme_ns_id_attr_groups;
 	device_add_disk(ctrl->device, ns->disk);
-	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
-					&nvme_ns_id_attr_group))
-		pr_warn("%s: failed to create sysfs group for identification\n",
-			ns->disk->disk_name);
 	if (ns->ndev && nvme_nvm_register_sysfs(ns))
 		pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
 			ns->disk->disk_name);
@@ -3093,8 +3098,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	nvme_fault_inject_fini(ns);
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
-		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
-					&nvme_ns_id_attr_group);
 		if (ns->ndev)
 			nvme_nvm_unregister_sysfs(ns);
 		del_gendisk(ns->disk);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 1ffd3e8b13a1..d9df78164835 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -227,11 +227,11 @@ void nvme_mpath_add_disk(struct nvme_ns_head *head)
 
 	mutex_lock(&head->subsys->lock);
 	if (!(head->disk->flags & GENHD_FL_UP)) {
+		struct device *dev = disk_to_dev(head->disk);
+
+		WARN_ON(dev->groups);
+		dev->groups = nvme_ns_id_attr_groups;
 		device_add_disk(&head->subsys->dev, head->disk);
-		if (sysfs_create_group(&disk_to_dev(head->disk)->kobj,
-				&nvme_ns_id_attr_group))
-			pr_warn("%s: failed to create sysfs group for identification\n",
-				head->disk->disk_name);
 	}
 	mutex_unlock(&head->subsys->lock);
 }
@@ -240,8 +240,6 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
-	sysfs_remove_group(&disk_to_dev(head->disk)->kobj,
-			   &nvme_ns_id_attr_group);
 	del_gendisk(head->disk);
 	blk_set_queue_dying(head->disk->queue);
 	/* make sure all pending bios are cleaned up */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0c4a33df3b2f..95529e86480d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -438,7 +438,7 @@ int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		u8 log_page, void *log, size_t size, u64 offset);
 
-extern const struct attribute_group nvme_ns_id_attr_group;
+extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct block_device_operations nvme_ns_head_ops;
 
 #ifdef CONFIG_NVME_MULTIPATH
-- 
2.12.3
