From: vishal.l.verma@intel.com (Vishal Verma)
Date: Thu, 28 Mar 2013 12:42:50 -0600
Subject: [PATCH] NVMe: Fix a build error for u64 division
Message-ID: <1364496170-27921-1-git-send-email-vishal.l.verma@intel.com>

A u64 division was producing a linker error with CONFIG_X86_32

Signed-off-by: Vishal Verma <vishal.l.verma at intel.com>
---
 drivers/block/nvme-scsi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index d5b3afe..483af35 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -2188,7 +2188,7 @@ static int nvme_trans_io(struct nvme_ns *ns, struct sg_io_hdr *hdr, u8 is_write,
 	xfer_bytes = min(((u64)hdr->dxfer_len), sum_iov_len);
 
 	/* If block count and actual data buffer size dont match, error out */
-	if ((xfer_bytes / (1 << ns->lba_shift)) != cdb_info.xfer_len) {
+	if (xfer_bytes != (cdb_info.xfer_len << ns->lba_shift)) {
 		res = -EINVAL;
 		goto out;
 	}
-- 
1.7.0.4
