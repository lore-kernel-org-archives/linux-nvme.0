From: keith.busch@intel.com (Keith Busch)
Date: Mon, 24 Jun 2013 14:30:59 -0600
Subject: [PATCHv3 5/5] NVMe: Add pci suspend/resume driver callbacks
In-Reply-To: <1372105859-27850-1-git-send-email-keith.busch@intel.com>
References: <1372105859-27850-1-git-send-email-keith.busch@intel.com>
Message-ID: <1372105859-27850-6-git-send-email-keith.busch@intel.com>

Used for going in and out of low power states.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index f943d49..600cbbe 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2212,8 +2212,29 @@ static void nvme_remove(struct pci_dev *pdev)
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
+	if (ret)
+		nvme_free_queues(ndev);
+	return ret;
+}
+
+SIMPLE_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume);
 
 static const struct pci_error_handlers nvme_err_handler = {
 	.error_detected	= nvme_error_detected,
@@ -2237,8 +2258,9 @@ static struct pci_driver nvme_driver = {
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
