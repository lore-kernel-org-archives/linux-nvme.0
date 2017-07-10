From: david.fugate@intel.com (David Wayne Fugate)
Date: Mon, 10 Jul 2017 12:39:59 -0600
Subject: [PATCH] NVMe: Added another device ID with stripe quirk
In-Reply-To: <a01eeb47-7566-05fb-4d8b-db5ddef36b82@grimberg.me>
References: <a01eeb47-7566-05fb-4d8b-db5ddef36b82@grimberg.me>
Message-ID: <1499711999-2370-1-git-send-email-david.fugate@intel.com>

Adds a fourth Intel controller which has the "stripe" quirk.

Signed-off-by: David Wayne Fugate <david.fugate at intel.com>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 48d3ed3..9101b3e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2462,6 +2462,9 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x0a54),
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
+	{ PCI_VDEVICE(INTEL, 0x0a55),
+		.driver_data = NVME_QUIRK_STRIPE_SIZE |
+				NVME_QUIRK_DEALLOCATE_ZEROES, },
 	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS },
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
-- 
2.7.4
