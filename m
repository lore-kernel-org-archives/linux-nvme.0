From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 7 Feb 2018 03:06:19 +0200
Subject: NVMEoF oops on reset
In-Reply-To: <CO2PR04MB21987F3848378AB2A7BA21B582FD0@CO2PR04MB2198.namprd04.prod.outlook.com>
References: <CO2PR04MB21987F3848378AB2A7BA21B582FD0@CO2PR04MB2198.namprd04.prod.outlook.com>
Message-ID: <d443433f-5456-a86d-84ce-49afa10f8eb8@mellanox.com>

Hi Berck,

On 2/7/2018 12:04 AM, Berck Nash wrote:
> We're experiencing an oops whenever we issue an "nvme reset" via the
> nvme cli on fabric setups.  Appears to be in the nvme_rdma code.  The
> problem occurs on mainline 4.15, as well as on 4.16-nvme (commit
> ca5554a696dce37852f6d6721520b4f13fc295c3).

please try me patches for fixing the state machine (attached).
These should apply over nvme-4.16 but still there is a missing commit 
from Sagi the I mentioned in the cover letter. So with these 4 patches 
your test should pass...


> 
> We can reproduce this simply by discovering, connecting, then issuing a
> reset.
> 
> Please see attached logs for both 4.15 as well as 4.16-nvme.
> 
> Let us know what else we can provide.
> 
> Berck Nash
> 

-Max.

> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&data=02%7C01%7Cmaxg%40mellanox.com%7Cc2d3ac6479c6472c461a08d56dad9ba4%7C8c5c71989dbe4cf9a2099e499881116c%7C0%7C0%7C636535514786932432&sdata=LzbcIxHJUP5SFWU2U%2FuYU%2B4It08G0XzrdyWsS%2FCa2cA%3D&reserved=0
> 
-------------- next part --------------
>From ba526951200393acb009939f596da9c6d49d4b4b Mon Sep 17 00:00:00 2001
From: Max Gurtovoy <maxg@mellanox.com>
Date: Wed, 31 Jan 2018 16:12:27 +0000
Subject: [PATCH v3 0/3] Fix host side state machine

Hi all,
this series is rebased above nvme-4.16.
Actually there is a still missing part in this tree (but I tested it on
my own "stable" mixed kernel with this patch):
"nvme-rdma: fix concurrent reset and reconnect" from Sagi.

The first motivation for this series was fixing RDMA initiator that crushes in
case we fail during initial connect and start error recovery during initial
connection establishment.
This patchset also renames NVME_CTRL_RECONNECTING to NVME_CTRL_CONNECTING as
this state doesn't represent only a reconnection flow but also used for
initialization process.

The tested transport for these patches was RDMA.
It will be appriciated if someone can run this series with real FC HW (to test
patch #3).

changes from V2 (James will implement the support for FC and resubmit the deleted patch):
 - removed FC support
 - removed the "nvme: delete NVME_CTRL_NEW --> NVME_CTRL_LIVE transition"

changes from V1:
 - Added FC support

Max Gurtovoy (3):
  nvme: rename NVME_CTRL_RECONNECTING state to NVME_CTRL_CONNECTING
  nvme-rdma: use NVME_CTRL_CONNECTING state to mark init process
  nvme: delete NVME_CTRL_LIVE --> NVME_CTRL_CONNECTING transition

 drivers/nvme/host/core.c    | 12 ++++++------
 drivers/nvme/host/fabrics.h |  9 +++++----
 drivers/nvme/host/fc.c      | 14 +++++++-------
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/pci.c     |  8 ++++----
 drivers/nvme/host/rdma.c    |  7 +++++--
 6 files changed, 28 insertions(+), 24 deletions(-)

-- 
1.8.3.1

-------------- next part --------------
>From 456342a26ce7ffef0af1e6d661bbbabad58957b2 Mon Sep 17 00:00:00 2001
From: Max Gurtovoy <maxg@mellanox.com>
Date: Tue, 23 Jan 2018 23:28:15 +0000
Subject: [PATCH 1/3] nvme: rename NVME_CTRL_RECONNECTING state to
 NVME_CTRL_CONNECTING

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

-------------- next part --------------
>From e8e665442b94a3e30681718c419b949bafdab805 Mon Sep 17 00:00:00 2001
From: Max Gurtovoy <maxg@mellanox.com>
Date: Tue, 23 Jan 2018 23:34:51 +0000
Subject: [PATCH 2/3] nvme-rdma: use NVME_CTRL_CONNECTING state to mark init
 process

In order to avoid concurrent error recovery during initialization
process (allowed by the NVME_CTRL_NEW --> NVME_CTRL_RESETTING transition)
we must mark the ctrl as CONNECTING before initial connection
establisment.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c | 1 +
 drivers/nvme/host/rdma.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c1a9706..1d7e304 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -296,6 +296,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		break;
 	case NVME_CTRL_CONNECTING:
 		switch (old_state) {
+		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_RESETTING:
 			changed = true;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 219c6a0..d86aee7 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1930,6 +1930,9 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	if (!ctrl->queues)
 		goto out_uninit_ctrl;
 
+	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING);
+	WARN_ON_ONCE(!changed);
+
 	ret = nvme_rdma_configure_admin_queue(ctrl, true);
 	if (ret)
 		goto out_kfree_queues;
-- 
1.8.3.1

-------------- next part --------------
>From ba526951200393acb009939f596da9c6d49d4b4b Mon Sep 17 00:00:00 2001
From: Max Gurtovoy <maxg@mellanox.com>
Date: Tue, 23 Jan 2018 23:45:26 +0000
Subject: [PATCH 3/3] nvme: delete NVME_CTRL_LIVE --> NVME_CTRL_CONNECTING
 transition

There is no logical reason to move from live state to connecting
state. In case of initial connection establishment, the transition
should be NVME_CTRL_NEW --> NVME_CTRL_CONNECTING --> NVME_CTRL_LIVE.
In case of error recovery or reset, the transition should be
NVME_CTRL_LIVE --> NVME_CTRL_RESETTING --> NVME_CTRL_CONNECTING -->
NVME_CTRL_LIVE.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1d7e304..c2a3700 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -297,7 +297,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	case NVME_CTRL_CONNECTING:
 		switch (old_state) {
 		case NVME_CTRL_NEW:
-		case NVME_CTRL_LIVE:
 		case NVME_CTRL_RESETTING:
 			changed = true;
 			/* FALLTHRU */
-- 
1.8.3.1
