From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 14 Feb 2019 14:50:52 -0800
Subject: [PATCH 1/6] nvmet: Fix indentation
In-Reply-To: <20190214225057.195397-1-bvanassche@acm.org>
References: <20190214225057.195397-1-bvanassche@acm.org>
Message-ID: <20190214225057.195397-2-bvanassche@acm.org>

This patch avoids that smatch complains about inconsistent indentation.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target") # v4.10
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 drivers/nvme/target/discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index d2cb71a0b419..a34cf4986a49 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -331,7 +331,7 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 			       cmd->get_log_page.lid);
 			req->error_loc =
 				offsetof(struct nvme_get_log_page_command, lid);
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 		}
 	case nvme_admin_identify:
 		req->data_len = NVME_IDENTIFY_DATA_SIZE;
-- 
2.21.0.rc0.258.g878e2cd30e-goog
