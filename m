From: wenbo.wang@memblaze.com (Wenbo Wang)
Date: Tue, 9 Aug 2016 03:18:16 +0000
Subject: [PATCH] nvme/quirk: Add a delay before checking device ready for
 memblaze device
Message-ID: <BJXPR01MB1988042B22A1478144DBEFFE01C0@BJXPR01MB198.CHNPR01.prod.partner.outlook.cn>

Add a delay before checking device ready for memblaze device


Signed-off-by: Wenbo Wang <wenbo.wang at memblaze.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c82282f..ab90e5f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2154,6 +2154,8 @@ static const struct pci_device_id nvme_id_table[] = {
        .driver_data = NVME_QUIRK_IDENTIFY_CNS, },
    { PCI_DEVICE(0x1c58, 0x0003),   /* HGST adapter */
        .driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
+   { PCI_DEVICE(0x1c5f, 0x0540),   /* Memblaze Pblaze4 adapter */
+       .driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
    { PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
    { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
    { 0, }
--
1.8.3.1
