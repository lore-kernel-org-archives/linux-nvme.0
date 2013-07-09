From: keith.busch@intel.com (Keith Busch)
Date: Tue,  9 Jul 2013 14:20:41 -0600
Subject: [PATCHv4 5/5] NVMe: Add pci suspend/resume driver callbacks
In-Reply-To: <1373401241-20259-1-git-send-email-keith.busch@intel.com>
References: <1373401241-20259-1-git-send-email-keith.busch@intel.com>
Message-ID: <1373401241-20259-6-git-send-email-keith.busch@intel.com>

Used for going in and out of low power states.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   56 +++++++++++++++++++++++++++++++++-----------
 1 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 1af943d..76caec6 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -791,6 +791,12 @@ static void nvme_make_request(struct request_queue *q, struct bio *bio)
 	struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
 	int result = -EBUSY;
 
+	if (!nvmeq) {
+		put_nvmeq(NULL);
+		bio_endio(bio, -EIO);
+		return;
+	}
+
 	spin_lock_irq(&nvmeq->q_lock);
 	if (!nvmeq->q_suspended && bio_list_empty(&nvmeq->sq_cong))
 		result = nvme_submit_bio_queue(nvmeq, ns, bio);
@@ -1258,9 +1264,13 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	if (result < 0)
 		return result;
 
-	nvmeq = nvme_alloc_queue(dev, 0, 64, 0);
-	if (!nvmeq)
-		return -ENOMEM;
+	nvmeq = dev->queues[0];
+	if (!nvmeq) {
+		nvmeq = nvme_alloc_queue(dev, 0, 64, 0);
+		if (!nvmeq)
+			return -ENOMEM;
+		dev->queues[0] = nvmeq;
+	}
 
 	aqa = nvmeq->q_depth - 1;
 	aqa |= aqa << 16;
@@ -1277,21 +1287,16 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 
 	result = nvme_enable_ctrl(dev, cap);
 	if (result)
-		goto free_q;
+		return result;
 
 	result = queue_request_irq(dev, nvmeq, "nvme admin");
 	if (result)
-		goto free_q;
+		return result;
 
-	dev->queues[0] = nvmeq;
 	spin_lock(&nvmeq->q_lock);
 	nvme_init_queue(nvmeq, 0);
 	spin_unlock(&nvmeq->q_lock);
 	return result;
-
- free_q:
-	nvme_free_queue_mem(nvmeq);
-	return result;
 }
 
 struct nvme_iod *nvme_map_user_pages(struct nvme_dev *dev, int write,
@@ -2207,8 +2212,30 @@ static void nvme_remove(struct pci_dev *pdev)
 #define nvme_link_reset NULL
 #define nvme_slot_reset NULL
 #define nvme_error_resume NULL
-#define nvme_suspend NULL
-#define nvme_resume NULL
+
+static int nvme_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+
+	nvme_dev_shutdown(ndev);
+	return 0;
+}
+
+static int nvme_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+	int ret;
+
+	ret = nvme_dev_start(ndev);
+	/* XXX: should remove gendisks if resume fails */
+	if (ret)
+		nvme_free_queues(ndev);
+	return ret;
+}
+
+SIMPLE_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume);
 
 static const struct pci_error_handlers nvme_err_handler = {
 	.error_detected	= nvme_error_detected,
@@ -2232,8 +2259,9 @@ static struct pci_driver nvme_driver = {
 	.id_table	= nvme_id_table,
 	.probe		= nvme_probe,
 	.remove		= nvme_remove,
-	.suspend	= nvme_suspend,
-	.resume		= nvme_resume,
+	.driver 	= {
+		.pm  	= &nvme_dev_pm_ops,
+	},
 	.err_handler	= &nvme_err_handler,
 };
 
-- 
1.7.0.4
