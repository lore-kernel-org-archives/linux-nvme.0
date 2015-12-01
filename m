From: hch@lst.de (Christoph Hellwig)
Date: Tue,  1 Dec 2015 19:52:49 +0100
Subject: [PATCH 14/26] NVMe: Use unbounded work queue for all work
In-Reply-To: <1448995981-11982-1-git-send-email-hch@lst.de>
References: <1448995981-11982-1-git-send-email-hch@lst.de>
Message-ID: <1448995981-11982-15-git-send-email-hch@lst.de>

From: Keith Busch <keith.busch@intel.com>

Removes all usage of the global work queue so work can't be
scheduled on two different work queues, and removes nvme's work queue
singlethreadedness so controllers can be driven in parallel.

Signed-off-by: Keith Busch <keith.busch at intel.com>
[hch: keep the dead controller removal on the system workqueue to avoid
 deadlocks]
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fac1de8..a909a8b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -371,7 +371,7 @@ static void async_req_completion(struct nvme_queue *nvmeq, void *ctx,
 	switch (result & 0xff07) {
 	case NVME_AER_NOTICE_NS_CHANGED:
 		dev_info(nvmeq->q_dmadev, "rescanning\n");
-		schedule_work(&nvmeq->dev->scan_work);
+		queue_work(nvme_workq, &nvmeq->dev->scan_work);
 	default:
 		dev_warn(nvmeq->q_dmadev, "async event result %08x\n", result);
 	}
@@ -1782,7 +1782,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 			return 0;
 		dev->ctrl.tagset = &dev->tagset;
 	}
-	schedule_work(&dev->scan_work);
+	queue_work(nvme_workq, &dev->scan_work);
 	return 0;
 }
 
@@ -2331,7 +2331,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto release_pools;
 
-	schedule_work(&dev->reset_work);
+	queue_work(nvme_workq, &dev->reset_work);
 	return 0;
 
  release_pools:
@@ -2352,7 +2352,7 @@ static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
 	if (prepare)
 		nvme_dev_shutdown(dev);
 	else
-		schedule_work(&dev->reset_work);
+		queue_work(nvme_workq, &dev->reset_work);
 }
 
 static void nvme_shutdown(struct pci_dev *pdev)
@@ -2403,7 +2403,7 @@ static int nvme_resume(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
-	schedule_work(&ndev->reset_work);
+	queue_work(nvme_workq, &ndev->reset_work);
 	return 0;
 }
 #endif
@@ -2451,7 +2451,7 @@ static int __init nvme_init(void)
 
 	init_waitqueue_head(&nvme_kthread_wait);
 
-	nvme_workq = create_singlethread_workqueue("nvme");
+	nvme_workq = alloc_workqueue("nvme", WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
 	if (!nvme_workq)
 		return -ENOMEM;
 
-- 
1.9.1
