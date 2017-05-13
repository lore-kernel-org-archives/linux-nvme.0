From: jsmart2021@gmail.com (James Smart)
Date: Sat, 13 May 2017 12:07:17 -0700
Subject: [PATCH 3/8] nvme_fc: add a dev_loss_tmo field to the remoteport
In-Reply-To: <20170513190722.25536-1-jsmart2021@gmail.com>
References: <20170513190722.25536-1-jsmart2021@gmail.com>
Message-ID: <20170513190722.25536-4-jsmart2021@gmail.com>

Add a dev_loss_tmo value, paralleling the SCSI FC transport, for device
connectivity loss. The transport can initialize it in the
nvme_fc_register_remoteport() call or fall back on a default of 60s.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c         | 14 ++++++++++++++
 include/linux/nvme-fc-driver.h |  9 +++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 55d0d8c3e92f..6eaf70eaedf4 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -45,6 +45,10 @@ enum nvme_fc_queue_flags {
 
 #define NVMEFC_QUEUE_DELAY	3		/* ms units */
 
+#define NVME_FC_DEFAULT_DEV_LOSS_TMO	60	/* seconds */
+#define NVME_FC_EXPECTED_RECONNECT_TM	2	/* seconds - E_D_TOV */
+#define NVME_FC_MIN_DEV_LOSS_TMO	(2 * NVME_FC_EXPECTED_RECONNECT_TM)
+
 struct nvme_fc_queue {
 	struct nvme_fc_ctrl	*ctrl;
 	struct device		*dev;
@@ -438,6 +442,12 @@ nvme_fc_register_remoteport(struct nvme_fc_local_port *localport,
 	unsigned long flags;
 	int ret, idx;
 
+	if (pinfo->dev_loss_tmo &&
+			pinfo->dev_loss_tmo < NVME_FC_MIN_DEV_LOSS_TMO) {
+		ret = -EINVAL;
+		goto out_reghost_failed;
+	}
+
 	newrec = kmalloc((sizeof(*newrec) + lport->ops->remote_priv_sz),
 			 GFP_KERNEL);
 	if (!newrec) {
@@ -471,6 +481,10 @@ nvme_fc_register_remoteport(struct nvme_fc_local_port *localport,
 	newrec->remoteport.port_id = pinfo->port_id;
 	newrec->remoteport.port_state = FC_OBJSTATE_ONLINE;
 	newrec->remoteport.port_num = idx;
+	if (pinfo->dev_loss_tmo)
+		newrec->remoteport.dev_loss_tmo = pinfo->dev_loss_tmo;
+	else
+		newrec->remoteport.dev_loss_tmo = NVME_FC_DEFAULT_DEV_LOSS_TMO;
 
 	spin_lock_irqsave(&nvme_fc_lock, flags);
 	list_add_tail(&newrec->endp_list, &lport->endp_list);
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index c42313f9a451..61f3eae534ee 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -40,6 +40,8 @@
  * @node_name: FC WWNN for the port
  * @port_name: FC WWPN for the port
  * @port_role: What NVME roles are supported (see FC_PORT_ROLE_xxx)
+ * @dev_loss_tmo: maximum delay for reconnects to an association on
+ *             this device. Used only on a remoteport.
  *
  * Initialization values for dynamic port fields:
  * @port_id:      FC N_Port_ID currently assigned the port. Upper 8 bits must
@@ -50,6 +52,7 @@ struct nvme_fc_port_info {
 	u64			port_name;
 	u32			port_role;
 	u32			port_id;
+	u32			dev_loss_tmo;
 };
 
 
@@ -244,6 +247,9 @@ struct nvme_fc_local_port {
  *             The length of the buffer corresponds to the remote_priv_sz
  *             value specified in the nvme_fc_port_template supplied by
  *             the LLDD.
+ * @dev_loss_tmo: maximum delay for reconnects to an association on
+ *             this device. To modify, lldd must call
+ *             nvme_fc_set_remoteport_devloss().
  *
  * Fields with dynamic values. Values may change base on link or login
  * state. LLDD may reference fields directly to change them. Initialized by
@@ -259,10 +265,9 @@ struct nvme_fc_remote_port {
 	u32 port_role;
 	u64 node_name;
 	u64 port_name;
-
 	struct nvme_fc_local_port *localport;
-
 	void *private;
+	u32 dev_loss_tmo;
 
 	/* dynamic fields */
 	u32 port_id;
-- 
2.11.0
