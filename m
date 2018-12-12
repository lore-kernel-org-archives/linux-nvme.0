From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 12 Dec 2018 15:11:46 -0800
Subject: [PATCH V2 10/12] nvmet: add error log support for admin-cmd
In-Reply-To: <20181212231148.4107-1-chaitanya.kulkarni@wdc.com>
References: <20181212231148.4107-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20181212231148.4107-11-chaitanya.kulkarni@wdc.com>

This patch adds the support to maintain the error log page for admin
commands.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/admin-cmd.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 721b041a6b3b..fa62db7a5e9e 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -47,6 +47,7 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 	if (!ns) {
 		pr_err("Could not find namespace id : %d\n",
 				le32_to_cpu(req->cmd->get_log_page.nsid));
+		req->error_loc = offsetof(struct nvme_rw_command, nsid);
 		return NVME_SC_INVALID_NS;
 	}
 
@@ -380,6 +381,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	u16 status = 0;
 
 	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
+		req->error_loc = offsetof(struct nvme_identify, nsid);
 		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
 		goto out;
 	}
@@ -500,6 +502,7 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 
 	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
 	if (!ns) {
+		req->error_loc = offsetof(struct nvme_identify, nsid);
 		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
 		goto out;
 	}
@@ -562,8 +565,10 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 	u16 status = NVME_SC_FEATURE_NOT_CHANGEABLE;
 
 	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->rw.nsid);
-	if (unlikely(!req->ns))
+	if (unlikely(!req->ns)) {
+		req->error_loc = offsetof(struct nvme_common_command, nsid);
 		return status;
+	}
 
 	mutex_lock(&subsys->lock);
 	switch (write_protect) {
@@ -602,8 +607,10 @@ u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask)
 {
 	u32 val32 = le32_to_cpu(req->cmd->common.cdw11);
 
-	if (val32 & ~mask)
+	if (val32 & ~mask) {
+		req->error_loc = offsetof(struct nvme_common_command, cdw11);
 		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+	}
 
 	WRITE_ONCE(req->sq->ctrl->aen_enabled, val32);
 	nvmet_set_result(req, val32);
@@ -635,6 +642,7 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 		status = nvmet_set_feat_write_protect(req);
 		break;
 	default:
+		req->error_loc = offsetof(struct nvme_common_command, cdw10);
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		break;
 	}
@@ -648,9 +656,10 @@ static u16 nvmet_get_feat_write_protect(struct nvmet_req *req)
 	u32 result;
 
 	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->common.nsid);
-	if (!req->ns)
+	if (!req->ns)  {
+		req->error_loc = offsetof(struct nvme_common_command, nsid);
 		return NVME_SC_INVALID_NS | NVME_SC_DNR;
-
+	}
 	mutex_lock(&subsys->lock);
 	if (req->ns->readonly == true)
 		result = NVME_NS_WRITE_PROTECT;
@@ -716,6 +725,8 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 	case NVME_FEAT_HOST_ID:
 		/* need 128-bit host identifier flag */
 		if (!(req->cmd->common.cdw11 & cpu_to_le32(1 << 0))) {
+			req->error_loc =
+				offsetof(struct nvme_common_command, cdw11);
 			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 			break;
 		}
@@ -727,6 +738,8 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 		status = nvmet_get_feat_write_protect(req);
 		break;
 	default:
+		req->error_loc =
+			offsetof(struct nvme_common_command, cdw10);
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		break;
 	}
@@ -848,5 +861,6 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 
 	pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
 	       req->sq->qid);
+	req->error_loc = offsetof(struct nvme_common_command, opcode);
 	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 }
-- 
2.17.0
