From: luto@kernel.org (Andy Lutomirski)
Date: Thu,  1 Dec 2016 16:42:41 -0800
Subject: [PATCH v2] nvme/pci: Log PCI_STATUS when the controller dies
Message-ID: <f028ad4073488a571f2e19e19ccff0f6daa4af33.1480639321.git.luto@kernel.org>

When debugging nvme controller crashes, it's nice to know whether
the controller died cleanly so that the failure is just reflected in
CSTS, it died and put an error in PCI_STATUS, or whether it died so
badly that it stopped responding to PCI configuration space reads.

Signed-off-by: Andy Lutomirski <luto at kernel.org>
---
 drivers/nvme/host/pci.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0248d0e21fee..f8dd83be01d9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1292,10 +1292,22 @@ static void nvme_watchdog_timer(unsigned long data)
 
 	/* Skip controllers under certain specific conditions. */
 	if (nvme_should_reset(dev, csts)) {
-		if (!nvme_reset(dev))
-			dev_warn(dev->dev,
-				"Failed status: 0x%x, reset controller.\n",
-				csts);
+		if (!nvme_reset(dev)) {
+			/* Read a config register to help see what died. */
+			u16 pci_status;
+			int result;
+
+			result = pci_read_config_word(to_pci_dev(dev->dev),
+						      PCI_STATUS, &pci_status);
+			if (result == PCIBIOS_SUCCESSFUL)
+				dev_warn(dev->dev,
+					 "controller is down; will reset: CSTS=0x%x, PCI_STATUS=0x%hx\n",
+					 csts, pci_status);
+			else
+				dev_warn(dev->dev,
+					 "controller is down; will reset: CSTS=0x%x, PCI_STATUS read failed (%d)\n",
+					 csts, result);
+		}
 		return;
 	}
 
-- 
2.9.3
