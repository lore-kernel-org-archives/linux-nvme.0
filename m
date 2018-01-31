From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 31 Jan 2018 18:31:24 +0200
Subject: [PATCH 1/3] nvme: rename NVME_CTRL_RECONNECTING state to
 NVME_CTRL_CONNECTING
In-Reply-To: <1517416286-31109-1-git-send-email-maxg@mellanox.com>
References: <1517416286-31109-1-git-send-email-maxg@mellanox.com>
Message-ID: <1517416286-31109-2-git-send-email-maxg@mellanox.com>

In pci transport, this state is used to mark the initialization
process. This should be also used in other transports as well.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c    | 10 +++++-----
 drivers/nvme/host/fabrics.h |  9 +++++----
 drivers/nvme/host/fc.c      | 14 +++++++-------
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/pci.c     |  8 ++++----
 drivers/nvme/host/rdma.c    |  4 ++--
 6 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b3af8e9..c1a9706 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -265,7 +265,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	switch (new_state) {
 	case NVME_CTRL_ADMIN_ONLY:
 		switch (old_state) {
-		case NVME_CTRL_RECONNECTING:
+		case NVME_CTRL_CONNECTING:
 			changed = true;
 			/* FALLTHRU */
 		default:
@@ -276,7 +276,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		switch (old_state) {
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_RESETTING:
-		case NVME_CTRL_RECONNECTING:
+		case NVME_CTRL_CONNECTING:
 			changed = true;
 			/* FALLTHRU */
 		default:
@@ -294,7 +294,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 			break;
 		}
 		break;
-	case NVME_CTRL_RECONNECTING:
+	case NVME_CTRL_CONNECTING:
 		switch (old_state) {
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_RESETTING:
@@ -309,7 +309,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_ADMIN_ONLY:
 		case NVME_CTRL_RESETTING:
-		case NVME_CTRL_RECONNECTING:
+		case NVME_CTRL_CONNECTING:
 			changed = true;
 			/* FALLTHRU */
 		default:
@@ -2682,7 +2682,7 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 		[NVME_CTRL_LIVE]	= "live",
 		[NVME_CTRL_ADMIN_ONLY]	= "only-admin",
 		[NVME_CTRL_RESETTING]	= "resetting",
-		[NVME_CTRL_RECONNECTING]= "reconnecting",
+		[NVME_CTRL_CONNECTING]	= "connecting",
 		[NVME_CTRL_DELETING]	= "deleting",
 		[NVME_CTRL_DEAD]	= "dead",
 	};
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 25b19f7..a3145d9 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -171,13 +171,14 @@ static inline blk_status_t nvmf_check_init_req(struct nvme_ctrl *ctrl,
 	    cmd->common.opcode != nvme_fabrics_command ||
 	    cmd->fabrics.fctype != nvme_fabrics_type_connect) {
 		/*
-		 * Reconnecting state means transport disruption, which can take
-		 * a long time and even might fail permanently, fail fast to
-		 * give upper layers a chance to failover.
+		 * Connecting state means transport disruption or initial
+		 * establishment, which can take a long time and even might
+		 * fail permanently, fail fast to give upper layers a chance
+		 * to failover.
 		 * Deleting state means that the ctrl will never accept commands
 		 * again, fail it permanently.
 		 */
-		if (ctrl->state == NVME_CTRL_RECONNECTING ||
+		if (ctrl->state == NVME_CTRL_CONNECTING ||
 		    ctrl->state == NVME_CTRL_DELETING) {
 			nvme_req(rq)->status = NVME_SC_ABORT_REQ;
 			return BLK_STS_IOERR;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b76ba46..b679971 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -534,7 +534,7 @@ static void __nvme_fc_delete_hw_queue(struct nvme_fc_ctrl *,
 {
 	switch (ctrl->ctrl.state) {
 	case NVME_CTRL_NEW:
-	case NVME_CTRL_RECONNECTING:
+	case NVME_CTRL_CONNECTING:
 		/*
 		 * As all reconnects were suppressed, schedule a
 		 * connect.
@@ -779,7 +779,7 @@ static void __nvme_fc_delete_hw_queue(struct nvme_fc_ctrl *,
 		}
 		break;
 
-	case NVME_CTRL_RECONNECTING:
+	case NVME_CTRL_CONNECTING:
 		/*
 		 * The association has already been terminated and the
 		 * controller is attempting reconnects.  No need to do anything
@@ -1724,7 +1724,7 @@ enum {
 	if (status &&
 	    (blk_queue_dying(rq->q) ||
 	     ctrl->ctrl.state == NVME_CTRL_NEW ||
-	     ctrl->ctrl.state == NVME_CTRL_RECONNECTING))
+	     ctrl->ctrl.state == NVME_CTRL_CONNECTING))
 		status |= cpu_to_le16(NVME_SC_DNR << 1);
 
 	if (__nvme_fc_fcpop_chk_teardowns(ctrl, op))
@@ -2951,7 +2951,7 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
 	unsigned long recon_delay = ctrl->ctrl.opts->reconnect_delay * HZ;
 	bool recon = true;
 
-	if (ctrl->ctrl.state != NVME_CTRL_RECONNECTING)
+	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING)
 		return;
 
 	if (portptr->port_state == FC_OBJSTATE_ONLINE)
@@ -2999,10 +2999,10 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
 	/* will block will waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
 
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RECONNECTING)) {
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: error_recovery: Couldn't change state "
-			"to RECONNECTING\n", ctrl->cnum);
+			"to CONNECTING\n", ctrl->cnum);
 		return;
 	}
 
@@ -3203,7 +3203,7 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
 	 * transport errors (frame drop, LS failure) inherently must kill
 	 * the association. The transport is coded so that any command used
 	 * to create the association (prior to a LIVE state transition
-	 * while NEW or RECONNECTING) will fail if it completes in error or
+	 * while NEW or CONNECTING) will fail if it completes in error or
 	 * times out.
 	 *
 	 * As such: as the connect request was mostly likely due to a
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8e7fc1b..91529c9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -123,7 +123,7 @@ enum nvme_ctrl_state {
 	NVME_CTRL_LIVE,
 	NVME_CTRL_ADMIN_ONLY,    /* Only admin queue live */
 	NVME_CTRL_RESETTING,
-	NVME_CTRL_RECONNECTING,
+	NVME_CTRL_CONNECTING,
 	NVME_CTRL_DELETING,
 	NVME_CTRL_DEAD,
 };
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0bc6a9e..8060ee9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1143,7 +1143,7 @@ static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
 	/* If there is a reset/reinit ongoing, we shouldn't reset again. */
 	switch (dev->ctrl.state) {
 	case NVME_CTRL_RESETTING:
-	case NVME_CTRL_RECONNECTING:
+	case NVME_CTRL_CONNECTING:
 		return false;
 	default:
 		break;
@@ -2290,12 +2290,12 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_dev_disable(dev, false);
 
 	/*
-	 * Introduce RECONNECTING state from nvme-fc/rdma transports to mark the
+	 * Introduce CONNECTING state from nvme-fc/rdma transports to mark the
 	 * initializing procedure here.
 	 */
-	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RECONNECTING)) {
+	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_warn(dev->ctrl.device,
-			"failed to mark controller RECONNECTING\n");
+			"failed to mark controller CONNECTING\n");
 		goto out;
 	}
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6c2fdfa..219c6a0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -887,7 +887,7 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 {
 	/* If we are resetting/deleting then do nothing */
-	if (ctrl->ctrl.state != NVME_CTRL_RECONNECTING) {
+	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING) {
 		WARN_ON_ONCE(ctrl->ctrl.state == NVME_CTRL_NEW ||
 			ctrl->ctrl.state == NVME_CTRL_LIVE);
 		return;
@@ -978,7 +978,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 {
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RECONNECTING))
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		return;
 
 	queue_work(nvme_wq, &ctrl->err_work);
-- 
1.8.3.1
