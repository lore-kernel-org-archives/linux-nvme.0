From: susobhan.dey@gmail.com (Susobhan Dey)
Date: Wed, 19 Sep 2018 04:05:46 -0700
Subject: [PATCH] Fixed retry multipath commands if queue_rq fails
Message-ID: <20180919110546.17029-1-susobhan.dey@gmail.com>

Signed-off-by: Susobhan Dey <susobhan.dey at gmail.com>
---
 drivers/nvme/host/fabrics.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 206d63cb1afc..96c8e47e2fdc 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -539,8 +539,13 @@ static struct nvmf_transport_ops *nvmf_lookup_transport(
 /*
  * For something we're not in a state to send to the device the default action
  * is to busy it and retry it after the controller state is recovered.  However,
- * if the controller is deleting or if anything is marked for failfast or
- * nvme multipath it is immediately failed.
+ * if the controller is deleting or if anything is marked for failfast.
+ * It may happen that just after choosing current path in case of multipath
+ * controller state can go into resetting/connecting either from keep_alive
+ * timeout or IO failure followed by failover. So there can be a race like
+ * when path was selected ctrl state was LIVE but while queue_check is done
+ * in rdma.c ctrl state was changed to resetting/connecting. We have to retry the
+ * same IO from different path and it will succeed.
  *
  * Note: commands used to initialize the controller will be marked for failfast.
  * Note: nvme cli/ioctl commands are marked for failfast.
@@ -550,7 +555,7 @@ blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
 {
 	if (ctrl->state != NVME_CTRL_DELETING &&
 	    ctrl->state != NVME_CTRL_DEAD &&
-	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
+	    !blk_noretry_request(rq))
 		return BLK_STS_RESOURCE;
 	nvme_req(rq)->status = NVME_SC_ABORT_REQ;
 	return BLK_STS_IOERR;
-- 
2.17.1
