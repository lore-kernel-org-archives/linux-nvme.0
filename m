From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 26 Jul 2018 19:56:56 -0700
Subject: [PATCH V2 3/3] nvmet: add ns write protect support
In-Reply-To: <20180727025656.9334-1-chaitanya.kulkarni@wdc.com>
References: <20180727025656.9334-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180727025656.9334-4-chaitanya.kulkarni@wdc.com>

This patch implements the Namespace Write Protect feature described in
"NVMe TP 4005a Namespace Write Protect". In this version, we implement
No Write Protect and Write Protect states for target ns which can be
toggled by set-features commands from the host side.

For write-protect state transition, we need to flush the ns specified
as a part of command so we also add helpers for carrying out synchronous
flush operations.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/admin-cmd.c   | 120 +++++++++++++++++++++++++++++-
 drivers/nvme/target/core.c        |   6 +-
 drivers/nvme/target/io-cmd-bdev.c |  12 +++
 drivers/nvme/target/io-cmd-file.c |  15 +++-
 drivers/nvme/target/nvmet.h       |   6 ++
 include/linux/nvme.h              |   2 +-
 6 files changed, 154 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 16a9b24270f9..17fb512d5c21 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -19,6 +19,51 @@
 #include <asm/unaligned.h>
 #include "nvmet.h"
 
+bool nvmet_ns_wp_cmd_allow(struct nvmet_req *req)
+{
+	bool ret = false;
+
+	if (likely(req->sq->qid != 0)) {
+		switch (req->cmd->common.opcode) {
+		case nvme_cmd_read:
+		case nvme_cmd_flush:
+			/* fall thru */
+			ret = true;
+		}
+		return ret;
+	}
+	/*
+	 * Right now we don't have a useful way to check for the allowed admin
+	 * cmds when the ns is write-protected, as we don't have any admin-cmds
+	 * which are operating on the target ns except for write-protect-feat.
+	 * For the completeness keep the valid list of admin cmds from the spec
+	 * here. In future when we add a new cmd or implement a feature
+	 * which operates on a ns and will trigger media change please add this
+	 * call to the code in the appropriate location and update cmd list.
+	 */
+	switch (req->cmd->common.opcode) {
+	case nvme_admin_get_features:
+	case nvme_admin_get_log_page:
+	case nvme_admin_identify:
+	case nvme_admin_ns_attach:
+		/* fall thru */
+		ret = true;
+		break;
+	case nvme_admin_set_features:
+		switch (le32_to_cpu(req->cmd->common.cdw10[0]) && 0xff) {
+		case NVME_FEAT_NUM_QUEUES:
+		case NVME_FEAT_KATO:
+		case NVME_FEAT_ASYNC_EVENT:
+		case NVME_FEAT_HOST_ID:
+		case NVME_FEAT_WRITE_PROTECT:
+			/* fall thru */
+			ret = true;
+		}
+		break;
+	}
+	return ret;
+}
+
 u32 nvmet_get_log_page_len(struct nvme_command *cmd)
 {
 	u32 len = le16_to_cpu(cmd->get_log_page.numdu);
@@ -140,7 +185,7 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	log->acs[nvme_admin_get_log_page]	= cpu_to_le32(1 << 0);
 	log->acs[nvme_admin_identify]		= cpu_to_le32(1 << 0);
 	log->acs[nvme_admin_abort_cmd]		= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_set_features]	= cpu_to_le32(1 << 0);
+	log->acs[nvme_admin_set_features]       = cpu_to_le32(1 << 0);
 	log->acs[nvme_admin_get_features]	= cpu_to_le32(1 << 0);
 	log->acs[nvme_admin_async_event]	= cpu_to_le32(1 << 0);
 	log->acs[nvme_admin_keep_alive]		= cpu_to_le32(1 << 0);
@@ -289,6 +334,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->psd[0].entry_lat = cpu_to_le32(0x10);
 	id->psd[0].exit_lat = cpu_to_le32(0x4);
 
+	id->nwpc = 1 << 0; /* write protect and no write protect */
+
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 
 	kfree(id);
@@ -341,7 +388,8 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	memcpy(&id->nguid, &ns->nguid, sizeof(id->nguid));
 
 	id->lbaf[0].ds = ns->blksize_shift;
-
+	if (ns->readonly)
+		id->nsattr |= (1 << 0);
 	nvmet_put_namespace(ns);
 done:
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
@@ -454,6 +502,57 @@ static void nvmet_execute_abort(struct nvmet_req *req)
 	nvmet_req_complete(req, 0);
 }
 
+static u16 nvmet_write_protect_flush_sync(struct nvmet_req *req)
+{
+	u16 status;
+
+	status = req->ns->file ? nvmet_file_flush(req) : nvmet_bdev_flush(req);
+
+	if (status) {
+		pr_err("write protect flush failed nsid: %u\n", req->ns->nsid);
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+	}
+	return status;
+}
+
+static u16 nvmet_feat_write_protect(struct nvmet_req *req)
+{
+	u32 write_protect = le32_to_cpu(req->cmd->common.cdw10[1]);
+	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
+	u16 status = NVME_SC_FEATURE_NOT_CHANGEABLE;
+
+	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->rw.nsid);
+	if (unlikely(!req->ns))
+		return status;
+
+	if (req->ns->readonly == false) {
+		if (write_protect == NVME_NS_WRITE_PROTECT) {
+			req->ns->readonly = true;
+			status = nvmet_write_protect_flush_sync(req);
+			/* Generate async event */
+			mutex_lock(&subsys->lock);
+			nvmet_ns_changed(subsys, req->ns->nsid);
+			mutex_unlock(&subsys->lock);
+			pr_info("write protection enabled for nsid : %d\n",
+					req->cmd->rw.nsid);
+		} else
+			pr_err("write protect invalid state transition\n");
+	} else {
+		if (write_protect == NVME_NS_NO_WRITE_PROTECT) {
+			req->ns->readonly = false;
+			status = NVME_SC_SUCCESS;
+			/* Generate async event */
+			mutex_lock(&subsys->lock);
+			nvmet_ns_changed(subsys, req->ns->nsid);
+			mutex_unlock(&subsys->lock);
+			pr_info("write protection disabled for nsid : %d\n",
+					req->cmd->rw.nsid);
+		} else
+			pr_err("write protect invalid state transition\n");
+	}
+	return status;
+}
+
 static void nvmet_execute_set_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
