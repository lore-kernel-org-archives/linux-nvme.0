From: prasadjoshi.linux@gmail.com (Prasad Joshi)
Date: Mon,  2 Sep 2013 22:30:24 +0530
Subject: [PATCH] Add data transfer length check for admin commands
Message-ID: <1378141224-4300-1-git-send-email-prasadjoshi.linux@gmail.com>

From: Prasad Joshi <pjoshi@stec-inc.com>

According to NVM Express 1.1 specifications, the lower 2 bits of a
NVME command opcode indicates, the data transfer (Figure 38). Zero value
of these two bits indicates, data length in actual NVME command is not
required. Similarly non-zero value indicates mandatory data transfer
length. The patch adds a verification of these bits along with correct
value of data transfer length.

Suggested-by: Matthew Wilcox <willy at linux.intel.com>
Signed-off-by: Prasad Joshi <pjoshi at stec-inc.com>
Signed-off-by: Anup Shendkar <ashenkar at stec-inc.com>
---
 drivers/block/nvme-core.c | 3 +++
 include/linux/nvme.h      | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index ce79a59..256278e 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1402,6 +1402,9 @@ static int nvme_user_admin_cmd(struct nvme_dev *dev,
 		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
+	if (((cmd.opcode & NVME_ADMIN_CMD_DATA_XFER_MASK) && !cmd.data_len) ||
+		(!(cmd.opcode & NVME_ADMIN_CMD_DATA_XFER_MASK) && cmd.data_len))
+		return -EINVAL;
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index f451c8d..3b2c8ee 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -508,6 +508,13 @@ struct nvme_admin_cmd {
 #define NVME_IOCTL_ADMIN_CMD	_IOWR('N', 0x41, struct nvme_admin_cmd)
 #define NVME_IOCTL_SUBMIT_IO	_IOW('N', 0x42, struct nvme_user_io)
 
+/*
+ * The 2 LSB bits of NVME Admin command opcode are called as data transfer bits.
+ * These two bits define where a command should include data transfer
+ * information.
+ */
+#define NVME_ADMIN_CMD_DATA_XFER_MASK (0b11)
+
 #ifdef __KERNEL__
 #include <linux/pci.h>
 #include <linux/miscdevice.h>
-- 
1.8.1.2
