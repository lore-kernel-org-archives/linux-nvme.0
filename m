From: bvanassche@acm.org (Bart Van Assche)
Date: Mon,  8 Oct 2018 14:28:50 -0700
Subject: [PATCH 12/16] nvmet: Remove unreachable code from
 nvmet_parse_discovery_cmd()
In-Reply-To: <20181008212854.68310-1-bvanassche@acm.org>
References: <20181008212854.68310-1-bvanassche@acm.org>
Message-ID: <20181008212854.68310-13-bvanassche@acm.org>

This patch avoids that smatch reports the following warning:

drivers/nvme/target/discovery.c:228:1 nvmet_parse_discovery_cmd() info: ignoring unreachable code.

Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 drivers/nvme/target/discovery.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index eae29f493a07..08e7e284655c 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -218,12 +218,9 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 			       cmd->identify.cns);
 			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 		}
-	default:
-		pr_err("unsupported cmd %d\n", cmd->common.opcode);
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 
-	pr_err("unhandled cmd %d\n", cmd->common.opcode);
+	pr_err("unsupported cmd %d\n", cmd->common.opcode);
 	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 }
 
-- 
2.19.0.605.g01d371f741-goog
