From: hare@suse.de (Hannes Reinecke)
Date: Tue, 29 May 2018 12:14:23 +0200
Subject: [PATCH 02/10] nvme: ANA transition timeout handling
In-Reply-To: <20180529101431.62271-1-hare@suse.de>
References: <20180529101431.62271-1-hare@suse.de>
Message-ID: <20180529101431.62271-3-hare@suse.de>

Use delayed work for processing ANA log pages, and resubmit the
workqueue function in case of an error or if a state is found to
be in 'transitioning'.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c      | 11 +++++++++--
 drivers/nvme/host/multipath.c | 33 +++++++++++++++++++++++++++------
 drivers/nvme/host/nvme.h      |  4 +++-
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b1e4f56a55ed..1be424053f47 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1516,6 +1516,12 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		goto out;
 	}
 
+	if (ns->anagrpid != le32_to_cpu(id->anagrpid)) {
+		dev_warn(ctrl->device, "nsid %d ANA group id changed\n",
+			 ns->head->ns_id);
+		queue_delayed_work(nvme_wq, &ctrl->ana_work, 0);
+	}
+
 	__nvme_revalidate_disk(disk, id);
 	nvme_report_ns_ids(ctrl, ns->head->ns_id, id, &ids);
 	if (!nvme_ns_ids_equal(&ns->head->ids, &ids)) {
@@ -2390,6 +2396,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->kas = le16_to_cpu(id->kas);
 	ctrl->max_namespaces = le32_to_cpu(id->mnan);
 	ctrl->anacap = id->anacap;
+	ctrl->anatt = id->anatt;
 	ctrl->nanagrpid = le32_to_cpu(id->nanagrpid);
 	ctrl->anagrpmax = le32_to_cpu(id->anagrpmax);
 
@@ -3415,7 +3422,7 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	case NVME_AER_NOTICE_ANA:
 		if (WARN_ON_ONCE(!ctrl->ana_log_buf))
 			break;
-		queue_work(nvme_wq, &ctrl->ana_work);
+		queue_delayed_work(nvme_wq, &ctrl->ana_work, 0);
 		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
@@ -3452,7 +3459,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
 	flush_work(&ctrl->scan_work);
-	cancel_work_sync(&ctrl->ana_work);
+	cancel_delayed_work_sync(&ctrl->ana_work);
 	cancel_work_sync(&ctrl->fw_act_work);
 	if (ctrl->ops->stop_ctrl)
 		ctrl->ops->stop_ctrl(ctrl);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 1a8791340862..2fcaf50d84e2 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -69,6 +69,8 @@ void nvme_failover_req(struct request *req)
 		 * entirely trivial..
 		 */
 		nvme_update_ana_state(ns, NVME_ANA_CHANGE);
+		queue_delayed_work(nvme_wq, &ns->ctrl->ana_work,
+				   ns->ctrl->anatt * HZ);
 		break;
 	case NVME_SC_ANA_PERSISTENT_LOSS:
 		nvme_update_ana_state(ns, NVME_ANA_PERSISTENT_LOSS);
@@ -309,7 +311,7 @@ static int nvme_process_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
 {
 	void *base = ctrl->ana_log_buf;
 	size_t offset = sizeof(struct nvme_ana_rsp_hdr);
-	int error, i;
+	int error = 0, i;
 
 	/*
 	 * If anagrpid never changes we don't need to process the namespace
@@ -323,7 +325,7 @@ static int nvme_process_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
 			ctrl->ana_log_buf, ctrl->ana_log_size, 0);
 	if (error) {
 		dev_warn(ctrl->device, "Failed to get ANA log: %d\n", error);
-		return error;
+		return -EIO;
 	}
 
 	for (i = 0; i < le16_to_cpu(ctrl->ana_log_buf->ngrps); i++) {
@@ -345,6 +347,8 @@ static int nvme_process_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
 		dev_info(ctrl->device, "ANA group %d: %s.\n",
 				grpid, nvme_ana_state_names[desc->state]);
 		WRITE_ONCE(ctrl->ana_state[grpid], desc->state);
+		if (desc->state == NVME_ANA_CHANGE)
+			error = -EAGAIN;
 		offset += sizeof(*desc);
 		if (!nr_nsids)
 			continue;
@@ -372,14 +376,31 @@ static int nvme_process_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
 			return -EINVAL;
 	}
 
-	return 0;
+	return error;
 }
 
 static void nvme_ana_work(struct work_struct *work)
 {
-	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, ana_work);
+	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl,
+					      ana_work.work);
+	int ret;
+
+	if (!ctrl->ana_log_buf)
+		return;
+	if (ctrl->state != NVME_CTRL_LIVE)
+		return;
+	ret = nvme_process_ana_log(ctrl, false);
+	if (ret == -EAGAIN || ret == -EIO) {
+		unsigned long log_delay = ctrl->anatt * HZ;
 
-	nvme_process_ana_log(ctrl, false);
+		/*
+		 * In case of an I/O error just add a small delay to not hit
+		 * the target too hard
+		 */
+		if (ret == -EIO)
+			log_delay = msecs_to_jiffies(NVME_ANA_LOG_DELAY);
+		queue_delayed_work(nvme_wq, &ctrl->ana_work, log_delay);
+	}
 	nvme_kick_requeue_lists(ctrl);
 }
 
@@ -404,7 +425,7 @@ int nvme_configure_ana(struct nvme_ctrl *ctrl)
 		return 0;
 	}
 
-	INIT_WORK(&ctrl->ana_work, nvme_ana_work);
+	INIT_DELAYED_WORK(&ctrl->ana_work, nvme_ana_work);
 	ctrl->ana_state = kcalloc(ctrl->anagrpmax, sizeof(*ctrl->ana_state),
 			GFP_KERNEL);
 	if (!ctrl->ana_state)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4a29c736370f..53cb7f8a6267 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -32,6 +32,7 @@ extern unsigned int admin_timeout;
 
 #define NVME_DEFAULT_KATO	5
 #define NVME_KATO_GRACE		10
+#define NVME_ANA_LOG_DELAY	500
 
 extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
@@ -195,12 +196,13 @@ struct nvme_ctrl {
 
 	/* asymmetric namespace access: */
 	u8 anacap;
+	u8 anatt;
 	u32 anagrpmax;
 	u32 nanagrpid;
 	enum nvme_ana_state *ana_state;
 	size_t ana_log_size;
 	struct nvme_ana_rsp_hdr *ana_log_buf;
-	struct work_struct ana_work;
+	struct delayed_work ana_work;
 
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
-- 
2.12.3
