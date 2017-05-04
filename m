From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu,  4 May 2017 11:07:33 -0700
Subject: [RFC 3/7] nvme_fc: add dev_loss_tmo to controller
In-Reply-To: <20170504180737.5472-1-jsmart2021@gmail.com>
References: <20170504180737.5472-1-jsmart2021@gmail.com>
Message-ID: <20170504180737.5472-4-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

This patch adds a dev_loss_tmo value to the controller. The value
is initialized from the remoteport.

The patch also adds a lldd-callable routine,
nvme_fc_set_remoteport_devloss() to change the value on the remoteport
and apply the new value to the controllers on the remote port.

The dev_loss_tmo value set on the controller will ultimately be the
maximum window allowed for reconnection, whether it was started due
to controller reset, transport error, or loss of connectivity to the
target.

When setting the value on the controller, the following is considered:
1. (max_connects * reconnect_delay), which may have been set by the
  request for a connection, is the user-specified connectivity window

2. kato is how long the target can survive a connectivity loss before
it fails - so it better be greater than or equal to the dev_loss_tmo
value selected. (Note: hack to know what fabrics layer will set
kato to)

3. The remoteport dev_loss_tmo is the value trying to be applied from
the fc layer.

The transport selects the smallest of the 3 values.  No change is
ever made to kato. After selecting the smallest value, if the
user-specified values have been overrun, they're recalculated to
correspond to dev_loss_tmo.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c         | 116 +++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme-fc-driver.h |   2 +
 2 files changed, 118 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 89a5aa3c8cd9..a975a48f00a5 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -167,6 +167,7 @@ struct nvme_fc_ctrl {
 	struct work_struct	delete_work;
 	struct work_struct	reset_work;
 	struct delayed_work	connect_work;
+	u32			dev_loss_tmo;
 
 	struct kref		ref;
 	u32			flags;
@@ -2725,6 +2726,119 @@ static const struct blk_mq_ops nvme_fc_admin_mq_ops = {
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
+	if (opts->kato && dev_loss_tmo > (opts->kato + NVME_KATO_GRACE)) {
+		dev_warn(ctrl->ctrl.device,
+			"NVME-FC{%d}: scaling reconnect window to "
+			"keep alive timeout (%d)\n",
+			ctrl->cnum, opts->kato + NVME_KATO_GRACE);
+		dev_loss_tmo = opts->kato + NVME_KATO_GRACE;
+	}
+
+	ctrl->dev_loss_tmo =
+		min_t(u32, ctrl->rport->remoteport.dev_loss_tmo, dev_loss_tmo);
+	if (ctrl->dev_loss_tmo < ctrl->rport->remoteport.dev_loss_tmo)
+		dev_warn(ctrl->ctrl.device,
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
+			dev_warn(ctrl->ctrl.device,
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
+	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
+		/* Apply values for use in next reconnect cycle */
+		nvme_fc_set_ctrl_devloss(ctrl, ctrl->ctrl.opts);
+
+		/*
+		 * if kato is smaller than device loss, if connectivity
+		 * is lost, the controller could fail before we give up.
+		 * Accept the value, but warn as it is a bad idea
+		 */
+		if (dev_loss_tmo > ctrl->ctrl.opts->kato)
+			dev_warn(ctrl->ctrl.device,
+				"NVME-FC{%d}: controller may fail prior "
+				"to dev_loss_tmo (%d) due to keep alive "
+				"timeout (%d)\n",
+				ctrl->cnum, ctrl->dev_loss_tmo,
+				ctrl->ctrl.opts->kato);
+
+	}
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
@@ -2816,6 +2930,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
+	nvme_fc_set_ctrl_devloss(ctrl, opts);
+
 	ret = nvme_fc_create_association(ctrl);
 	if (ret) {
 		ctrl->ctrl.opts = NULL;
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 7df9faef5af0..ab5f66f4c0f8 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -451,6 +451,8 @@ int nvme_fc_register_remoteport(struct nvme_fc_local_port *localport,
 
 int nvme_fc_unregister_remoteport(struct nvme_fc_remote_port *remoteport);
 
+int nvme_fc_set_remoteport_devloss(struct nvme_fc_remote_port *remoteport,
+			u32 dev_loss_tmo);
 
 
 /*
-- 
2.11.0
