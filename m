From: keith.busch@intel.com (Keith Busch)
Date: Wed, 24 Feb 2016 09:15:53 -0700
Subject: [PATCHv4-4.5 2/7] NVMe: Use IDA for namespace disk naming
In-Reply-To: <1456330558-819-1-git-send-email-keith.busch@intel.com>
References: <1456330558-819-1-git-send-email-keith.busch@intel.com>
Message-ID: <1456330558-819-3-git-send-email-keith.busch@intel.com>

A namespace may be detached from a controller, but a user may be holding
a reference to it. Attaching a new namespace with the same NSID will create
duplicate names when using the NSID to name the disk.

This patch uses an IDA that is released only when the last reference is
released instead of using the namespace ID.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
---
Changes from previous:

  Delete the controller's IDA when the last controller reference is
  released rather than device is removed. This keeps it available for
  all namespace lifetime.

 drivers/nvme/host/core.c | 16 +++++++++++++---
 drivers/nvme/host/nvme.h |  2 ++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3cd921e..4b54081 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -55,8 +55,9 @@ static void nvme_free_ns(struct kref *kref)
 	ns->disk->private_data = NULL;
 	spin_unlock(&dev_list_lock);
 
-	nvme_put_ctrl(ns->ctrl);
 	put_disk(ns->disk);
+	ida_simple_remove(&ns->ctrl->ns_ida, ns->instance);
+	nvme_put_ctrl(ns->ctrl);
 	kfree(ns);
 }
 
@@ -1118,9 +1119,13 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
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
@@ -1153,7 +1158,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	disk->queue = ns->queue;
 	disk->driverfs_dev = ctrl->device;
 	disk->flags = GENHD_FL_EXT_DEVT;
-	sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance, nsid);
+	sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance, ns->instance);
 
 	if (nvme_revalidate_disk(ns->disk))
 		goto out_free_disk;
@@ -1173,6 +1178,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	kfree(disk);
  out_free_queue:
 	blk_cleanup_queue(ns->queue);
+ out_release_instance:
+	ida_simple_remove(&ctrl->ns_ida, ns->instance);
  out_free_ns:
 	kfree(ns);
 }
@@ -1350,6 +1358,7 @@ static void nvme_free_ctrl(struct kref *kref)
 
 	put_device(ctrl->device);
 	nvme_release_instance(ctrl);
+	ida_destroy(&ctrl->ns_ida);
 
 	ctrl->ops->free_ctrl(ctrl);
 }
@@ -1390,6 +1399,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	}
 	get_device(ctrl->device);
 	dev_set_drvdata(ctrl->device, ctrl);
+	ida_init(&ctrl->ns_ida);
 
 	spin_lock(&dev_list_lock);
 	list_add_tail(&ctrl->node, &nvme_ctrl_list);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9664d07..9407f2f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -72,6 +72,7 @@ struct nvme_ctrl {
 	struct mutex namespaces_mutex;
 	struct device *device;	/* char device */
 	struct list_head node;
+	struct ida ns_ida;
 
 	char name[12];
 	char serial[20];
@@ -102,6 +103,7 @@ struct nvme_ns {
 	struct request_queue *queue;
 	struct gendisk *disk;
 	struct kref kref;
+	int instance;
 
 	u8 eui[8];
 	u8 uuid[16];
-- 
2.6.2.307.g37023ba
