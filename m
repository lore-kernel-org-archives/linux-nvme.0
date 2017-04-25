From: hch@lst.de (Christoph Hellwig)
Date: Tue, 25 Apr 2017 19:00:56 +0200
Subject: [PATCH] nvme-scsi: remove nvme_trans_security_protocol
Message-ID: <20170425170056.15735-1-hch@lst.de>

This function just returns the same error code and sense data as
the default statement in the switch in the caller.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/scsi.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index f49ae2758bb7..a232b13bad6e 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -2138,15 +2138,6 @@ static int nvme_trans_request_sense(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	return res;
 }
 
-static int nvme_trans_security_protocol(struct nvme_ns *ns,
-					struct sg_io_hdr *hdr,
-					u8 *cmd)
-{
-	return nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
-				ILLEGAL_REQUEST, SCSI_ASC_ILLEGAL_COMMAND,
-				SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-}
-
 static int nvme_trans_synchronize_cache(struct nvme_ns *ns,
 					struct sg_io_hdr *hdr)
 {
@@ -2414,10 +2405,6 @@ static int nvme_scsi_translate(struct nvme_ns *ns, struct sg_io_hdr *hdr)
 	case REQUEST_SENSE:
 		retcode = nvme_trans_request_sense(ns, hdr, cmd);
 		break;
-	case SECURITY_PROTOCOL_IN:
-	case SECURITY_PROTOCOL_OUT:
-		retcode = nvme_trans_security_protocol(ns, hdr, cmd);
-		break;
 	case SYNCHRONIZE_CACHE:
 		retcode = nvme_trans_synchronize_cache(ns, hdr);
 		break;
-- 
2.11.0
