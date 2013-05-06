From: matthew.r.wilcox@intel.com (Matthew Wilcox)
Date: Mon,  6 May 2013 08:22:18 -0400
Subject: [PATCH] NVMe: Simplify Firmware Activate code slightly
Message-ID: <1367842938-17731-1-git-send-email-matthew.r.wilcox@intel.com>

Add definitions for the three Firmware Activate actions, and change the
SCSI translation code to construct the command into a temporary variable
instead of translating the endianness back-and-forth.

Signed-off-by: Matthew Wilcox <matthew.r.wilcox at intel.com>
---
 drivers/block/nvme-scsi.c |    6 ++----
 include/linux/nvme.h      |    3 +++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index 1c0710c..fed54b0 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -1577,10 +1577,8 @@ static int nvme_trans_send_fw_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		c.dlfw.numd = cpu_to_le32((tot_len/BYTES_TO_DWORDS) - 1);
 		c.dlfw.offset = cpu_to_le32(offset/BYTES_TO_DWORDS);
 	} else if (opcode == nvme_admin_activate_fw) {
-		c.common.cdw10[0] = cpu_to_le32(buffer_id);
-		/* AA=01b Replace & activate at reset */
-		c.common.cdw10[0] = cpu_to_le32(le32_to_cpu(
-						c.common.cdw10[0]) | 0x00000008);
+		u32 cdw10 = buffer_id | NVME_FWACT_REPL_ACTV;
+		c.common.cdw10[0] = cpu_to_le32(cdw10);
 	}
 
 	nvme_sc = nvme_submit_admin_cmd(dev, &c, NULL);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 971ef08..f451c8d 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -316,6 +316,9 @@ enum {
 	NVME_FEAT_WRITE_ATOMIC	= 0x0a,
 	NVME_FEAT_ASYNC_EVENT	= 0x0b,
 	NVME_FEAT_SW_PROGRESS	= 0x0c,
+	NVME_FWACT_REPL		= (0 << 3),
+	NVME_FWACT_REPL_ACTV	= (1 << 3),
+	NVME_FWACT_ACTV		= (2 << 3),
 };
 
 struct nvme_identify {
-- 
1.7.10.4
