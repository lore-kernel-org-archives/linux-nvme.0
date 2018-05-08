From: jsmart2021@gmail.com (James Smart)
Date: Mon,  7 May 2018 17:12:12 -0700
Subject: [PATCH 5/7] nvme_fc: change controllers first connect to use
 reconnect path
In-Reply-To: <20180508001214.8951-1-jsmart2021@gmail.com>
References: <20180508001214.8951-1-jsmart2021@gmail.com>
Message-ID: <20180508001214.8951-6-jsmart2021@gmail.com>

Current code follows the framework that has been in the transports
from the beginning where initial link-side controller connect occurs
as part of "creating the controller". Thus that first connect fully
talks to the controller and obtains values that can then be used in
for blk-mq setup, etc. It also means that everything about the
controller is fully know before the "create controller" call returns.

This has several weaknesses:
- The initial create_ctrl call made by the cli will block for a long
  time as wire transactions are performed synchronously. This delay
  becomes longer if errors occur or connectivity is lost and retries
  need to be performed.
- Code wise, it means there is a separate connect path for initial
  controller connect vs the (same) steps used in the reconnect path.
- And as there's separate paths, it means there's separate error
  handling and retry logic. It also plays havoc with the NEW state
  (should transition out of it after successful initial connect) vs
  the RESETTING and CONNECTING (reconnect) states that want to be
  transitioned to on error.
- As there's separate paths, to recover from errors and disruptions,
  it requires separate recovery/retry paths as well and can severely
  convolute the controller state.
- Given the duration of the initial create_ctrl() call, automation
  of dynamic discovery can't use simplistic udev rules. Instead,
  more convoluted use of systemd is required.

This patch reworks the fc transport to use the same connect paths
for the initial connection as it uses for reconnect. This makes a
single path for error recovery and handling. Given that the initial
connect becomes asynchronous on a background work thread, the
create_ctrl() now returns very quickly, allowing the simplified
auto-connnect scripting.

This patch:
- Removes the driving of the initial connect and replaces it with
  a state transition to CONNECTING and initiating the reconnect
  thread. A dummy state transition of RESETTING had to be traversed
  as a direct transtion of NEW->CONNECTING is not allowed. Given
  that the controller is "new", the RESETTING transition is a simple
  no-op. Once in the reconnecting thread, the normal behaviors of
  ctrl_loss_tmo (max_retries * connect_delay) and dev_loss_tmo will
  apply before the controller is torn down.
- Only if the state transitions couldn't be traversed and the
  reconnect thread not scheduled, will the controller be torn down
  while in create_ctrl.
- The prior code used the controller state of NEW to indicate
  whether request queues had been initialized or not. For the admin
  queue, the request queue is always created, so there's no need to
  check a state. For IO queues, change to tracking whether a successful
  io request queue create has occurred (e.g. 1st successful connect).
- The initial controller id is initialized to the dynamic controller
  id used in the initial connect message. It will be overwritten by
  the real controller id once the controller is connected on the wire.

Note: this patch is dependent on these changes that have been
added to the nvme-cli utility:
- nvme-cli: Wait for device file if not present after successful add_ctrl
- nvme-cli: Add ioctl retry support for "connect-all"

With this patch, a simplistic udev rule such as one of the following
options below, may now be used to support auto connectivity:

option A:
   ACTION=="change", SUBSYSTEM=="fc", ENV{FC_EVENT}=="nvmediscovery", \
        ENV{NVMEFC_HOST_TRADDR}=="*", ENV{NVMEFC_TRADDR}=="*", \
	RUN+="/usr/sbin/nvme connect-all --transport=fc --host-traddr=$env{NVMEFC_HOST_TRADDR} --traddr=$env{NVMEFC_TRADDR}"

