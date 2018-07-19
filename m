From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 19 Jul 2018 15:28:36 +0200
Subject: [PATCH 2/4] nvme: rdma: abort commands before resetting controller
In-Reply-To: <20180719132838.15556-1-jthumshirn@suse.de>
References: <20180719132838.15556-1-jthumshirn@suse.de>
Message-ID: <20180719132838.15556-3-jthumshirn@suse.de>

Currently if a timeout on rdma happens we just go ahead and reset the
underlying transport.

Instead try to abort the timeout out command and if this fails as well
continue the error path escalation and tear down the transport.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/rdma.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 13a6064e4794..aed4752cfac6 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1671,10 +1671,26 @@ static enum blk_eh_timer_return
 nvme_rdma_timeout(struct request *rq, bool reserved)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
+	u16 qid = nvme_rdma_queue_idx(req->queue);
+	int ret;
+
+	dev_warn(ctrl->device,
+		 "I/O %d QID %d timeout, aborting\n",
+		 rq->tag, qid);
+
+	ret = nvme_abort_cmd(ctrl, rq, cpu_to_le16(qid));
+	if (!ret)
+		return BLK_EH_RESET_TIMER;
 
-	dev_warn(req->queue->ctrl->ctrl.device,
-		 "I/O %d QID %d timeout, reset controller\n",
-		 rq->tag, nvme_rdma_queue_idx(req->queue));
+	/*
+	 * If the request was already cancelled once there's no need
+	 * in doing it again, escalate to the next error recovery
+	 * level.
+	 */
+	dev_warn(ctrl->device,
+		 "I/O %d QID %d abort failed %d, reset controller\n",
+		 rq->tag, qid, ret);
 
 	/* queue error recovery */
 	nvme_rdma_error_recovery(req->queue->ctrl);
-- 
2.16.4
