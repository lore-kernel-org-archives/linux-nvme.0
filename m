From: jsmart2021@gmail.com (James Smart)
Date: Thu,  7 Sep 2017 16:27:29 -0700
Subject: [PATCH 5/5] lpfc: remove use of FC-specific error codes
In-Reply-To: <20170907232729.28763-1-jsmart2021@gmail.com>
References: <20170907232729.28763-1-jsmart2021@gmail.com>
Message-ID: <20170907232729.28763-6-jsmart2021@gmail.com>

The lpfc driver used the FC-specific error when it needed to return
an error to the FC-NVME transport. Convert to use a generic value
(NVME_SC_INTERNAL).

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/scsi/lpfc/lpfc_nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 0a0a1b92d01d..d05af618e63f 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -884,7 +884,7 @@ lpfc_nvme_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 					 wcqe->total_data_placed);
 			nCmd->transferred_length = 0;
 			nCmd->rcv_rsplen = 0;
-			nCmd->status = NVME_SC_FC_TRANSPORT_ERROR;
+			nCmd->status = NVME_SC_INTERNAL;
 		}
 	}
 
-- 
2.13.1
