From: hch@lst.de (Christoph Hellwig)
Date: Fri, 20 Nov 2015 17:35:19 +0100
Subject: [PATCH 24/47] nvme: only add a controller to dev_list after it's been
 fully initialized
In-Reply-To: <1448037342-18384-1-git-send-email-hch@lst.de>
References: <1448037342-18384-1-git-send-email-hch@lst.de>
Message-ID: <1448037342-18384-25-git-send-email-hch@lst.de>

Without this we can easily get bad derferences on nvmeq->d_db when the nvme
kthread tries to poll the CQs for controllers that are in half initialized
state.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 51 +++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8251735..c8e381b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2082,6 +2082,30 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
 	kthread_stop(kworker_task);
 }
 
+static int nvme_dev_list_add(struct nvme_dev *dev)
+{
+	bool start_thread = false;
+
+	spin_lock(&dev_list_lock);
+	if (list_empty(&dev_list) && IS_ERR_OR_NULL(nvme_thread)) {
+		start_thread = true;
+		nvme_thread = NULL;
+	}
+	list_add(&dev->node, &dev_list);
+	spin_unlock(&dev_list_lock);
+
+	if (start_thread) {
+		nvme_thread = kthread_run(nvme_kthread, NULL, "nvme");
+		wake_up_all(&nvme_kthread_wait);
+	} else
+		wait_event_killable(nvme_kthread_wait, nvme_thread);
+
+	if (IS_ERR_OR_NULL(nvme_thread))
+		return nvme_thread ? PTR_ERR(nvme_thread) : -EINTR;
+
+	return 0;
+}
+
 /*
 * Remove the node from the device list and check
 * for whether or not we need to stop the nvme_thread.
@@ -2197,7 +2221,6 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 static void nvme_probe_work(struct work_struct *work)
 {
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, probe_work);
-	bool start_thread = false;
 	int result;
 
 	result = nvme_dev_map(dev);
@@ -2208,25 +2231,6 @@ static void nvme_probe_work(struct work_struct *work)
 	if (result)
 		goto unmap;
 
-	spin_lock(&dev_list_lock);
-	if (list_empty(&dev_list) && IS_ERR_OR_NULL(nvme_thread)) {
-		start_thread = true;
-		nvme_thread = NULL;
-	}
-	list_add(&dev->node, &dev_list);
-	spin_unlock(&dev_list_lock);
-
-	if (start_thread) {
-		nvme_thread = kthread_run(nvme_kthread, NULL, "nvme");
-		wake_up_all(&nvme_kthread_wait);
-	} else
-		wait_event_killable(nvme_kthread_wait, nvme_thread);
-
-	if (IS_ERR_OR_NULL(nvme_thread)) {
-		result = nvme_thread ? PTR_ERR(nvme_thread) : -EINTR;
-		goto disable;
-	}
-
 	nvme_init_queue(dev->queues[0], 0);
 	result = nvme_alloc_admin_tags(dev);
 	if (result)
@@ -2242,6 +2246,10 @@ static void nvme_probe_work(struct work_struct *work)
 
 	dev->ctrl.event_limit = 1;
 
+	result = nvme_dev_list_add(dev);
+	if (result)
+		goto remove;
+
 	/*
 	 * Keep the controller around but remove all namespaces if we don't have
 	 * any working I/O queue.
@@ -2256,6 +2264,8 @@ static void nvme_probe_work(struct work_struct *work)
 
 	return;
 
+ remove:
+	nvme_dev_list_remove(dev);
  free_tags:
 	nvme_dev_remove_admin(dev);
 	blk_put_queue(dev->ctrl.admin_q);
@@ -2263,7 +2273,6 @@ static void nvme_probe_work(struct work_struct *work)
 	dev->queues[0]->tags = NULL;
  disable:
 	nvme_disable_queue(dev, 0);
-	nvme_dev_list_remove(dev);
  unmap:
 	nvme_dev_unmap(dev);
  out:
-- 
1.9.1
