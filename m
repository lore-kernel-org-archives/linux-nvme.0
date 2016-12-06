From: luto@kernel.org (Andy Lutomirski)
Date: Tue,  6 Dec 2016 10:14:35 -0800
Subject: [PATCH] nvme/scsi: Remove START STOP emulation
Message-ID: <1a075417a8c929924316bb5f9d93370c485c9d0e.1481048041.git.luto@kernel.org>

Now that the broken power state control is gone, it appears to serve
no purpose.  Just delete it.  NVME devices don't have a concept of
started vs stopped anyway.

Signed-off-by: Andy Lutomirski <luto at kernel.org>
---
 drivers/nvme/host/scsi.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index 3eaa4d27801e..6369d48b5f9f 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -2165,32 +2165,6 @@ static int nvme_trans_synchronize_cache(struct nvme_ns *ns,
 	return nvme_trans_status_code(hdr, nvme_sc);
 }
 
-static int nvme_trans_start_stop(struct nvme_ns *ns, struct sg_io_hdr *hdr,
-							u8 *cmd)
-{
-	u8 immed, pcmod, no_flush, start;
-
-	immed = cmd[1] & 0x01;
-	pcmod = cmd[3] & 0x0f;
-	no_flush = cmd[4] & 0x04;
-	start = cmd[4] & 0x01;
-
-	if (immed != 0) {
-		return nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-	} else {
-		if (no_flush == 0) {
-			/* Issue NVME FLUSH command prior to START STOP UNIT */
-			int res = nvme_trans_synchronize_cache(ns, hdr);
-			if (res)
-				return res;
-		}
-
-		return 0;
-	}
-}
-
 static int nvme_trans_format_unit(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 							u8 *cmd)
 {
@@ -2446,9 +2420,6 @@ static int nvme_scsi_translate(struct nvme_ns *ns, struct sg_io_hdr *hdr)
 	case SECURITY_PROTOCOL_OUT:
 		retcode = nvme_trans_security_protocol(ns, hdr, cmd);
 		break;
-	case START_STOP:
-		retcode = nvme_trans_start_stop(ns, hdr, cmd);
-		break;
 	case SYNCHRONIZE_CACHE:
 		retcode = nvme_trans_synchronize_cache(ns, hdr);
 		break;
-- 
2.9.3
