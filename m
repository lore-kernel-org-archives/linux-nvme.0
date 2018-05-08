From: jsmart2021@gmail.com (James Smart)
Date: Mon,  7 May 2018 17:12:13 -0700
Subject: [PATCH 6/7] nvme_fc: fix nulling of queue data on reconnect
In-Reply-To: <20180508001214.8951-1-jsmart2021@gmail.com>
References: <20180508001214.8951-1-jsmart2021@gmail.com>
Message-ID: <20180508001214.8951-7-jsmart2021@gmail.com>

The reconnect path is calling the init routines to clear a queue
structure. But the queue structure has state that perhaps needs
to persist as long as the controller is live.

Remove the nvme_fc_init_queue() calls on reconnect.
The nvme_fc_free_queue() calls will clear state bits and reset
any relevant queue state for a new connection.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 7b9fb2e5afee..3cab280cf5f7 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1879,6 +1879,7 @@ nvme_fc_free_queue(struct nvme_fc_queue *queue)
 	 */
 
 	queue->connection_id = 0;
+	atomic_set(&queue->csn, 1);
 }
 
 static void
@@ -2472,7 +2473,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 }
 
 static int
-nvme_fc_reinit_io_queues(struct nvme_fc_ctrl *ctrl)
+nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 {
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
 	unsigned int nr_io_queues, numq;
@@ -2493,8 +2494,6 @@ nvme_fc_reinit_io_queues(struct nvme_fc_ctrl *ctrl)
 	if (ctrl->ctrl.queue_count == 1)
 		return 0;
 
-	nvme_fc_init_io_queues(ctrl);
-
 	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
 	if (ret)
 		goto out_free_io_queues;
@@ -2592,8 +2591,6 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	 * Create the admin queue
 	 */
 
-	nvme_fc_init_queue(ctrl, 0);
-
 	ret = __nvme_fc_create_hw_queue(ctrl, &ctrl->queues[0], 0,
 				NVME_AQ_DEPTH);
 	if (ret)
@@ -2680,7 +2677,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		if (!ctrl->ioq_live)
 			ret = nvme_fc_create_io_queues(ctrl);
 		else
-			ret = nvme_fc_reinit_io_queues(ctrl);
+			ret = nvme_fc_recreate_io_queues(ctrl);
 		if (ret)
 			goto out_term_aen_ops;
 	}
@@ -3028,6 +3025,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	if (!ctrl->queues)
 		goto out_free_ida;
 
+	nvme_fc_init_queue(ctrl, 0);
+
 	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
 	ctrl->admin_tag_set.ops = &nvme_fc_admin_mq_ops;
 	ctrl->admin_tag_set.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-- 
2.13.1
