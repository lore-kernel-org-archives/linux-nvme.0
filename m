From: keith.busch@intel.com (Keith Busch)
Date: Mon,  6 May 2013 17:03:35 -0600
Subject: [PATCH 5/5] NVMe: Add pci suspend/resume driver callbacks
In-Reply-To: <1367881415-7978-1-git-send-email-keith.busch@intel.com>
References: <1367881415-7978-1-git-send-email-keith.busch@intel.com>
Message-ID: <1367881415-7978-6-git-send-email-keith.busch@intel.com>

Used for going in and out of suspend and hibernation power states.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 89c75c5..96593fd 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2137,8 +2137,25 @@ static void nvme_remove(struct pci_dev *pdev)
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
+
+	return nvme_dev_start(ndev);
+}
+
+UNIVERSAL_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume, NULL);
 
 static const struct pci_error_handlers nvme_err_handler = {
 	.error_detected	= nvme_error_detected,
@@ -2162,8 +2179,9 @@ static struct pci_driver nvme_driver = {
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
