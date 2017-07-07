From: keith.busch@intel.com (Keith Busch)
Date: Fri,  7 Jul 2017 12:22:57 -0400
Subject: [PATCH 3/7] nvme/fc: remove unused "queue_size" field
In-Reply-To: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
Message-ID: <1499444581-28268-4-git-send-email-keith.busch@intel.com>

This was being saved in a structure, but never used anywhere. The queue
size is obtained through other means, so there's no reason to duplicate
this without a user for it.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/fc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6328158..26a3c5d 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -50,7 +50,6 @@ struct nvme_fc_queue {
 	struct device		*dev;
 	struct blk_mq_hw_ctx	*hctx;
 	void			*lldd_handle;
-	int			queue_size;
 	size_t			cmnd_capsule_len;
 	u32			qnum;
 	u32			rqcnt;
@@ -1526,7 +1525,7 @@ nvme_fc_init_admin_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 }
 
 static void
-nvme_fc_init_queue(struct nvme_fc_ctrl *ctrl, int idx, size_t queue_size)
+nvme_fc_init_queue(struct nvme_fc_ctrl *ctrl, int idx)
 {
 	struct nvme_fc_queue *queue;
 
@@ -1542,8 +1541,6 @@ nvme_fc_init_queue(struct nvme_fc_ctrl *ctrl, int idx, size_t queue_size)
 	else
 		queue->cmnd_capsule_len = sizeof(struct nvme_command);
 
-	queue->queue_size = queue_size;
-
 	/*
 	 * Considered whether we should allocate buffers for all SQEs
 	 * and CQEs and dma map them - mapping their respective entries
@@ -1667,7 +1664,7 @@ nvme_fc_init_io_queues(struct nvme_fc_ctrl *ctrl)
 	int i;
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++)
-		nvme_fc_init_queue(ctrl, i, ctrl->ctrl.sqsize);
+		nvme_fc_init_queue(ctrl, i);
 }
 
 static void
@@ -2284,7 +2281,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	 * Create the admin queue
 	 */
 
-	nvme_fc_init_queue(ctrl, 0, NVME_AQ_DEPTH);
+	nvme_fc_init_queue(ctrl, 0);
 
 	ret = __nvme_fc_create_hw_queue(ctrl, &ctrl->queues[0], 0,
 				NVME_AQ_DEPTH);
-- 
2.5.5
