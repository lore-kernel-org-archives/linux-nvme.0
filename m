From: keith.busch@intel.com (Keith Busch)
Date: Thu, 23 Apr 2015 10:24:45 -0600
Subject: [PATCH] NVMe: Fix VPD B0 max sectors translation
Message-ID: <1429806285-11418-1-git-send-email-keith.busch@intel.com>

Use the namespace's block format for reporting the max transfer length.

Max unmap count is left as-is since NVMe doesn't provide a max, so the
value the driver provided the block layer is valid for any format.

Reported-by: Martin K. Petersen <martin.petersen at oracle.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-scsi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index 6b736b0..88f13c5 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -944,7 +944,8 @@ static int nvme_trans_ext_inq_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 static int nvme_trans_bdev_limits_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 					u8 *inq_response, int alloc_len)
 {
-	__be32 max_sectors = cpu_to_be32(queue_max_hw_sectors(ns->queue));
+	__be32 max_sectors = cpu_to_be32(
+		nvme_block_nr(ns, queue_max_hw_sectors(ns->queue)));
 	__be32 max_discard = cpu_to_be32(ns->queue->limits.max_discard_sectors);
 	__be32 discard_desc_count = cpu_to_be32(0x100);
 
-- 
1.7.10.4
