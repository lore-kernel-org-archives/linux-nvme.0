From: keith.busch@intel.com (Keith Busch)
Date: Tue, 29 Apr 2014 15:52:27 -0600
Subject: [PATCHv2] NVMe: Use last bytes of f/w rev SCSI Inquiry
Message-ID: <1398808347-9839-1-git-send-email-keith.busch@intel.com>

After skipping right-padded spaces, use the last four bytes of the
firmware revision when reporting the Inquiry Product Revision. These
are generally more indicative to what is running.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1 -> v2:

The NVMe spec defines this field as an ASCII string, which may be
right-padded with spaces and we don't care to use those in reporting a
product revision.

I have it on good authority that the SNT reference will be updated to
align more like the SAT, which uses the last words of the ATA Identify
firmware revision unless it is padded with spaces in which case it uses
the first. In anticipation of that, here's a patch!

 drivers/block/nvme-scsi.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index 2c3f5be..00a3f18 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -686,6 +686,7 @@ static int nvme_trans_standard_inquiry_page(struct nvme_ns *ns,
 	u8 resp_data_format = 0x02;
 	u8 protect;
 	u8 cmdque = 0x01 << 1;
+	u8 fw_offset = sizeof(dev->firmware_rev);
 
 	mem = dma_alloc_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
 				&dma_addr, GFP_KERNEL);
@@ -721,7 +722,11 @@ static int nvme_trans_standard_inquiry_page(struct nvme_ns *ns,
 	inq_response[7] = cmdque;	/* wbus16=0 | sync=0 | vs=0 */
 	strncpy(&inq_response[8], "NVMe    ", 8);
 	strncpy(&inq_response[16], dev->model, 16);
-	strncpy(&inq_response[32], dev->firmware_rev, 4);
+
+	while (dev->firmware_rev[fw_offset - 1] == ' ' && fw_offset > 4)
+		fw_offset--;
+	fw_offset -= 4;
+	strncpy(&inq_response[32], dev->firmware_rev + fw_offset, 4);
 
 	xfer_len = min(alloc_len, STANDARD_INQUIRY_LENGTH);
 	res = nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
-- 
1.7.10.4
