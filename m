From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon,  9 Jul 2018 23:40:11 -0400
Subject: [PATCH] nvmet: remove duplicate code
Message-ID: <20180710034011.26589-1-chaitanya.kulkarni@wdc.com>

This patch removes the duplicate code present in the
nvmet_parse_discovery_cmd() and uses the parsing function style similar
to nvmet_parse_admin_cmd().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/discovery.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index eae29f493a07..261e64d0dedb 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -218,11 +218,7 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 			       cmd->identify.cns);
 			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 		}
-	default:
-		pr_err("unsupported cmd %d\n", cmd->common.opcode);
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
-
 	pr_err("unhandled cmd %d\n", cmd->common.opcode);
 	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 }
-- 
2.17.0
