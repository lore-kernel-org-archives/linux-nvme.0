From: hare@suse.de (Hannes Reinecke)
Date: Fri,  8 Jun 2018 14:13:20 +0200
Subject: [PATCHv2] nvme: ANA transition timeout handling
Message-ID: <20180608121320.74149-1-hare@suse.de>

Turn the ana_state array into an array of ana groups, and add
a timer to each group for tracking ANA transition timeout.
Once the timeout expires the controller will be reset.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c      |  2 ++
 drivers/nvme/host/multipath.c | 78 ++++++++++++++++++++++++++++++++++---------
 drivers/nvme/host/nvme.h      | 14 +++++++-
 3 files changed, 77 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e62de51209b2..c2362e81619a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -114,6 +114,7 @@ int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		return -EBUSY;
+	nvme_stop_anatt(ctrl);
 	if (!queue_work(nvme_reset_wq, &ctrl->reset_work))
 		return -EBUSY;
 	return 0;
@@ -2378,6 +2379,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->kas = le16_to_cpu(id->kas);
 	ctrl->max_namespaces = le32_to_cpu(id->mnan);
 	ctrl->anacap = id->anacap;
+	ctrl->anatt = id->anatt;
 	ctrl->nanagrpid = le32_to_cpu(id->nanagrpid);
 	ctrl->anagrpmax = le32_to_cpu(id->anagrpmax);
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 67809e4a1752..b14026e41cac 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -44,7 +44,7 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 
 static void nvme_update_ana_state(struct nvme_ns *ns, enum nvme_ana_state state)
 {
-	WRITE_ONCE(ns->ctrl->ana_state[ns->anagrpid], state);
+	WRITE_ONCE(ns->ctrl->ana_groups[ns->anagrpid].state, state);
 }
 
 void nvme_failover_req(struct request *req)
@@ -64,13 +64,17 @@ void nvme_failover_req(struct request *req)
 	 */
 	switch (status) {
 	case NVME_SC_ANA_TRANSITION:
-		/*
-		 * XXX: We should verify the controller doesn't die on during
-		 * the transition.  But that means we per-group timeout from
-		 * when we first hit the change state, so this won't be
-		 * entirely trivial..
-		 */
 		nvme_update_ana_state(ns, NVME_ANA_CHANGE);
+		if (ns->ctrl->state == NVME_CTRL_LIVE) {
+			struct nvme_ana_group *grp =
+				&ns->ctrl->ana_groups[ns->anagrpid];
+			/*
+			 * Use timer_reduce() to ensure we're not modifying
+			 * an already running timer.
+			 */
+			timer_reduce(&grp->anatt_timer,
+				     ns->ctrl->anatt * HZ + jiffies);
+		}
 		break;
 	case NVME_SC_ANA_PERSISTENT_LOSS:
 		nvme_update_ana_state(ns, NVME_ANA_PERSISTENT_LOSS);
@@ -104,7 +108,7 @@ static inline enum nvme_ana_state nvme_ns_ana_state(struct nvme_ns *ns)
 		return NVME_ANA_OPTIMIZED;
 	if (WARN_ON_ONCE(ns->anagrpid > ns->ctrl->anagrpmax))
 		return 0;
-	return READ_ONCE(ns->ctrl->ana_state[ns->anagrpid]);
+	return READ_ONCE(ns->ctrl->ana_groups[ns->anagrpid].state);
 }
 
 static const char *nvme_ana_state_names[] = {
@@ -351,7 +355,7 @@ static int nvme_process_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
 
 		dev_info(ctrl->device, "ANA group %d: %s.\n",
 				grpid, nvme_ana_state_names[desc->state]);
-		WRITE_ONCE(ctrl->ana_state[grpid], desc->state);
+		WRITE_ONCE(ctrl->ana_groups[grpid].state, desc->state);
 		offset += sizeof(*desc);
 		if (!nr_nsids)
 			continue;
@@ -395,14 +399,48 @@ static int nvme_process_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
 static void nvme_ana_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, ana_work);
+	u32 grpid;
 
 	nvme_process_ana_log(ctrl, false);
+	for (grpid = 1; grpid < ctrl->anagrpmax; grpid++) {
+		struct nvme_ana_group *grp = &ctrl->ana_groups[grpid];
+		enum nvme_ana_state state = READ_ONCE(grp->state);
+
+		if (ctrl->state == NVME_CTRL_LIVE && state == NVME_ANA_CHANGE)
+			timer_reduce(&grp->anatt_timer,
+				     ctrl->anatt * HZ + jiffies);
+		else
+			del_timer(&grp->anatt_timer);
+	}
 	nvme_kick_requeue_lists(ctrl);
 }
 
