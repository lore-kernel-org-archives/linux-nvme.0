From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed,  7 Jun 2017 11:45:29 +0200
Subject: [PATCH v6 02/10] nvmet: use NVME_IDENTIFY_DATA_SIZE
In-Reply-To: <20170607094536.32419-1-jthumshirn@suse.de>
References: <20170607094536.32419-1-jthumshirn@suse.de>
Message-ID: <20170607094536.32419-3-jthumshirn@suse.de>

Use NVME_IDENTIFY_DATA_SIZE define instead of hard coding the magic
4096 value.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/admin-cmd.c | 4 ++--
 drivers/nvme/target/discovery.c | 2 +-
 include/linux/nvme.h            | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index ff1f97006322..96c144325443 100644
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
@@ -504,7 +504,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
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
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index e400a69fa1d3..c004af5faa48 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -659,6 +659,8 @@ struct nvme_identify {
 	__u32			rsvd11[5];
 };
 
+#define NVME_IDENTIFY_DATA_SIZE 4096
+
 struct nvme_features {
 	__u8			opcode;
 	__u8			flags;
-- 
2.12.3
