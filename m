From: wenbo.wang@memblaze.com (Wenbo Wang)
Date: Thu, 11 Feb 2016 16:38:45 +0000
Subject: [PATCH for-4.5 05/13] NVMe: Fix namespace removal deadlock
In-Reply-To: <1455128250-5984-6-git-send-email-keith.busch@intel.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-6-git-send-email-keith.busch@intel.com>
Message-ID: <BJXPR01MB1994CF464CC02616EAC036BE0A80@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>

Not sure if async namespace removal has any potential risk.

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Thursday, February 11, 2016 2:17 AM
To: linux-nvme at lists.infradead.org; Jens Axboe
Cc: Christoph Hellwig; Sagi Grimberg; Wenbo Wang; Keith Busch
Subject: [PATCH for-4.5 05/13] NVMe: Fix namespace removal deadlock

Namespace removal holds the namespace list mutex. If the controller fails during namespace removal, the reset work will deadlock trying to acquire the mutex, and no progress will be made.

This patch completes the potentially blocking parts of namespace removal in a controller work queue so that reset work can cleanup a failed controller.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 81 ++++++++++++++++++++++++++++++------------------
 drivers/nvme/host/nvme.h |  6 ++++
 2 files changed, 57 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c index 852b789..be27f9f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -48,6 +48,10 @@ static void nvme_free_ns(struct kref *kref)  {
 	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
 
+	mutex_lock(&ns->ctrl->namespaces_mutex);
+	list_del_init(&ns->list);
+	mutex_unlock(&ns->ctrl->namespaces_mutex);
+
 	if (ns->type == NVME_NS_LIGHTNVM)
 		nvme_nvm_unregister(ns->queue, ns->disk->disk_name);
 
@@ -1106,6 +1110,37 @@ static struct nvme_ns *nvme_find_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	return NULL;
 }
 
+static void nvme_ns_remove_work(struct work_struct *work) {
+	struct nvme_ns *ns = container_of(work, struct nvme_ns, remove_work);
+	bool kill = nvme_io_incapable(ns->ctrl) &&
+			!blk_queue_dying(ns->queue);
+
+	if (kill) {
+		blk_set_queue_dying(ns->queue);
+
+		/*
+		 * The controller was shutdown first if we got here through
+		 * device removal. The shutdown may requeue outstanding
+		 * requests. These need to be aborted immediately so
+		 * del_gendisk doesn't block indefinitely for their completion.
+		 */
+		blk_mq_abort_requeue_list(ns->queue);
+	}
+	if (ns->disk->flags & GENHD_FL_UP) {
+		if (blk_get_integrity(ns->disk))
+			blk_integrity_unregister(ns->disk);
+		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
+					&nvme_ns_attr_group);
+		del_gendisk(ns->disk);
+	}
+	if (kill || !blk_queue_dying(ns->queue)) {
+		blk_mq_abort_requeue_list(ns->queue);
+		blk_cleanup_queue(ns->queue);
+	}
+	nvme_put_ns(ns);
+}
+
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)  {
 	struct nvme_ns *ns;
@@ -1161,6 +1196,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	list_add_tail(&ns->list, &ctrl->namespaces);
 	kref_get(&ctrl->kref);
+	INIT_WORK(&ns->remove_work, nvme_ns_remove_work);
 	if (ns->type == NVME_NS_LIGHTNVM)
 		return;
 
@@ -1180,35 +1216,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 static void nvme_ns_remove(struct nvme_ns *ns)  {
-	bool kill = nvme_io_incapable(ns->ctrl) &&
-			!blk_queue_dying(ns->queue);
-
-	lockdep_assert_held(&ns->ctrl->namespaces_mutex);
-
-	if (kill) {
-		blk_set_queue_dying(ns->queue);
-
-		/*
-		 * The controller was shutdown first if we got here through
-		 * device removal. The shutdown may requeue outstanding
-		 * requests. These need to be aborted immediately so
-		 * del_gendisk doesn't block indefinitely for their completion.
-		 */
-		blk_mq_abort_requeue_list(ns->queue);
-	}
-	if (ns->disk->flags & GENHD_FL_UP) {
-		if (blk_get_integrity(ns->disk))
-			blk_integrity_unregister(ns->disk);
-		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
-					&nvme_ns_attr_group);
-		del_gendisk(ns->disk);
-	}
-	if (kill || !blk_queue_dying(ns->queue)) {
-		blk_mq_abort_requeue_list(ns->queue);
-		blk_cleanup_queue(ns->queue);
-	}
-	list_del_init(&ns->list);
-	nvme_put_ns(ns);
+	if (!test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
+		queue_work(ns->ctrl->ns_workq, &ns->remove_work);
 }
 
 static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid) @@ -1305,6 +1314,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list)
 		nvme_ns_remove(ns);
 	mutex_unlock(&ctrl->namespaces_mutex);
+
+	flush_workqueue(ctrl->ns_workq);
 }
 
 static DEFINE_IDA(nvme_instance_ida);
@@ -1337,12 +1348,14 @@ static void nvme_release_instance(struct nvme_ctrl *ctrl)  }
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
- {
+{
 	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
 
 	spin_lock(&dev_list_lock);
 	list_del(&ctrl->node);
 	spin_unlock(&dev_list_lock);
+
+	destroy_workqueue(ctrl->ns_workq);
 }
 
 static void nvme_free_ctrl(struct kref *kref) @@ -1392,11 +1405,19 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	get_device(ctrl->device);
 	dev_set_drvdata(ctrl->device, ctrl);
 
+	ctrl->ns_workq = alloc_workqueue("nvme-ns", WQ_UNBOUND, 0);
+	if (!ctrl->ns_workq) {
+		ret = -ENOMEM;
+		goto out_destroy_device;
+	}
+
 	spin_lock(&dev_list_lock);
 	list_add_tail(&ctrl->node, &nvme_ctrl_list);
 	spin_unlock(&dev_list_lock);
 
 	return 0;
+out_destroy_device:
+	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
 out_release_instance:
 	nvme_release_instance(ctrl);
 out:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h index 9664d07..d330512 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -72,6 +72,7 @@ struct nvme_ctrl {
 	struct mutex namespaces_mutex;
 	struct device *device;	/* char device */
 	struct list_head node;
+	struct workqueue_struct *ns_workq;
 
 	char name[12];
 	char serial[20];
@@ -112,6 +113,11 @@ struct nvme_ns {
 	bool ext;
 	u8 pi_type;
 	int type;
+	struct work_struct remove_work;
+	unsigned long flags;
+
+#define NVME_NS_REMOVING 0
+
 	u64 mode_select_num_blocks;
 	u32 mode_select_block_len;
 };
--
2.6.2.307.g37023ba
