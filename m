From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  7 Nov 2018 16:30:21 -0800
Subject: [PATCH] nvme-core: add work elements to struct nvme_ctrl
Message-ID: <20181108003021.28624-1-sagi@grimberg.me>

connect_work and err_work can be reused rdma, fc and by other future
transports so share those in nvme_ctrl.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fc.c   | 18 ++++++++----------
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/rdma.c | 19 ++++++++-----------
 3 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 0b70c8bab045..c8b08bd4359c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -159,8 +159,6 @@ struct nvme_fc_ctrl {
 	struct blk_mq_tag_set	admin_tag_set;
 	struct blk_mq_tag_set	tag_set;
 
-	struct delayed_work	connect_work;
-
 	struct kref		ref;
 	u32			flags;
 	u32			iocnt;
@@ -547,7 +545,7 @@ nvme_fc_resume_controller(struct nvme_fc_ctrl *ctrl)
 			"NVME-FC{%d}: connectivity re-established. "
 			"Attempting reconnect\n", ctrl->cnum);
 
-		queue_delayed_work(nvme_wq, &ctrl->connect_work, 0);
+		queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work, 0);
 		break;
 
 	case NVME_CTRL_RESETTING:
@@ -2814,7 +2812,7 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
-	cancel_delayed_work_sync(&ctrl->connect_work);
+	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
 	/*
 	 * kill the association on the link side.  this will block
 	 * waiting for io to terminate
@@ -2849,7 +2847,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 		else if (time_after(jiffies + recon_delay, rport->dev_loss_end))
 			recon_delay = rport->dev_loss_end - jiffies;
 
-		queue_delayed_work(nvme_wq, &ctrl->connect_work, recon_delay);
+		queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work, recon_delay);
 	} else {
 		if (portptr->port_state == FC_OBJSTATE_ONLINE)
 			dev_warn(ctrl->ctrl.device,
@@ -2917,7 +2915,7 @@ nvme_fc_connect_ctrl_work(struct work_struct *work)
 
 	struct nvme_fc_ctrl *ctrl =
 			container_of(to_delayed_work(work),
-				struct nvme_fc_ctrl, connect_work);
+				struct nvme_fc_ctrl, ctrl.connect_work);
 
 	ret = nvme_fc_create_association(ctrl);
 	if (ret)
@@ -3013,7 +3011,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	kref_init(&ctrl->ref);
 
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
-	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
+	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work, nvme_fc_connect_ctrl_work);
 	spin_lock_init(&ctrl->lock);
 
 	/* io queue count */
@@ -3084,7 +3082,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	nvme_get_ctrl(&ctrl->ctrl);
 
-	if (!queue_delayed_work(nvme_wq, &ctrl->connect_work, 0)) {
+	if (!queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work, 0)) {
 		nvme_put_ctrl(&ctrl->ctrl);
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: failed to schedule initial connect\n",
@@ -3092,7 +3090,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 		goto fail_ctrl;
 	}
 
-	flush_delayed_work(&ctrl->connect_work);
+	flush_delayed_work(&ctrl->ctrl.connect_work);
 
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: new ctrl: NQN \"%s\"\n",
@@ -3103,7 +3101,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 fail_ctrl:
 	nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
 	cancel_work_sync(&ctrl->ctrl.reset_work);
-	cancel_delayed_work_sync(&ctrl->connect_work);
+	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
 
 	ctrl->ctrl.opts = NULL;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5f3b97919c09..56b4a1a3e130 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -239,6 +239,8 @@ struct nvme_ctrl {
 	u16 maxcmd;
 	int nr_reconnects;
 	struct nvmf_ctrl_options *opts;
+	struct delayed_work connect_work;
+	struct work_struct err_work;
 };
 
 struct nvme_subsystem {
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d181cafedc58..23596059052c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -101,12 +101,9 @@ struct nvme_rdma_ctrl {
 
 	/* other member variables */
 	struct blk_mq_tag_set	tag_set;
-	struct work_struct	err_work;
 
 	struct nvme_rdma_qe	async_event_sqe;
 
-	struct delayed_work	reconnect_work;
-
 	struct list_head	list;
 
 	struct blk_mq_tag_set	admin_tag_set;
@@ -909,8 +906,8 @@ static void nvme_rdma_stop_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
-	cancel_work_sync(&ctrl->err_work);
-	cancel_delayed_work_sync(&ctrl->reconnect_work);
+	cancel_work_sync(&ctrl->ctrl.err_work);
+	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
 }
 
 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
@@ -942,7 +939,7 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 	if (nvmf_should_reconnect(&ctrl->ctrl)) {
 		dev_info(ctrl->ctrl.device, "Reconnecting in %d seconds...\n",
 			ctrl->ctrl.opts->reconnect_delay);
-		queue_delayed_work(nvme_wq, &ctrl->reconnect_work,
+		queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work,
 				ctrl->ctrl.opts->reconnect_delay * HZ);
 	} else {
 		nvme_delete_ctrl(&ctrl->ctrl);
@@ -1014,7 +1011,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(to_delayed_work(work),
-			struct nvme_rdma_ctrl, reconnect_work);
+			struct nvme_rdma_ctrl, ctrl.connect_work);
 
 	++ctrl->ctrl.nr_reconnects;
 
@@ -1037,7 +1034,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
-			struct nvme_rdma_ctrl, err_work);
+			struct nvme_rdma_ctrl, ctrl.err_work);
 
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	nvme_rdma_teardown_io_queues(ctrl, false);
@@ -1058,7 +1055,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
 		return;
 
-	queue_work(nvme_wq, &ctrl->err_work);
+	queue_work(nvme_wq, &ctrl->ctrl.err_work);
 }
 
 static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
@@ -1931,9 +1928,9 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
-	INIT_DELAYED_WORK(&ctrl->reconnect_work,
+	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
 			nvme_rdma_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
+	INIT_WORK(&ctrl->ctrl.err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
 	ctrl->ctrl.queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
-- 
2.17.1
