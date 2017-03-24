From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu, 23 Mar 2017 20:41:23 -0700
Subject: [PATCH 2/6] nvme_fc: Add check of status_code in ERSP_IU
In-Reply-To: <20170324034127.8676-1-jsmart2021@gmail.com>
References: <20170324034127.8676-1-jsmart2021@gmail.com>
Message-ID: <20170324034127.8676-3-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

Add check of status_code in ERSP_IU

Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/fc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9690beb..7b8989a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1226,6 +1226,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 					(freq->rcv_rsplen / 4) ||
 			     be32_to_cpu(op->rsp_iu.xfrd_len) !=
 					freq->transferred_length ||
+			     op->rsp_iu.status_code ||
 			     op->rqno != le16_to_cpu(cqe->command_id))) {
 			status = -EIO;
 			goto done;
-- 
2.9.3
