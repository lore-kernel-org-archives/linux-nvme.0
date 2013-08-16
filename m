From: keith.busch@intel.com (Keith Busch)
Date: Fri, 16 Aug 2013 16:00:32 -0600
Subject: [PATCHv2 5/5] NVMe: Add shutdown pci callback
In-Reply-To: <1376690432-9775-1-git-send-email-keith.busch@intel.com>
References: <1376690432-9775-1-git-send-email-keith.busch@intel.com>
Message-ID: <1376690432-9775-6-git-send-email-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
A couple vendors at FMS as well as a few firmware engineers I spoke with
highly recommended we do a safe shutdown sequence for their devices.

 drivers/block/nvme-core.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index cb64866..84bb905 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2272,6 +2272,12 @@ static void nvme_remove(struct pci_dev *pdev)
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
@@ -2325,6 +2331,7 @@ static struct pci_driver nvme_driver = {
 	.id_table	= nvme_id_table,
 	.probe		= nvme_probe,
 	.remove		= nvme_remove,
+	.shutdown	= nvme_shutdown,
 	.driver		= {
 		.pm	= &nvme_dev_pm_ops,
 	},
-- 
1.7.10.4
