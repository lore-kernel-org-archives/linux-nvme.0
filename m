From: indraneel.m@samsung.com (Indraneel M)
Date: Thu, 11 Dec 2014 16:17:19 +0530
Subject: [PATCH][linux-block] NVMe: Fix FS mount issue(hot-remove followed by
 hot-add)
Message-ID: <1418294839-3464-1-git-send-email-indraneel.m@samsung.com>

Jens, this version is against the linux-block tree.

After Hot-remove of a device with a mounted partition,
when the device is hot-added again, the new node reappears
as nvme0n1. Mounting this new node fails with the error:

mount: mount /dev/nvme0n1p1 on /mnt failed: File exists.

The old nodes's FS entries still exist and the kernel can't re-create
procfs and sysfs entries for the new node with the same name.
The patch fixes this issue.

Signed-off-by: Indraneel M <indraneel.m at samsung.com>

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e2bb8af..a14e90f 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2600,6 +2600,7 @@ static void nvme_free_dev(struct kref *kref)
 	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
 
 	nvme_free_namespaces(dev);
+	nvme_release_instance(dev);
 	free_percpu(dev->io_queue);
 	kfree(dev->queues);
 	kfree(dev->entry);
@@ -2859,7 +2860,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dev_shutdown(dev);
 	nvme_free_queues(dev, 0);
 	rcu_barrier();
-	nvme_release_instance(dev);
 	nvme_release_prp_pools(dev);
 	kref_put(&dev->kref, nvme_free_dev);
 }
-- 
1.8.3.2
