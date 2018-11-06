From: acelan.kao@canonical.com (AceLan Kao)
Date: Tue,  6 Nov 2018 10:04:02 +0800
Subject: [PATCH 2/2] nvme: add quirk to not call disable function when
 suspending
In-Reply-To: <20181106020402.21120-1-acelan.kao@canonical.com>
References: <20181106020402.21120-1-acelan.kao@canonical.com>
Message-ID: <20181106020402.21120-2-acelan.kao@canonical.com>

Call nvme_dev_disable() function leads to the power consumption goes
up to 2.2 Watt during suspend-to-idle, and from SK hynix FE, they
suggest us to use its own APST feature to do the power management during
s2idle.
After D3 is diabled and nvme_dev_disable() is not called while
suspending, the power consumption drops to 0.77 Watt during s2idle.

Signed-off-by: AceLan Kao <acelan.kao at canonical.com>
---
 drivers/nvme/host/nvme.h | 5 +++++
 drivers/nvme/host/pci.c  | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cee79cb388af..35d260a4cf46 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -90,6 +90,11 @@ enum nvme_quirks {
 	 * Set MEDIUM priority on SQ creation
 	 */
 	NVME_QUIRK_MEDIUM_PRIO_SQ		= (1 << 7),
+
+	/*
+	 * Do not disable nvme when suspending(s2idle)
+	 */
+	NVME_QUIRK_NO_DISABLE			= (1 << 8),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c33bb201b884..586f3516e36b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -31,6 +31,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/sed-opal.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/suspend.h>
 
 #include "nvme.h"
 
@@ -2612,8 +2613,11 @@ static int nvme_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+	struct nvme_ctrl *ctrl = &ndev->ctrl;
+
+	if (!(pm_suspend_via_s2idle() && (ctrl->quirks & NVME_QUIRK_NO_DISABLE)))
+		nvme_dev_disable(ndev, true);
 
-	nvme_dev_disable(ndev, true);
 	return 0;
 }
 
@@ -2716,6 +2720,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE(0x1d1d, 0x2601),	/* CNEX Granby */
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
+	{ PCI_DEVICE(0x1c5c, 0x1527),   /* Sk Hynix */
+		.driver_data = NVME_QUIRK_NO_DISABLE, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.17.1
