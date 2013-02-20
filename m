From: keith.busch@intel.com (Keith Busch)
Date: Wed, 20 Feb 2013 16:52:40 -0700
Subject: [PATCH 3/8] NVMe: Suspend/resume power management
In-Reply-To: <1361404365-18982-1-git-send-email-keith.busch@intel.com>
References: <1361404365-18982-1-git-send-email-keith.busch@intel.com>
Message-ID: <1361404365-18982-3-git-send-email-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 28e014e..98ef07a 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -1874,8 +1874,27 @@ static void __devexit nvme_remove(struct pci_dev *pdev)
 #define nvme_link_reset NULL
 #define nvme_slot_reset NULL
 #define nvme_error_resume NULL
+
+#ifdef CONFIG_PM
+static int nvme_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+	return nvme_shutdown_controller(ndev);
+}
+
+static int nvme_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+	return nvme_restart_controller(ndev);
+}
+#else
 #define nvme_suspend NULL
 #define nvme_resume NULL
+#endif
+
+UNIVERSAL_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume, NULL);
 
 static const struct pci_error_handlers nvme_err_handler = {
 	.error_detected	= nvme_error_detected,
@@ -1899,8 +1918,9 @@ static struct pci_driver nvme_driver = {
 	.id_table	= nvme_id_table,
 	.probe		= nvme_probe,
 	.remove		= __devexit_p(nvme_remove),
-	.suspend	= nvme_suspend,
-	.resume		= nvme_resume,
+	.driver 	= {
+		.pm  	= &nvme_dev_pm_ops,
+	},
 	.err_handler	= &nvme_err_handler,
 };
 
-- 
1.7.0.4
