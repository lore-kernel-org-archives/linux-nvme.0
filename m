From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  4 Jul 2017 10:57:36 +0300
Subject: [PATCH v2 8/8] nvme-fc: use blk_mq_delay_run_hw_queue instead of
 open-coding it
In-Reply-To: <1499155056-11241-1-git-send-email-sagi@grimberg.me>
References: <1499155056-11241-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499155056-11241-9-git-send-email-sagi@grimberg.me>

Cc: James Smart <james.smart at broadcom.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 1e859ee2b565..50cc3b2b0e11 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1966,10 +1966,9 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 		if (ret != -EBUSY)
 			return BLK_STS_IOERR;
 
-		if (op->rq) {
-			blk_mq_stop_hw_queues(op->rq->q);
-			blk_mq_delay_queue(queue->hctx, NVMEFC_QUEUE_DELAY);
-		}
+		if (op->rq)
+			blk_mq_delay_run_hw_queue(queue->hctx, NVMEFC_QUEUE_DELAY);
+
 		return BLK_STS_RESOURCE;
 	}
 
-- 
2.7.4
