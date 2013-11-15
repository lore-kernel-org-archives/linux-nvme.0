From: keith.busch@intel.com (Keith Busch)
Date: Fri, 15 Nov 2013 10:47:10 -0700
Subject: [PATCHv2] NVMe: Disable admin queue on init failure
Message-ID: <1384537630-11052-1-git-send-email-keith.busch@intel.com>

Disable the admin queue if device fails during initialization so the
queue's irq is freed.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1->v2:
Moved the responsibilty of handling the admin queue to the funtion that
set it up. This fixes the case where the controller is responsive but
unable to handle io, so the cdev is still usable.

Fixed my typo in commit message from the sad rush to post the patch
yesterday.

 drivers/block/nvme-core.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index da52092..145d621 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1864,7 +1864,11 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	return 0;
 
  free_queues:
-	nvme_free_queues(dev);
+	for (i = dev->queue_count - 1; i > 0; i--) {
+		nvme_free_queue(dev->queues[i]);
+		dev->queue_count--;
+		dev->queues[i] = NULL;
+	}
 	return result;
 }
 
@@ -2141,6 +2145,7 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	return result;
 
  disable:
+	nvme_disable_queue(dev, 0);
 	spin_lock(&dev_list_lock);
 	list_del_init(&dev->node);
 	spin_unlock(&dev_list_lock);
-- 
1.7.10.4
