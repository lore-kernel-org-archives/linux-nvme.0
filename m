From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 21 Sep 2016 13:02:24 -0700
Subject: [PATCH] nvme-rdma: only clear queue flags after successful connect
Message-ID: <1474488144-7158-1-git-send-email-sagi@grimberg.me>

Otherwise, nvme_rdma_stop_and_clear_queue() will incorrectly
try to stop/free rdma qps/cm_ids that are already freed.

Fixes: e89ca58f9c90 ("nvme-rdma: add DELETING queue flag")
Reported-by: Steve Wise <swise at opengridcomputing.com>
Tested-by: Steve Wise <swise at opengridcomputing.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Jens, care to pick this last minute fix for rc8?
Thanks

 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index c2c2c28e6eb5..fbdb2267e460 100644
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
 
+	clear_bit(NVME_RDMA_Q_DELETING, &queue->flags);
 	set_bit(NVME_RDMA_Q_CONNECTED, &queue->flags);
 
 	return 0;
-- 
1.9.1
