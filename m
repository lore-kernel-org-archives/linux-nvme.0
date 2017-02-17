From: danielroschka@phoenitydawn.de (Daniel Roschka)
Date: Fri, 17 Feb 2017 22:25:58 +0100
Subject: [PATCH] Detect NVMe controller in recent MacBooks
Message-ID: <3815714.Y54y20dpT8@buzzard>

Adds support for detection of the NVMe controller found in the 
following recent MacBooks:
- Retina MacBook 2016 (MacBook9,1)
- 13" MacBook Pro 2016 without Touch Bar (MacBook13,1)
- 13" MacBook Pro 2016 with Touch Bar (MacBook13,2)

Signed-off-by: Daniel Roschka <danielroschka at phoenitydawn.de>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3faefabf339c..22401aeae96e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2110,6 +2110,7 @@ static const struct pci_device_id nvme_id_table[] = {
                .driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
        { PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
        { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
+       { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
        { 0, }
 };
 MODULE_DEVICE_TABLE(pci, nvme_id_table);
-- 
2.11.0
