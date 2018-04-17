From: wxu@cnexlabs.com (Wei Xu)
Date: Tue, 17 Apr 2018 09:55:12 +0800
Subject: [PATCH] nvme: lightnvm: add granby support
Message-ID: <1523930112-7402-1-git-send-email-wxu@cnexlabs.com>

Add a new lightnvm quirk to identify CNEX?s Granby controller.

Signed-off-by: Wei Xu <wxu at cnexlabs.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cb73bc8..9419e88 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2529,6 +2529,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE(0x1d1d, 0x2807),	/* CNEX WL */
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
+	{ PCI_DEVICE(0x1d1d, 0x2601),	/* CNEX Granby */
+		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.7.4
