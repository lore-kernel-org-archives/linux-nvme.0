From: keith.busch@intel.com (Keith Busch)
Date: Tue, 10 Dec 2013 13:10:37 -0700
Subject: [PATCH 2/5] NVMe: Schedule reset for failed controllers
In-Reply-To: <1386706240-2300-1-git-send-email-keith.busch@intel.com>
References: <1386706240-2300-1-git-send-email-keith.busch@intel.com>
Message-ID: <1386706240-2300-3-git-send-email-keith.busch@intel.com>

Schedules a controller reset when it indicates it has a failed status. If
the device does not become ready after a reset, the pci device will be
scheduled for removal.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   20 ++++++++++++++++++--
 include/linux/nvme.h      |    1 +
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index f3c2065..d1b456b 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -60,6 +60,8 @@ static LIST_HEAD(dev_list);
 static struct task_struct *nvme_thread;
 static struct workqueue_struct *nvme_workq;
 
+static void nvme_reset_failed_dev(struct work_struct *ws);
+
 /*
  * An NVM Express queue.  Each device has at least two (one for admin
  * commands and one for I/O commands).
@@ -1597,13 +1599,24 @@ static void nvme_resubmit_bios(struct nvme_queue *nvmeq)
 
 static int nvme_kthread(void *data)
 {
-	struct nvme_dev *dev;
+	struct nvme_dev *dev, *next;
 
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		spin_lock(&dev_list_lock);
-		list_for_each_entry(dev, &dev_list, node) {
+		list_for_each_entry_safe(dev, next, &dev_list, node) {
 			int i;
+			if (readl(&dev->bar->csts) & NVME_CSTS_CFS &&
+							dev->initialized) {
+				if (work_busy(&dev->reset_work))
+					continue;
+				list_del_init(&dev->node);
+				dev_warn(&dev->pci_dev->dev,
+					"Failed status, reset controller\n");
+				INIT_WORK(&dev->reset_work, nvme_reset_failed_dev);
+				queue_work(nvme_workq, &dev->reset_work);
+				continue;
+			}
 			for (i = 0; i < dev->queue_count; i++) {
 				struct nvme_queue *nvmeq = dev->queues[i];
 				if (!nvmeq)
@@ -1994,6 +2007,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 {
 	int i;
 
+	dev->initialized = 0;
 	for (i = dev->queue_count - 1; i >= 0; i--)
 		nvme_disable_queue(dev, i);
 
@@ -2184,6 +2198,7 @@ static int nvme_dev_resume(struct nvme_dev *dev)
 		queue_work(nvme_workq, &dev->reset_work);
 		spin_unlock(&dev_list_lock);
 	}
+	dev->initialized = 1;
 	return 0;
 }
 
@@ -2257,6 +2272,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto remove;
 
+	dev->initialized = 1;
 	kref_init(&dev->kref);
 	return 0;
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index cdd37fc..95af9d7 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -95,6 +95,7 @@ struct nvme_dev {
 	u32 max_hw_sectors;
 	u32 stripe_size;
 	u16 oncs;
+	u8 initialized;
 };
 
 /*
-- 
1.7.10.4
