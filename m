From: jsmart2021@gmail.com (James Smart)
Date: Sat, 24 Dec 2016 09:46:39 -0800
Subject: [PATCH 2/3] nvme_fc: Add check of status_code in ERSP_IU
Message-ID: <585eb47f.QfHJhdihZkHxbVbF%jsmart2021@gmail.com>


Add check of status_code in ERSP_IU

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 827c2b5..03bb599 100644
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
2.5.0
