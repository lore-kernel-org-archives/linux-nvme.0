From: rama@fastorsystems.com (Ramachandra Rao Gajula)
Date: Tue, 5 Mar 2013 10:16:55 -0800
Subject: Added MSI supoort (includes MSI Multiple) to Linux NVME Driver
Message-ID: <CAKt=HwLSYf66pq8N9kdt-iq8_O7UH5neHGL13gR5pAngEZeetA@mail.gmail.com>

------

Added MSI supoort (includes MSI Multiple) to Linux NVME Driver

------

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c

------


@@ -1416,6 +1416,7 @@ static int set_queue_count(struct nvme_dev *dev,
int count)
 static int __devinit nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	int result, cpu, i, nr_io_queues, db_bar_size, q_depth;
+	int try_msi=0;

 	nr_io_queues = num_online_cpus();
 	result = set_queue_count(dev, nr_io_queues);
@@ -1436,21 +1437,42 @@ static int __devinit
nvme_setup_io_queues(struct nvme_dev *dev)
 		dev->queues[0]->q_db = dev->dbs;
 	}

+	/* init for MSI-X */
 	for (i = 0; i < nr_io_queues; i++)
 		dev->entry[i].entry = i;
 	for (;;) {
 		result = pci_enable_msix(dev->pci_dev, dev->entry,
 								nr_io_queues);
-		if (result == 0) {
+		if (result == 0) {	/* got all vectors */
+			dev->pci_dev.msix_enabled = 1;
 			break;
 		} else if (result > 0) {
 			nr_io_queues = result;
-			continue;
-		} else {
-			nr_io_queues = 1;
+			continue;	/* get as many as vectors as possible */
+		} else {	/* MSI-X failed; so try MSI and if not, finally intx */
+			nr_io_queues = num_online_cpus();
+			try_msi = 1;
 			break;
 		}
 	}
+	/* if MSI-X failed, then try for MSI for nr_io_queues vectors */
+	if (try_msi) {
+		for (;;) {
+			result = pci_enable_msi_block(dev->pci_dev,nr_io_queues);
+			if (result == 0) {
+				dev->pci_dev.msi_enabled = 1;
+				for (i = 0; i < nr_io_queues; i++)
+					dev->entry[i].vector = i + dev->pci_dev->irq;
+				break;
+			} else if (result > 0) {
+				nr_io_queues = result;
+				continue;	/* get as many messages as we can */
+			} else {	/* no MSI, fall back to intx with just 1 queue */
+				nr_io_queues = 1;
+				break;
+			}
+		}
+	}

 	result = queue_request_irq(dev, dev->queues[0], "nvme admin");
 	/* XXX: handle failure here */
@@ -1662,12 +1684,12 @@ static int __devinit nvme_probe(struct pci_dev *pdev,

 	result = nvme_setup_prp_pools(dev);
 	if (result)
-		goto disable_msix;
+		goto free_instance;

 	dev->bar = ioremap(pci_resource_start(pdev, 0), 8192);
 	if (!dev->bar) {
 		result = -ENOMEM;
-		goto disable_msix;
+		goto free_prps;
 	}

 	result = nvme_configure_admin_queue(dev);
@@ -1693,10 +1715,15 @@ static int __devinit nvme_probe(struct pci_dev *pdev,
 	nvme_free_queues(dev);
  unmap:
 	iounmap(dev->bar);
- disable_msix:
-	pci_disable_msix(pdev);
-	nvme_release_instance(dev);
+
+	if (dev->pci_dev.msi_enabled)
+		pci_disable_msi(pdev);
+	else
+		pci_disable_msix(pdev);
+ free_prps:
 	nvme_release_prp_pools(dev);
+ free_instance:
+	nvme_release_instance(dev);
  disable:
 	pci_disable_device(pdev);
 	pci_release_regions(pdev);
@@ -1711,7 +1738,10 @@ static void __devexit nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 	nvme_dev_remove(dev);
-	pci_disable_msix(pdev);
+	if (dev->pci_dev.msi_enabled)
+		pci_disable_msi(pdev);
+	else
+		pci_disable_msix(pdev);
 	iounmap(dev->bar);
 	nvme_release_instance(dev);
 	nvme_release_prp_pools(dev);
@@ -1796,3 +1826,4 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION("0.8");
 module_init(nvme_init);
 module_exit(nvme_exit);
+
