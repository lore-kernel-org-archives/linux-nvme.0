From: hch@lst.de (Christoph Hellwig)
Date: Mon, 14 May 2018 09:56:45 +0200
Subject: [PATCH 10/11] nvmet: add minimal ANA support
In-Reply-To: <20180514075646.28823-1-hch@lst.de>
References: <20180514075646.28823-1-hch@lst.de>
Message-ID: <20180514075646.28823-11-hch@lst.de>

Just add a default ANA group 1 that is optimized on all ports.  This is
(and will remain) the default assignment for any namespace not epxlicitly
assigned to another ANA group.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/admin-cmd.c | 80 ++++++++++++++++++++++++++++++++-
 drivers/nvme/target/configfs.c  | 10 +++++
 drivers/nvme/target/core.c      | 17 +++++++
 drivers/nvme/target/io-cmd.c    | 17 +++++++
 drivers/nvme/target/nvmet.h     | 15 +++++++
 5 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index a2fbcef0d2b8..b60a720a1e1b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -118,6 +118,73 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+static u32 nvmet_format_ana_group(struct nvmet_req *req, u32 grpid,
+		struct nvme_ana_group_desc *desc)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_ns *ns;
+	u32 count = 0;
+
+	if (!(req->cmd->get_log_page.lsp & NVME_ANA_LOG_RGO)) {
+		rcu_read_lock();
+		list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link)
+			if (ns->anagrpid == grpid)
+				desc->nsids[count++] = cpu_to_le32(ns->nsid);
+		rcu_read_unlock();
+	}
+
+	desc->grpid = cpu_to_le32(grpid);
+	desc->nnsids = cpu_to_le32(count);
+	desc->chgcnt = cpu_to_le64(nvmet_ana_chgcnt);
+	desc->state = req->port->ana_state[grpid];
+	memset(desc->rsvd17, 0, sizeof(desc->rsvd17));
+	memset(desc->nsids + count, 0,
+		(NVMET_MAX_NAMESPACES - count) * sizeof(__le32));
+
+	return sizeof(struct nvme_ana_group_desc) + count * sizeof(__le32);
+}
+
+static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
+{
+	struct nvme_ana_rsp_hdr hdr = { 0, };
+	struct nvme_ana_group_desc *desc;
+	size_t offset = sizeof(struct nvme_ana_rsp_hdr); /* start beyond hdr */
+	size_t len;
+	u32 grpid;
+	u16 ngrps = 0;
+	u16 status;
+
+	status = NVME_SC_INTERNAL;
+	desc = kmalloc(sizeof(struct nvme_ana_group_desc) +
+			NVMET_MAX_NAMESPACES * sizeof(__le32), GFP_KERNEL);
+	if (!desc)
+		goto out;
+
+	down_read(&nvmet_ana_sem);
+	for (grpid = 1; grpid <= NVMET_MAX_ANAGRPS; grpid++) {
+		if (!nvmet_ana_group_enabled[grpid])
+			continue;
+
+		len = nvmet_format_ana_group(req, grpid, desc);
+		status = nvmet_copy_to_sgl(req, offset, desc, len);
+		if (status)
+			break;
+		offset += len;
+		ngrps++;
+	}
+
+	hdr.chgcnt = cpu_to_le64(nvmet_ana_chgcnt);
+	hdr.ngrps = cpu_to_le16(ngrps);
+	up_read(&nvmet_ana_sem);
+
+	kfree(desc);
+
+	/* copy the header last once we know the information */
+	status = nvmet_copy_to_sgl(req, 0, &hdr, sizeof(hdr));
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
@@ -149,8 +216,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	 * the safest is to leave it as zeroes.
 	 */
 
-	/* we support multiple ports and multiples hosts: */
-	id->cmic = (1 << 0) | (1 << 1);
+	/* we support multiple ports, multiples hosts and ANA: */
+	id->cmic = (1 << 0) | (1 << 1) | (1 << 3);
 
 	/* no limit on data transfer sizes for now */
 	id->mdts = 0;
@@ -218,6 +285,11 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	id->msdbd = ctrl->ops->msdbd;
 
+	id->anacap = (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3) | (1 << 4);
+	id->anatt = 10; /* random value */
+	id->anagrpmax = cpu_to_le32(NVMET_MAX_ANAGRPS);
+	id->nanagrpid = cpu_to_le32(NVMET_MAX_ANAGRPS);
+
 	/*
 	 * Meh, we don't really support any power state.  Fake up the same
 	 * values that qemu does.
@@ -270,6 +342,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	 * controllers, but also with any other user of the block device.
 	 */
 	id->nmic = (1 << 0);
+	id->anagrpid = cpu_to_le32(ns->anagrpid);
 
 	memcpy(&id->nguid, &ns->nguid, sizeof(uuid_le));
 
@@ -538,6 +611,9 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 		case NVME_LOG_SMART:
 			req->execute = nvmet_execute_get_log_page_smart;
 			return 0;
+		case NVME_LOG_ANA:
+			req->execute = nvmet_execute_get_log_page_ana;
+			return 0;
 		}
 		break;
 	case nvme_admin_identify:
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index ad9ff27234b5..7aa5488dc453 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -861,6 +861,7 @@ static void nvmet_port_release(struct config_item *item)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
 
+	kfree(port->ana_state);
 	kfree(port);
 }
 
@@ -896,6 +897,15 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 	if (!port)
 		return ERR_PTR(-ENOMEM);
 
