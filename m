From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon,  9 Jul 2018 23:54:24 -0400
Subject: [RFC PATCH] nvmet: add support for ns write protect feature
Message-ID: <20180710035424.29088-1-chaitanya.kulkarni@wdc.com>

This patch implements the Namespace Write Protect feature described in
"NVMe TP 4005a Namespace Write Protect". In this version, we implement
No Write Protect and Write Protect states for target ns which can be
toggled by set-features commands from the host side.

We use the NVMeOF Command effects log to freeze the queue on the host
side when the user tries to execute the set-features command for
ns write protect feature. For write-protect state transition,
we need to flush the ns specified as a part of command so we also add
helpers for carrying out synchronous flush operations.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
Hi,

This RFC is light on the details, it will be great if I
can get some feedback on whether or not we want to have this
code/feature in the target, on approval I'll post the
patches for nvme-cli along with the review comments patch which
I've used for the testing this code. Also for the sake completness
I've added sync versions of flush for bdev and file, we can get rid of
those as per spec :-

"A Flush command shall complete successfully with no effect. All
volatile write cache data and metadata associated with the
specified namespace is written to non-volatile media as part of
transitioning to the write protected state."

Regards,
Chaitanya
---
 drivers/nvme/target/admin-cmd.c   | 122 +++++++++++++++++++++++++++++-
 drivers/nvme/target/core.c        |   4 +
 drivers/nvme/target/io-cmd-bdev.c |  11 +++
 drivers/nvme/target/io-cmd-file.c |  15 +++-
 drivers/nvme/target/nvmet.h       |   5 ++
 include/linux/nvme.h              |  16 +++-
 6 files changed, 167 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 837bbdbfaa4b..b8d4f97cb2bd 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -19,6 +19,64 @@
 #include <asm/unaligned.h>
 #include "nvmet.h"
 
+int nvmet_ns_is_wp(struct nvmet_ns *ns)
+{
+	switch (ns->wp_state) {
+	case NVME_NS_NO_WRITE_PROTECT:
+		return 0;
+	case NVME_NS_WRITE_PROTECT:
+		return 1;
+	}
+	WARN_ON("invalid ns write protect state");
+	return -1;
+}
+
+bool nvmet_ns_wp_cmd_allow(struct nvmet_req *req)
+{
+	bool ret = false;
+
+	switch (req->cmd->common.opcode) {
+	case nvme_cmd_dsm: /* allow DSM ? */
+	case nvme_cmd_read:
+	case nvme_cmd_flush:
+		/* fall thru */
+		ret = true;
+		goto out;
+	}
+
+	/*
+	 * Right now we don't have a useful way to check for the allowed admin
+	 * cmds when the ns is write-protected, as we don't have any admin-cmds
+	 * which are operating on the target ns except for write-protect-feat.
+	 * For the completeness keep the valid list of admin cmds from the spec
+	 * here. In future when we add a new cmd or implement a feature
+	 * which operates on a ns and will trigger media change please add this
+	 * call to the code in the appropriate location.
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
+out:
+	return ret;
+}
+
 u32 nvmet_get_log_page_len(struct nvme_command *cmd)
 {
 	u32 len = le16_to_cpu(cmd->get_log_page.numdu);
@@ -140,7 +198,7 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	log->acs[nvme_admin_get_log_page]	= cpu_to_le32(1 << 0);
 	log->acs[nvme_admin_identify]		= cpu_to_le32(1 << 0);
 	log->acs[nvme_admin_abort_cmd]		= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_set_features]	= cpu_to_le32(1 << 0);
+	log->acs[nvme_admin_set_features]	= cpu_to_le32(1 << 16 | 1 << 0);
 	log->acs[nvme_admin_get_features]	= cpu_to_le32(1 << 0);
 	log->acs[nvme_admin_async_event]	= cpu_to_le32(1 << 0);
 	log->acs[nvme_admin_keep_alive]		= cpu_to_le32(1 << 0);
@@ -289,6 +347,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->psd[0].entry_lat = cpu_to_le32(0x10);
 	id->psd[0].exit_lat = cpu_to_le32(0x4);
 
+	id->nwpc = 1 << 0; /* write protect and no write protect */
+
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 
 	kfree(id);
@@ -342,6 +402,8 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	id->lbaf[0].ds = ns->blksize_shift;
 
+	id->nsattr = nvmet_ns_is_wp(ns);
+
 	nvmet_put_namespace(ns);
 done:
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
@@ -454,6 +516,53 @@ static void nvmet_execute_abort(struct nvmet_req *req)
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
+	u32 wp_state = le32_to_cpu(req->cmd->common.cdw10[1]);
+	u16 status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+
+	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->rw.nsid);
+	if (unlikely(!req->ns))
+		return status;
+
+	switch (req->ns->wp_state) {
+	case NVME_NS_NO_WRITE_PROTECT:
+		if (wp_state == NVME_NS_WRITE_PROTECT) {
+			pr_info("enabled write protection for nsid : %d '%s'\n",
+				req->cmd->rw.nsid, req->ns->device_path);
+			req->ns->wp_state = NVME_NS_WRITE_PROTECT;
+			status = nvmet_write_protect_flush_sync(req);
+		} else
+			pr_err("write protect invalid state transition\n");
+		break;
+	case NVME_NS_WRITE_PROTECT:
+		if (wp_state == NVME_NS_NO_WRITE_PROTECT) {
+			req->ns->wp_state = NVME_NS_NO_WRITE_PROTECT;
+			pr_info("disabled write protection for nsid %d '%s'\n",
+				req->cmd->rw.nsid, req->ns->device_path);
+			status = NVME_SC_SUCCESS;
+		} else
+			pr_err("write protect invalid state transition\n");
+		break;
+	default:
+		pr_err("invalid write protect state %u\n", wp_state);
+	}
+	return status;
+}
+
 static void nvmet_execute_set_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
