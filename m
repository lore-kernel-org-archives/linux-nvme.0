From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  4 Jul 2018 12:40:19 +0300
Subject: [PATCH for-4.19 fold 1/2] nvme-rdma: unquiesce io queues before
 destroying them
Message-ID: <20180704094020.28669-1-sagi@grimberg.me>

if the controller is going away completey, blk_cleanup_queue
make block on queue freeze if we don't unquiesce. To fix this,
modify nvme_rdma_teardown_io_queues to only unquiesce if the
controller is being removed, and do it before we destroy the
io queues completely.

Fixes: 037011f47e22 ("nvme-rdma: unquiesce queues when deleting the controller")
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
** fold into 037011f47e22

 drivers/nvme/host/rdma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 66d1cf92d163..f369e8be5233 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1741,15 +1741,15 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 		nvme_rdma_stop_io_queues(ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
 					nvme_cancel_request, &ctrl->ctrl);
+		if (shutdown)
+			nvme_start_queues(&ctrl->ctrl);
 		nvme_rdma_destroy_io_queues(ctrl, shutdown);
 	}
 
-	if (shutdown) {
-		nvme_start_queues(&ctrl->ctrl);
+	if (shutdown)
 		nvme_shutdown_ctrl(&ctrl->ctrl);
-	} else {
+	else
 		nvme_disable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
-	}
 
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
-- 
2.14.1
