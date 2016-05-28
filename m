From: nvme@elfenteich.de (Carina Willbold)
Date: Sat, 28 May 2016 23:22:35 +0200
Subject: [PATCH v2] NVMe: Recognize the MacBook9,1 NVMe controller
Message-ID: <20160528212235.GB27943@speicherleck.de>

With this patch, the flash drive of the April 2016 MacBook9,1 12"
(A1534) is properly recognized and works just fine.

Signed-off-by: Carina Willbold <nvme at elfenteich.de>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Christoph Hellwig <hch at lst.de>

---
 drivers/nvme/host/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4fd733f..3d4c25d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2180,7 +2180,11 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
+        /*
+         * Controllers that don't use the NVMe class code:
+         */
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, nvme_id_table);
-- 
2.8.2
