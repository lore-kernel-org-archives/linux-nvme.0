From: keith.busch@intel.com (Keith Busch)
Date: Thu, 14 Nov 2013 16:52:27 -0700
Subject: [PATCH] NVMe: disable admin queue on initi failure
Message-ID: <1384473147-15775-1-git-send-email-keith.busch@intel.com>

Disable the admin queue if device fails during IO initialization so the
queue's irq is freed.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index da52092..28120ec 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1751,8 +1751,10 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 
 	nr_io_queues = num_online_cpus();
 	result = set_queue_count(dev, nr_io_queues);
-	if (result < 0)
+	if (result < 0) {
+		nvme_disable_queue(dev, 0);
 		return result;
+	}
 	if (result < nr_io_queues)
 		nr_io_queues = result;
 
@@ -1855,7 +1857,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	for (i = 1; i < dev->queue_count; i++) {
 		result = nvme_create_queue(dev->queues[i], i);
 		if (result) {
-			for (--i; i > 0; i--)
+			for (--i; i >= 0; i--)
 				nvme_disable_queue(dev, i);
 			goto free_queues;
 		}
-- 
1.7.10.4