@@ -484,6 +583,9 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 	case NVME_FEAT_HOST_ID:
 		status = NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
 		break;
+	case NVME_FEAT_WRITE_PROTECT:
+		status = nvmet_feat_write_protect(req);
+		break;
 	default:
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		break;
@@ -496,7 +598,9 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10[0]);
+	u32 nsid = le32_to_cpu(req->cmd->common.nsid);
 	u16 status = 0;
+	u32 result;
 
 	switch (cdw10 & 0xff) {
 	/*
@@ -543,6 +647,18 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 		status = nvmet_copy_to_sgl(req, 0, &req->sq->ctrl->hostid,
 				sizeof(req->sq->ctrl->hostid));
 		break;
+	case NVME_FEAT_WRITE_PROTECT:
+		req->ns = nvmet_find_namespace(req->sq->ctrl, nsid);
+		if (!req->ns)
+			status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		else {
+			if (req->ns->readonly == true)
+				result = NVME_NS_WRITE_PROTECT;
+			else
+				result = NVME_NS_NO_WRITE_PROTECT;
+			nvmet_set_result(req, result);
+		}
+		break;
 	default:
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		break;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ddd85715a00a..94f786e49c1d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -176,7 +176,7 @@ static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
 	mutex_unlock(&ctrl->lock);
 }
 
-static void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid)
+void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid)
 {
 	struct nvmet_ctrl *ctrl;
 
@@ -443,6 +443,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	ns->subsys = subsys;
 	uuid_gen(&ns->uuid);
 	ns->buffered_io = false;
+	ns->readonly = false;
 
 	return ns;
 }
@@ -561,6 +562,9 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	if (unlikely(!req->ns))
 		return NVME_SC_INVALID_NS | NVME_SC_DNR;
 
+	if (unlikely(req->ns->readonly && nvmet_ns_wp_cmd_allow(req) == false))
+		return NVME_SC_NS_WRITE_PROTECTED;
+
 	if (req->ns->file)
 		return nvmet_file_parse_io_cmd(req);
 	else
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index e0b0f7df70c2..e6819ad8d153 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -124,6 +124,18 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 	submit_bio(bio);
 }
 
+u16 nvmet_bdev_flush(struct nvmet_req *req)
+{
+	blk_status_t status;
+	int ret;
+
+	ret = blkdev_issue_flush(req->ns->bdev, GFP_KERNEL, NULL);
+
+	status = errno_to_blk_status(ret);
+
+	return status != BLK_STS_OK ? NVME_SC_INTERNAL | NVME_SC_DNR : 0;
+}
+
 static u16 nvmet_bdev_discard_range(struct nvmet_ns *ns,
 		struct nvme_dsm_range *range, struct bio **bio)
 {
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index c2d0d08b59c8..152b2ef236e1 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -211,14 +211,23 @@ static void nvmet_file_execute_rw_buffered_io(struct nvmet_req *req)
 	queue_work(buffered_io_wq, &req->f.work);
 }
 
-static void nvmet_file_flush_work(struct work_struct *w)
+u16 nvmet_file_flush(struct nvmet_req *req)
 {
-	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
 	int ret;
 
 	ret = vfs_fsync(req->ns->file, 1);
 
-	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+	return ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0;
+}
+
+static void nvmet_file_flush_work(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+	u16 status;
+
+	status = nvmet_file_flush(req);
+
+	nvmet_req_complete(req, status);
 }
 
 static void nvmet_file_execute_flush(struct nvmet_req *req)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 688993855402..d9171faaa26d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -60,6 +60,7 @@ struct nvmet_ns {
 	struct block_device	*bdev;
 	struct file		*file;
 	u32			nsid;
+	bool			readonly;
 	u32			blksize_shift;
 	loff_t			size;
 	u8			nguid[16];
@@ -380,6 +381,11 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns);
 int nvmet_file_ns_enable(struct nvmet_ns *ns);
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns);
 void nvmet_file_ns_disable(struct nvmet_ns *ns);
+u16 nvmet_bdev_flush(struct nvmet_req *req);
+u16 nvmet_file_flush(struct nvmet_req *req);
+int nvmet_ns_is_wp(struct nvmet_ns *ns);
+bool nvmet_ns_wp_cmd_allow(struct nvmet_req *req);
+void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
 
 static inline u32 nvmet_rw_len(struct nvmet_req *req)
 {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 8514d4e0b597..d02561cf94c8 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -312,7 +312,7 @@ struct nvme_id_ns {
 	__le16			nabspf;
 	__le16			noiob;
 	__u8			nvmcap[16];
-	__u8			rsvd64[32];
+	__u8			rsvd64[35];
 	__u8			nsattr;
 	__u8			rsvd100[4];
 	__u8			nguid[16];
-- 
2.17.0