+	port->ana_state = kcalloc(NVMET_MAX_ANAGRPS + 1,
+			sizeof(*port->ana_state), GFP_KERNEL);
+	if (!port->ana_state) {
+		kfree(port);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	port->ana_state[NVMET_DEFAULT_ANA_GRPID] = NVME_ANA_OPTIMIZED;
+
 	INIT_LIST_HEAD(&port->entry);
 	INIT_LIST_HEAD(&port->subsystems);
 	INIT_LIST_HEAD(&port->referrals);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 00109e489429..1ee31cb60f7c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -39,6 +39,10 @@ static DEFINE_IDA(cntlid_ida);
  */
 DECLARE_RWSEM(nvmet_config_sem);
 
+u32 nvmet_ana_group_enabled[NVMET_MAX_ANAGRPS + 1];
+u64 nvmet_ana_chgcnt;
+DECLARE_RWSEM(nvmet_ana_sem);
+
 static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 		const char *subsysnqn);
 
@@ -396,6 +400,10 @@ void nvmet_ns_free(struct nvmet_ns *ns)
 {
 	nvmet_ns_disable(ns);
 
+	down_write(&nvmet_ana_sem);
+	nvmet_ana_group_enabled[ns->anagrpid]--;
+	up_write(&nvmet_ana_sem);
+
 	kfree(ns->device_path);
 	kfree(ns);
 }
@@ -413,6 +421,12 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 
 	ns->nsid = nsid;
 	ns->subsys = subsys;
+
+	down_write(&nvmet_ana_sem);
+	ns->anagrpid = NVMET_DEFAULT_ANA_GRPID;
+	nvmet_ana_group_enabled[ns->anagrpid]++;
+	up_write(&nvmet_ana_sem);
+
 	uuid_gen(&ns->uuid);
 
 	return ns;
@@ -1051,6 +1065,8 @@ static int __init nvmet_init(void)
 {
 	int error;
 
+	nvmet_ana_group_enabled[NVMET_DEFAULT_ANA_GRPID] = 1;
+
 	error = nvmet_init_discovery();
 	if (error)
 		goto out;
@@ -1058,6 +1074,7 @@ static int __init nvmet_init(void)
 	error = nvmet_init_configfs();
 	if (error)
 		goto out_exit_discovery;
+
 	return 0;
 
 out_exit_discovery:
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index cd2344179673..a208b6e4b0e0 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -189,6 +189,20 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
 	}
 }
 
+static u16 nvmet_check_ana_state(struct nvmet_port *port,
+		struct nvmet_ns *ns)
+{
+	enum nvme_ana_state state = port->ana_state[ns->anagrpid];
+
+	if (unlikely(state == NVME_ANA_INACCESSIBLE))
+		return NVME_SC_ANA_INACCESSIBLE;
+	if (unlikely(state == NVME_ANA_PERSISTENT_LOSS))
+		return NVME_SC_ANA_PERSISTENT_LOSS;
+	if (unlikely(state == NVME_ANA_CHANGE))
+		return NVME_SC_ANA_TRANSITION;
+	return 0;
+}
+
 u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
@@ -203,6 +217,9 @@ u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	req->ns = nvmet_find_namespace(req->sq->ctrl, cmd->rw.nsid);
 	if (unlikely(!req->ns))
 		return NVME_SC_INVALID_NS | NVME_SC_DNR;
+	ret = nvmet_check_ana_state(req->port, req->ns);
+	if (unlikely(ret))
+		return ret;
 
 	switch (cmd->common.opcode) {
 	case nvme_cmd_read:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6060247906bb..f8394e61d3b9 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -48,6 +48,7 @@ struct nvmet_ns {
 	loff_t			size;
 	u8			nguid[16];
 	uuid_t			uuid;
+	u32			anagrpid;
 
 	bool			enabled;
 	struct nvmet_subsys	*subsys;
@@ -96,6 +97,7 @@ struct nvmet_port {
 	struct list_head		subsystems;
 	struct config_group		referrals_group;
 	struct list_head		referrals;
+	enum nvme_ana_state		*ana_state;
 	void				*priv;
 	bool				enabled;
 };
@@ -331,6 +333,15 @@ u32 nvmet_get_log_page_len(struct nvme_command *cmd);
  */
 #define NVMET_MAX_NAMESPACES	1024
 
+/*
+ * 0 is not a valid ANA group ID, so we start numbering at 1.
+ *
+ * ANA Group 1 exists without manual intervention, has namespaces assigned to it
+ * by default, and is available in an optimized state through all ports.
+ */
+#define NVMET_MAX_ANAGRPS	1
+#define NVMET_DEFAULT_ANA_GRPID	1
+
 #define NVMET_KAS		10
 #define NVMET_DISC_KATO		120
 
@@ -344,6 +355,10 @@ extern struct nvmet_subsys *nvmet_disc_subsys;
 extern u64 nvmet_genctr;
 extern struct rw_semaphore nvmet_config_sem;
 
+extern u32 nvmet_ana_group_enabled[NVMET_MAX_ANAGRPS + 1];
+extern u64 nvmet_ana_chgcnt;
+extern struct rw_semaphore nvmet_ana_sem;
+
 bool nvmet_host_allowed(struct nvmet_req *req, struct nvmet_subsys *subsys,
 		const char *hostnqn);
 
-- 
2.17.0
