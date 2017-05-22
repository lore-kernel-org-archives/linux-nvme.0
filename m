From: jsmart2021@gmail.com (James Smart)
Date: Mon, 22 May 2017 15:28:44 -0700
Subject: [PATCH v3 3/3] nvme_fcloop: fix port deletes and callbacks
In-Reply-To: <20170522222844.22494-1-jsmart2021@gmail.com>
References: <20170522222844.22494-1-jsmart2021@gmail.com>
Message-ID: <20170522222844.22494-4-jsmart2021@gmail.com>

Now that there are potentially long delays between when a
remoteport or targetport delete calls is made and when the
callback occurs (dev_loss_tmo timeout), no longer block in the
delete routines and move the final nport puts to the callbacks.

Moved the fcloop_nport_get/put/free routines to avoid forward
declarations.

Ensure port_info structs used in registrations are nulled in
case fields are not set (ex: devloss_tmo values).

Signed-off-by: James Smart <james.smart at broadcom.com>
---
This is the 3rd version of this patch: 
v2: cut on nvme-4.12
v3: remove remoteport and localport completions

 drivers/nvme/host/fc.c       |  1 +
 drivers/nvme/target/fcloop.c | 86 +++++++++++++++++++-------------------------
 2 files changed, 37 insertions(+), 50 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 1ba693f7bdf0..8ac109981960 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2728,6 +2728,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	INIT_WORK(&ctrl->reset_work, nvme_fc_reset_ctrl_work);
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
 	spin_lock_init(&ctrl->lock);
+	init_waitqueue_head(&ctrl->ioabort_wait);
 
 	/* io queue count */
 	ctrl->queue_count = min_t(unsigned int,
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 294a6611fb24..70445d5e5a6a 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -227,8 +227,6 @@ struct fcloop_nport {
 	struct fcloop_lport *lport;
 	struct list_head nport_list;
 	struct kref ref;
-	struct completion rport_unreg_done;
-	struct completion tport_unreg_done;
 	u64 node_name;
 	u64 port_name;
 	u32 port_role;
@@ -636,6 +634,32 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 }
 
 static void
+fcloop_nport_free(struct kref *ref)
+{
+	struct fcloop_nport *nport =
+		container_of(ref, struct fcloop_nport, ref);
+	unsigned long flags;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	list_del(&nport->nport_list);
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	kfree(nport);
+}
+
+static void
+fcloop_nport_put(struct fcloop_nport *nport)
+{
+	kref_put(&nport->ref, fcloop_nport_free);
+}
+
+static int
+fcloop_nport_get(struct fcloop_nport *nport)
+{
+	return kref_get_unless_zero(&nport->ref);
+}
+
+static void
 fcloop_localport_delete(struct nvme_fc_local_port *localport)
 {
 	struct fcloop_lport *lport = localport->private;
@@ -649,8 +673,7 @@ fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 {
 	struct fcloop_rport *rport = remoteport->private;
 
-	/* release any threads waiting for the unreg to complete */
-	complete(&rport->nport->rport_unreg_done);
+	fcloop_nport_put(rport->nport);
 }
 
 static void
@@ -658,8 +681,7 @@ fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 {
 	struct fcloop_tport *tport = targetport->private;
 
-	/* release any threads waiting for the unreg to complete */
-	complete(&tport->nport->tport_unreg_done);
+	fcloop_nport_put(tport->nport);
 }
 
 #define	FCLOOP_HW_QUEUES		4
@@ -727,6 +749,7 @@ fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
 		goto out_free_opts;
 	}
 
+	memset(&pinfo, 0, sizeof(pinfo));
 	pinfo.node_name = opts->wwnn;
 	pinfo.port_name = opts->wwpn;
 	pinfo.port_role = opts->roles;
@@ -809,32 +832,6 @@ fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
 	return ret ? ret : count;
 }
 
-static void
-fcloop_nport_free(struct kref *ref)
-{
-	struct fcloop_nport *nport =
-		container_of(ref, struct fcloop_nport, ref);
-	unsigned long flags;
-
-	spin_lock_irqsave(&fcloop_lock, flags);
-	list_del(&nport->nport_list);
-	spin_unlock_irqrestore(&fcloop_lock, flags);
-
-	kfree(nport);
-}
-
-static void
-fcloop_nport_put(struct fcloop_nport *nport)
-{
-	kref_put(&nport->ref, fcloop_nport_free);
-}
-
-static int
-fcloop_nport_get(struct fcloop_nport *nport)
-{
-	return kref_get_unless_zero(&nport->ref);
-}
-
 static struct fcloop_nport *
 fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
 {
@@ -943,6 +940,7 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
 	if (!nport)
 		return -EIO;
 
+	memset(&pinfo, 0, sizeof(pinfo));
 	pinfo.node_name = nport->node_name;
 	pinfo.port_name = nport->port_name;
 	pinfo.port_role = nport->port_role;
@@ -984,23 +982,17 @@ __unlink_remote_port(struct fcloop_nport *nport)
 }
 
 static int
-__wait_remoteport_unreg(struct fcloop_nport *nport, struct fcloop_rport *rport)
+__remoteport_unreg(struct fcloop_nport *nport, struct fcloop_rport *rport)
 {
 	int ret;
 
 	if (!rport)
 		return -EALREADY;
 
-	init_completion(&nport->rport_unreg_done);
-
 	ret = nvme_fc_unregister_remoteport(rport->remoteport);
 	if (ret)
 		return ret;
 
-	wait_for_completion(&nport->rport_unreg_done);
-
-	fcloop_nport_put(nport);
-
 	return ret;
 }
 
@@ -1034,7 +1026,7 @@ fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
 	if (!nport)
 		return -ENOENT;
 
-	ret = __wait_remoteport_unreg(nport, rport);
+	ret = __remoteport_unreg(nport, rport);
 
 	return ret ? ret : count;
 }
@@ -1091,23 +1083,17 @@ __unlink_target_port(struct fcloop_nport *nport)
 }
 
 static int
-__wait_targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
+__targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
 {
 	int ret;
 
 	if (!tport)
 		return -EALREADY;
 
-	init_completion(&nport->tport_unreg_done);
-
 	ret = nvmet_fc_unregister_targetport(tport->targetport);
 	if (ret)
 		return ret;
 
-	wait_for_completion(&nport->tport_unreg_done);
-
-	fcloop_nport_put(nport);
-
 	return ret;
 }
 
@@ -1141,7 +1127,7 @@ fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
 	if (!nport)
 		return -ENOENT;
 
-	ret = __wait_targetport_unreg(nport, tport);
+	ret = __targetport_unreg(nport, tport);
 
 	return ret ? ret : count;
 }
@@ -1228,11 +1214,11 @@ static void __exit fcloop_exit(void)
 
 		spin_unlock_irqrestore(&fcloop_lock, flags);
 
-		ret = __wait_targetport_unreg(nport, tport);
+		ret = __targetport_unreg(nport, tport);
 		if (ret)
 			pr_warn("%s: Failed deleting target port\n", __func__);
 
-		ret = __wait_remoteport_unreg(nport, rport);
+		ret = __remoteport_unreg(nport, rport);
 		if (ret)
 			pr_warn("%s: Failed deleting remote port\n", __func__);
 
-- 
2.11.0
