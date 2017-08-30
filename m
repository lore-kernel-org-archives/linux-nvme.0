From: omri@excelero.com (Omri Mann)
Date: Wed, 30 Aug 2017 15:22:59 +0300
Subject: [PATCH V4] nvmet: Add support for HOST_ID feature.
Message-ID: <1504095779-13255-1-git-send-email-omri@excelero.com>

Add host_id feature to NVMeoF targets. This will be required in order to
support reservations.
Signed-off-by: Omri Mann <omri at excelero.com>
---
 drivers/nvme/target/admin-cmd.c   | 14 ++++++++++++--
 drivers/nvme/target/fabrics-cmd.c |  1 +
 drivers/nvme/target/nvmet.h       |  2 ++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index ff1f970..22f61a1 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -387,7 +387,7 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 	u32 val32;
 	u16 status = 0;
 
-	switch (cdw10 & 0xf) {
+	switch (cdw10 & 0xff) {
 	case NVME_FEAT_NUM_QUEUES:
 		nvmet_set_result(req,
 			(subsys->max_qid - 1) | ((subsys->max_qid - 1) << 16));
@@ -397,6 +397,9 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 		req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
 		nvmet_set_result(req, req->sq->ctrl->kato);
 		break;
+	case NVME_FEAT_HOST_ID:
+		status = NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
+		break;
 	default:
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		break;
@@ -411,7 +414,7 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10[0]);
 	u16 status = 0;
 
-	switch (cdw10 & 0xf) {
+	switch (cdw10 & 0xff) {
 	/*
 	 * These features are mandatory in the spec, but we don't
 	 * have a useful way to implement them.  We'll eventually
@@ -445,6 +448,13 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 	case NVME_FEAT_KATO:
 		nvmet_set_result(req, req->sq->ctrl->kato * 1000);
 		break;
+	case NVME_FEAT_HOST_ID:
+		if (!(le32_to_cpu(req->cmd->common.cdw10[1]) & 1))
+			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		else
+			status = nvmet_copy_to_sgl(req, 0,
+			req->sq->ctrl->hostid, sizeof(req->sq->ctrl->hostid));
+		break;
 	default:
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		break;
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 3cc1726..40c8682 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -154,6 +154,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 				  le32_to_cpu(c->kato), &ctrl);
 	if (status)
 		goto out;
+	memcpy(ctrl->hostid, d->hostid, sizeof(ctrl->hostid));
 
 	status = nvmet_install_queue(ctrl, req);
 	if (status) {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index cfc5c7f..60b823d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -108,6 +108,8 @@ struct nvmet_ctrl {
 	struct nvmet_cq		**cqs;
 	struct nvmet_sq		**sqs;
 
+	u8			hostid[16];
+
 	struct mutex		lock;
 	u64			cap;
 	u64			serial;
-- 
1.8.3.1
