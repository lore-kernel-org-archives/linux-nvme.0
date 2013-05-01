From: keith.busch@intel.com (Keith Busch)
Date: Wed,  1 May 2013 13:07:50 -0600
Subject: [PATCH] NVMe: Free allocated memory in probe failure
In-Reply-To: <1367435271-15784-1-git-send-email-keith.busch@intel.com>
References: <1367435271-15784-1-git-send-email-keith.busch@intel.com>
Message-ID: <1367435271-15784-4-git-send-email-keith.busch@intel.com>

When initializing in probe fails, free only the allocated memory.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 82a5f81..2801875 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1703,11 +1703,11 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev->entry = kcalloc(num_possible_cpus(), sizeof(*dev->entry),
 								GFP_KERNEL);
 	if (!dev->entry)
-		goto free;
+		goto free_dev;
 	dev->queues = kcalloc(num_possible_cpus() + 1, sizeof(void *),
 								GFP_KERNEL);
 	if (!dev->queues)
-		goto free;
+		goto free_entry;
 
 	if (pci_enable_device_mem(pdev))
 		goto free;
@@ -1781,7 +1781,9 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_release_regions(pdev);
  free:
 	kfree(dev->queues);
+ free_entry:
 	kfree(dev->entry);
+ free_dev:
 	kfree(dev);
 	return result;
 }
-- 
1.7.0.4
