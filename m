From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  4 Dec 2017 11:24:35 +0200
Subject: [PATCH rfc 2/2] nvmet: expose option to emulate a nvm subsystem in
 read-only mode
In-Reply-To: <20171204092435.20000-1-sagi@grimberg.me>
References: <20171204092435.20000-1-sagi@grimberg.me>
Message-ID: <20171204092435.20000-3-sagi@grimberg.me>

Useful for exercising the host. Also, if a host connects to
a subsystem which is read-only to begin with, queue an AER
to let it know about it.

In read-only state, we fail writes/dsms/write-zeros.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/admin-cmd.c   |  3 +++
 drivers/nvme/target/configfs.c    | 34 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c        |  2 +-
 drivers/nvme/target/fabrics-cmd.c |  3 +++
 drivers/nvme/target/io-cmd.c      |  8 +++++++-
 drivers/nvme/target/nvmet.h       |  3 +++
 6 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6b921c253618..aab646f44a66 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -69,6 +69,9 @@ static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
 
 	ctrl = req->sq->ctrl;
 
+	if(req->sq->ctrl->subsys->read_only)
+		slog->critical_warning |= NVME_SMART_CRIT_MEDIA;
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link) {
 		host_reads += part_stat_read(ns->bdev->bd_part, ios[READ]);
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 8f378030c8e4..c966228439f6 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -711,6 +711,39 @@ static ssize_t nvmet_subsys_attr_allow_any_host_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_subsys_, attr_allow_any_host);
 
+static ssize_t nvmet_subsys_attr_ro_show(struct config_item *item,
+		char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%d\n",
+		to_subsys(item)->read_only);
+}
+
+static ssize_t nvmet_subsys_attr_ro_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	bool subsys_ro = subsys->read_only;
+	bool ro;
+
+	if (strtobool(page, &ro))
+		return -EINVAL;
+
+	subsys->read_only = ro;
+	if ((!subsys_ro && ro) || (subsys_ro && !ro)) {
+		struct nvmet_ctrl *ctrl;
+
+		/* read only state change, send a SMART AER */
+		mutex_lock(&subsys->lock);
+		list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+			nvmet_add_async_event(ctrl, NVME_AER_SMART, 0, 0);
+		mutex_unlock(&subsys->lock);
+	}
+
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_subsys_, attr_ro);
+
 static ssize_t nvmet_subsys_attr_version_show(struct config_item *item,
 					      char *page)
 {
@@ -770,6 +803,7 @@ CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
 
 static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_allow_any_host,
+	&nvmet_subsys_attr_attr_ro,
 	&nvmet_subsys_attr_attr_version,
 	&nvmet_subsys_attr_attr_serial,
 	NULL,
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 841a37dfb987..5b4d30db9776 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -117,7 +117,7 @@ static void nvmet_async_event_work(struct work_struct *work)
 	}
 }
 
-static void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
+void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page)
 {
 	struct nvmet_async_event *aen;
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 62315cc4b5b0..fc9ef44d2b49 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -177,6 +177,9 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
+	if(req->sq->ctrl->subsys->read_only)
+		nvmet_add_async_event(req->sq->ctrl, NVME_AER_SMART, 0, 0);
+
 	pr_info("creating controller %d for subsystem %s for NQN %s.\n",
 		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn);
 	req->rsp->result.u16 = cpu_to_le16(ctrl->cntlid);
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 0a4372a016f2..6f121d2f2ea3 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -202,8 +202,10 @@ u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 		return NVME_SC_INVALID_NS | NVME_SC_DNR;
 
 	switch (cmd->common.opcode) {
-	case nvme_cmd_read:
 	case nvme_cmd_write:
+		if(unlikely(req->sq->ctrl->subsys->read_only))
+			return NVME_SC_READ_ONLY | NVME_SC_DNR;
+	case nvme_cmd_read:
 		req->execute = nvmet_execute_rw;
 		req->data_len = nvmet_rw_len(req);
 		return 0;
@@ -212,11 +214,15 @@ u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 		req->data_len = 0;
 		return 0;
 	case nvme_cmd_dsm:
+		if(unlikely(req->sq->ctrl->subsys->read_only))
+			return NVME_SC_READ_ONLY | NVME_SC_DNR;
 		req->execute = nvmet_execute_dsm;
 		req->data_len = (le32_to_cpu(cmd->dsm.nr) + 1) *
 			sizeof(struct nvme_dsm_range);
 		return 0;
 	case nvme_cmd_write_zeroes:
+		if(unlikely(req->sq->ctrl->subsys->read_only))
+			return NVME_SC_READ_ONLY | NVME_SC_DNR;
 		req->execute = nvmet_execute_write_zeroes;
 		return 0;
 	default:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index d69d948c8f36..a9fb763020b6 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -144,6 +144,7 @@ struct nvmet_ctrl {
 
 struct nvmet_subsys {
 	enum nvme_subsys_type	type;
+	bool			read_only;
 
 	struct mutex		lock;
 	struct kref		ref;
@@ -287,6 +288,8 @@ void nvmet_sq_destroy(struct nvmet_sq *sq);
 int nvmet_sq_init(struct nvmet_sq *sq);
 
 void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl);
+void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
+		u8 event_info, u8 log_page);
 
 void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new);
 u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
-- 
2.14.1
