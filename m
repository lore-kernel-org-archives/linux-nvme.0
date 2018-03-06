From: jsmart2021@gmail.com (James Smart)
Date: Mon,  5 Mar 2018 20:55:24 -0800
Subject: [PATCH] nvme_fc: minor fixes on sqsize
Message-ID: <20180306045524.3474-1-jsmart2021@gmail.com>

Corrected two outstanding issues in the transport around sqsize.

The first is the Create Connection LS, which is to use a sqvalue
which mirror what will be in the fabric connect, is sending count
rather than count - 1.

The second is the hw queue for the admin queue. It's using the
define that corresponds to the count - 1 value. It should be count.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 8cacaccac90d..fc00c609c695 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1323,7 +1323,7 @@ nvme_fc_connect_queue(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 				sizeof(struct fcnvme_lsdesc_cr_conn_cmd));
 	conn_rqst->connect_cmd.ersp_ratio = cpu_to_be16(ersp_ratio);
 	conn_rqst->connect_cmd.qid  = cpu_to_be16(queue->qnum);
-	conn_rqst->connect_cmd.sqsize = cpu_to_be16(qsize);
+	conn_rqst->connect_cmd.sqsize = cpu_to_be16(qsize - 1);
 
 	lsop->queue = queue;
 	lsreq->rqstaddr = conn_rqst;
@@ -2643,7 +2643,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	nvme_fc_init_queue(ctrl, 0);
 
 	ret = __nvme_fc_create_hw_queue(ctrl, &ctrl->queues[0], 0,
-				NVME_AQ_BLK_MQ_DEPTH);
+				NVME_AQ_BLK_MQ_DEPTH + 1);
 	if (ret)
 		goto out_free_queue;
 
-- 
2.13.1
