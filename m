From: gwendal@chromium.org (Gwendal Grignou)
Date: Fri, 26 Oct 2018 15:41:46 -0700
Subject: [PATCH] nvme-pci: Add Write Zero support to Intel 660p
Message-ID: <20181026224146.198311-1-gwendal@chromium.org>

Given Intel 660p returns 0 when reading discarded data,
allow Write Zero.

nvme id-ns /dev/nvme0n1
...
dlfeat  : 1
...

Check Write Zeros is now enabled:
cat /sys/block/nvme0n1/queue/write_zeroes_max_bytes
2199023255040

Signed-off-by: Gwendal Grignou <gwendal at chromium.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7e09e45b0b28d..b81ad51d78b72 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2694,6 +2694,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_MEDIUM_PRIO_SQ },
+	{ PCI_VDEVICE(INTEL, 0xf1a8), /* Intel 660P */
+		.driver_data = NVME_QUIRK_DEALLOCATE_ZEROES, },
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
-- 
2.19.1.568.g152ad8e336-goog
