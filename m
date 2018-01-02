From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Wed,  3 Jan 2018 07:56:08 +0800
Subject: [PATCH 1/3] nvme-pci: add nvme_pci_pre_init
In-Reply-To: <1514937370-4805-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1514937370-4805-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1514937370-4805-2-git-send-email-jianchao.w.wang@oracle.com>

No fucntional change. Add nvme_pci_pre_init to package the nvme
specified initialization work before configuring admin queue.
Then nvme_pci_enable and nvme_pci_configure_admin_queue could be
clearer.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 145 +++++++++++++++++++++++++-----------------------
 1 file changed, 77 insertions(+), 68 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6e58de1..365dd05 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1581,21 +1581,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	int result;
 	u32 aqa;
 	struct nvme_queue *nvmeq;
-
-	result = nvme_remap_bar(dev, db_bar_size(dev, 0));
-	if (result < 0)
-		return result;
-
-	dev->subsystem = readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 1, 0) ?
-				NVME_CAP_NSSRC(dev->ctrl.cap) : 0;
-
-	if (dev->subsystem &&
-	    (readl(dev->bar + NVME_REG_CSTS) & NVME_CSTS_NSSRO))
-		writel(NVME_CSTS_NSSRO, dev->bar + NVME_REG_CSTS);
-
-	result = nvme_disable_ctrl(&dev->ctrl, dev->ctrl.cap);
-	if (result < 0)
-		return result;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	nvmeq = dev->queues[0];
 	if (!nvmeq) {
@@ -1616,13 +1602,20 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	if (result)
 		return result;
 
+	/*
+	 * Some devices and/or platforms don't advertise or work with INTx
+	 * interrupts. Pre-enable a single MSIX or MSI vec for setup. We'll
+	 * adjust this later.
+	 */
+	result = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (result < 0)
+		return result;
+
 	nvmeq->cq_vector = 0;
 	nvme_init_queue(nvmeq, 0);
 	result = queue_request_irq(nvmeq);
-	if (result) {
+	if (result)
 		nvmeq->cq_vector = -1;
-		return result;
-	}
 
 	return result;
 }
@@ -2096,56 +2089,6 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 		goto disable;
 	}
 
-	/*
-	 * Some devices and/or platforms don't advertise or work with INTx
-	 * interrupts. Pre-enable a single MSIX or MSI vec for setup. We'll
-	 * adjust this later.
-	 */
-	result = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
-	if (result < 0)
-		return result;
-
-	dev->ctrl.cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
-
-	dev->q_depth = min_t(int, NVME_CAP_MQES(dev->ctrl.cap) + 1,
-				io_queue_depth);
-	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
-	dev->dbs = dev->bar + 4096;
-
-	/*
-	 * Temporary fix for the Apple controller found in the MacBook8,1 and
-	 * some MacBook7,1 to avoid controller resets and data loss.
-	 */
-	if (pdev->vendor == PCI_VENDOR_ID_APPLE && pdev->device == 0x2001) {
-		dev->q_depth = 2;
-		dev_warn(dev->ctrl.device, "detected Apple NVMe controller, "
-			"set queue depth=%u to work around controller resets\n",
-			dev->q_depth);
-	} else if (pdev->vendor == PCI_VENDOR_ID_SAMSUNG &&
-		   (pdev->device == 0xa821 || pdev->device == 0xa822) &&
-		   NVME_CAP_MQES(dev->ctrl.cap) == 0) {
-		dev->q_depth = 64;
-		dev_err(dev->ctrl.device, "detected PM1725 NVMe controller, "
-                        "set queue depth=%u\n", dev->q_depth);
-	}
-
-	/*
-	 * CMBs can currently only exist on >=1.2 PCIe devices. We only
-	 * populate sysfs if a CMB is implemented. Since nvme_dev_attrs_group
-	 * has no name we can pass NULL as final argument to
-	 * sysfs_add_file_to_group.
-	 */
-
-	if (readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 2, 0)) {
-		dev->cmb = nvme_map_cmb(dev);
-		if (dev->cmb) {
-			if (sysfs_add_file_to_group(&dev->ctrl.device->kobj,
-						    &dev_attr_cmb.attr, NULL))
-				dev_warn(dev->ctrl.device,
-					 "failed to add sysfs attribute for CMB\n");
-		}
-	}
-
 	pci_enable_pcie_error_reporting(pdev);
 	pci_save_state(pdev);
 	return 0;
@@ -2290,6 +2233,68 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 		nvme_put_ctrl(&dev->ctrl);
 }
 
+/* Include the initialization work before setup admin queue
+ */
+static int nvme_pci_pre_init(struct nvme_dev *dev)
+{
+	int ret;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+
+	dev->ctrl.cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
+
+	dev->q_depth = min_t(int, NVME_CAP_MQES(dev->ctrl.cap) + 1,
+				io_queue_depth);
+	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
+	dev->dbs = dev->bar + 4096;
+
+	ret = nvme_remap_bar(dev, db_bar_size(dev, 0));
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Temporary fix for the Apple controller found in the MacBook8,1 and
+	 * some MacBook7,1 to avoid controller resets and data loss.
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_APPLE && pdev->device == 0x2001) {
+		dev->q_depth = 2;
+		dev_warn(dev->ctrl.device, "detected Apple NVMe controller, "
+			"set queue depth=%u to work around controller resets\n",
+			dev->q_depth);
+	} else if (pdev->vendor == PCI_VENDOR_ID_SAMSUNG &&
+		   (pdev->device == 0xa821 || pdev->device == 0xa822) &&
+		   NVME_CAP_MQES(dev->ctrl.cap) == 0) {
+		dev->q_depth = 64;
+		dev_err(dev->ctrl.device, "detected PM1725 NVMe controller, "
+                        "set queue depth=%u\n", dev->q_depth);
+	}
+
+	/*
+	 * CMBs can currently only exist on >=1.2 PCIe devices. We only
+	 * populate sysfs if a CMB is implemented. Since nvme_dev_attrs_group
+	 * has no name we can pass NULL as final argument to
+	 * sysfs_add_file_to_group.
+	 */
+
+	if (readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 2, 0)) {
+		dev->cmb = nvme_map_cmb(dev);
+		if (dev->cmb) {
+			if (sysfs_add_file_to_group(&dev->ctrl.device->kobj,
+						    &dev_attr_cmb.attr, NULL))
+				dev_warn(dev->ctrl.device,
+					 "failed to add sysfs attribute for CMB\n");
+		}
+	}
+
+	dev->subsystem = readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 1, 0) ?
+				NVME_CAP_NSSRC(dev->ctrl.cap) : 0;
+
+	if (dev->subsystem &&
+	    (readl(dev->bar + NVME_REG_CSTS) & NVME_CSTS_NSSRO))
+		writel(NVME_CSTS_NSSRO, dev->bar + NVME_REG_CSTS);
+
+	return nvme_disable_ctrl(&dev->ctrl, dev->ctrl.cap);
+}
+
 static void nvme_reset_work(struct work_struct *work)
 {
 	struct nvme_dev *dev =
@@ -2312,6 +2317,10 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
+	result = nvme_pci_pre_init(dev);
+	if (result)
+		goto out;
+
 	result = nvme_pci_configure_admin_queue(dev);
 	if (result)
 		goto out;
-- 
2.7.4
