From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 10 Apr 2018 20:18:07 +0300
Subject: [PATCH v1 3/5] nvme-rdma: add keep-alive mechanism as admin_q property
In-Reply-To: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
References: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
Message-ID: <1523380689-17151-4-git-send-email-maxg@mellanox.com>

Activate/deactivate it during admin queue creation/destruction
and remove association to nvme ctrl.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 758537e..cf65183 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -734,6 +734,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
+	nvme_stop_keep_alive(&ctrl->ctrl);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	if (remove) {
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
@@ -801,6 +802,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (error)
 		goto out_cleanup_queue;
 
+	nvme_start_keep_alive(&ctrl->ctrl);
+
 	return 0;
 
 out_cleanup_queue:
@@ -959,8 +962,6 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 			struct nvme_rdma_ctrl, err_work);
 
-	nvme_stop_keep_alive(&ctrl->ctrl);
-
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
-- 
1.8.3.1
