From: hch@lst.de (Christoph Hellwig)
Date: Fri, 30 Sep 2016 13:51:10 +0200
Subject: [PATCH 5/5] nvmet: use symbolic constants for CNS values
In-Reply-To: <1475236270-18329-1-git-send-email-hch@lst.de>
References: <1475236270-18329-1-git-send-email-hch@lst.de>
Message-ID: <1475236270-18329-6-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/admin-cmd.c | 6 +++---
 drivers/nvme/target/discovery.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6944f24..6fe4c48 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -511,13 +511,13 @@ int nvmet_parse_admin_cmd(struct nvmet_req *req)
 	case nvme_admin_identify:
 		req->data_len = 4096;
 		switch (le32_to_cpu(cmd->identify.cns)) {
-		case 0x00:
+		case NVME_ID_CNS_NS:
 			req->execute = nvmet_execute_identify_ns;
 			return 0;
-		case 0x01:
+		case NVME_ID_CNS_CTRL:
 			req->execute = nvmet_execute_identify_ctrl;
 			return 0;
-		case 0x02:
+		case NVME_ID_CNS_NS_ACTIVE_LIST:
 			req->execute = nvmet_execute_identify_nslist;
 			return 0;
 		}
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index a6c25fb..12f39ee 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -187,7 +187,7 @@ int nvmet_parse_discovery_cmd(struct nvmet_req *req)
 	case nvme_admin_identify:
 		req->data_len = 4096;
 		switch (le32_to_cpu(cmd->identify.cns)) {
-		case 0x01:
+		case NVME_ID_CNS_CTRL:
 			req->execute =
 				nvmet_execute_identify_disc_ctrl;
 			return 0;
-- 
2.1.4
