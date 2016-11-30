From: luto@kernel.org (Andy Lutomirski)
Date: Tue, 29 Nov 2016 17:18:55 -0800
Subject: [PATCH] nvme/pci: Log PCI_STATUS when the controller dies
Message-ID: <0e60b11aa18049f2643b62400c3fcbd959791c51.1480468668.git.luto@kernel.org>

Signed-off-by: Andy Lutomirski <luto at kernel.org>
---
 drivers/nvme/host/pci.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0248d0e21fee..b4527e5b1364 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1292,10 +1292,16 @@ static void nvme_watchdog_timer(unsigned long data)
 
 	/* Skip controllers under certain specific conditions. */
 	if (nvme_should_reset(dev, csts)) {
-		if (!nvme_reset(dev))
+		if (!nvme_reset(dev)) {
+			/* Read a config register to help see what died. */
+			u16 pci_status = 0xffff;
+
+			pci_read_config_word(to_pci_dev(dev->dev),
+					     PCI_STATUS, &pci_status);
 			dev_warn(dev->dev,
-				"Failed status: 0x%x, reset controller.\n",
-				csts);
+				"controller is down; will reset: CSTS=0x%x, PCI_STATUS=0x%hx\n",
+				 csts, pci_status);
+		}
 		return;
 	}
 
-- 
2.9.3
