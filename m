From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Fri, 28 Oct 2016 17:23:19 -0700
Subject: [PATCH v5 13/14] nvme: Fix a race condition related to stopping queues
In-Reply-To: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
References: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
Message-ID: <3a8cc957-ea9e-fe1d-f325-ad9ca1aae8a8@sandisk.com>

Avoid that nvme_queue_rq() is still running when nvme_stop_queues()
returns.

Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8403996..fe15d94 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2083,7 +2083,7 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
 		spin_unlock_irq(ns->queue->queue_lock);
 
-		blk_mq_stop_hw_queues(ns->queue);
+		blk_mq_quiesce_queue(ns->queue);
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
 }
-- 
2.10.1
