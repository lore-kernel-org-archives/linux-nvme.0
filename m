From: keith.busch@intel.com (Keith Busch)
Date: Tue, 19 Aug 2014 19:15:59 -0600
Subject: [PATCH] NVMe: Reference count pci device
Message-ID: <1408497359-11312-1-git-send-email-keith.busch@intel.com>

If an nvme device is removed but user space has an open reference,
the nvme driver would have been holding an invalid reference to its pci
device. You may get a general protection fault on x86 h/w when the driver
uses that reference in dma_map_sg(), as is done in nvme_map_user_pages()
from the IOCTL interface.

This patch fixes the fault by taking a reference on the pci device and
holding it even after device removal until all opens on the nvme device
are closed.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reported-by: Nilesh Choudhury <nilesh.choudhury at oracle.com>
---
 drivers/block/nvme-core.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 28aec2d..44426a6 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2667,6 +2667,7 @@ static void nvme_free_dev(struct kref *kref)
 {
 	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
 
+	pci_dev_put(dev->pci_dev);
 	nvme_free_namespaces(dev);
 	free_percpu(dev->io_queue);
 	kfree(dev->queues);
@@ -2842,11 +2843,11 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev->reset_workfn = nvme_reset_failed_dev;
 	INIT_WORK(&dev->reset_work, nvme_reset_workfn);
 	INIT_WORK(&dev->cpu_work, nvme_cpu_workfn);
-	dev->pci_dev = pdev;
+	dev->pci_dev = pci_dev_get(pdev);
 	pci_set_drvdata(pdev, dev);
 	result = nvme_set_instance(dev);
 	if (result)
-		goto free;
+		goto put_pci;
 
 	result = nvme_setup_prp_pools(dev);
 	if (result)
@@ -2884,6 +2885,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_release_prp_pools(dev);
  release:
 	nvme_release_instance(dev);
+ put_pci:
+	pci_dev_put(dev->pci_dev);
  free:
 	free_percpu(dev->io_queue);
 	kfree(dev->queues);
-- 
1.7.10.4
