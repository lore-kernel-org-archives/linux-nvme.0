From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 19 Jul 2018 15:28:37 +0200
Subject: [PATCH 3/4] nvmet: loop: abort commands before resetting controller
In-Reply-To: <20180719132838.15556-1-jthumshirn@suse.de>
References: <20180719132838.15556-1-jthumshirn@suse.de>
Message-ID: <20180719132838.15556-4-jthumshirn@suse.de>

Currently if a timeout on loop happens we just go ahead and reset the
underlying transport.

Instead try to abort the timeout out command and if this fails as well
continue the error path escalation and tear down the transport.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/target/loop.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index af7fbf4132b0..b6c355125cb0 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -141,9 +141,24 @@ static enum blk_eh_timer_return
 nvme_loop_timeout(struct request *rq, bool reserved)
 {
 	struct nvme_loop_iod *iod = blk_mq_rq_to_pdu(rq);
+	struct nvme_ctrl *ctrl = &iod->queue->ctrl->ctrl;
+	int qid = nvme_loop_queue_idx(iod->queue);
+	int ret;
+
+	dev_warn(ctrl->device,
+		 "I/O %d QID %d timeout, aborting\n",
+		 rq->tag, qid);
+
+	ret = nvme_abort_cmd(ctrl, rq, cpu_to_le16(qid));
+	if (!ret)
+		return BLK_EH_RESET_TIMER;
+
+	dev_warn(ctrl->device,
+		 "I/O %d QID %d abort failed %d, reset controller\n",
+		 rq->tag, qid, ret);
 
 	/* queue error recovery */
-	nvme_reset_ctrl(&iod->queue->ctrl->ctrl);
+	nvme_reset_ctrl(ctrl);
 
 	/* fail with DNR on admin cmd timeout */
 	nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
-- 
2.16.4
