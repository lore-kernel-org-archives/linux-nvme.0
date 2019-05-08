From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed,  8 May 2019 14:41:28 -0700
Subject: [RFC PATCH] nvme: guard ctrl->state by lock
Message-ID: <20190508214128.20620-1-chaitanya.kulkarni@wdc.com>

This patch adds a helper function to check the nvme_ctrl state.
This helper function uses controller lock when accessing ctrl->state
member which is guarded in the nvme_change_ctrl_state().

This RFC is light on the details, if this change is acceptable I'd
like to send the detailed tested version.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/core.c      | 80 ++++++++++++++++++++++++++++-------
 drivers/nvme/host/fabrics.c   |  4 +-
 drivers/nvme/host/fabrics.h   |  8 ++--
 drivers/nvme/host/multipath.c |  6 +--
 drivers/nvme/host/nvme.h      |  1 +
 5 files changed, 74 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index afd303489473..5182ce9fe21b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -94,6 +94,57 @@ static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
 
+inline bool nvme_validate_ctrl_state(enum nvme_ctrl_state s)
+{
+	int ret;
+
+	switch (s) {
+	case NVME_CTRL_NEW:
+		ret = true;
+		break;
+	case NVME_CTRL_LIVE:
+		ret = true;
+		break;
+	case NVME_CTRL_ADMIN_ONLY:
+		ret = true;
+		break;
+	case NVME_CTRL_RESETTING:
+		ret = true;
+		break;
+	case NVME_CTRL_CONNECTING:
+		ret = true;
+		break;
+	case NVME_CTRL_DELETING:
+		ret = true;
+		break;
+	case NVME_CTRL_DEAD:
+		break;
+	default:
+		ret = false;
+	}
+	return ret;
+}
+
+bool nvme_check_ctrl_state(struct nvme_ctrl *c, enum nvme_ctrl_state state)
+{
+	bool ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&c->lock, flags);
+
+	if (!nvme_validate_ctrl_state(state)) {
+		ret = false;
+		goto out_unlock;
+	}
+
+	ret = c->state == state ? true : false;
+
+out_unlock:
+	spin_unlock_irqrestore(&c->lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_check_ctrl_state);
+
 static void nvme_set_queue_dying(struct nvme_ns *ns)
 {
 	/*
@@ -113,7 +164,8 @@ static void nvme_queue_scan(struct nvme_ctrl *ctrl)
 	/*
 	 * Only new queue scan work when admin and IO queues are both alive
 	 */
-	if (ctrl->state == NVME_CTRL_LIVE)
+
+	if (nvme_check_ctrl_state(ctrl, NVME_CTRL_LIVE))
 		queue_work(nvme_wq, &ctrl->scan_work);
 }
 
@@ -134,8 +186,8 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
 	ret = nvme_reset_ctrl(ctrl);
 	if (!ret) {
 		flush_work(&ctrl->reset_work);
-		if (ctrl->state != NVME_CTRL_LIVE &&
-		    ctrl->state != NVME_CTRL_ADMIN_ONLY)
+		if (!nvme_check_ctrl_state(ctrl, NVME_CTRL_LIVE) &&
+		    !nvme_check_ctrl_state(ctrl, NVME_CTRL_ADMIN_ONLY))
 			ret = -ENETRESET;
 	}
 
@@ -2405,8 +2457,8 @@ static int nvme_active_ctrls(struct nvme_subsystem *subsys)
 
 	mutex_lock(&subsys->lock);
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
-		if (ctrl->state != NVME_CTRL_DELETING &&
-		    ctrl->state != NVME_CTRL_DEAD)
+		if (!nvme_check_ctrl_state(ctrl, NVME_CTRL_DELETING) &&
+		    !nvme_check_ctrl_state(ctrl, NVME_CTRL_DEAD))
 			count++;
 	}
 	mutex_unlock(&subsys->lock);
@@ -2727,13 +2779,9 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 	struct nvme_ctrl *ctrl =
 		container_of(inode->i_cdev, struct nvme_ctrl, cdev);
 
-	switch (ctrl->state) {
-	case NVME_CTRL_LIVE:
-	case NVME_CTRL_ADMIN_ONLY:
-		break;
-	default:
-		return -EWOULDBLOCK;
-	}
+	if (!nvme_check_ctrl_state(ctrl, NVME_CTRL_LIVE) &&
+	    !nvme_check_ctrl_state(ctrl, NVME_CTRL_ADMIN_ONLY))
+		return EWOULDBLOCK;
 
 	file->private_data = ctrl;
 	return 0;
@@ -3026,7 +3074,7 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 		[NVME_CTRL_DEAD]	= "dead",
 	};
 
