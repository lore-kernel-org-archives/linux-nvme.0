From: hch@lst.de (Christoph Hellwig)
Date: Sat,  3 Oct 2015 15:39:46 +0200
Subject: [PATCH 7/8] nvme: merge nvme_dev_start,
 nvme_dev_resume and nvme_async_probe
In-Reply-To: <1443879587-23553-1-git-send-email-hch@lst.de>
References: <1443879587-23553-1-git-send-email-hch@lst.de>
Message-ID: <1443879587-23553-8-git-send-email-hch@lst.de>

And give the resulting function a sensible name.  This keeps all the
error handling in a single place and will allow for further improvements
to it.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c | 53 ++++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e03a95b..61cfff3 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -87,6 +87,7 @@ static struct class *nvme_class;
 static int __nvme_reset(struct nvme_dev *dev);
 static int nvme_reset(struct nvme_dev *dev);
 static int nvme_process_cq(struct nvme_queue *nvmeq);
+static void nvme_dead_ctrl(struct nvme_dev *dev);
 
 struct async_cmd_info {
 	struct kthread_work work;
@@ -2949,14 +2950,15 @@ static const struct file_operations nvme_dev_fops = {
 	.compat_ioctl	= nvme_dev_ioctl,
 };
 
-static int nvme_dev_start(struct nvme_dev *dev)
+static void nvme_probe_work(struct work_struct *work)
 {
-	int result;
+	struct nvme_dev *dev = container_of(work, struct nvme_dev, probe_work);
 	bool start_thread = false;
+	int result;
 
 	result = nvme_dev_map(dev);
 	if (result)
-		return result;
+		goto out;
 
 	result = nvme_configure_admin_queue(dev);
 	if (result)
@@ -2991,7 +2993,17 @@ static int nvme_dev_start(struct nvme_dev *dev)
 		goto free_tags;
 
 	dev->event_limit = 1;
-	return result;
+
+	if (dev->online_queues < 2) {
+		dev_warn(dev->dev, "IO queues not created\n");
+		nvme_free_queues(dev, 1);
+		nvme_dev_remove(dev);
+	} else {
+		nvme_unfreeze_queues(dev);
+		nvme_dev_add(dev);
+	}
+
+	return;
 
  free_tags:
 	nvme_dev_remove_admin(dev);
@@ -3003,7 +3015,9 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	nvme_dev_list_remove(dev);
  unmap:
 	nvme_dev_unmap(dev);
-	return result;
+ out:
+	if (!work_busy(&dev->reset_work))
+		nvme_dead_ctrl(dev);
 }
 
 static int nvme_remove_dead_ctrl(void *arg)
@@ -3017,24 +3031,6 @@ static int nvme_remove_dead_ctrl(void *arg)
 	return 0;
 }
 
-static int nvme_dev_resume(struct nvme_dev *dev)
-{
-	int ret;
-
-	ret = nvme_dev_start(dev);
-	if (ret)
-		return ret;
-	if (dev->online_queues < 2) {
-		dev_warn(dev->dev, "IO queues not created\n");
-		nvme_free_queues(dev, 1);
-		nvme_dev_remove(dev);
-	} else {
-		nvme_unfreeze_queues(dev);
-		nvme_dev_add(dev);
-	}
-	return 0;
-}
-
 static void nvme_dead_ctrl(struct nvme_dev *dev)
 {
 	dev_warn(dev->dev, "Device failed to resume\n");
@@ -3113,7 +3109,6 @@ static ssize_t nvme_sysfs_reset(struct device *dev,
 }
 static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
 
-static void nvme_async_probe(struct work_struct *work);
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int node, result = -ENOMEM;
@@ -3164,7 +3159,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	INIT_LIST_HEAD(&dev->node);
 	INIT_WORK(&dev->scan_work, nvme_dev_scan);
-	INIT_WORK(&dev->probe_work, nvme_async_probe);
+	INIT_WORK(&dev->probe_work, nvme_probe_work);
 	schedule_work(&dev->probe_work);
 	return 0;
 
@@ -3184,14 +3179,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return result;
 }
 
-static void nvme_async_probe(struct work_struct *work)
-{
-	struct nvme_dev *dev = container_of(work, struct nvme_dev, probe_work);
-
-	if (nvme_dev_resume(dev) && !work_busy(&dev->reset_work))
-		nvme_dead_ctrl(dev);
-}
-
 static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-- 
1.9.1
