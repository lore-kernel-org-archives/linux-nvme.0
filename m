From: agordeev@redhat.com (Alexander Gordeev)
Date: Tue, 28 Jan 2014 09:38:54 +0100
Subject: [PATCH 08/14] NVMe: nvme_dev_map() is a bad place to set admin queue
 IRQ number
In-Reply-To: <cover.1390897693.git.agordeev@redhat.com>
References: <cover.1390897693.git.agordeev@redhat.com>
Message-ID: <89acbd530af682cd02ed5e04e18528cd54943924.1390897693.git.agordeev@redhat.com>

Initialization of the admin queue interrupt number within
nvme_dev_map() is confusing. Just keep nvme_dev_map() and
nvme_dev_unmap() counterparts simple and let deal function
nvme_configure_admin_queue() with the admin queue in full.

Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 drivers/block/nvme-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e004c09..98d4b51 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1424,6 +1424,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	if (result)
 		return result;
 
+	dev->entry[0].vector = dev->pci_dev->irq;
 	result = queue_request_irq(nvmeq, "nvme admin");
 	if (result)
 		return result;
@@ -2077,7 +2078,6 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	if (pci_enable_device_mem(pdev))
 		return result;
 
-	dev->entry[0].vector = pdev->irq;
 	pci_set_master(pdev);
 	bars = pci_select_bars(pdev, IORESOURCE_MEM);
 	if (pci_request_selected_regions(pdev, bars, "nvme"))
-- 
1.7.7.6
