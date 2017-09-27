From: jsmart2021@gmail.com (James Smart)
Date: Tue, 26 Sep 2017 21:50:43 -0700
Subject: [PATCH v2 4/7] nvme_fc: add dev_loss_tmo to controller
In-Reply-To: <20170927045046.22238-1-jsmart2021@gmail.com>
References: <20170927045046.22238-1-jsmart2021@gmail.com>
Message-ID: <20170927045046.22238-5-jsmart2021@gmail.com>

This patch adds a dev_loss_tmo value to the controller. The value
is initialized from the remoteport.

The patch also adds a lldd-callable routine,
nvme_fc_set_remoteport_devloss() to change the value on the remoteport
and apply the new value to the controllers on the remote port.

The dev_loss_tmo value set on the controller will ultimately be the
maximum window allowed for reconnection, whether it was started due
to controller reset, transport error, or loss of connectivity to the
target.

The dev_loss_tmo value set on the controller will be the smaller of
the controller's (max_connects * reconnect_delay) window set at creation
and the remoteport's dev_loss_tmo value.  After selecting the smallest
value, if the controller's reconnect window is superceeded by the
remoteport's dev_loss_tmo value, the reconnect values will be
adjusted for the new dev_loss_tmo value.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c         | 93 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme-fc-driver.h |  2 +
 2 files changed, 95 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index db6484bfe02b..63fb35bb6f1f 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -163,6 +163,7 @@ struct nvme_fc_ctrl {
 
 	struct work_struct	delete_work;
 	struct delayed_work	connect_work;
+	u32			dev_loss_tmo;
 
 	struct kref		ref;
 	u32			flags;
@@ -2740,6 +2741,96 @@ static const struct blk_mq_ops nvme_fc_admin_mq_ops = {
 };
 
 
+static void
+nvme_fc_set_ctrl_devloss(struct nvme_fc_ctrl *ctrl,
+		struct nvmf_ctrl_options *opts)
+{
+	u32 dev_loss_tmo;
+
+	/*
+	 * dev_loss_tmo will be the max amount of time after an association
+	 * failure that will be allowed for a new association to be
+	 * established. It doesn't matter why the original association
+	 * failed (FC connectivity loss, transport error, admin-request).
+	 * The new association must be established before dev_loss_tmo
+	 * expires or the controller will be torn down.
+	 *
+	 * If the connect parameters are less than the FC port dev_loss_tmo
+	 * parameter, scale dev_loss_tmo to the connect parameters.
+	 *
+	 * If the connect parameters are larger than the FC port
+	 * dev_loss_tmo parameter, adjust the connect parameters so that
+	 * there is at least 1 attempt at a reconnect attempt before failing.
+	 * Note: reconnects will be attempted only if there is FC connectivity.
+	 */
+
+	if (opts->max_reconnects < 1)
+		opts->max_reconnects = 1;
+	dev_loss_tmo = opts->reconnect_delay * opts->max_reconnects;
+
+	ctrl->dev_loss_tmo =
+		min_t(u32, ctrl->rport->remoteport.dev_loss_tmo, dev_loss_tmo);
+	if (ctrl->dev_loss_tmo < ctrl->rport->remoteport.dev_loss_tmo)
+		dev_info(ctrl->ctrl.device,
+			"NVME-FC{%d}: scaling dev_loss_tmo to reconnect "
+			"window (%d)\n",
+			ctrl->cnum, ctrl->dev_loss_tmo);
+
+	/* resync dev_loss_tmo with the reconnect window */
+	if (ctrl->dev_loss_tmo < opts->reconnect_delay * opts->max_reconnects) {
+		if (!ctrl->dev_loss_tmo)
+			opts->max_reconnects = 0;
+		else {
+			opts->reconnect_delay =
+				min_t(u32, opts->reconnect_delay,
+					ctrl->dev_loss_tmo -
+						NVME_FC_EXPECTED_RECONNECT_TM);
+			opts->max_reconnects = DIV_ROUND_UP(ctrl->dev_loss_tmo,
+						opts->reconnect_delay);
+			dev_info(ctrl->ctrl.device,
+				"NVME-FC{%d}: dev_loss_tmo %d: scaling "
+				"reconnect delay %d max reconnects %d\n",
+				ctrl->cnum, ctrl->dev_loss_tmo,
+				opts->reconnect_delay, opts->max_reconnects);
+		}
+	}
+}
+
+int
+nvme_fc_set_remoteport_devloss(struct nvme_fc_remote_port *portptr,
+			u32 dev_loss_tmo)
+{
+	struct nvme_fc_rport *rport = remoteport_to_rport(portptr);
+	struct nvme_fc_ctrl *ctrl;
+	unsigned long flags;
+
+	/*
+	 * Allow dev_loss_tmo set to 0. This will allow
+	 * nvme_fc_unregister_remoteport() to immediately delete
+	 * controllers without waiting a dev_loss_tmo timeout.
+	 */
+	if (dev_loss_tmo && dev_loss_tmo < NVME_FC_MIN_DEV_LOSS_TMO)
+		return -ERANGE;
+
+	spin_lock_irqsave(&rport->lock, flags);
+
+	if (portptr->port_state != FC_OBJSTATE_ONLINE) {
+		spin_unlock_irqrestore(&rport->lock, flags);
+		return -EINVAL;
+	}
+
+	rport->remoteport.dev_loss_tmo = dev_loss_tmo;
+
+	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list)
+		/* Apply values for use in next reconnect cycle */
+		nvme_fc_set_ctrl_devloss(ctrl, ctrl->ctrl.opts);
+
+	spin_unlock_irqrestore(&rport->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_fc_set_remoteport_devloss);
+
 static struct nvme_ctrl *
 nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	struct nvme_fc_lport *lport, struct nvme_fc_rport *rport)
@@ -2837,6 +2928,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
+	nvme_fc_set_ctrl_devloss(ctrl, opts);
+
 	ret = nvme_fc_create_association(ctrl);
 	if (ret) {
 		ctrl->ctrl.opts = NULL;
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 6e457e4f9543..a2344456266c 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -452,6 +452,8 @@ int nvme_fc_register_remoteport(struct nvme_fc_local_port *localport,
 int nvme_fc_unregister_remoteport(struct nvme_fc_remote_port *remoteport);
 
 
+int nvme_fc_set_remoteport_devloss(struct nvme_fc_remote_port *remoteport,
+			u32 dev_loss_tmo);
 
 /*
  * ***************  LLDD FC-NVME Target/Subsystem API ***************
-- 
2.13.1
