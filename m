From: jsmart2021@gmail.com (James Smart)
Date: Fri, 21 Sep 2018 11:49:20 -0700
Subject: [PATCH] nvme: call nvme_complete_rq on NVME_MPATH failures
Message-ID: <20180921184920.12902-1-jsmart2021@gmail.com>

When an io is rejected by nvmf_check_ready() due to validation of
the controller state, the nvmf_fail_nonready_command() will normally
return BLK_STS_RESOURCE to requeue and retry. However, if the
controller is dying or the io is marked for NVME multipath, the io
is failed so that the controller can terminate or so that the io can
be issued on a different path. Unfortunately, as this reject point
is before the transport has accepted the command, blk-mq ends up
completing the io and never calls nvme_complete_rq(), which is where
multipath may preserve/re-route the io. The end result is, the device
user ends up seeing an EIO error.

Example: single path connectivity, controller is under load, and a
reset is induced. An i/o is received: a) while the reset state has
been set but the queues have yet to be stopped; or b) after queues
are started (at end of reset) but before the reconnect has completed.
The io finishes with an EIO status.

This patch modifies the reject point such that it appears to queue
successfully, but actually completes the io with an error and calls
nvme_complete_rq().

Signed-off-by: James Smart <jsmart2021 at gmail.com>
---
 drivers/nvme/host/fabrics.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 206d63cb1afc..ed4b8e8e0249 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -548,11 +548,20 @@ static struct nvmf_transport_ops *nvmf_lookup_transport(
 blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
 		struct request *rq)
 {
+	struct nvme_request *nvmerq = nvme_req(rq);
+
 	if (ctrl->state != NVME_CTRL_DELETING &&
 	    ctrl->state != NVME_CTRL_DEAD &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;
-	nvme_req(rq)->status = NVME_SC_ABORT_REQ;
+
+	nvmerq->status = NVME_SC_ABORT_REQ;
+	nvmerq->result.u64 = 0;
+	if (rq->cmd_flags & REQ_NVME_MPATH) {
+		blk_mq_start_request(rq);
+		nvme_complete_rq(rq);
+		return BLK_STS_OK;
+	}
 	return BLK_STS_IOERR;
 }
 EXPORT_SYMBOL_GPL(nvmf_fail_nonready_command);
-- 
2.13.1
