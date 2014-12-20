From: keith.busch@intel.com (Keith Busch)
Date: Fri, 19 Dec 2014 17:54:16 -0700
Subject: [PATCH 4/4] NVMe: Freeze queues on shutdown
In-Reply-To: <1419036856-16275-1-git-send-email-keith.busch@intel.com>
References: <1419036856-16275-1-git-send-email-keith.busch@intel.com>
Message-ID: <1419036856-16275-5-git-send-email-keith.busch@intel.com>

We need to prevent entering queues and allocating requests when we are
about to disable a h/w queue.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 9642c83..3063958 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2244,10 +2244,13 @@ static void nvme_wait_dq(struct nvme_delq_ctx *dq, struct nvme_dev *dev)
 					fatal_signal_pending(current)) {
 			set_current_state(TASK_RUNNING);
 
+			blk_mq_freeze_queue_start(dev->admin_q);
 			nvme_disable_ctrl(dev, readq(&dev->bar->cap));
 			nvme_disable_queue(dev, 0);
 
-			send_sig(SIGKILL, dq->worker->task, 1);
+			blk_cleanup_queue(dev->admin_q);
+			blk_mq_unfreeze_queue(dev->admin_q);
+
 			flush_kthread_worker(dq->worker);
 			return;
 		}
@@ -2383,6 +2386,22 @@ static void nvme_dev_list_remove(struct nvme_dev *dev)
 		kthread_stop(tmp);
 }
 
+static void nvme_freeze_queues(struct nvme_dev *dev)
+{
+	struct nvme_ns *ns;
+
+	list_for_each_entry(ns, &dev->namespaces, list)
+		blk_mq_freeze_queue_start(ns->queue);
+}
+
+static void nvme_unfreeze_queues(struct nvme_dev *dev)
+{
+	struct nvme_ns *ns;
+
+	list_for_each_entry(ns, &dev->namespaces, list)
+		blk_mq_unfreeze_queue(ns->queue);
+}
+
 static void nvme_dev_shutdown(struct nvme_dev *dev)
 {
 	int i;
@@ -2391,6 +2410,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 	dev->initialized = 0;
 	nvme_dev_list_remove(dev);
 
+	nvme_freeze_queues(dev);
 	if (dev->bar)
 		csts = readl(&dev->bar->csts);
 	if (csts & NVME_CSTS_CFS || !(csts & NVME_CSTS_RDY)) {
@@ -2646,7 +2666,8 @@ static int nvme_dev_resume(struct nvme_dev *dev)
 		dev->reset_workfn = nvme_remove_disks;
 		queue_work(nvme_workq, &dev->reset_work);
 		spin_unlock(&dev_list_lock);
-	}
+	} else
+		nvme_unfreeze_queues(dev);
 	dev->initialized = 1;
 	return 0;
 }
@@ -2783,8 +2804,8 @@ static void nvme_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 	flush_work(&dev->reset_work);
 	misc_deregister(&dev->miscdev);
-	nvme_dev_remove(dev);
 	nvme_dev_shutdown(dev);
+	nvme_dev_remove(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);
 	nvme_free_admin_tags(dev);
-- 
1.7.10.4
