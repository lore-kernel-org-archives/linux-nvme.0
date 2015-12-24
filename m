From: hch@lst.de (Christoph Hellwig)
Date: Thu, 24 Dec 2015 11:15:53 +0100
Subject: [PATCH 1/3] nvme: synchronize access to ctrl->namespaces
In-Reply-To: <1450952155-8693-1-git-send-email-hch@lst.de>
References: <1450952155-8693-1-git-send-email-hch@lst.de>
Message-ID: <1450952155-8693-2-git-send-email-hch@lst.de>

Currently traversal and modification of ctrl->namespaces happens completely
unsynchronized, which can be fixed by the addition of a simple mutex.

Note: nvme_dev_ioctl will be handled in the next patch.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 13 +++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  4 ++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1437ff3..eba7e96 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1034,6 +1034,8 @@ static struct nvme_ns *nvme_find_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns;
 
+	lockdep_assert_held(&ctrl->namespaces_mutex);
+
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		if (ns->ns_id == nsid)
 			return ns;
@@ -1049,6 +1051,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	struct gendisk *disk;
 	int node = dev_to_node(ctrl->dev);
 
+	lockdep_assert_held(&ctrl->namespaces_mutex);
+
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
 		return;
@@ -1118,6 +1122,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	bool kill = nvme_io_incapable(ns->ctrl) &&
 			!blk_queue_dying(ns->queue);
 
+	lockdep_assert_held(&ns->ctrl->namespaces_mutex);
+
 	if (kill)
 		blk_set_queue_dying(ns->queue);
 	if (ns->disk->flags & GENHD_FL_UP) {
@@ -1188,6 +1194,8 @@ static void __nvme_scan_namespaces(struct nvme_ctrl *ctrl, unsigned nn)
 	struct nvme_ns *ns, *next;
 	unsigned i;
 
+	lockdep_assert_held(&ctrl->namespaces_mutex);
+
 	for (i = 1; i <= nn; i++)
 		nvme_validate_ns(ctrl, i);
 
@@ -1205,6 +1213,7 @@ void nvme_scan_namespaces(struct nvme_ctrl *ctrl)
 	if (nvme_identify_ctrl(ctrl, &id))
 		return;
 
+	mutex_lock(&ctrl->namespaces_mutex);
 	nn = le32_to_cpu(id->nn);
 	if (ctrl->vs >= NVME_VS(1, 1) &&
 	    !(ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)) {
@@ -1214,6 +1223,7 @@ void nvme_scan_namespaces(struct nvme_ctrl *ctrl)
 	__nvme_scan_namespaces(ctrl, le32_to_cpup(&id->nn));
  done:
 	list_sort(NULL, &ctrl->namespaces, ns_cmp);
+	mutex_unlock(&ctrl->namespaces_mutex);
 	kfree(id);
 }
 
@@ -1221,8 +1231,10 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns, *next;
 
+	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list)
 		nvme_ns_remove(ns);
+	mutex_unlock(&ctrl->namespaces_mutex);
 }
 
 static DEFINE_IDA(nvme_instance_ida);
@@ -1290,6 +1302,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	int ret;
 
 	INIT_LIST_HEAD(&ctrl->namespaces);
+	mutex_init(&ctrl->namespaces_mutex);
 	kref_init(&ctrl->kref);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d88cf45..d203745 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -69,6 +69,7 @@ struct nvme_ctrl {
 	int instance;
 	struct blk_mq_tag_set *tagset;
 	struct list_head namespaces;
+	struct mutex namespaces_mutex;
 	struct device *device;	/* char device */
 	struct list_head node;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b82bbea..e4a6868 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1907,6 +1907,7 @@ static void nvme_freeze_queues(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns;
 
+	mutex_lock(&dev->ctrl.namespaces_mutex);
 	list_for_each_entry(ns, &dev->ctrl.namespaces, list) {
 		blk_mq_freeze_queue_start(ns->queue);
 
@@ -1917,18 +1918,21 @@ static void nvme_freeze_queues(struct nvme_dev *dev)
 		blk_mq_cancel_requeue_work(ns->queue);
 		blk_mq_stop_hw_queues(ns->queue);
 	}
+	mutex_unlock(&dev->ctrl.namespaces_mutex);
 }
 
 static void nvme_unfreeze_queues(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns;
 
+	mutex_lock(&dev->ctrl.namespaces_mutex);
 	list_for_each_entry(ns, &dev->ctrl.namespaces, list) {
 		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
 		blk_mq_unfreeze_queue(ns->queue);
 		blk_mq_start_stopped_hw_queues(ns->queue, true);
 		blk_mq_kick_requeue_list(ns->queue);
 	}
+	mutex_unlock(&dev->ctrl.namespaces_mutex);
 }
 
 static void nvme_dev_shutdown(struct nvme_dev *dev)
-- 
1.9.1
