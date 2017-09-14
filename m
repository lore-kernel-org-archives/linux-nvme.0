From: jsmart2021@gmail.com (James Smart)
Date: Thu, 14 Sep 2017 11:30:15 -0700
Subject: [PATCH] qla2xxx: convert nvme Transport error to internal error
Message-ID: <20170914183015.21540-1-jsmart2021@gmail.com>

Patch removing transport-specific errors crosssed with a qla2xxx update
that referenced the status value being removed.

Swap status to an internal error.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 1f59e7a74c7b..6b33a1f24f56 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -180,7 +180,7 @@ static void qla_nvme_sp_done(void *ptr, int res)
 		goto rel;
 
 	if (unlikely(res == QLA_FUNCTION_FAILED))
-		fd->status = NVME_SC_FC_TRANSPORT_ERROR;
+		fd->status = NVME_SC_INTERNAL;
 	else
 		fd->status = 0;
 
-- 
2.13.1
