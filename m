From: keith.busch@intel.com (Keith Busch)
Date: Thu, 18 Jun 2015 13:36:40 -0600
Subject: [PATCH 2/2] NVMe: Fix filesystem deadlock on removal
In-Reply-To: <1434656200-32497-1-git-send-email-keith.busch@intel.com>
References: <1434656200-32497-1-git-send-email-keith.busch@intel.com>
Message-ID: <1434656200-32497-2-git-send-email-keith.busch@intel.com>

Move gendisk deletion before controller shutdown so filesystem may sync
dirty pages. Before, this would deadlock trying to allocate requests
on frozen queues that are about to be deleted.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 9bc0b06..a230b90 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -3123,8 +3123,8 @@ static void nvme_remove(struct pci_dev *pdev)
 	flush_work(&dev->reset_work);
 	flush_work(&dev->scan_work);
 	device_remove_file(dev->device, &dev_attr_reset_controller);
-	nvme_dev_shutdown(dev);
 	nvme_dev_remove(dev);
+	nvme_dev_shutdown(dev);
 	nvme_dev_remove_admin(dev);
 	device_destroy(nvme_class, MKDEV(nvme_char_major, dev->instance));
 	nvme_free_queues(dev, 0);
-- 
1.7.10.4
