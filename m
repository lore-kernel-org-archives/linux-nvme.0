From: keith.busch@intel.com (Keith Busch)
Date: Fri, 18 Jul 2014 11:40:20 -0600
Subject: [PATCH] NVMe: Fix filesystem sync deadlock on removal
Message-ID: <1405705220-26439-1-git-send-email-keith.busch@intel.com>

This changes the order of deleting the gendisks so it happens after the
nvme IO queues are freed. If a device is removed while a filesystem has
associated dirty data, the removal will wait on these to complete before
proceeding from del_gendisk, which could have caused deadlock before.

The implication of this is that an orderly removal of a responsive
device won't necessarily wait for dirty data to be written, but we are
not guaranteed the device is even going to respond at this point either.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 28aec2d..0f3a1cb 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2770,8 +2770,8 @@ static void nvme_remove_disks(struct work_struct *ws)
 {
 	struct nvme_dev *dev = container_of(ws, struct nvme_dev, reset_work);
 
-	nvme_dev_remove(dev);
 	nvme_free_queues(dev, 1);
+	nvme_dev_remove(dev);
 }
 
 static int nvme_dev_resume(struct nvme_dev *dev)
@@ -2920,10 +2920,10 @@ static void nvme_remove(struct pci_dev *pdev)
 	flush_work(&dev->reset_work);
 	flush_work(&dev->cpu_work);
 	misc_deregister(&dev->miscdev);
-	nvme_dev_remove(dev);
 	nvme_dev_shutdown(dev);
 	nvme_free_queues(dev, 0);
 	rcu_barrier();
+	nvme_dev_remove(dev);
 	nvme_release_instance(dev);
 	nvme_release_prp_pools(dev);
 	kref_put(&dev->kref, nvme_free_dev);
-- 
1.7.10.4
