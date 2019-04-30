From: keith.busch@intel.com (Keith Busch)
Date: Tue, 30 Apr 2019 09:33:41 -0600
Subject: [PATCH 2/2] nvme/pci: Unquiesce admin queue on shutdown
In-Reply-To: <20190430153341.25433-1-keith.busch@intel.com>
References: <20190430153341.25433-1-keith.busch@intel.com>
Message-ID: <20190430153341.25433-2-keith.busch@intel.com>

Just like IO queues, the admin queue also will not be restarted after a
controller shutdown. Unquiesce this queue so that we do not block
request dispatch on a permanently disabled controller.

Reported-by: Yufen Yu <yuyufen at huawei.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c5a997727c4f..46e033b0bb79 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2436,8 +2436,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	 * must flush all entered requests to their failed completion to avoid
 	 * deadlocking blk-mq hot-cpu notifier.
 	 */
-	if (shutdown)
+	if (shutdown) {
 		nvme_start_queues(&dev->ctrl);
+		if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q))
+			blk_mq_unquiesce_queue(dev->ctrl.admin_q);
+	}
 	mutex_unlock(&dev->shutdown_lock);
 }
 
-- 
2.14.4
