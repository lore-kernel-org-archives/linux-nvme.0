From: indraneel.m@samsung.com (Indraneel M)
Date: Wed, 10 Dec 2014 19:55:40 +0530
Subject: [PATCH] NVMe: Fix FS mount issue (hot-remove followed by hot-add)
Message-ID: <1418221540-3696-1-git-send-email-indraneel.m@samsung.com>

After Hot-remove of a device with a mounted partition,
when the device is hot-added again, the new node reappears
as nvme0n1. Mounting this new node fails with the error:

mount: mount /dev/nvme0n1p1 on /mnt failed: File exists.

The old nodes's FS entries still exist and the kernel can't re-create
procfs and sysfs entries for the new node with the same name.
The patch fixes this issue.

Signed-off-by: Indraneel M <indraneel.m at samsung.com>

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 00fa5d2..5c151d7 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2735,6 +2735,7 @@ static void nvme_free_dev(struct kref *kref)
 
 	pci_dev_put(dev->pci_dev);
 	nvme_free_namespaces(dev);
+	nvme_release_instance(dev);
 	free_percpu(dev->io_queue);
 	kfree(dev->queues);
 	kfree(dev->entry);
@@ -2995,7 +2996,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dev_shutdown(dev);
 	nvme_free_queues(dev, 0);
 	nvme_dev_remove(dev);
-	nvme_release_instance(dev);
 	nvme_release_prp_pools(dev);
 	kref_put(&dev->kref, nvme_free_dev);
 }
-- 
1.8.3.2
