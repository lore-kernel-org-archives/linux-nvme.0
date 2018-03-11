From: jaroslaw.janik@gmail.com (=?UTF-8?q?Jaros=C5=82aw=20Janik?=)
Date: Sun, 11 Mar 2018 19:51:56 +0100
Subject: [PATCH] nvme-pci: disable APST for Samsung NVMe SSD 960 EVO + ASUS
 PRIME Z370-A
Message-ID: <20180311185156.3807-1-jaroslaw.janik@gmail.com>

Yet another "incompatible" Samsung NVMe SSD 960 EVO and Asus motherboard
combination. 960 EVO device disappears from PCIe bus within few minutes
after boot-up when APST is in use and never gets back. Forcing
NVME_QUIRK_NO_APST is the only way to make this drive work with this
particular motherboard. NVME_QUIRK_NO_DEEPEST_PS doesn't work, upgrading
motherboard's BIOS didn't help either.
Since this is a desktop motherboard, the only drawback of not using APST
is increased device temperature.

Signed-off-by: Jaros?aw Janik <jaroslaw.janik at gmail.com>
---
 drivers/nvme/host/pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5933a5c732e8..3bfaf083ca0b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2460,10 +2460,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 	} else if (pdev->vendor == 0x144d && pdev->device == 0xa804) {
 		/*
 		 * Samsung SSD 960 EVO drops off the PCIe bus after system
-		 * suspend on a Ryzen board, ASUS PRIME B350M-A.
+		 * suspend on a Ryzen board, ASUS PRIME B350M-A, as well as
+		 * within few minutes after bootup on a Coffee Lake board -
+		 * ASUS PRIME Z370-A
 		 */
 		if (dmi_match(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC.") &&
-		    dmi_match(DMI_BOARD_NAME, "PRIME B350M-A"))
+		    (dmi_match(DMI_BOARD_NAME, "PRIME B350M-A") ||
+		     dmi_match(DMI_BOARD_NAME, "PRIME Z370-A")))
 			return NVME_QUIRK_NO_APST;
 	}
 
-- 
2.16.1
