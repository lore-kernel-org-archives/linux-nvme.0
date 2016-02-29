From: hch@lst.de (Christoph Hellwig)
Date: Mon, 29 Feb 2016 15:59:46 +0100
Subject: [PATCH 3/4] nvme: replace the kthread with a per-device watchdog timer
In-Reply-To: <1456757987-7244-1-git-send-email-hch@lst.de>
References: <1456757987-7244-1-git-send-email-hch@lst.de>
Message-ID: <1456757987-7244-4-git-send-email-hch@lst.de>

The only work left in the kthread is the periodic health check for each
controller.  There is no need to run this from process context or keep
a thread context around for it, so replace it with a simpler timer.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/pci.c | 112 ++++++++++--------------------------------------
 1 file changed, 23 insertions(+), 89 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 10839f7..a623360 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -27,7 +27,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kdev_t.h>
-#include <linux/kthread.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -39,6 +38,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/t10-pi.h>
+#include <linux/timer.h>
 #include <linux/types.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <asm/unaligned.h>
@@ -64,11 +64,7 @@ static bool use_cmb_sqes = true;
 module_param(use_cmb_sqes, bool, 0644);
 MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
 
-static LIST_HEAD(dev_list);
-static DEFINE_SPINLOCK(dev_list_lock);
-static struct task_struct *nvme_thread;
 static struct workqueue_struct *nvme_workq;
-static wait_queue_head_t nvme_kthread_wait;
 
 struct nvme_dev;
 struct nvme_queue;
@@ -82,7 +78,6 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
  */
 struct nvme_dev {
-	struct list_head node;
 	struct nvme_queue **queues;
 	struct blk_mq_tag_set tagset;
 	struct blk_mq_tag_set admin_tagset;
@@ -101,6 +96,7 @@ struct nvme_dev {
 	struct work_struct scan_work;
 	struct work_struct remove_work;
 	struct work_struct async_work;
+	struct timer_list watchdog_timer;
 	struct mutex shutdown_lock;
 	bool subsystem;
 	void __iomem *cmb;
@@ -1334,36 +1330,26 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	return result;
 }
 
-static int nvme_kthread(void *data)
+static void nvme_watchdog_timer(unsigned long data)
 {
-	struct nvme_dev *dev, *next;
+	struct nvme_dev *dev = (struct nvme_dev *)data;
+	u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
-	while (!kthread_should_stop()) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		spin_lock(&dev_list_lock);
-		list_for_each_entry_safe(dev, next, &dev_list, node) {
-			u32 csts = readl(dev->bar + NVME_REG_CSTS);
-
-			/*
-			 * Skip controllers currently under reset.
-			 */
-			if (work_pending(&dev->reset_work) || work_busy(&dev->reset_work))
-				continue;
-
-			if ((dev->subsystem && (csts & NVME_CSTS_NSSRO)) ||
-							csts & NVME_CSTS_CFS) {
-				if (queue_work(nvme_workq, &dev->reset_work)) {
-					dev_warn(dev->ctrl.device,
-						"Failed status: %x, reset controller\n",
-						readl(dev->bar + NVME_REG_CSTS));
-				}
-				continue;
-			}
+	/*
+	 * Skip controllers currently under reset.
+	 */
+	if (!work_pending(&dev->reset_work) && !work_busy(&dev->reset_work) &&
+	    ((csts & NVME_CSTS_CFS) ||
+	     (dev->subsystem && (csts & NVME_CSTS_NSSRO)))) {
+		if (queue_work(nvme_workq, &dev->reset_work)) {
+			dev_warn(dev->dev,
+				"Failed status: 0x%x, reset controller.\n",
+				csts);
 		}
-		spin_unlock(&dev_list_lock);
-		schedule_timeout(round_jiffies_relative(HZ));
+		return;
 	}
-	return 0;
+
+	mod_timer(&dev->watchdog_timer, round_jiffies(jiffies + HZ));
 }
 
 static int nvme_create_io_queues(struct nvme_dev *dev)
@@ -1777,56 +1763,12 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 	}
 }
 
