From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 10 May 2016 15:14:28 +0200
Subject: [PATCH] NVMe: Only release requested regions
Message-ID: <1462886068-14605-1-git-send-email-jthumshirn@suse.de>

The NVMe driver only requests the PCIe device's memory regions but releases
all possible regions (including eventual I/O regions). This leads to a stale
warning entry in dmesg about freeing non existent resources.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index eec73fe..6f5ad07 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1759,9 +1759,14 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 static void nvme_dev_unmap(struct nvme_dev *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	int bars;
+
 	if (dev->bar)
 		iounmap(dev->bar);
-	pci_release_regions(to_pci_dev(dev->dev));
+
+	bars = pci_select_bars(pdev, IORESOURCE_MEM);
+	pci_release_selected_regions(pdev, bars);
 }
 
 static void nvme_pci_disable(struct nvme_dev *dev)
@@ -1998,7 +2003,7 @@ static int nvme_dev_map(struct nvme_dev *dev)
 
        return 0;
   release:
-       pci_release_regions(pdev);
+       pci_release_selected_regions(pdev, bars);
        return -ENODEV;
 }
 
-- 
1.8.5.6
