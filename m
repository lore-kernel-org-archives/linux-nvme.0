From: keith.busch@intel.com (Keith Busch)
Date: Thu, 18 Feb 2016 11:18:05 -0700
Subject: [PATCH] NVMe: Use IDA for namespace disk naming
Message-ID: <1455819485-3730-1-git-send-email-keith.busch@intel.com>

A namespace may be detached from a controller, but a user may be holding
a reference to it. Attaching a new namespace with the same NSID will create
duplicate names when using the NSID to name the disk.

This patch uses an IDA that is released only when the last reference is
released instead of using the namespace ID.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 25 ++++++++++++++++++-------
 drivers/nvme/host/nvme.h |  2 ++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b29fae6..9b1253f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -48,10 +48,6 @@ static void nvme_free_ns(struct kref *kref)
 {
 	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
 
-	mutex_lock(&ns->ctrl->namespaces_mutex);
-	list_del_init(&ns->list);
-	mutex_unlock(&ns->ctrl->namespaces_mutex);
-
 	if (ns->type == NVME_NS_LIGHTNVM)
 		nvme_nvm_unregister(ns->queue, ns->disk->disk_name);
 
@@ -59,8 +55,9 @@ static void nvme_free_ns(struct kref *kref)
 	ns->disk->private_data = NULL;
 	spin_unlock(&dev_list_lock);
 
-	nvme_put_ctrl(ns->ctrl);
 	put_disk(ns->disk);
+	ida_simple_remove(&ns->ctrl->ns_ida, ns->instance);
+	nvme_put_ctrl(ns->ctrl);
 	kfree(ns);
 }
 
@@ -1152,9 +1149,13 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (!ns)
 		return;
 
+	ns->instance = ida_simple_get(&ctrl->ns_ida, 1, 0, GFP_KERNEL);
+	if (ns->instance < 0)
+		goto out_free_ns;
+
 	ns->queue = blk_mq_init_queue(ctrl->tagset);
 	if (IS_ERR(ns->queue))
-		goto out_free_ns;
+		goto out_release_instance;
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, ns->queue);
 	ns->queue->queuedata = ns;
 	ns->ctrl = ctrl;
@@ -1187,7 +1188,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	disk->queue = ns->queue;
 	disk->driverfs_dev = ctrl->device;
 	disk->flags = GENHD_FL_EXT_DEVT;
-	sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance, nsid);
+	sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance, ns->instance);
 
 	if (nvme_revalidate_disk(ns->disk))
 		goto out_free_disk;
@@ -1207,6 +1208,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	kfree(disk);
  out_free_queue:
 	blk_cleanup_queue(ns->queue);
+ out_release_instance:
+	ida_simple_remove(&ctrl->ns_ida, ns->instance);
  out_free_ns:
 	kfree(ns);
 }
@@ -1225,6 +1228,11 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 		blk_mq_abort_requeue_list(ns->queue);
 		blk_cleanup_queue(ns->queue);
 	}
+
+	mutex_lock(&ns->ctrl->namespaces_mutex);
+	list_del_init(&ns->list);
+	mutex_unlock(&ns->ctrl->namespaces_mutex);
+
 	nvme_put_ns(ns);
 }
 
@@ -1358,6 +1366,8 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 	spin_lock(&dev_list_lock);
 	list_del(&ctrl->node);
 	spin_unlock(&dev_list_lock);
+
+	ida_destroy(&ctrl->ns_ida);
 }
 
 static void nvme_free_ctrl(struct kref *kref)
@@ -1406,6 +1416,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	}
 	get_device(ctrl->device);
 	dev_set_drvdata(ctrl->device, ctrl);
+	ida_init(&ctrl->ns_ida);
 
 	spin_lock(&dev_list_lock);
 	list_add_tail(&ctrl->node, &nvme_ctrl_list);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b50e591..3b0f84a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -72,6 +72,7 @@ struct nvme_ctrl {
 	struct mutex namespaces_mutex;
 	struct device *device;	/* char device */
 	struct list_head node;
+	struct ida ns_ida;
 
 	char name[12];
 	char serial[20];
@@ -103,6 +104,7 @@ struct nvme_ns {
 	struct request_queue *queue;
 	struct gendisk *disk;
 	struct kref kref;
+	int instance;
 
 	u8 eui[8];
 	u8 uuid[16];
-- 
2.6.2.307.g37023ba
