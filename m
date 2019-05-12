From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Mon, 13 May 2019 00:54:17 +0900
Subject: [PATCH v3 7/7] nvme-pci: enable to trigger device coredump by hand
In-Reply-To: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1557676457-4195-8-git-send-email-akinobu.mita@gmail.com>

This provides a way to trigger the nvme device coredump by writing
anything to /sys/devices/.../coredump attribute.

Cc: Johannes Berg <johannes at sipsolutions.net>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Minwoo Im <minwoo.im.dev at gmail.com>
Cc: Kenneth Heitke <kenneth.heitke at intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
* v3
- Extracted from 'add device coredump infrastructure' patch
- Avoid deadlock in .coredump callback

 drivers/nvme/host/pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6522592..fad5395 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3288,6 +3288,14 @@ static void nvme_coredump_complete(struct nvme_dev *dev)
 	nvme_coredump_clear(dev);
 }
 
+static void nvme_coredump(struct device *dev)
+{
+	struct nvme_dev *ndev = dev_get_drvdata(dev);
+
+	nvme_dev_disable(ndev, false, true);
+	nvme_reset_ctrl_sync(&ndev->ctrl);
+}
+
 #else
 
 static void nvme_coredump_init(struct nvme_dev *dev)
@@ -3302,6 +3310,10 @@ static void nvme_coredump_complete(struct nvme_dev *dev)
 {
 }
 
+static void nvme_coredump(struct device *dev)
+{
+}
+
 #endif /* CONFIG_DEV_COREDUMP */
 
 static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
@@ -3409,6 +3421,7 @@ static struct pci_driver nvme_driver = {
 	.shutdown	= nvme_shutdown,
 	.driver		= {
 		.pm	= &nvme_dev_pm_ops,
+		.coredump = nvme_coredump,
 	},
 	.sriov_configure = pci_sriov_configure_simple,
 	.err_handler	= &nvme_err_handler,
-- 
2.7.4
