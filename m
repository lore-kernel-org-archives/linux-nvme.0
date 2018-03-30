From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 30 Mar 2018 02:57:46 -0400
Subject: [RFC PATCH 7/8] nvmet: integrate passthru code with target core
In-Reply-To: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180330065747.20962-8-chaitanya.kulkarni@wdc.com>

This patch integrates passthru code with target core, it
exports APIs to enable/disable passthru ctrl via configfs.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c  | 47 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h |  2 ++
 2 files changed, 49 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 406fc4ca9768..2dad36666772 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -400,6 +400,29 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	return ns;
 }
 
+int nvmet_pt_ctrl_enable(struct nvmet_subsys *subsys)
+{
+	if (!subsys)
+		return -ENODEV;
+
+	if (nvme_get_ctrl_by_name(subsys->pt_ctrl_path, &subsys->pt_ctrl)) {
+		pr_err("unable to find passthru ctrl' %s'\n",
+				subsys->pt_ctrl_path);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+void nvmet_pt_ctrl_disable(struct nvmet_subsys *subsys)
+{
+	if (!subsys || !subsys->pt_ctrl)
+		return;
+
+	nvme_put_ctrl_by_name(subsys->pt_ctrl);
+	subsys->pt_ctrl = NULL;
+}
+
 static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 {
 	u32 old_sqhd, new_sqhd;
@@ -501,6 +524,14 @@ int nvmet_sq_init(struct nvmet_sq *sq)
 }
 EXPORT_SYMBOL_GPL(nvmet_sq_init);
 
+static bool nvmet_ctrl_pt_allow(struct nvmet_req *req)
+{
+	if (req->sq->ctrl && !req->sq->ctrl->subsys->pt_ctrl)
+		return false;
+
+	return nvmet_is_pt_cmd_supported(req);
+}
+
 bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 		struct nvmet_sq *sq, struct nvmet_fabrics_ops *ops)
 {
@@ -535,6 +566,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	if (unlikely(!req->sq->ctrl))
 		/* will return an error for any Non-connect command: */
 		status = nvmet_parse_connect_cmd(req);
+	else if (nvmet_ctrl_pt_allow(req))
+		status = nvmet_parse_pt_cmd(req);
 	else if (likely(req->sq->qid != 0))
 		status = nvmet_parse_io_cmd(req);
 	else if (req->cmd->common.opcode == nvme_fabrics_command)
@@ -570,6 +603,19 @@ EXPORT_SYMBOL_GPL(nvmet_req_uninit);
 
 void nvmet_req_execute(struct nvmet_req *req)
 {
+	/*
+	 * Right now data_len is calculated before the transfer len
+	 * after we parse the command, With passthru interface
+	 * we allow VUC's. In order to make the code simple and compact,
+	 * instead of assinging the the dala len for each VUC in the command
+	 * parse function just use the transfer len as it is. This may
+	 * result is error if expected data_len != transfer_len.
+	 */
+	if (req->sq->ctrl && req->sq->ctrl->subsys->pt_ctrl) {
+		req->execute(req);
+		return;
+	}
+
 	if (unlikely(req->data_len != req->transfer_len))
 		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR);
 	else
@@ -1010,6 +1056,7 @@ static void nvmet_subsys_free(struct kref *ref)
 
 	WARN_ON_ONCE(!list_empty(&subsys->namespaces));
 
+	kfree(subsys->pt_ctrl_path);
 	kfree(subsys->subsysnqn);
 	kfree(subsys);
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 1495e6df84a7..f2d694fffa1c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -350,5 +350,7 @@ extern struct rw_semaphore nvmet_config_sem;
 bool nvmet_host_allowed(struct nvmet_req *req, struct nvmet_subsys *subsys,
 		const char *hostnqn);
 
+int nvmet_pt_ctrl_enable(struct nvmet_subsys *subsys);
+void nvmet_pt_ctrl_disable(struct nvmet_subsys *subsys);
 bool nvmet_is_pt_cmd_supported(struct nvmet_req *req);
 #endif /* _NVMET_H */
-- 
2.14.1
