From: jsmart2021@gmail.com (James Smart)
Date: Wed, 28 Feb 2018 14:49:10 -0800
Subject: [PATCH] nvme_fc: fix abort race on teardown with lld reject
Message-ID: <20180228224911.15754-1-jsmart2021@gmail.com>

Another abort race: An io request is started, becomes active,
and is attempted to be started with the lldd. At the same time
the controller is stopped/torndown and an itterator is run to
abort the ios. As the io is active, it is added to the outstanding
aborted io count.  However on the original io request thread, the
driver ends up rejecting the io due to the condition that induced
the controller teardown. The driver reject path didn't check whether
it was in the outstanding io count. This left the count outstanding
stopping controller teardown.

Correct by, in the driver reject case, setting the state to
inactive and checking whether it was in the outstanding io count.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index bd72e8e4dfb7..8cacaccac90d 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2193,7 +2193,7 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
 	struct nvme_command *sqe = &cmdiu->sqe;
 	u32 csn;
-	int ret;
+	int ret, opstate;
 
 	/*
 	 * before attempting to send the io, check to see if we believe
@@ -2271,6 +2271,9 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 					queue->lldd_handle, &op->fcp_req);
 
 	if (ret) {
+		opstate = atomic_xchg(&op->state, FCPOP_STATE_COMPLETE);
+		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
+
 		if (!(op->flags & FCOP_FLAGS_AEN))
 			nvme_fc_unmap_data(ctrl, op->rq, op);
 
-- 
2.13.1
