From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 12 Jun 2018 15:55:05 -0400
Subject: [PATCH V3 7/8] nvmet: integrate passthru code with core
In-Reply-To: <20180612195506.23616-1-chaitanya.kulkarni@wdc.com>
References: <20180612195506.23616-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180612195506.23616-8-chaitanya.kulkarni@wdc.com>

This patch adds passthru command handling capability for
the NVMeOF target and exports passthru APIs which are used
to integrate passthru code with nvmet-core.
We add passthru ns member to the target request to hold the
ns reference for respective commands.
The new file passthru-cmd.c handles passthru cmd parsing and
execution. In the passthru mode create a block layer request
from the nvmet request and map the data on block layer request.
For handling the side effects we add two functions similar
to the passthru functions present in the nvme-core.
We explicitly blacklist the commands at the time of parsing,
which allows us to route the fabric commands through default
code path.

Also as we integrate passthru code with target core, it
exports APIs to enable/disable passthru ctrl via configfs.

We make sure for each passthru subsystem only one target
ctrl is created. In order to achieve that we add guards
for passthru subsystem configuration and nvmet_ns configuration
via configfs.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c  | 175 ++++++++++++++++++++++++++++++++++--
 drivers/nvme/target/nvmet.h |   4 +
 2 files changed, 170 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 067672520369..0d27eecae85e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -334,11 +334,63 @@ static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
 	nvmet_file_ns_disable(ns);
 }
 
+static int nvmet_pt_ns(struct nvme_ctrl *ctrl, char *disk_name)
+{
+	int ret = 0;
+	struct nvme_ns *ns;
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
+
+	return ret;
+}
+
+static int nvmet_ns_device_path_allow(struct nvmet_ns *ns)
+{
+	int ret = 0;
+	char *dev_file;
+	struct nvmet_subsys *s = ns->subsys;
+
+	mutex_lock(&nvmet_subsystems_lock);
+	list_for_each_entry(s, &nvmet_subsystems, entry) {
+		mutex_lock(&s->lock);
+		if (s->pt_ctrl) {
+			dev_file = strrchr(ns->device_path, '/');
+			dev_file++;
+			if (nvmet_pt_ns(s->pt_ctrl, dev_file)) {
+				pr_err("%s ns belongs to passthru ctrl\n",
+						ns->device_path);
+				ret = -EINVAL;
+				mutex_unlock(&s->lock);
+				break;
+			}
+		}
+		mutex_unlock(&s->lock);
+	}
+	mutex_unlock(&nvmet_subsystems_lock);
+
+	return ret;
+}
+
+
 int nvmet_ns_enable(struct nvmet_ns *ns)
 {
 	struct nvmet_subsys *subsys = ns->subsys;
 	int ret = 0;
 
+	ret = nvmet_ns_device_path_allow(ns);
+	if (ret)
+		goto out;
+
 	mutex_lock(&subsys->lock);
 	if (ns->enabled)
 		goto out_unlock;
@@ -380,6 +432,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	ret = 0;
 out_unlock:
 	mutex_unlock(&subsys->lock);
+out:
 	return ret;
 out_dev_put:
 	nvmet_ns_dev_disable(ns);
@@ -446,6 +499,72 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	return ns;
 }
 
