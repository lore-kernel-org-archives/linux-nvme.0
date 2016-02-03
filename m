From: keith.busch@intel.com (Keith Busch)
Date: Wed,  3 Feb 2016 09:05:41 -0700
Subject: [PATCH 2/4] NVMe: Sync stopped queues with block layer
In-Reply-To: <1454515543-21683-1-git-send-email-keith.busch@intel.com>
References: <1454515543-21683-1-git-send-email-keith.busch@intel.com>
Message-ID: <1454515543-21683-3-git-send-email-keith.busch@intel.com>

Make sure no work will submit requests to a stopped h/w queue.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c5bf001..9d415489 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1415,6 +1415,7 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 
 		blk_mq_cancel_requeue_work(ns->queue);
 		blk_mq_stop_hw_queues(ns->queue);
+		blk_sync_queue(ns->queue);
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
 }
-- 
2.6.2.307.g37023ba
