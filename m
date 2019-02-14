From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 14 Feb 2019 22:59:37 +0000
Subject: [PATCH 1/6] nvmet: Fix indentation
In-Reply-To: <20190214225057.195397-2-bvanassche@acm.org>
References: <20190214225057.195397-1-bvanassche@acm.org>,
 <20190214225057.195397-2-bvanassche@acm.org>
Message-ID: <BYAPR04MB4502F2E1C137D24CE1FA483186670@BYAPR04MB4502.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> on behalf of Bart Van Assche <bvanassche@acm.org>
Sent: Thursday, February 14, 2019 2:50 PM
To: Christoph Hellwig
Cc: Keith Busch; Sagi Grimberg; linux-nvme at lists.infradead.org; Bart Van Assche
Subject: [PATCH 1/6] nvmet: Fix indentation
?
This patch avoids that smatch complains about inconsistent indentation.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target") # v4.10
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
?drivers/nvme/target/discovery.c | 2 +-
?1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index d2cb71a0b419..a34cf4986a49 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -331,7 +331,7 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
??????????????????????????????? cmd->get_log_page.lid);
???????????????????????? req->error_loc =
???????????????????????????????? offsetof(struct nvme_get_log_page_command, lid);
-?????????????? return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+?????????????????????? return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
???????????????? }
???????? case nvme_admin_identify:
???????????????? req->data_len = NVME_IDENTIFY_DATA_SIZE;
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
