From: jay.e.sternberg@intel.com (Jay Sternberg)
Date: Mon, 12 Nov 2018 13:56:36 -0800
Subject: [PATCH v3 4/8] nvmet: Make kato and AEN processing for use by other
 controllers
In-Reply-To: <1542059800-35938-1-git-send-email-jay.e.sternberg@intel.com>
References: <1542059800-35938-1-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <1542059800-35938-5-git-send-email-jay.e.sternberg@intel.com>

Make common process of get/set features available to other controllers by
making simple functions static inline and others not static and prototypes
in nvmet.h file

Also remove static from nvmet_execute_async_event and add prototype to
nvmet.h to allow used by other controllers

Signed-off-by: Jay Sternberg <jay.e.sternberg at intel.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
v2 - unchanged
v3 - moved nvmet_get_feat_kato and nvmet_get_feat_async_event out of nvmet.h

 drivers/nvme/target/admin-cmd.c | 54 +++++++++++++++++++++++++++++------------
 drivers/nvme/target/nvmet.h     |  6 +++++
 2 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 8824570..888f486 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -586,11 +586,34 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
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
@@ -599,19 +622,10 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
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
@@ -647,6 +661,16 @@ static u16 nvmet_get_feat_write_protect(struct nvmet_req *req)
 	return 0;
 }
 
+void nvmet_get_feat_kato(struct nvmet_req *req)
+{
+	nvmet_set_result(req, req->sq->ctrl->kato * 1000);
+}
+
+void nvmet_get_feat_async_event(struct nvmet_req *req)
+{
+	nvmet_set_result(req, READ_ONCE(req->sq->ctrl->aen_enabled));
+}
+
 static void nvmet_execute_get_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
@@ -676,7 +700,7 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 		break;
 #endif
 	case NVME_FEAT_ASYNC_EVENT:
-		nvmet_set_result(req, READ_ONCE(req->sq->ctrl->aen_enabled));
+		nvmet_get_feat_async_event(req);
 		break;
 	case NVME_FEAT_VOLATILE_WC:
 		nvmet_set_result(req, 1);
@@ -686,7 +710,7 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 			(subsys->max_qid-1) | ((subsys->max_qid-1) << 16));
 		break;
 	case NVME_FEAT_KATO:
-		nvmet_set_result(req, req->sq->ctrl->kato * 1000);
+		nvmet_get_feat_kato(req);
 		break;
 	case NVME_FEAT_HOST_ID:
 		/* need 128-bit host identifier flag */
@@ -709,7 +733,7 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static void nvmet_execute_async_event(struct nvmet_req *req)
+void nvmet_execute_async_event(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index da4a2dd..e9a81f6 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -355,6 +355,12 @@ static inline bool nvmet_aen_bit_disabled(struct nvmet_ctrl *ctrl, u32 bn)
 	return test_and_set_bit(bn, &ctrl->aen_masked);
 }
 
+void nvmet_get_feat_kato(struct nvmet_req *req);
+void nvmet_get_feat_async_event(struct nvmet_req *req);
+u16 nvmet_set_feat_kato(struct nvmet_req *req);
+u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask);
+void nvmet_execute_async_event(struct nvmet_req *req);
+
 u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
 u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req);
 u16 nvmet_file_parse_io_cmd(struct nvmet_req *req);
-- 
1.8.3.1
