From: omri@excelero.com (Omri Mann)
Date: Mon, 28 Aug 2017 15:07:37 +0300
Subject: [PATCH] nvmet: Add support for HOST_ID feature.
Message-ID: <1503922057-1141-1-git-send-email-omri@excelero.com>

Add host_id feature to NVMeoF targets. This will be required in order to
support reservations.
Signed-off-by: Omri Mann <omri at excelero.com>
---
 drivers/nvme/target/admin-cmd.c | 7 +++++++
 drivers/nvme/target/nvmet.h     | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index a53bb66..071de0b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -461,6 +461,10 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 		req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
 		nvmet_set_result(req, req->sq->ctrl->kato);
 		break;
+	case NVME_FEAT_HOST_ID:
+		status = nvmet_copy_from_sgl(req, 0, &req->sq->ctrl->host_id,
+						8);
+		break;
 	default:
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		break;
@@ -509,6 +513,9 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 	case NVME_FEAT_KATO:
 		nvmet_set_result(req, req->sq->ctrl->kato * 1000);
 		break;
+	case NVME_FEAT_HOST_ID:
+		status = nvmet_copy_to_sgl(req, 0, &req->sq->ctrl->host_id, 8);
+		break;
 	default:
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		break;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e3b244c..841f35d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -132,6 +132,7 @@ struct nvmet_ctrl {
 
 	char			subsysnqn[NVMF_NQN_FIELD_LEN];
 	char			hostnqn[NVMF_NQN_FIELD_LEN];
+	u64			host_id;
 };
 
 struct nvmet_subsys {
-- 
1.8.3.1
