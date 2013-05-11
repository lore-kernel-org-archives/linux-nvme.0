From: rama@fastorsystems.com (Ramachandra Rao Gajula)
Date: Sat, 11 May 2013 15:19:31 -0700
Subject: [PATCH] NVMe: Add MSI support for capable devices
Message-ID: <CAKt=Hw+Jr-Pbp=UWxbay-7yXpcG2nKZ6Rm1OMP-HxVx6Oa3iwg@mail.gmail.com>

>From 3dbb01dab9b3e5aabb05636b7ed86d
81ff54d641 Mon Sep 17 00:00:00 2001
From: Ramachandra Gajula <rama@fastorsystems.com>
Date: Sat, 11 May 2013 14:00:13 -0700
Subject: [PATCH] NVMe: Add MSI support for capable devices

Add MSI support for capable devices that use one or more interrupt vectors.

Signed-off-by: Ramachandra Gajula <rama at fastorsystems.com>
---
 drivers/block/nvme-core.c |   32 ++++++++++++++++++++++++++++----
 1 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index bcb81c8..0f6225b 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1431,7 +1431,7 @@ static int set_queue_count(struct nvme_dev *dev,
int count)

 static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
-       int result, cpu, i, nr_io_queues, db_bar_size, q_depth;
+       int result, cpu, i, nr_io_queues, db_bar_size, q_depth, q_cnt;

        nr_io_queues = num_online_cpus();
        result = set_queue_count(dev, nr_io_queues);
@@ -1440,6 +1440,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
        if (result < nr_io_queues)
                nr_io_queues = result;

+       q_cnt = nr_io_queues;
        /* Deregister the admin queue's interrupt */
        free_irq(dev->entry[0].vector, dev->queues[0]);

@@ -1463,10 +1464,27 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
                        nr_io_queues = result;
                        continue;
                } else {
-                       nr_io_queues = 1;
+                       nr_io_queues = q_cnt;
                        break;
                }
        }
+       /* if MSI-X failed, then try for MSI for nr_io_queues vectors */
+        if (!dev->pci_dev->msix_enabled) {
+                for (;;) {
+                        result = pci_enable_msi_block(dev->pci_dev,
nr_io_queues);
+                        if (result == 0) {
+                                for (i = 0; i < nr_io_queues; i++)
+                                        dev->entry[i].vector = i +
dev->pci_dev->irq;
+                                break;
+                        } else if (result > 0) {
+                                nr_io_queues = result;
+                                continue;
+                        } else {
+                                nr_io_queues = 1;
+                                break;
+                        }
+                }
+        }

        result = queue_request_irq(dev, dev->queues[0], "nvme admin");
        /* XXX: handle failure here */
@@ -1651,7 +1669,10 @@ static void nvme_free_dev(struct kref *kref)
 {
        struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
        nvme_dev_remove(dev);
-       pci_disable_msix(dev->pci_dev);
+       if (dev->pci_dev->msi_enabled)
+               pci_disable_msi(dev->pci_dev);
+       else
+               pci_disable_msix(dev->pci_dev);
        iounmap(dev->bar);
        nvme_release_instance(dev);
        nvme_release_prp_pools(dev);
@@ -1778,7 +1799,10 @@ static int nvme_probe(struct pci_dev *pdev,
const struct pci_device_id *id)
  unmap:
        iounmap(dev->bar);
  disable_msix:
-       pci_disable_msix(pdev);
+       if (dev->pci_dev->msi_enabled)
+               pci_disable_msi(pdev);
+       else
+               pci_disable_msix(pdev);
        nvme_release_instance(dev);
        nvme_release_prp_pools(dev);
  disable:
--
1.7.9.1
