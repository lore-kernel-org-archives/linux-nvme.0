From: keith.busch@intel.com (Keith Busch)
Date: Mon,  2 May 2016 14:36:07 -0600
Subject: [PATCH] NVMe: Add device ID's with stripe quirk
Message-ID: <1462221367-28539-1-git-send-email-keith.busch@intel.com>

Adds two Intel controllers that have the "stripe" quirk.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2bffb94..e02950c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2106,6 +2106,12 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x0953),
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DISCARD_ZEROES, },
+	{ PCI_VDEVICE(INTEL, 0x0a53),
+		.driver_data = NVME_QUIRK_STRIPE_SIZE |
+				NVME_QUIRK_DISCARD_ZEROES, },
+	{ PCI_VDEVICE(INTEL, 0x0a54),
+		.driver_data = NVME_QUIRK_STRIPE_SIZE |
+				NVME_QUIRK_DISCARD_ZEROES, },
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
-- 
2.7.2