option B:
   SUBSYSTEM!="fc", GOTO="nvme_autoconnect_end"
   ACTION!="change", GOTO="nvme_autoconnect_end"
   ENV{FC_EVENT}!="nvmediscovery", GOTO="nvme_autoconnect_end"
   ENV{NVMEFC_HOST_TRADDR}!="?*", GOTO="nvme_autoconnect_end"
   ENV{NVMEFC_TRADDR}!="?*", GOTO="nvme_autoconnect_end"
   RUN+="/usr/sbin/nvme connect-all -t fc --host-traddr=$env{NVMEFC_HOST_TRADDR} -a $env{NVMEFC_TRADDR}"
   LABEL="nvme_autoconnect_end"

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 102 ++++++++++++++++++++++---------------------------
 1 file changed, 45 insertions(+), 57 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index d6842ed50097..7b9fb2e5afee 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -142,6 +142,7 @@ struct nvme_fc_ctrl {
 	struct nvme_fc_rport	*rport;
 	u32			cnum;
 
+	bool			ioq_live;
 	bool			assoc_active;
 	u64			association_id;
 
@@ -2452,6 +2453,8 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	if (ret)
 		goto out_delete_hw_queues;
 
+	ctrl->ioq_live = true;
+
 	return 0;
 
 out_delete_hw_queues:
@@ -2601,8 +2604,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	if (ret)
 		goto out_delete_hw_queue;
 
-	if (ctrl->ctrl.state != NVME_CTRL_NEW)
-		blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
+	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 
 	ret = nvmf_connect_admin_queue(&ctrl->ctrl);
 	if (ret)
@@ -2675,7 +2677,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	 */
 
 	if (ctrl->ctrl.queue_count > 1) {
-		if (ctrl->ctrl.state == NVME_CTRL_NEW)
+		if (!ctrl->ioq_live)
 			ret = nvme_fc_create_io_queues(ctrl);
 		else
 			ret = nvme_fc_reinit_io_queues(ctrl);
@@ -2762,8 +2764,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	 * use blk_mq_tagset_busy_itr() and the transport routine to
 	 * terminate the exchanges.
 	 */
-	if (ctrl->ctrl.state != NVME_CTRL_NEW)
-		blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 
@@ -2919,7 +2920,7 @@ nvme_fc_connect_ctrl_work(struct work_struct *work)
 		nvme_fc_reconnect_or_delete(ctrl, ret);
 	else
 		dev_info(ctrl->ctrl.device,
-			"NVME-FC{%d}: controller reconnect complete\n",
+			"NVME-FC{%d}: controller connect complete\n",
 			ctrl->cnum);
 }
 
@@ -2967,7 +2968,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 {
 	struct nvme_fc_ctrl *ctrl;
 	unsigned long flags;
-	int ret, idx, retry;
+	int ret, idx;
 
 	if (!(rport->remoteport.port_role &
 	    (FC_PORT_ROLE_NVME_DISCOVERY | FC_PORT_ROLE_NVME_TARGET))) {
@@ -2994,11 +2995,13 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	}
 
 	ctrl->ctrl.opts = opts;
+	ctrl->ctrl.nr_reconnects = 0;
 	INIT_LIST_HEAD(&ctrl->ctrl_list);
 	ctrl->lport = lport;
 	ctrl->rport = rport;
 	ctrl->dev = lport->dev;
 	ctrl->cnum = idx;
+	ctrl->ioq_live = false;
 	ctrl->assoc_active = false;
 	init_waitqueue_head(&ctrl->ioabort_wait);
 
@@ -3017,6 +3020,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
+	ctrl->ctrl.cntlid = 0xffff;
 
 	ret = -ENOMEM;
 	ctrl->queues = kcalloc(ctrl->ctrl.queue_count,
@@ -3066,68 +3070,52 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
-	/*
-	 * It's possible that transactions used to create the association
-	 * may fail. Examples: CreateAssociation LS or CreateIOConnection
-	 * LS gets dropped/corrupted/fails; or a frame gets dropped or a
-	 * command times out for one of the actions to init the controller
-	 * (Connect, Get/Set_Property, Set_Features, etc). Many of these
-	 * transport errors (frame drop, LS failure) inherently must kill
-	 * the association. The transport is coded so that any command used
-	 * to create the association (prior to a LIVE state transition
-	 * while NEW or CONNECTING) will fail if it completes in error or
-	 * times out.
-	 *
-	 * As such: as the connect request was mostly likely due to a
-	 * udev event that discovered the remote port, meaning there is
-	 * not an admin or script there to restart if the connect
-	 * request fails, retry the initial connection creation up to
-	 * three times before giving up and declaring failure.
-	 */
-	for (retry = 0; retry < 3; retry++) {
-		ret = nvme_fc_create_association(ctrl);
-		if (!ret)
-			break;
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING) ||
+	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
+		dev_err(ctrl->ctrl.device,
+			"NVME-FC{%d}: failed to init ctrl state\n", ctrl->cnum);
+		goto fail_ctrl;
 	}
 
-	if (ret) {
-		nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
-		cancel_work_sync(&ctrl->ctrl.reset_work);
-		cancel_delayed_work_sync(&ctrl->connect_work);
+	nvme_get_ctrl(&ctrl->ctrl);
 
-		/* couldn't schedule retry - fail out */
+	if (!queue_delayed_work(nvme_wq, &ctrl->connect_work, 0)) {
+		nvme_put_ctrl(&ctrl->ctrl);
 		dev_err(ctrl->ctrl.device,
-			"NVME-FC{%d}: Connect retry failed\n", ctrl->cnum);
+			"NVME-FC{%d}: failed to schedule initial connect\n",
+			ctrl->cnum);
+		goto fail_ctrl;
+	}
 
-		ctrl->ctrl.opts = NULL;
+	dev_info(ctrl->ctrl.device,
+		"NVME-FC{%d}: new ctrl: NQN \"%s\"\n",
+		ctrl->cnum, ctrl->ctrl.opts->subsysnqn);
 
-		/* initiate nvme ctrl ref counting teardown */
-		nvme_uninit_ctrl(&ctrl->ctrl);
+	return &ctrl->ctrl;
 
-		/* Remove core ctrl ref. */
-		nvme_put_ctrl(&ctrl->ctrl);
+fail_ctrl:
+	nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
+	cancel_work_sync(&ctrl->ctrl.reset_work);
+	cancel_delayed_work_sync(&ctrl->connect_work);
 
-		/* as we're past the point where we transition to the ref
-		 * counting teardown path, if we return a bad pointer here,
-		 * the calling routine, thinking it's prior to the
-		 * transition, will do an rport put. Since the teardown
-		 * path also does a rport put, we do an extra get here to
-		 * so proper order/teardown happens.
-		 */
-		nvme_fc_rport_get(rport);
+	ctrl->ctrl.opts = NULL;
 
-		if (ret > 0)
-			ret = -EIO;
-		return ERR_PTR(ret);
-	}
+	/* initiate nvme ctrl ref counting teardown */
+	nvme_uninit_ctrl(&ctrl->ctrl);
 
-	nvme_get_ctrl(&ctrl->ctrl);
+	/* Remove core ctrl ref. */
+	nvme_put_ctrl(&ctrl->ctrl);
 
-	dev_info(ctrl->ctrl.device,
-		"NVME-FC{%d}: new ctrl: NQN \"%s\"\n",
-		ctrl->cnum, ctrl->ctrl.opts->subsysnqn);
+	/* as we're past the point where we transition to the ref
+	 * counting teardown path, if we return a bad pointer here,
+	 * the calling routine, thinking it's prior to the
+	 * transition, will do an rport put. Since the teardown
+	 * path also does a rport put, we do an extra get here to
+	 * so proper order/teardown happens.
+	 */
+	nvme_fc_rport_get(rport);
 
-	return &ctrl->ctrl;
+	return ERR_PTR(-EIO);
 
 out_cleanup_admin_q:
 	blk_cleanup_queue(ctrl->ctrl.admin_q);
-- 
2.13.1
