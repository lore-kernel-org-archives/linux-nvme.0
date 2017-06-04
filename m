From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Sun,  4 Jun 2017 12:36:49 +0200
Subject: [PATCH v4 8/8] nvmet: use NVME_IDENTIFY_DATA_SIZE
In-Reply-To: <20170604103649.22130-1-jthumshirn@suse.de>
References: <20170604103649.22130-1-jthumshirn@suse.de>
Message-ID: <20170604103649.22130-9-jthumshirn@suse.de>

Use NVME_IDENTIFY_DATA_SIZE define instead of hard coding the magic
4096 value.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/target/admin-cmd.c | 4 ++--
 drivers/nvme/target/discovery.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 833b5ef935c3..def6cde1e714 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -336,7 +336,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 static void nvmet_execute_identify_nslist(struct nvmet_req *req)
 {
-	static const int buf_size = 4096;
+	static const int buf_size = NVME_IDENTIFY_DATA_SIZE;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmet_ns *ns;
 	u32 min_nsid = le32_to_cpu(req->cmd->identify.nsid);
@@ -554,7 +554,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 		}
 		break;
 	case nvme_admin_identify:
-		req->data_len = 4096;
+		req->data_len = NVME_IDENTIFY_DATA_SIZE;
 		switch (cmd->identify.cns) {
 		case NVME_ID_CNS_NS:
 			req->execute = nvmet_execute_identify_ns;
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 1aaf597e81fc..c7a90384dd75 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -185,7 +185,7 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 		}
 	case nvme_admin_identify:
-		req->data_len = 4096;
+		req->data_len = NVME_IDENTIFY_DATA_SIZE;
 		switch (cmd->identify.cns) {
 		case NVME_ID_CNS_CTRL:
 			req->execute =
-- 
2.12.0
