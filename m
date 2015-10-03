From: hch@lst.de (Christoph Hellwig)
Date: Sat,  3 Oct 2015 15:39:44 +0200
Subject: [PATCH 5/8] nvme: merge nvme_dev_reset into nvme_reset_failed_dev
In-Reply-To: <1443879587-23553-1-git-send-email-hch@lst.de>
References: <1443879587-23553-1-git-send-email-hch@lst.de>
Message-ID: <1443879587-23553-6-git-send-email-hch@lst.de>

And give the resulting function a more descriptive name.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index be35b1d..509ad4b 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -84,7 +84,6 @@ static wait_queue_head_t nvme_kthread_wait;
 
 static struct class *nvme_class;
 
-static void nvme_reset_failed_dev(struct work_struct *ws);
 static int nvme_reset(struct nvme_dev *dev);
 static int nvme_process_cq(struct nvme_queue *nvmeq);
 
@@ -3053,8 +3052,9 @@ static void nvme_dead_ctrl(struct nvme_dev *dev)
 	}
 }
 
-static void nvme_dev_reset(struct nvme_dev *dev)
+static void nvme_reset_work(struct work_struct *ws)
 {
+	struct nvme_dev *dev = container_of(ws, struct nvme_dev, reset_work);
 	bool in_probe = work_busy(&dev->probe_work);
 
 	nvme_dev_shutdown(dev);
@@ -3074,12 +3074,6 @@ static void nvme_dev_reset(struct nvme_dev *dev)
 	schedule_work(&dev->probe_work);
 }
 
-static void nvme_reset_failed_dev(struct work_struct *ws)
-{
-	struct nvme_dev *dev = container_of(ws, struct nvme_dev, reset_work);
-	nvme_dev_reset(dev);
-}
-
 static int nvme_reset(struct nvme_dev *dev)
 {
 	int ret = -EBUSY;
@@ -3142,7 +3136,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto free;
 
 	INIT_LIST_HEAD(&dev->namespaces);
-	INIT_WORK(&dev->reset_work, nvme_reset_failed_dev);
+	INIT_WORK(&dev->reset_work, nvme_reset_work);
 	dev->dev = get_device(&pdev->dev);
 	pci_set_drvdata(pdev, dev);
 	result = nvme_set_instance(dev);
-- 
1.9.1
