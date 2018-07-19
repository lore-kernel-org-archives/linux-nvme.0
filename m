From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 19 Jul 2018 15:28:38 +0200
Subject: [PATCH 4/4] nvme: fc: abort commands before resetting controller
In-Reply-To: <20180719132838.15556-1-jthumshirn@suse.de>
References: <20180719132838.15556-1-jthumshirn@suse.de>
Message-ID: <20180719132838.15556-5-jthumshirn@suse.de>

Currently if a timeout on fc happens we just go ahead and reset the
underlying transport.

Instead try for a more fine grained error recovery by first aborting
the FC OP, if this fails abort the NVMe command and if this as well
fails go the hard route and reset the controller.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/fc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9cc33752539a..0ba0075c3b75 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2054,6 +2054,15 @@ nvme_fc_timeout(struct request *rq, bool reserved)
 {
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
 	struct nvme_fc_ctrl *ctrl = op->ctrl;
+	u16 qid = op->queue->qnum;
+	int ret;
+
+	if (!__nvme_fc_abort_op(ctrl, op))
+		return BLK_EH_RESET_TIMER;
+
+	ret = nvme_abort_cmd(&ctrl->ctrl, rq, cpu_to_le16(qid));
+	if (!ret)
+		return BLK_EH_RESET_TIMER;
 
 	/*
 	 * we can't individually ABTS an io without affecting the queue,
-- 
2.16.4
