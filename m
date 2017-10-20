From: keith.busch@intel.com (Keith Busch)
Date: Fri, 20 Oct 2017 16:19:21 -0600
Subject: [PATCHv2 2/5] nvme/fc: remove unused "queue_size" field
In-Reply-To: <20171020221924.30659-1-keith.busch@intel.com>
References: <20171020221924.30659-1-keith.busch@intel.com>
Message-ID: <20171020221924.30659-3-keith.busch@intel.com>

This was being saved in a structure, but never used anywhere. The queue
size is obtained through other means, so there's no reason to duplicate
this without a user for it.

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/fc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e91e81d9f9fd..6b8e6ec3c2ab 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -41,7 +41,6 @@ struct nvme_fc_queue {
 	struct device		*dev;
 	struct blk_mq_hw_ctx	*hctx;
 	void			*lldd_handle;
-	int			queue_size;
 	size_t			cmnd_capsule_len;
 	u32			qnum;
 	u32			rqcnt;
@@ -1662,7 +1661,7 @@ nvme_fc_init_admin_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 }
 
 static void
-nvme_fc_init_queue(struct nvme_fc_ctrl *ctrl, int idx, size_t queue_size)
+nvme_fc_init_queue(struct nvme_fc_ctrl *ctrl, int idx)
 {
 	struct nvme_fc_queue *queue;
 
@@ -1678,8 +1677,6 @@ nvme_fc_init_queue(struct nvme_fc_ctrl *ctrl, int idx, size_t queue_size)
 	else
 		queue->cmnd_capsule_len = sizeof(struct nvme_command);
 
-	queue->queue_size = queue_size;
-
 	/*
 	 * Considered whether we should allocate buffers for all SQEs
 	 * and CQEs and dma map them - mapping their respective entries
@@ -1803,7 +1800,7 @@ nvme_fc_init_io_queues(struct nvme_fc_ctrl *ctrl)
 	int i;
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++)
-		nvme_fc_init_queue(ctrl, i, ctrl->ctrl.sqsize);
+		nvme_fc_init_queue(ctrl, i);
 }
 
 static void
@@ -2436,7 +2433,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	 * Create the admin queue
 	 */
 
-	nvme_fc_init_queue(ctrl, 0, NVME_AQ_BLK_MQ_DEPTH);
+	nvme_fc_init_queue(ctrl, 0);
 
 	ret = __nvme_fc_create_hw_queue(ctrl, &ctrl->queues[0], 0,
 				NVME_AQ_BLK_MQ_DEPTH);
-- 
2.13.6
