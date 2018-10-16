From: jay.e.sternberg@intel.com (Jay Sternberg)
Date: Tue, 16 Oct 2018 10:11:16 -0700
Subject: [PATCH v2 04/11] nvmet: Make kato and AEN processing for use by other
 controllers
In-Reply-To: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
References: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <1539709883-12424-5-git-send-email-jay.e.sternberg@intel.com>

Make common process of get/set features available to other controllers by
making simple functions static inline and others not static and prototypes
in nvmet.h file

Also remove static from nvmet_execute_async_event and add prototype to
nvmet.h to allow used by other controllers

Signed-off-by: Jay Sternberg <jay.e.sternberg at intel.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
v2 - unchanged

 drivers/nvme/target/admin-cmd.c | 44 +++++++++++++++++++++++++++--------------
 drivers/nvme/target/nvmet.h     | 14 +++++++++++++
 2 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index e69edd5..289ee18 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -582,11 +582,34 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 	return status;
 }
 
+u16 nvmet_set_feat_kato(struct nvmet_req *req)
+{
+	u32 val32 = le32_to_cpu(req->cmd->common.cdw10[1]);
+
+	req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
+
+	nvmet_set_result(req, req->sq->ctrl->kato);
+
+	return 0;
+}
+
+u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask)
+{
+	u32 val32 = le32_to_cpu(req->cmd->common.cdw10[1]);
+
+	if (val32 & ~mask)
+		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+
+	WRITE_ONCE(req->sq->ctrl->aen_enabled, val32);
+	nvmet_set_result(req, val32);
+
+	return 0;
+}
+
 static void nvmet_execute_set_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10[0]);
-	u32 val32;
 	u16 status = 0;
 
 	switch (cdw10 & 0xff) {
@@ -595,19 +618,10 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 			(subsys->max_qid - 1) | ((subsys->max_qid - 1) << 16));
 		break;
 	case NVME_FEAT_KATO:
-		val32 = le32_to_cpu(req->cmd->common.cdw10[1]);
-		req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
-		nvmet_set_result(req, req->sq->ctrl->kato);
+		status = nvmet_set_feat_kato(req);
 		break;
 	case NVME_FEAT_ASYNC_EVENT:
-		val32 = le32_to_cpu(req->cmd->common.cdw10[1]);
-		if (val32 & ~NVMET_AEN_CFG_ALL) {
-			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-			break;
-		}
-
-		WRITE_ONCE(req->sq->ctrl->aen_enabled, val32);
-		nvmet_set_result(req, val32);
+		status = nvmet_set_feat_async_event(req, NVMET_AEN_CFG_ALL);
 		break;
 	case NVME_FEAT_HOST_ID:
 		status = NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
@@ -672,7 +686,7 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 		break;
 #endif
 	case NVME_FEAT_ASYNC_EVENT:
-		nvmet_set_result(req, READ_ONCE(req->sq->ctrl->aen_enabled));
+		nvmet_get_feat_async_event(req);
 		break;
 	case NVME_FEAT_VOLATILE_WC:
 		nvmet_set_result(req, 1);
@@ -682,7 +696,7 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 			(subsys->max_qid-1) | ((subsys->max_qid-1) << 16));
 		break;
 	case NVME_FEAT_KATO:
-		nvmet_set_result(req, req->sq->ctrl->kato * 1000);
+		nvmet_get_feat_kato(req);
 		break;
 	case NVME_FEAT_HOST_ID:
 		/* need 128-bit host identifier flag */
@@ -705,7 +719,7 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static void nvmet_execute_async_event(struct nvmet_req *req)
+void nvmet_execute_async_event(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 4910e83c..e263330 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -339,6 +339,20 @@ static inline bool nvmet_aen_bit_disabled(struct nvmet_ctrl *ctrl, u32 bn)
 	return test_and_set_bit(bn, &ctrl->aen_masked);
 }
 
+static inline void nvmet_get_feat_kato(struct nvmet_req *req)
+{
+	nvmet_set_result(req, req->sq->ctrl->kato * 1000);
+}
+
+static inline void nvmet_get_feat_async_event(struct nvmet_req *req)
+{
+	nvmet_set_result(req, READ_ONCE(req->sq->ctrl->aen_enabled));
+}
+
+u16 nvmet_set_feat_kato(struct nvmet_req *req);
+u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask);
+void nvmet_execute_async_event(struct nvmet_req *req);
+
 u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
 u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req);
 u16 nvmet_file_parse_io_cmd(struct nvmet_req *req);
-- 
1.8.3.1
