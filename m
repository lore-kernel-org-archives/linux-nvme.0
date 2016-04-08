From: keith.busch@intel.com (Keith Busch)
Date: Fri,  8 Apr 2016 16:09:10 -0600
Subject: [PATCH] NVMe: Always use MSI/MSI-x interrupts
Message-ID: <1460153350-4992-1-git-send-email-keith.busch@intel.com>

Multiple users have reported device initialization failure due the driver
not receiving legacy PCI interrupts. This is not unique to any particular
controller, but has been observed on multiple platforms.

There have been no issues reported or observed when with message signaled
interrupts, so this patch attempts to use MSI-x during initialization,
falling back to MSI. If that fails, legacy would become the default.

The setup_io_queues error handling had to change as a result: the admin
queue's msix_entry used to be initialized to the legacy IRQ. The case
where nr_io_queues is 0 would fail request_irq when setting up the admin
queue's interrupt since re-enabling MSI-x fails with 0 vectors, leaving
the admin queue's msix_entry invalid. Instead, return success immediately.

Reported-by: Tim Muhlemmer <muhlemmer at gmail.com>
Reported-by: Jon Derrick <jonathan.derrick at intel.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 29f31bc..28d434d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1478,8 +1478,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (result > 0) {
 		dev_err(dev->ctrl.device,
 			"Could not set queue count (%d)\n", result);
-		nr_io_queues = 0;
-		result = 0;
+		return 0;
 	}
 
 	if (dev->cmb && NVME_CMB_SQS(dev->cmbsz)) {
@@ -1513,7 +1512,9 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 * If we enable msix early due to not intx, disable it again before
 	 * setting up the full range we need.
 	 */
-	if (!pdev->irq)
+	if (pdev->msi_enabled)
+		pci_disable_msi(pdev);
+	else if (pdev->msix_enabled)
 		pci_disable_msix(pdev);
 
 	for (i = 0; i < nr_io_queues; i++)
@@ -1696,7 +1697,6 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	if (pci_enable_device_mem(pdev))
 		return result;
 
-	dev->entry[0].vector = pdev->irq;
 	pci_set_master(pdev);
 
 	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64)) &&
@@ -1709,13 +1709,18 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	}
 
 	/*
-	 * Some devices don't advertse INTx interrupts, pre-enable a single
-	 * MSIX vec for setup. We'll adjust this later.
+	 * Some devices and/or platforms don't advertise or work with INTx
+	 * interrupts. Pre-enable a single MSIX or MSI vec for setup. We'll
+	 * adjust this later.
 	 */
-	if (!pdev->irq) {
-		result = pci_enable_msix(pdev, dev->entry, 1);
-		if (result < 0)
-			goto disable;
+	if (pci_enable_msix(pdev, dev->entry, 1)) {
+		pci_enable_msi(pdev);
+		dev->entry[0].vector = pdev->irq;
+	}
+
+	if (!dev->entry[0].vector) {
+		result = -ENODEV;
+		goto disable;
 	}
 
 	cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
-- 
2.7.2
