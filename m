From: dheepthi.s@gracelabs.com (Dheepthi K)
Date: Wed, 17 Jun 2015 21:40:59 +0530
Subject: [PATCH 1/1] NVMe : Corrected memory freeing.
Message-ID: <1434557459-4732-1-git-send-email-dheepthi.s@gracelabs.com>

Memory freeing order has been corrected incase of
allocation failure.

Signed-off-by: Dheepthi K <dheepthi.s at gracelabs.com>
---
 drivers/block/nvme-core.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 683dff2..9bac53b 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2947,11 +2947,11 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev->entry = kzalloc_node(num_possible_cpus() * sizeof(*dev->entry),
 							GFP_KERNEL, node);
 	if (!dev->entry)
-		goto free;
+		goto free_dev;
 	dev->queues = kzalloc_node((num_possible_cpus() + 1) * sizeof(void *),
 							GFP_KERNEL, node);
 	if (!dev->queues)
-		goto free;
+		goto free_entry;
 
 	INIT_LIST_HEAD(&dev->namespaces);
 	dev->reset_workfn = nvme_reset_failed_dev;
@@ -2987,9 +2987,10 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_release_instance(dev);
  put_pci:
 	pci_dev_put(dev->pci_dev);
- free:
 	kfree(dev->queues);
+ free_entry:
 	kfree(dev->entry);
+ free_dev:
 	kfree(dev);
 	return result;
 }
-- 
1.7.9.5