-static int nvme_dev_list_add(struct nvme_dev *dev)
-{
-	bool start_thread = false;
-
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
-	if (IS_ERR_OR_NULL(nvme_thread))
-		return nvme_thread ? PTR_ERR(nvme_thread) : -EINTR;
-
-	return 0;
-}
-
-/*
-* Remove the node from the device list and check
-* for whether or not we need to stop the nvme_thread.
-*/
-static void nvme_dev_list_remove(struct nvme_dev *dev)
-{
-	struct task_struct *tmp = NULL;
-
-	spin_lock(&dev_list_lock);
-	list_del_init(&dev->node);
-	if (list_empty(&dev_list) && !IS_ERR_OR_NULL(nvme_thread)) {
-		tmp = nvme_thread;
-		nvme_thread = NULL;
-	}
-	spin_unlock(&dev_list_lock);
-
-	if (tmp)
-		kthread_stop(tmp);
-}
-
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
 	int i;
 	u32 csts = -1;
 
-	nvme_dev_list_remove(dev);
+	del_timer_sync(&dev->watchdog_timer);
 
 	mutex_lock(&dev->shutdown_lock);
 	if (dev->bar) {
@@ -1927,9 +1869,7 @@ static void nvme_reset_work(struct work_struct *work)
 	dev->ctrl.event_limit = NVME_NR_AEN_COMMANDS;
 	queue_work(nvme_workq, &dev->async_work);
 
-	result = nvme_dev_list_add(dev);
-	if (result)
-		goto remove;
+	mod_timer(&dev->watchdog_timer, round_jiffies(jiffies + HZ));
 
 	/*
 	 * Keep the controller around but remove all namespaces if we don't have
@@ -1946,8 +1886,6 @@ static void nvme_reset_work(struct work_struct *work)
 	clear_bit(NVME_CTRL_RESETTING, &dev->flags);
 	return;
 
- remove:
-	nvme_dev_list_remove(dev);
  free_tags:
 	nvme_dev_remove_admin(dev);
 	blk_put_queue(dev->ctrl.admin_q);
@@ -2055,11 +1993,12 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev->dev = get_device(&pdev->dev);
 	pci_set_drvdata(pdev, dev);
 
-	INIT_LIST_HEAD(&dev->node);
 	INIT_WORK(&dev->scan_work, nvme_dev_scan);
 	INIT_WORK(&dev->reset_work, nvme_reset_work);
 	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
 	INIT_WORK(&dev->async_work, nvme_async_event_work);
+	setup_timer(&dev->watchdog_timer, nvme_watchdog_timer,
+		(unsigned long)dev);
 	mutex_init(&dev->shutdown_lock);
 	init_completion(&dev->ioq_wait);
 
@@ -2108,9 +2047,7 @@ static void nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
-	spin_lock(&dev_list_lock);
-	list_del_init(&dev->node);
-	spin_unlock(&dev_list_lock);
+	del_timer_sync(&dev->watchdog_timer);
 
 	pci_set_drvdata(pdev, NULL);
 	flush_work(&dev->async_work);
@@ -2223,8 +2160,6 @@ static int __init nvme_init(void)
 {
 	int result;
 
-	init_waitqueue_head(&nvme_kthread_wait);
-
 	nvme_workq = alloc_workqueue("nvme", WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
 	if (!nvme_workq)
 		return -ENOMEM;
@@ -2239,7 +2174,6 @@ static void __exit nvme_exit(void)
 {
 	pci_unregister_driver(&nvme_driver);
 	destroy_workqueue(nvme_workq);
-	BUG_ON(nvme_thread && !IS_ERR(nvme_thread));
 	_nvme_check_size();
 }
 
-- 
2.1.4
