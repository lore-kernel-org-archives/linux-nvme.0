From: keith.busch@intel.com (Keith Busch)
Date: Thu,  5 Sep 2013 14:45:13 -0600
Subject: [PATCH 7/9] NVMe: Add shutdown pci callback
In-Reply-To: <1378413915-16667-1-git-send-email-keith.busch@intel.com>
References: <1378413915-16667-1-git-send-email-keith.busch@intel.com>
Message-ID: <1378413915-16667-8-git-send-email-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index c400c0a..d09ef43 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2360,6 +2360,12 @@ static void nvme_remove(struct pci_dev *pdev)
 	kref_put(&dev->kref, nvme_free_dev);
 }
 
+static void nvme_shutdown(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+	nvme_dev_shutdown(dev);
+}
+
 /* These functions are yet to be implemented */
 #define nvme_error_detected NULL
 #define nvme_dump_registers NULL
@@ -2409,6 +2415,7 @@ static struct pci_driver nvme_driver = {
 	.id_table	= nvme_id_table,
 	.probe		= nvme_probe,
 	.remove		= nvme_remove,
+	.shutdown	= nvme_shutdown,
 	.driver		= {
 		.pm	= &nvme_dev_pm_ops,
 	},
-- 
1.7.0.4
