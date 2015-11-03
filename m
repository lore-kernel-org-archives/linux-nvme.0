From: guenther@tum.de (Stephan =?utf-8?Q?G=C3=BCnther?=)
Date: Wed, 4 Nov 2015 00:49:45 +0100
Subject: [PATCH 2/2] nvme: add support for Apple NVMe controller
In-Reply-To: <33537e8a12dff1f96eaec9098724d01e@localhost>
References: <33537e8a12dff1f96eaec9098724d01e@localhost>
Message-ID: <945882bb63ee0a329046b67b0342452a@localhost>

Add PCI ID of Apple's NVMe controller.

Signed-off-by: Stephan Guenther <guenther at tum.de>
Signed-off-by: Maurice Leclaire <leclaire at in.tum.de>
---
 drivers/block/nvme-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 2f1766b..ed088cf 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -3326,6 +3326,7 @@ static const struct pci_error_handlers nvme_err_handler = {
 
 static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, nvme_id_table);
