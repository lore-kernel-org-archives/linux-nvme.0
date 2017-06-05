From: wenxiong@linux.vnet.ibm.com (wenxiong@linux.vnet.ibm.com)
Date: Mon,  5 Jun 2017 10:39:32 -0500
Subject: [PATCH] nvme: TUR(Test unit Ready) broken for nvme drvices
Message-ID: <1496677172-22797-1-git-send-email-wenxiong@linux.vnet.ibm.com>

From: Wen Xiong <wenxiong@linux.vnet.ibm.com>

When doing sg_turs over nvme devices, we got the following errors.
The patch fixes the issue.
dd if=/dev/nvme0n1 of=/dev/null bs=1M count=1
1+0 records in
1+0 records out
1048576 bytes (1.0 MB) copied, 0.000994747 s, 1.1 GB/s

sg_turs /dev/nvme0n1
device not ready

Signed-off-by: Wen Xiong <wenxiong at linux.vnet.ibm.com>
---
 drivers/nvme/host/scsi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index 1f7671e..af27930 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -2208,7 +2208,7 @@ static int nvme_trans_test_unit_ready(struct nvme_ns *ns,
 					struct sg_io_hdr *hdr,
 					u8 *cmd)
 {
-	if (nvme_ctrl_ready(ns->ctrl))
+	if (!nvme_ctrl_ready(ns->ctrl))
 		return nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
 					    NOT_READY, SCSI_ASC_LUN_NOT_READY,
 					    SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-- 
1.7.1
