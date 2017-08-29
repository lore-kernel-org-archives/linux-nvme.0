From: omri@excelero.com (Omri Mann)
Date: Tue, 29 Aug 2017 12:13:02 +0300
Subject: [PATCH V3] nvmet: Add support for HOST_ID feature.
Message-ID: <1503997982-13175-1-git-send-email-omri@excelero.com>

Add hostid feature to NVMeoF targets. This will be required in order to
support reservations.
Signed-off-by: Omri Mann <omri at excelero.com>
---
 drivers/nvme/target/admin-cmd.c   | 10 ++++++++++
 drivers/nvme/target/fabrics-cmd.c |  1 +
 drivers/nvme/target/nvmet.h       |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index a53bb66..b98ec5e 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -461,6 +461,9 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 		req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
 		nvmet_set_result(req, req->sq->ctrl->kato);
 		break;
+	case NVME_FEAT_HOST_ID:
+		status = NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
+		break;
 	default:
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		break;
@@ -509,6 +512,13 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 	case NVME_FEAT_KATO:
 		nvmet_set_result(req, req->sq->ctrl->kato * 1000);
 		break;
+	case NVME_FEAT_HOST_ID:
+		if (!(le32_to_cpu(req->cmd->common.cdw10[1]) & 1))
+			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		else
+			status = nvmet_copy_to_sgl(req, 0,
+					&req->sq->ctrl->hostid, 16);
+		break;
 	default:
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		break;
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 3cc1726..859a667 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -154,6 +154,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 				  le32_to_cpu(c->kato), &ctrl);
 	if (status)
 		goto out;
+	uuid_copy(&ctrl->hostid, &d->hostid);
 
 	status = nvmet_install_queue(ctrl, req);
 	if (status) {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e3b244c..ae7c6b7 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -110,6 +110,8 @@ struct nvmet_ctrl {
 	struct nvmet_cq		**cqs;
 	struct nvmet_sq		**sqs;
 
+	uuid_t			hostid;
+
 	struct mutex		lock;
 	u64			cap;
 	u32			cc;
-- 
1.8.3.1
