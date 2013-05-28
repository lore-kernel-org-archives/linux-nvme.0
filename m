From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 28 May 2013 18:57:07 -0400
Subject: [PATCH] NVMe: Add MSI support for capable devices
In-Reply-To: <CAKt=Hw+Jr-Pbp=UWxbay-7yXpcG2nKZ6Rm1OMP-HxVx6Oa3iwg@mail.gmail.com>
References: <CAKt=Hw+Jr-Pbp=UWxbay-7yXpcG2nKZ6Rm1OMP-HxVx6Oa3iwg@mail.gmail.com>
Message-ID: <20130528225707.GA8211@linux.intel.com>

On Sat, May 11, 2013@03:19:31PM -0700, Ramachandra Rao Gajula wrote:
> +++ b/drivers/block/nvme-core.c
> @@ -1431,7 +1431,7 @@ static int set_queue_count(struct nvme_dev *dev,
> int count)
> 
>  static int nvme_setup_io_queues(struct nvme_dev *dev)
>  {
> -       int result, cpu, i, nr_io_queues, db_bar_size, q_depth;
> +       int result, cpu, i, nr_io_queues, db_bar_size, q_depth, q_cnt;

This patch was corrupted (tabs converted to spaces), so I retyped it.
I made a few changes along the way; see what you think:

commit 7597f23c7c7ac462b776dbf0d371d8ae16873b13
Author: Ramachandra Rao Gajula <rama at fastorsystems.com>
Date:   Sat May 11 15:19:31 2013 -0700

    NVMe: Add MSI support
    
    Some devices only have support for MSI, not MSI-X.  While MSI is more
    limited, it still provides better performance than line-based interrupts.
    
    Signed-off-by: Ramachandra Gajula <rama at fastorsystems.com>
    Signed-off-by: Matthew Wilcox <matthew.r.wilcox at intel.com>

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index a57d3bc..072c57c 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1637,7 +1637,8 @@ static int set_queue_count(struct nvme_dev *dev, int count)
 
 static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
-	int result, cpu, i, nr_io_queues, db_bar_size, q_depth;
+	struct pci_dev *pdev = dev->pci_dev;
+	int result, cpu, i, nr_io_queues, db_bar_size, q_depth, q_count;
 
 	nr_io_queues = num_online_cpus();
 	result = set_queue_count(dev, nr_io_queues);
@@ -1646,14 +1647,14 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (result < nr_io_queues)
 		nr_io_queues = result;
 
+	q_count = nr_io_queues;
 	/* Deregister the admin queue's interrupt */
 	free_irq(dev->entry[0].vector, dev->queues[0]);
 
 	db_bar_size = 4096 + ((nr_io_queues + 1) << (dev->db_stride + 3));
 	if (db_bar_size > 8192) {
 		iounmap(dev->bar);
-		dev->bar = ioremap(pci_resource_start(dev->pci_dev, 0),
-								db_bar_size);
+		dev->bar = ioremap(pci_resource_start(pdev, 0), db_bar_size);
 		dev->dbs = ((void __iomem *)dev->bar) + 4096;
 		dev->queues[0]->q_db = dev->dbs;
 	}
@@ -1661,19 +1662,36 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	for (i = 0; i < nr_io_queues; i++)
 		dev->entry[i].entry = i;
 	for (;;) {
-		result = pci_enable_msix(dev->pci_dev, dev->entry,
-								nr_io_queues);
+		result = pci_enable_msix(pdev, dev->entry, nr_io_queues);
 		if (result == 0) {
 			break;
 		} else if (result > 0) {
 			nr_io_queues = result;
 			continue;
 		} else {
-			nr_io_queues = 1;
+			nr_io_queues = 0;
 			break;
 		}
 	}
 
+	if (nr_io_queues == 0) {
+		nr_io_queues = q_count;
+		for (;;) {
+			result = pci_enable_msi_block(pdev, dev->entry,
+								nr_io_queues);
+			if (result == 0) {
+				for (i = 0; i < nr_io_queues; i++)
+					dev->entry[i].vector = i + pdev->irq;
+			} else if (result > 0) {
+				nr_io_queues = result;
+				continue;
+			} else {
+				nr_io_queues = 1;
+				break;
+			}
+		}
+	}
+
 	result = queue_request_irq(dev, dev->queues[0], "nvme admin");
 	/* XXX: handle failure here */
 
@@ -1854,7 +1872,10 @@ static void nvme_free_dev(struct kref *kref)
 {
 	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
 	nvme_dev_remove(dev);
-	pci_disable_msix(dev->pci_dev);
+	if (dev->pci_dev->msi_enabled)
+		pci_disable_msi(dev->pci_dev);
+	else if (dev->pci_dev->msix_enabled)
+		pci_disable_msix(dev->pci_dev);
 	iounmap(dev->bar);
 	nvme_release_instance(dev);
 	nvme_release_prp_pools(dev);
@@ -1987,7 +2008,10 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  unmap:
 	iounmap(dev->bar);
  disable_msix:
-	pci_disable_msix(pdev);
+	if (dev->pci_dev->msi_enabled)
+		pci_disable_msi(dev->pci_dev);
+	else if (dev->pci_dev->msix_enabled)
+		pci_disable_msix(dev->pci_dev);
 	nvme_release_instance(dev);
 	nvme_release_prp_pools(dev);
  disable:
