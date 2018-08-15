From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 15 Aug 2018 15:58:51 -0400
Subject: [PATCH V4 6/9] nvmet: integrate passthru code with core
In-Reply-To: <20180815195854.15449-1-chaitanya.kulkarni@wdc.com>
References: <20180815195854.15449-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180815195854.15449-7-chaitanya.kulkarni@wdc.com>

This patch integrates the passthru command code with NVMeOF target
core. As we integrate the passthru code with target core, it exports
APIs to enable/disable passthru ctrl via configfs.

Here we also make sure none of the target-ns belongs to the passthru-ctrl
and none of the existing subsystems is configured with this passthru-ctrl.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c  | 180 +++++++++++++++++++++++++++++++++++++++++---
 drivers/nvme/target/nvmet.h |   4 +
 2 files changed, 175 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ada700cce2d2..98ca0e5f20a1 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -369,11 +369,66 @@ static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
 	nvmet_file_ns_disable(ns);
 }
 
+static int nvmet_pt_ns(struct nvme_ctrl *ctrl, char *disk_name)
+{
+	struct nvme_ns *ns;
+	int ret = 0;
+
+	if (!disk_name)
+		return -EINVAL;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (!strcmp(ns->disk->disk_name, disk_name)) {
+			ret = -EINVAL;
+			break;
+		}
+	}
+	up_read(&ctrl->namespaces_rwsem);
+	return ret;
+}
+
+static int nvmet_ns_device_path_allow(struct nvmet_ns *ns)
+{
+	struct nvmet_subsys *s = ns->subsys;
+	char *dev_file;
+	int ret = 0;
+
+	mutex_lock(&nvmet_subsystems_lock);
+	list_for_each_entry(s, &nvmet_subsystems, entry) {
+		kref_get(&s->ref);
+		mutex_unlock(&nvmet_subsystems_lock);
+		mutex_lock(&s->lock);
+		if (s->pt_ctrl) {
+			dev_file = strrchr(ns->device_path, '/');
+			dev_file++;
+			if (nvmet_pt_ns(s->pt_ctrl, dev_file)) {
+				pr_err("%s ns belongs to passthru ctrl\n",
+						ns->device_path);
+				ret = -EINVAL;
+				mutex_unlock(&s->lock);
+				mutex_lock(&nvmet_subsystems_lock);
+				nvmet_subsys_put(s);
+				break;
+			}
+		}
+		mutex_unlock(&s->lock);
+		mutex_lock(&nvmet_subsystems_lock);
+		nvmet_subsys_put(s);
+	}
+	mutex_unlock(&nvmet_subsystems_lock);
+	return ret;
+}
+
 int nvmet_ns_enable(struct nvmet_ns *ns)
 {
 	struct nvmet_subsys *subsys = ns->subsys;
 	int ret;
 
+	ret = nvmet_ns_device_path_allow(ns);
+	if (ret)
+		goto out;
+
 	mutex_lock(&subsys->lock);
 	ret = -EMFILE;
 	if (subsys->nr_namespaces == NVMET_MAX_NAMESPACES)
@@ -420,6 +475,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	ret = 0;
 out_unlock:
 	mutex_unlock(&subsys->lock);
+out:
 	return ret;
 out_dev_put:
 	nvmet_ns_dev_disable(ns);
@@ -498,6 +554,77 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	return ns;
 }
 
