From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Mon, 11 Apr 2016 17:15:50 -0300
Subject: [PATCH 1/2] nvme: Fix pci_device_id table by adding the most generic
 devices in the end
Message-ID: <1460405751-8884-1-git-send-email-gpiccoli@linux.vnet.ibm.com>

The struct pci_device_id is used on a PCI driver probe by the PCI core
mechanism to match the devices present on the system with the driver
being probed. For each device, the match procedure reads each entry in
the pci_device_id struct provided by the driver and tries to match the
first entry it is able to do.

For example, if the table contains a generic entry, like a class generic
id, the PCI core can match the driver to this device ignoring the
following entries on pci_device_id. It means that the most generic entries
should go to the end of the table, to allow the PCI probe mechanism trying
to test the maximum number of members of the id table it can. In this way
we are able to avoid a case in which a generic match is done before the
PCI core is able to test a more specific entry (possible denying some
quirk to be enabled).

This patch moves the PCI_DEVICE_CLASS entry to the end of the struct
nvme_id_table[], so the match to the specific devices will be tried
by the PCI core mechanism before the per-class match can happen.

Signed-off-by: Guilherme G. Piccoli <gpiccoli at linux.vnet.ibm.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 24ccda3..220e0b5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2172,8 +2172,8 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_DISCARD_ZEROES, },
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
-	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
+	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, nvme_id_table);
-- 
2.1.0
