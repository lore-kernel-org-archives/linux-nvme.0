From: keith.busch@intel.com (Keith Busch)
Date: Thu, 17 Apr 2014 12:13:55 -0600
Subject: [PATCH] NVMe: Use lower bits of firmware rev for SCSI Inq
Message-ID: <1397758435-8305-1-git-send-email-keith.busch@intel.com>

Vendors indicate to me that the lower bits of the NVMe ID Controller
firmware revision are more inidicative of the running version, so while
this isn't aligned with the SNT, it is more useful.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-scsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index 2c3f5be..1b9b5f4 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -721,7 +721,7 @@ static int nvme_trans_standard_inquiry_page(struct nvme_ns *ns,
 	inq_response[7] = cmdque;	/* wbus16=0 | sync=0 | vs=0 */
 	strncpy(&inq_response[8], "NVMe    ", 8);
 	strncpy(&inq_response[16], dev->model, 16);
-	strncpy(&inq_response[32], dev->firmware_rev, 4);
+	strncpy(&inq_response[32], dev->firmware_rev + 4, 4);
 
 	xfer_len = min(alloc_len, STANDARD_INQUIRY_LENGTH);
 	res = nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
-- 
1.7.10.4
