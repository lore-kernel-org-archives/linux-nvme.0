From: jsmart2021@gmail.com (James Smart)
Date: Thu,  7 Sep 2017 16:27:26 -0700
Subject: [PATCH 2/5] nvme-fc: remove use of FC-specific error codes
In-Reply-To: <20170907232729.28763-1-jsmart2021@gmail.com>
References: <20170907232729.28763-1-jsmart2021@gmail.com>
Message-ID: <20170907232729.28763-3-jsmart2021@gmail.com>

The FC-NVME transport used the FC-specific error codes in cases where
it had to fabricate an error to go back up stack. Instead of using the
FC-specific values, now use a generic value (NVME_SC_INTERNAL).

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6e436987baae..af075e998944 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1376,7 +1376,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	if (atomic_read(&op->state) == FCPOP_STATE_ABORTED)
 		status = cpu_to_le16((NVME_SC_ABORT_REQ | NVME_SC_DNR) << 1);
 	else if (freq->status)
-		status = cpu_to_le16(NVME_SC_FC_TRANSPORT_ERROR << 1);
+		status = cpu_to_le16(NVME_SC_INTERNAL << 1);
 
 	/*
 	 * For the linux implementation, if we have an unsuccesful
@@ -1404,7 +1404,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		 */
 		if (freq->transferred_length !=
 			be32_to_cpu(op->cmd_iu.data_len)) {
-			status = cpu_to_le16(NVME_SC_FC_TRANSPORT_ERROR << 1);
+			status = cpu_to_le16(NVME_SC_INTERNAL << 1);
 			goto done;
 		}
 		result.u64 = 0;
@@ -1421,7 +1421,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 					freq->transferred_length ||
 			     op->rsp_iu.status_code ||
 			     sqe->common.command_id != cqe->command_id)) {
-			status = cpu_to_le16(NVME_SC_FC_TRANSPORT_ERROR << 1);
+			status = cpu_to_le16(NVME_SC_INTERNAL << 1);
 			goto done;
 		}
 		result = cqe->result;
@@ -1429,7 +1429,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		break;
 
 	default:
-		status = cpu_to_le16(NVME_SC_FC_TRANSPORT_ERROR << 1);
+		status = cpu_to_le16(NVME_SC_INTERNAL << 1);
 		goto done;
 	}
 
-- 
2.13.1