@@ -484,6 +593,9 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 	case NVME_FEAT_HOST_ID:
 		status = NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
 		break;
+	case NVME_FEAT_WRITE_PROTECT:
+		status = nvmet_feat_write_protect(req);
+		break;
 	default:
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		break;
@@ -496,6 +608,7 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10[0]);
+	u32 nsid = le32_to_cpu(req->cmd->common.nsid);
 	u16 status = 0;
 
 	switch (cdw10 & 0xff) {
@@ -543,6 +656,13 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 		status = nvmet_copy_to_sgl(req, 0, &req->sq->ctrl->hostid,
 				sizeof(req->sq->ctrl->hostid));
 		break;
+	case NVME_FEAT_WRITE_PROTECT:
+		req->ns = nvmet_find_namespace(req->sq->ctrl, nsid);
+		if (!req->ns)
+			status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		else
+			nvmet_set_result(req, req->ns->wp_state);
+		break;
 	default:
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		break;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ddd85715a00a..dbe473f58bf1 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -443,6 +443,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	ns->subsys = subsys;
 	uuid_gen(&ns->uuid);
 	ns->buffered_io = false;
+	ns->wp_state = NVME_NS_NO_WRITE_PROTECT;
 
 	return ns;
 }
@@ -561,6 +562,9 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	if (unlikely(!req->ns))
 		return NVME_SC_INVALID_NS | NVME_SC_DNR;
 
+	if (nvmet_ns_is_wp(req->ns) && !nvmet_ns_wp_cmd_allow(req))
+		return NVME_SC_NS_WRITE_PROTECTED;
+
 	if (req->ns->file)
 		return nvmet_file_parse_io_cmd(req);
 	else
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index e0b0f7df70c2..dfac4b3137de 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -124,6 +124,17 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
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
+	return status != BLK_STS_OK ? NVME_SC_INTERNAL | NVME_SC_DNR : 0;
+}
+
 static u16 nvmet_bdev_discard_range(struct nvmet_ns *ns,
 		struct nvme_dsm_range *range, struct bio **bio)
 {
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 57c660e3245d..0780925ca36f 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -207,14 +207,23 @@ static void nvmet_file_execute_rw_buffered_io(struct nvmet_req *req)
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
index 688993855402..8ae1dfa475eb 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -60,6 +60,7 @@ struct nvmet_ns {
 	struct block_device	*bdev;
 	struct file		*file;
 	u32			nsid;
+	u32			wp_state; /* write protect state */
 	u32			blksize_shift;
 	loff_t			size;
 	u8			nguid[16];
@@ -380,6 +381,10 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns);
 int nvmet_file_ns_enable(struct nvmet_ns *ns);
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns);
 void nvmet_file_ns_disable(struct nvmet_ns *ns);
+u16 nvmet_bdev_flush(struct nvmet_req *req);
+u16 nvmet_file_flush(struct nvmet_req *req);
+int nvmet_ns_is_wp(struct nvmet_ns *ns);
+bool nvmet_ns_wp_cmd_allow(struct nvmet_req *req);
 
 static inline u32 nvmet_rw_len(struct nvmet_req *req)
 {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 80dfedcf0bf7..c506ef2b48ca 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -254,7 +254,7 @@ struct nvme_id_ctrl {
 	__le16			awun;
 	__le16			awupf;
 	__u8			nvscc;
-	__u8			rsvd531;
+	__u8			nwpc;
 	__le16			acwu;
 	__u8			rsvd534[2];
 	__le32			sgls;
@@ -312,7 +312,8 @@ struct nvme_id_ns {
 	__le16			nabspf;
 	__le16			noiob;
 	__u8			nvmcap[16];
-	__u8			rsvd64[40];
+	__u8			nsattr;
+	__u8			rsvd64[39];
 	__u8			nguid[16];
 	__u8			eui64[8];
 	struct nvme_lbaf	lbaf[16];
@@ -758,6 +759,7 @@ enum {
 	NVME_FEAT_HOST_ID	= 0x81,
 	NVME_FEAT_RESV_MASK	= 0x82,
 	NVME_FEAT_RESV_PERSIST	= 0x83,
+	NVME_FEAT_WRITE_PROTECT = 0x84,
 	NVME_LOG_ERROR		= 0x01,
 	NVME_LOG_SMART		= 0x02,
 	NVME_LOG_FW_SLOT	= 0x03,
@@ -770,6 +772,14 @@ enum {
 	NVME_FWACT_ACTV		= (2 << 3),
 };
 
+/* NVMe Namespace Write Protect State */
+enum {
+	NVME_NS_NO_WRITE_PROTECT = 0,
+	NVME_NS_WRITE_PROTECT,
+	NVME_NS_WRITE_PROTECT_POWER_CYCLE,
+	NVME_NS_WRITE_PROTECT_PERMANENT,
+};
+
 #define NVME_MAX_CHANGED_NAMESPACES	1024
 
 struct nvme_identify {
@@ -1116,6 +1126,8 @@ enum {
 	NVME_SC_SGL_INVALID_OFFSET	= 0x16,
 	NVME_SC_SGL_INVALID_SUBTYPE	= 0x17,
 
+	NVME_SC_NS_WRITE_PROTECTED	= 0x20,
+
 	NVME_SC_LBA_RANGE		= 0x80,
 	NVME_SC_CAP_EXCEEDED		= 0x81,
 	NVME_SC_NS_NOT_READY		= 0x82,
-- 
2.17.0