-	if ((unsigned)ctrl->state < ARRAY_SIZE(state_name) &&
+	if (nvme_validate_ctrl_state(ctrl->state) &&
 	    state_name[ctrl->state])
 		return sprintf(buf, "%s\n", state_name[ctrl->state]);
 
@@ -3511,7 +3559,7 @@ static void nvme_scan_work(struct work_struct *work)
 	struct nvme_id_ctrl *id;
 	unsigned nn;
 
-	if (ctrl->state != NVME_CTRL_LIVE)
+	if (!nvme_check_ctrl_state(ctrl, NVME_CTRL_LIVE))
 		return;
 
 	WARN_ON_ONCE(!ctrl->tagset);
@@ -3559,7 +3607,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 * removing the namespaces' disks; fail all the queues now to avoid
 	 * potentially having to clean up the failed sync later.
 	 */
-	if (ctrl->state == NVME_CTRL_DEAD)
+	if (nvme_check_ctrl_state(ctrl, NVME_CTRL_DEAD))
 		nvme_kill_queues(ctrl);
 
 	down_write(&ctrl->namespaces_rwsem);
@@ -3648,7 +3696,7 @@ static void nvme_fw_act_work(struct work_struct *work)
 		msleep(100);
 	}
 
-	if (ctrl->state != NVME_CTRL_LIVE)
+	if (!nvme_check_ctrl_state(ctrl, NVME_CTRL_LIVE))
 		return;
 
 	nvme_start_queues(ctrl);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 592d1e61ef7e..9fb3ee01d964 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -547,8 +547,8 @@ static struct nvmf_transport_ops *nvmf_lookup_transport(
 blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
 		struct request *rq)
 {
-	if (ctrl->state != NVME_CTRL_DELETING &&
-	    ctrl->state != NVME_CTRL_DEAD &&
+	if (!nvme_check_ctrl_state(ctrl, NVME_CTRL_DELETING) &&
+	    !nvme_check_ctrl_state(ctrl, NVME_CTRL_DEAD) &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;
 
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 3044d8b99a24..98bf803a7a03 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -149,8 +149,8 @@ static inline bool
 nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
 			struct nvmf_ctrl_options *opts)
 {
-	if (ctrl->state == NVME_CTRL_DELETING ||
-	    ctrl->state == NVME_CTRL_DEAD ||
+	if (nvme_check_ctrl_state(ctrl, NVME_CTRL_DELETING) ||
+	    nvme_check_ctrl_state(ctrl, NVME_CTRL_DEAD) ||
 	    strcmp(opts->subsysnqn, ctrl->opts->subsysnqn) ||
 	    strcmp(opts->host->nqn, ctrl->opts->host->nqn) ||
 	    memcmp(&opts->host->id, &ctrl->opts->host->id, sizeof(uuid_t)))
@@ -179,8 +179,8 @@ bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 static inline bool nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 		bool queue_live)
 {
-	if (likely(ctrl->state == NVME_CTRL_LIVE ||
-		   ctrl->state == NVME_CTRL_ADMIN_ONLY))
+	if (likely(nvme_check_ctrl_state(ctrl, NVME_CTRL_LIVE) ||
+		   nvme_check_ctrl_state(ctrl, NVME_CTRL_ADMIN_ONLY)))
 		return true;
 	return __nvmf_check_ready(ctrl, rq, queue_live);
 }
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 499acf07d61a..6fff3b195ec5 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -129,7 +129,7 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 	struct nvme_ns *found = NULL, *fallback = NULL, *ns;
 
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
-		if (ns->ctrl->state != NVME_CTRL_LIVE ||
+		if (!nvme_check_ctrl_state(ns->ctrl, NVME_CTRL_LIVE) ||
 		    test_bit(NVME_NS_ANA_PENDING, &ns->flags))
 			continue;
 
@@ -184,7 +184,7 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 	for (ns = nvme_next_ns(head, old);
 	     ns != old;
 	     ns = nvme_next_ns(head, ns)) {
-		if (ns->ctrl->state != NVME_CTRL_LIVE ||
+		if (!nvme_check_ctrl_state(ns->ctrl, NVME_CTRL_LIVE) ||
 		    test_bit(NVME_NS_ANA_PENDING, &ns->flags))
 			continue;
 
@@ -206,7 +206,7 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 
 static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 {
-	return ns->ctrl->state == NVME_CTRL_LIVE &&
+	return nvme_check_ctrl_state(ns->ctrl, NVME_CTRL_LIVE) &&
 		ns->ana_state == NVME_ANA_OPTIMIZED;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5ee75b5ff83f..0d7aaef91489 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -469,6 +469,7 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
 
 extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct block_device_operations nvme_ns_head_ops;
+bool nvme_check_ctrl_state(struct nvme_ctrl *c, enum nvme_ctrl_state state);
 
 #ifdef CONFIG_NVME_MULTIPATH
 bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl);
-- 
2.17.0
