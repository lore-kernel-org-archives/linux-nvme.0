From: keith.busch@intel.com (Keith Busch)
Date: Mon, 18 May 2015 13:30:23 -0600
Subject: [PATCH 4/4] NVMe: Remove disks before shutdown
In-Reply-To: <1431977423-31587-1-git-send-email-keith.busch@intel.com>
References: <1431977423-31587-1-git-send-email-keith.busch@intel.com>
Message-ID: <1431977423-31587-5-git-send-email-keith.busch@intel.com>

On orderly removal, we need to shut down the controller after disks are
deleted to prevent deadlock on a filesystem sync.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 767ea54..62a147d 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2960,8 +2960,8 @@ static void nvme_remove_disks(struct work_struct *ws)
 {
 	struct nvme_dev *dev = container_of(ws, struct nvme_dev, reset_work);
 
-	nvme_free_queues(dev, 1);
 	nvme_dev_remove(dev);
+	nvme_free_queues(dev, 1);
 }
 
 static int nvme_dev_resume(struct nvme_dev *dev)
@@ -3126,8 +3126,8 @@ static void nvme_remove(struct pci_dev *pdev)
 	flush_work(&dev->probe_work);
 	flush_work(&dev->scan_work);
 	flush_work(&dev->reset_work);
-	nvme_dev_shutdown(dev);
 	nvme_dev_remove(dev);
+	nvme_dev_shutdown(dev);
 	nvme_dev_remove_admin(dev);
 	device_destroy(nvme_class, MKDEV(nvme_char_major, dev->instance));
 	nvme_free_queues(dev, 0);
-- 
1.7.10.4
