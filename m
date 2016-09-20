From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 20 Sep 2016 11:57:28 -0700
Subject: [PATCH] nvme-rdma: Fix early queue flags settings
Message-ID: <1474397848-19013-1-git-send-email-sagi@grimberg.me>

When we reconnect we can't really clear the
queue flags (DELETING flag in specific) because
we might end up trigerring a use-after-free condition
if we fail to establish the rdma connection.

Fixes: e89ca58f9c90 ("nvme-rdma: add DELETING queue flag")
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index c2c2c28e6eb5..3437f0e8866f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -561,7 +561,6 @@ static int nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl,
 
 	queue = &ctrl->queues[idx];
 	queue->ctrl = ctrl;
-	queue->flags = 0;
 	init_completion(&queue->cm_done);
 
 	if (idx > 0)
@@ -595,6 +594,7 @@ static int nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl,
 		goto out_destroy_cm_id;
 	}
 
+	queue->flags = 0;
 	set_bit(NVME_RDMA_Q_CONNECTED, &queue->flags);
 
 	return 0;
-- 
1.9.1
