From: kai.heng.feng@canonical.com (Kai-Heng Feng)
Date: Thu,  9 Nov 2017 01:12:03 -0500
Subject: [PATCH] nvme-pci: disable APST on Samsung SSD 960 EVO + ASUS PRIME
 B350M-A
Message-ID: <20171109061203.18857-1-kai.heng.feng@canonical.com>

The NVMe device in question drops off the PCIe bus after system suspend.
I've tried several approaches to workaround this issue, but none of them
works:
- NVME_QUIRK_DELAY_BEFORE_CHK_RDY
- NVME_QUIRK_NO_DEEPEST_PS
- Disable APST before controller shutdown
- Delay between controller shutdown and system suspend
- Explicitly set power state to 0 before controller shutdown

Fortunately it's a desktop, so disable APST won't hurt the battery.

Also, change the quirk function name to reflect it's for vendor
combination quirks.

BugLink: https://bugs.launchpad.net/bugs/1705748
Signed-off-by: Kai-Heng Feng <kai.heng.feng at canonical.com>
---
 drivers/nvme/host/pci.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 32c413ec818c..3bb8c1915334 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2438,7 +2438,7 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	return -ENODEV;
 }
 
-static unsigned long check_dell_samsung_bug(struct pci_dev *pdev)
+static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 {
 	if (pdev->vendor == 0x144d && pdev->device == 0xa802) {
 		/*
@@ -2453,6 +2453,14 @@ static unsigned long check_dell_samsung_bug(struct pci_dev *pdev)
 		    (dmi_match(DMI_PRODUCT_NAME, "XPS 15 9550") ||
 		     dmi_match(DMI_PRODUCT_NAME, "Precision 5510")))
 			return NVME_QUIRK_NO_DEEPEST_PS;
+	} else if (pdev->vendor == 0x144d && pdev->device == 0xa804) {
+		/*
+		 * Samsung SSD 960 EVO drops off the PCIe bus after system
+		 * suspend on a Ryzen board, ASUS PRIME B350M-A.
+		 */
+		if (dmi_match(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC.") &&
+		    dmi_match(DMI_BOARD_NAME, "PRIME B350M-A"))
+			return NVME_QUIRK_NO_APST;
 	}
 
 	return 0;
@@ -2492,7 +2500,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto unmap;
 
-	quirks |= check_dell_samsung_bug(pdev);
+	quirks |= check_vendor_combination_bug(pdev);
 
 	result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
 			quirks);
-- 
2.14.1
