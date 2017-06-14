From: hch@lst.de (Christoph Hellwig)
Date: Wed, 14 Jun 2017 08:35:36 +0200
Subject: [PATCH 1/2] nvme-scsi: remove TEST UNIT READY emuation
In-Reply-To: <20170614063537.1044-1-hch@lst.de>
References: <20170614063537.1044-1-hch@lst.de>
Message-ID: <20170614063537.1044-2-hch@lst.de>

This emulation has been broken for a year and a half, so remove it
instead of hacking around it.

Reported-by: Wen Xiong <wenxiong at linux.vnet.ibm.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/scsi.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index 1f7671e631dd..aff3b36d93b6 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -2204,18 +2204,6 @@ static int nvme_trans_format_unit(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	return res;
 }
 
-static int nvme_trans_test_unit_ready(struct nvme_ns *ns,
-					struct sg_io_hdr *hdr,
-					u8 *cmd)
-{
-	if (nvme_ctrl_ready(ns->ctrl))
-		return nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
-					    NOT_READY, SCSI_ASC_LUN_NOT_READY,
-					    SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-	else
-		return nvme_trans_completion(hdr, SAM_STAT_GOOD, NO_SENSE, 0, 0);
-}
-
 static int nvme_trans_write_buffer(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 							u8 *cmd)
 {
@@ -2411,9 +2399,6 @@ static int nvme_scsi_translate(struct nvme_ns *ns, struct sg_io_hdr *hdr)
 	case FORMAT_UNIT:
 		retcode = nvme_trans_format_unit(ns, hdr, cmd);
 		break;
-	case TEST_UNIT_READY:
-		retcode = nvme_trans_test_unit_ready(ns, hdr, cmd);
-		break;
 	case WRITE_BUFFER:
 		retcode = nvme_trans_write_buffer(ns, hdr, cmd);
 		break;
-- 
2.11.0
