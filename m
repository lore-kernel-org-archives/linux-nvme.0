From: jsmart2021@gmail.com (James Smart)
Date: Wed,  7 Mar 2018 15:59:36 -0800
Subject: [PATCH v2] nvme_fc: rework sqsize handling
Message-ID: <20180307235936.2830-1-jsmart2021@gmail.com>

Corrected four outstanding issues in the transport around sqsize.

1: Create Connection LS is sending the 1's-based sqsize, should be
sending the 0's-based value.

2: allocation of hw queue is using the 0's-base size. It should be
using the 1's-based value.

3: normalization of ctrl.sqsize by MQES is using MQES+1 (1's-based
value). It should be MQES (0's-based value).

4: Missing clause to ensure queue_count not larger than ctrl->sqsize.

Corrected by:
Clean up routines that pass queue size around. The queue size value is
the actual count (1's-based) value and determined from ctrl->sqsize + 1.

Routines that send 0's-based value adapt from queue size.

Sset ctrl->sqsize properly for MQES.

Added clause to nsure queue_count not larger than ctrl->sqsize + 1.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index bb7e7851082a..590c5b99cae8 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1210,7 +1210,7 @@ nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
 				sizeof(struct fcnvme_lsdesc_cr_assoc_cmd));
 
 	assoc_rqst->assoc_cmd.ersp_ratio = cpu_to_be16(ersp_ratio);
-	assoc_rqst->assoc_cmd.sqsize = cpu_to_be16(qsize);
+	assoc_rqst->assoc_cmd.sqsize = cpu_to_be16(qsize - 1);
 	/* Linux supports only Dynamic controllers */
 	assoc_rqst->assoc_cmd.cntlid = cpu_to_be16(0xffff);
 	uuid_copy(&assoc_rqst->assoc_cmd.hostid, &ctrl->ctrl.opts->host->id);
@@ -1325,7 +1325,7 @@ nvme_fc_connect_queue(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 				sizeof(struct fcnvme_lsdesc_cr_conn_cmd));
 	conn_rqst->connect_cmd.ersp_ratio = cpu_to_be16(ersp_ratio);
 	conn_rqst->connect_cmd.qid  = cpu_to_be16(queue->qnum);
-	conn_rqst->connect_cmd.sqsize = cpu_to_be16(qsize);
+	conn_rqst->connect_cmd.sqsize = cpu_to_be16(qsize - 1);
 
 	lsop->queue = queue;
 	lsreq->rqstaddr = conn_rqst;
@@ -2494,11 +2494,11 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 		goto out_free_tag_set;
 	}
 
-	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.opts->queue_size);
+	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
 	if (ret)
 		goto out_cleanup_blk_queue;
 
-	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.opts->queue_size);
+	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
 	if (ret)
 		goto out_delete_hw_queues;
 
@@ -2545,11 +2545,11 @@ nvme_fc_reinit_io_queues(struct nvme_fc_ctrl *ctrl)
 	if (ret)
 		goto out_free_io_queues;
 
-	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.opts->queue_size);
+	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
 	if (ret)
 		goto out_free_io_queues;
 
-	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.opts->queue_size);
+	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
 	if (ret)
 		goto out_delete_hw_queues;
 
@@ -2645,13 +2645,12 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	nvme_fc_init_queue(ctrl, 0);
 
 	ret = __nvme_fc_create_hw_queue(ctrl, &ctrl->queues[0], 0,
-				NVME_AQ_BLK_MQ_DEPTH);
+				NVME_AQ_DEPTH);
 	if (ret)
 		goto out_free_queue;
 
 	ret = nvme_fc_connect_admin_queue(ctrl, &ctrl->queues[0],
-				NVME_AQ_BLK_MQ_DEPTH,
-				(NVME_AQ_BLK_MQ_DEPTH / 4));
+				NVME_AQ_DEPTH, (NVME_AQ_DEPTH / 4));
 	if (ret)
 		goto out_delete_hw_queue;
 
@@ -2679,7 +2678,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	}
 
 	ctrl->ctrl.sqsize =
-		min_t(int, NVME_CAP_MQES(ctrl->ctrl.cap) + 1, ctrl->ctrl.sqsize);
+		min_t(int, NVME_CAP_MQES(ctrl->ctrl.cap), ctrl->ctrl.sqsize);
 
 	ret = nvme_enable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
 	if (ret)
@@ -2712,6 +2711,14 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		opts->queue_size = ctrl->ctrl.maxcmd;
 	}
 
+	if (opts->queue_size > ctrl->ctrl.sqsize + 1) {
+		/* warn if sqsize is lower than queue_size */
+		dev_warn(ctrl->ctrl.device,
+			"queue_size %zu > ctrl sqsize %u, clamping down\n",
+			opts->queue_size, ctrl->ctrl.sqsize + 1);
+		opts->queue_size = ctrl->ctrl.sqsize + 1;
+	}
+
 	ret = nvme_fc_init_aen_ops(ctrl);
 	if (ret)
 		goto out_term_aen_ops;
-- 
2.13.1
