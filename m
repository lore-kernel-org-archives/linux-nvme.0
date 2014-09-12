From: keith.busch@intel.com (Keith Busch)
Date: Fri, 12 Sep 2014 16:07:20 -0600
Subject: [PATCH RESEND] NVMe: Passthrough IOCTL for IO commands
Message-ID: <1410559640-30561-1-git-send-email-keith.busch@intel.com>

The NVME_IOCTL_SUBMIT_IO only works for IO commands with block data
transfers and isn't usable for other NVMe commands like flush,
data set management, or any sort of vendor unique command. The
NVME_IOCTL_ADMIN_CMD, however, can easily be modified to accept arbitrary
IO commands in addition to arbitrary admin commands without breaking
backward compatibility. This patch just adds a new IOCTL to distinguish
if the driver should submit the command on an IO or Admin queue.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
The only difference from the original patch is now using "this_cpu_read()"
to obtain the queue id instead of the processor id, similar to the bug-fix
in Sam's patch:

http://lists.infradead.org/pipermail/linux-nvme/2014-July/001090.html

which I think should also be applied! :)

 drivers/block/nvme-core.c |   17 ++++++++++++-----
 include/uapi/linux/nvme.h |    5 ++++-
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 2e0f95f..65f6711 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1710,10 +1710,10 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	return status;
 }
 
-static int nvme_user_admin_cmd(struct nvme_dev *dev,
-					struct nvme_admin_cmd __user *ucmd)
+static int nvme_user_cmd(struct nvme_dev *dev,
+			struct nvme_passthru_cmd __user *ucmd, bool ioq)
 {
-	struct nvme_admin_cmd cmd;
+	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
 	int status, length;
 	struct nvme_iod *uninitialized_var(iod);
@@ -1752,6 +1752,9 @@ static int nvme_user_admin_cmd(struct nvme_dev *dev,
 								ADMIN_TIMEOUT;
 	if (length != cmd.data_len)
 		status = -ENOMEM;
+	else if (ioq)
+		status = nvme_submit_sync_cmd(dev, this_cpu_read(*dev->io_queue), &c,
+							&cmd.result, timeout);
 	else
 		status = nvme_submit_sync_cmd(dev, 0, &c, &cmd.result, timeout);
 
@@ -1777,7 +1780,9 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
 		force_successful_syscall_return();
 		return ns->ns_id;
 	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_admin_cmd(ns->dev, (void __user *)arg);
+		return nvme_user_cmd(ns->dev, (void __user *)arg, false);
+	case NVME_IOCTL_IO_CMD:
+		return nvme_user_cmd(ns->dev, (void __user *)arg, true);
 	case NVME_IOCTL_SUBMIT_IO:
 		return nvme_submit_io(ns, (void __user *)arg);
 	case SG_GET_VERSION_NUM:
@@ -2721,7 +2726,9 @@ static long nvme_dev_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	struct nvme_dev *dev = f->private_data;
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_admin_cmd(dev, (void __user *)arg);
+		return nvme_user_cmd(dev, (void __user *)arg, false);
+	case NVME_IOCTL_IO_CMD:
+		return nvme_user_cmd(dev, (void __user *)arg, true);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index 134518b..9710655 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -503,7 +503,7 @@ struct nvme_user_io {
 	__u16	appmask;
 };
 
-struct nvme_admin_cmd {
+struct nvme_passthru_cmd {
 	__u8	opcode;
 	__u8	flags;
 	__u16	rsvd1;
@@ -524,8 +524,11 @@ struct nvme_admin_cmd {
 	__u32	result;
 };
 
+#define nvme_admin_cmd nvme_passthru_cmd
+
 #define NVME_IOCTL_ID		_IO('N', 0x40)
 #define NVME_IOCTL_ADMIN_CMD	_IOWR('N', 0x41, struct nvme_admin_cmd)
 #define NVME_IOCTL_SUBMIT_IO	_IOW('N', 0x42, struct nvme_user_io)
+#define NVME_IOCTL_IO_CMD	_IOWR('N', 0x43, struct nvme_passthru_cmd)
 
 #endif /* _UAPI_LINUX_NVME_H */
-- 
1.7.10.4