+void nvme_anatt_timedout(struct timer_list *t)
+{
+	struct nvme_ana_group *grp = from_timer(grp, t, anatt_timer);
+
+	if (grp->ctrl->state != NVME_CTRL_LIVE)
+		return;
+	dev_info(grp->ctrl->device, "ANA group %d: ANATT timeout, resetting\n",
+		 grp->grpid);
+	nvme_reset_ctrl(grp->ctrl);
+}
+
+void nvme_stop_anatt(struct nvme_ctrl *ctrl)
+{
+	u32 grpid;
+
+	for (grpid = 0; grpid < ctrl->anagrpmax; grpid++) {
+		struct nvme_ana_group *grp = &ctrl->ana_groups[grpid];
+
+		del_timer(&grp->anatt_timer);
+	}
+}
+
 int nvme_configure_ana(struct nvme_ctrl *ctrl)
 {
 	int error;
+	u32 grpid;
 
 	if (!nvme_ctrl_has_ana(ctrl))
 		return 0;
@@ -422,14 +460,21 @@ int nvme_configure_ana(struct nvme_ctrl *ctrl)
 	}
 
 	INIT_WORK(&ctrl->ana_work, nvme_ana_work);
-	ctrl->ana_state = kcalloc(ctrl->anagrpmax, sizeof(*ctrl->ana_state),
-			GFP_KERNEL);
-	if (!ctrl->ana_state)
+	ctrl->ana_groups = kcalloc(ctrl->anagrpmax, sizeof(*ctrl->ana_groups),
+				   GFP_KERNEL);
+	if (!ctrl->ana_groups)
 		return -ENOMEM;
 
+	for (grpid = 1; grpid < ctrl->anagrpmax; grpid++) {
+		struct nvme_ana_group *grp = &ctrl->ana_groups[grpid];
+		grp->grpid = grpid;
+		grp->ctrl = ctrl;
+		timer_setup(&grp->anatt_timer, nvme_anatt_timedout, 0);
+	}
+
 	ctrl->ana_log_buf = kmalloc(ctrl->ana_log_size, GFP_KERNEL);
 	if (!ctrl->ana_log_buf)
-		goto out_free_ana_state;
+		goto out_free_ana_groups;
 
 	error = nvme_process_ana_log(ctrl, true);
 	if (error)
@@ -437,15 +482,16 @@ int nvme_configure_ana(struct nvme_ctrl *ctrl)
 	return 0;
 out_free_ana_log_buf:
 	kfree(ctrl->ana_log_buf);
-out_free_ana_state:
-	kfree(ctrl->ana_state);
+out_free_ana_groups:
+	kfree(ctrl->ana_groups);
 	return -ENOMEM;
 }
 
 void nvme_deconfigure_ana(struct nvme_ctrl *ctrl)
 {
+	nvme_stop_anatt(ctrl);
 	kfree(ctrl->ana_log_buf);
-	kfree(ctrl->ana_state);
+	kfree(ctrl->ana_groups);
 }
 
 static ssize_t ana_grpid_show(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index be2585576bad..7d909d1f4843 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -119,6 +119,13 @@ static inline struct nvme_request *nvme_req(struct request *req)
 	return blk_mq_rq_to_pdu(req);
 }
 
+struct nvme_ana_group {
+	u32 grpid;
+	struct nvme_ctrl *ctrl;
+	enum nvme_ana_state state;
+	struct timer_list anatt_timer;
+};
+
 /* The below value is the specific amount of delay needed before checking
  * readiness in case of the PCI_DEVICE(0x1c58, 0x0003), which needs the
  * NVME_QUIRK_DELAY_BEFORE_CHK_RDY quirk enabled. The value (in ms) was
@@ -200,9 +207,10 @@ struct nvme_ctrl {
 
 	/* asymmetric namespace access: */
 	u8 anacap;
+	u8 anatt;
 	u32 anagrpmax;
 	u32 nanagrpid;
-	enum nvme_ana_state *ana_state;
+	struct nvme_ana_group *ana_groups;
 	size_t ana_log_size;
 	struct nvme_ana_rsp_hdr *ana_log_buf;
 	struct work_struct ana_work;
@@ -469,6 +477,7 @@ void nvme_mpath_add_disk(struct nvme_ns *ns);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 int nvme_configure_ana(struct nvme_ctrl *ctrl);
 void nvme_deconfigure_ana(struct nvme_ctrl *ctrl);
+void nvme_stop_anatt(struct nvme_ctrl *ctrl);
 
 static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
@@ -531,6 +540,9 @@ static inline int nvme_configure_ana(struct nvme_ctrl *ctrl)
 static inline void nvme_deconfigure_ana(struct nvme_ctrl *ctrl)
 {
 }
+static inline void nvme_stop_anatt(struct nvme_ctrl *ctrl)
+{
+}
 #endif /* CONFIG_NVME_MULTIPATH */
 
 #ifdef CONFIG_NVM
-- 
2.12.3
