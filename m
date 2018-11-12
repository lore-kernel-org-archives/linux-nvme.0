From: jay.e.sternberg@intel.com (Jay Sternberg)
Date: Mon, 12 Nov 2018 13:56:38 -0800
Subject: [PATCH v3 6/8] nvmet: Add support to Discovery controllers for
 commands
In-Reply-To: <1542059800-35938-1-git-send-email-jay.e.sternberg@intel.com>
References: <1542059800-35938-1-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <1542059800-35938-7-git-send-email-jay.e.sternberg@intel.com>

Add custom get/set features to commands allowed by Discovery controllers.

Signed-off-by: Jay Sternberg <jay.e.sternberg at intel.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
v2 - unchanged
v3 - updated commit description

 drivers/nvme/target/discovery.c | 53 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 6e0f91e..050e4d7 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -183,6 +183,47 @@ static void nvmet_execute_identify_disc_ctrl(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+static void nvmet_execute_disc_set_features(struct nvmet_req *req)
+{
+	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10[0]);
+	u16 stat;
+
+	switch (cdw10 & 0xff) {
+	case NVME_FEAT_KATO:
+		stat = nvmet_set_feat_kato(req);
+		break;
+	case NVME_FEAT_ASYNC_EVENT:
+		stat = nvmet_set_feat_async_event(req,
+						  NVMET_DISC_AEN_CFG_OPTIONAL);
+		break;
+	default:
+		stat = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		break;
+	}
+
+	nvmet_req_complete(req, stat);
+}
+
+static void nvmet_execute_disc_get_features(struct nvmet_req *req)
+{
+	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10[0]);
+	u16 stat = 0;
+
+	switch (cdw10 & 0xff) {
+	case NVME_FEAT_KATO:
+		nvmet_get_feat_kato(req);
+		break;
+	case NVME_FEAT_ASYNC_EVENT:
+		nvmet_get_feat_async_event(req);
+		break;
+	default:
+		stat = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		break;
+	}
+
+	nvmet_req_complete(req, stat);
+}
+
 u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
@@ -194,6 +235,18 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 	}
 
 	switch (cmd->common.opcode) {
+	case nvme_admin_set_features:
+		req->execute = nvmet_execute_disc_set_features;
+		req->data_len = 0;
+		return 0;
+	case nvme_admin_get_features:
+		req->execute = nvmet_execute_disc_get_features;
+		req->data_len = 0;
+		return 0;
+	case nvme_admin_async_event:
+		req->execute = nvmet_execute_async_event;
+		req->data_len = 0;
+		return 0;
 	case nvme_admin_keep_alive:
 		req->execute = nvmet_execute_keep_alive;
 		req->data_len = 0;
-- 
1.8.3.1