+int nvmet_pt_ctrl_enable(struct nvmet_subsys *subsys)
+{
+	struct nvmet_subsys *s;
+	struct nvmet_ns *tns;
+	char *pt_ctrl_path;
+	char *dev_file;
+	int ret = 0;
+
+	if (!subsys)
+		return -ENODEV;
+
+	if (subsys->pt_ctrl)
+		return -EINVAL;
+
+	pt_ctrl_path = subsys->pt_ctrl_path;
+	if (nvme_get_ctrl_by_path(pt_ctrl_path, &subsys->pt_ctrl)) {
+		pr_err("unable to find passthru ctrl '%s'\n", pt_ctrl_path);
+		return -ENODEV;
+	}
+
+	mutex_lock(&nvmet_subsystems_lock);
+	list_for_each_entry(s, &nvmet_subsystems, entry) {
+		/* skip current subsys */
+		if (!strcmp(s->subsysnqn, subsys->subsysnqn))
+			continue;
+
+		kref_get(&s->ref);
+		mutex_unlock(&nvmet_subsystems_lock);
+		/* check if this pt ctrl is alredy belongs to other subsys */
+		if (s->pt_ctrl && !strcmp(s->pt_ctrl_path, pt_ctrl_path)) {
+			ret = -EINVAL;
+			pr_err("pt ctrl %s is associated with subsys %s\n",
+					subsys->pt_ctrl_path, subsys->subsysnqn);
+			goto out;
+		}
+		/* check if any target ns is present on pt ctrl's ns list */
+		mutex_lock(&s->lock);
+		list_for_each_entry(tns, &s->namespaces, dev_link) {
+			dev_file = strrchr(tns->device_path, '/');
+			dev_file++;
+			if (nvmet_pt_ns(subsys->pt_ctrl, dev_file)) {
+				ret = -EINVAL;
+				pr_err("ns conflict passthru enable failed\n");
+				break;
+			}
+		}
+		mutex_unlock(&s->lock);
+out:
+		mutex_lock(&nvmet_subsystems_lock);
+		nvmet_subsys_put(s);
+		if (ret)
+			break;
+
+	}
+	mutex_unlock(&nvmet_subsystems_lock);
+	if (ret) {
+		nvmet_pt_ctrl_disable(subsys);
+		kfree(subsys->pt_ctrl_path);
+		subsys->pt_ctrl_path = NULL;
+	}
+	return ret;
+}
+
+void nvmet_pt_ctrl_disable(struct nvmet_subsys *subsys)
+{
+	if (!subsys || !subsys->pt_ctrl)
+		return;
+
+	nvme_put_ctrl_by_path(subsys->pt_ctrl);
+	subsys->pt_ctrl = NULL;
+}
 static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 {
 	u32 old_sqhd, new_sqhd;
@@ -687,6 +814,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	if (unlikely(!req->sq->ctrl))
 		/* will return an error for any Non-connect command: */
 		status = nvmet_parse_connect_cmd(req);
+	else if (nvmet_pt_cmd_allow(req))
+		status = nvmet_pt_parse_pt_cmd(req);
 	else if (likely(req->sq->qid != 0))
 		status = nvmet_parse_io_cmd(req);
 	else if (req->cmd->common.opcode == nvme_fabrics_command)
@@ -722,7 +851,16 @@ EXPORT_SYMBOL_GPL(nvmet_req_uninit);
 
 void nvmet_req_execute(struct nvmet_req *req)
 {
-	if (unlikely(req->data_len != req->transfer_len))
+	/*
+	 * Right now data_len is calculated before the transfer len
+	 * after we parse the command, With passthru interface
+	 * we allow VUC's. In order to make the code simple and compact,
+	 * instead of assinging the the dala len for each VUC in the command
+	 * parse function just use the transfer len as it is. This may
+	 * result is error if expected data_len != transfer_len.
+	 */
+	if (!(req->sq->ctrl && req->sq->ctrl->subsys->pt_ctrl) &&
+			unlikely(req->data_len != req->transfer_len))
 		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR);
 	else
 		req->execute(req);
@@ -943,6 +1081,19 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	}
 
 	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+	/*
+	 * Check here if this subsystem is already connected to the
+	 * passthru ctrl. We allow only one target ctrl for one passthru
+	 * subsystem.
+	 */
+	mutex_lock(&subsys->lock);
+	if (subsys->pt_ctrl) {
+		if (subsys->pt_connected == true) {
+			mutex_unlock(&subsys->lock);
+			goto out_put_subsystem;
+		}
+	}
+	mutex_unlock(&subsys->lock);
 	down_read(&nvmet_config_sem);
 	if (!nvmet_host_allowed(req, subsys, hostnqn)) {
 		pr_info("connect by host %s for subsystem %s not allowed\n",
@@ -991,12 +1142,16 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (!ctrl->sqs)
 		goto out_free_cqs;
 
-	ret = ida_simple_get(&cntlid_ida,
-			     NVME_CNTLID_MIN, NVME_CNTLID_MAX,
-			     GFP_KERNEL);
-	if (ret < 0) {
-		status = NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
-		goto out_free_sqs;
+	if (subsys->pt_ctrl)
+		ret = subsys->pt_ctrl->cntlid;
+	else {
+		ret = ida_simple_get(&cntlid_ida,
+				NVME_CNTLID_MIN, NVME_CNTLID_MAX,
+				GFP_KERNEL);
+		if (ret < 0) {
+			status = NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
+			goto out_free_sqs;
+		}
 	}
 	ctrl->cntlid = ret;
 
@@ -1030,13 +1185,16 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 
 	mutex_lock(&subsys->lock);
 	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
+	if (subsys->pt_ctrl && subsys->pt_connected == false)
+		subsys->pt_connected = true;
 	mutex_unlock(&subsys->lock);
 
 	*ctrlp = ctrl;
 	return 0;
 
 out_remove_ida:
-	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
+	if (!subsys->pt_ctrl)
+		ida_simple_remove(&cntlid_ida, ctrl->cntlid);
 out_free_sqs:
 	kfree(ctrl->sqs);
 out_free_cqs:
@@ -1057,6 +1215,8 @@ static void nvmet_ctrl_free(struct kref *ref)
 	struct nvmet_subsys *subsys = ctrl->subsys;
 
 	mutex_lock(&subsys->lock);
+	if (subsys->pt_ctrl && subsys->pt_connected == true)
+		subsys->pt_connected = false;
 	list_del(&ctrl->subsys_entry);
 	mutex_unlock(&subsys->lock);
 
@@ -1065,7 +1225,8 @@ static void nvmet_ctrl_free(struct kref *ref)
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fatal_err_work);
 
-	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
+	if (!subsys->pt_ctrl)
+		ida_simple_remove(&cntlid_ida, ctrl->cntlid);
 
 	kfree(ctrl->sqs);
 	kfree(ctrl->cqs);
@@ -1189,6 +1350,7 @@ static void nvmet_subsys_free(struct kref *ref)
 	list_del(&subsys->entry);
 	mutex_unlock(&nvmet_subsystems_lock);
 
+	kfree(subsys->pt_ctrl_path);
 	kfree(subsys->subsysnqn);
 	kfree(subsys);
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 5975839d2b7c..c2712392bb33 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -216,6 +216,8 @@ struct nvmet_subsys {
 
 	struct list_head	entry;
 
+	bool			pt_connected;
+	char			*pt_ctrl_path;
 	struct nvme_ctrl	*pt_ctrl;
 };
 
@@ -446,6 +448,8 @@ u16 nvmet_bdev_flush(struct nvmet_req *req);
 u16 nvmet_file_flush(struct nvmet_req *req);
 void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
 bool nvmet_pt_cmd_allow(struct nvmet_req *req);
+int nvmet_pt_ctrl_enable(struct nvmet_subsys *subsys);
+void nvmet_pt_ctrl_disable(struct nvmet_subsys *subsys);
 
 static inline u32 nvmet_rw_len(struct nvmet_req *req)
 {
-- 
2.14.1