+int nvmet_pt_ctrl_enable(struct nvmet_subsys *subsys)
+{
+	int ret = 0;
+	char *dev_file;
+	char *pt_ctrl_path;
+	struct nvmet_ns *tns;
+	struct nvmet_subsys *s;
+
+	if (!subsys)
+		return -ENODEV;
+
+	if (subsys->pt_ctrl)
+		return -EINVAL;
+
+	pt_ctrl_path = subsys->pt_ctrl_path;
+	if (nvme_get_ctrl_by_path(pt_ctrl_path, &subsys->pt_ctrl)) {
+		pr_err("unable to find passthru ctrl' %s'\n", pt_ctrl_path);
+		return -ENODEV;
+	}
+
+	mutex_lock(&nvmet_subsystems_lock);
+	list_for_each_entry(s, &nvmet_subsystems, entry) {
+		/* skip current subsys */
+		if (!strcmp(s->subsysnqn, subsys->subsysnqn))
+			continue;
+
+		/* this pt ctrl is alredy belongs to other subsys */
+		if (s->pt_ctrl && !strcmp(s->pt_ctrl_path, pt_ctrl_path)) {
+			ret = -EINVAL;
+			pr_err("pt ctrl %s is associated with subsys %s\n",
+				subsys->pt_ctrl_path, subsys->subsysnqn);
+			break;
+		}
+		mutex_lock(&s->lock);
+		/* check if any target ns is present on pt ctrl's ns list */
+		list_for_each_entry_rcu(tns, &s->namespaces, dev_link) {
+			dev_file = strrchr(tns->device_path, '/');
+			dev_file++;
+			if (nvmet_pt_ns(subsys->pt_ctrl, dev_file)) {
+				ret = -EINVAL;
+				pr_err("ns conflict passthru enable failed\n");
+				break;
+			}
+		}
+		mutex_unlock(&s->lock);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&nvmet_subsystems_lock);
+
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
@@ -600,6 +719,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	if (unlikely(!req->sq->ctrl))
 		/* will return an error for any Non-connect command: */
 		status = nvmet_parse_connect_cmd(req);
+	else if (nvmet_pt_cmd_allow(req))
+		status = nvmet_pt_parse_pt_cmd(req);
 	else if (likely(req->sq->qid != 0))
 		status = nvmet_parse_io_cmd(req);
 	else if (req->cmd->common.opcode == nvme_fabrics_command)
@@ -635,7 +756,16 @@ EXPORT_SYMBOL_GPL(nvmet_req_uninit);
 
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
@@ -847,6 +977,21 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		goto out;
 	}
 
+	/*
+	 * Check here if this subsystem is already connected to the
+	 * passthru ctrl. We allow only one target ctrl for one passthru
+	 * subsystem.
+	 */
+	mutex_lock(&subsys->lock);
+	if (subsys->pt_ctrl) {
+		if (subsys->pt_connected == false)
+			subsys->pt_connected = true;
+		else {
+			mutex_unlock(&subsys->lock);
+			goto out_put_subsystem;
+		}
+	}
+	mutex_unlock(&subsys->lock);
 	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 	down_read(&nvmet_config_sem);
 	if (!nvmet_host_allowed(req, subsys, hostnqn)) {
@@ -894,13 +1039,18 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
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
+
 	ctrl->cntlid = ret;
 
 	ctrl->ops = req->ops;
@@ -939,7 +1089,8 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	return 0;
 
 out_remove_ida:
-	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
+	if (!subsys->pt_ctrl)
+		ida_simple_remove(&cntlid_ida, ctrl->cntlid);
 out_free_sqs:
 	kfree(ctrl->sqs);
 out_free_cqs:
@@ -968,13 +1119,18 @@ static void nvmet_ctrl_free(struct kref *ref)
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fatal_err_work);
 
-	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
+	if (!subsys->pt_ctrl)
+		ida_simple_remove(&cntlid_ida, ctrl->cntlid);
 
 	kfree(ctrl->sqs);
 	kfree(ctrl->cqs);
 	kfree(ctrl->changed_ns_list);
 	kfree(ctrl);
 
+	mutex_lock(&subsys->lock);
+	if (subsys->pt_ctrl && subsys->pt_connected == true)
+		subsys->pt_connected = false;
+	mutex_unlock(&subsys->lock);
 	nvmet_subsys_put(subsys);
 }
 
@@ -1092,6 +1248,7 @@ static void nvmet_subsys_free(struct kref *ref)
 	list_del(&subsys->entry);
 	mutex_unlock(&nvmet_subsystems_lock);
 
+	kfree(subsys->pt_ctrl_path);
 	kfree(subsys->subsysnqn);
 	kfree(subsys);
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index a716c2db64a0..ea61ff4bc0b7 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -188,6 +188,8 @@ struct nvmet_subsys {
 
 	struct list_head	entry;
 
+	bool			pt_connected;
+	char			*pt_ctrl_path;
 	struct nvme_ctrl	*pt_ctrl;
 };
 
@@ -392,6 +394,8 @@ void nvmet_bdev_ns_disable(struct nvmet_ns *ns);
 void nvmet_file_ns_disable(struct nvmet_ns *ns);
 
 bool nvmet_pt_cmd_allow(struct nvmet_req *req);
+int nvmet_pt_ctrl_enable(struct nvmet_subsys *subsys);
+void nvmet_pt_ctrl_disable(struct nvmet_subsys *subsys);
 
 static inline u32 nvmet_rw_len(struct nvmet_req *req)
 {
-- 
2.17.0
