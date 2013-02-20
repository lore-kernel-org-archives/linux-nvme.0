From: keith.busch@intel.com (Keith Busch)
Date: Wed, 20 Feb 2013 16:52:41 -0700
Subject: [PATCH 4/8] NVMe: Add shutdown callback
In-Reply-To: <1361404365-18982-1-git-send-email-keith.busch@intel.com>
References: <1361404365-18982-1-git-send-email-keith.busch@intel.com>
Message-ID: <1361404365-18982-4-git-send-email-keith.busch@intel.com>

Shuts down the controller in a controlled way in accordance with the
NVMe spec when a system shutdown request occurs.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 98ef07a..aeaea1a 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -1875,6 +1875,12 @@ static void __devexit nvme_remove(struct pci_dev *pdev)
 #define nvme_slot_reset NULL
 #define nvme_error_resume NULL
 
+static void nvme_shutdown(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+	nvme_shutdown_controller(dev);
+}
+
 #ifdef CONFIG_PM
 static int nvme_suspend(struct device *dev)
 {
@@ -1918,6 +1924,7 @@ static struct pci_driver nvme_driver = {
 	.id_table	= nvme_id_table,
 	.probe		= nvme_probe,
 	.remove		= __devexit_p(nvme_remove),
+	.shutdown	= nvme_shutdown,
 	.driver 	= {
 		.pm  	= &nvme_dev_pm_ops,
 	},
-- 
1.7.0.4
