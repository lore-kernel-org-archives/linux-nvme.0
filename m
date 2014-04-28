From: keith.busch@intel.com (Keith Busch)
Date: Mon, 28 Apr 2014 17:16:19 -0600
Subject: [PATCH] NVMe: Passthrough IOCTL for IO commands
Message-ID: <1398726979-26954-1-git-send-email-keith.busch@intel.com>

The NVME_IOCTL_SUBMIT_IO only works for IO commands with block data
transfers and isn't usable for other NVMe commands like flush,
data set management, or any sort of vendor unique command. The
NVME_IOCTL_ADMIN_CMD, however, can easily be modified to accept IO
commands as well without breaking ABI compatibility. This patch just adds
a new IOCTL to distinquish if we should submit on an IO or Admin queue.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---

As an example of what this can get us, here's a 'flush' user program:

int main(int argc, char **argv)
{
	static const char *perrstr;
	int err, fd;
	unsigned nsid;
	struct nvme_passthru_cmd cmd;

	if (argc < 2) {
		fprintf(stderr, "Usage: %s <device> <nsid(optional)>\n",
								argv[0]);
		return 1;
	}

	perrstr = argv[1];
	fd = open(argv[1], O_RDWR);
	if (fd < 0)
		goto perror;

	if (argc == 2) {
		perrstr = "Getting namespace ID";
		nsid = ioctl(fd, NVME_IOCTL_ID);
		if (nsid == (unsigned)-1)
			goto perror;
	} else {
		if (sscanf(argv[2], "%i", &nsid) != 1) {
			fprintf(stderr, "Invalid parameter:%s\n", argv[2]);
			return 1;
		}
	}

	memset(&cmd, 0, sizeof(cmd));
	cmd.opcode = nvme_cmd_flush;
	cmd.nsid = nsid;

	perrstr = "Flush";
	err = ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
	if (err < 0)
		goto perror;
	else if (err != 0)
		fprintf(stderr, "NVME IO command error:%d\n", err);
	else
		printf("NVMe Flush: success\n");
	return err;

 perror:
	perror(perrstr);
	return 1;
}

 drivers/block/nvme-core.c |   17 ++++++++++++-----
 include/uapi/linux/nvme.h |    5 ++++-
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index efa9c8f..40fa193 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1639,10 +1639,10 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
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
@@ -1681,6 +1681,9 @@ static int nvme_user_admin_cmd(struct nvme_dev *dev,
 								ADMIN_TIMEOUT;
 	if (length != cmd.data_len)
 		status = -ENOMEM;
+	else if (ioq)
+		status = nvme_submit_sync_cmd(dev, smp_processor_id() + 1, &c,
+							&cmd.result, timeout);
 	else
 		status = nvme_submit_sync_cmd(dev, 0, &c, &cmd.result, timeout);
 
@@ -1706,7 +1709,9 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
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
@@ -2592,7 +2597,9 @@ static long nvme_dev_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
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
index 096fe1c..a5f4161 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -461,7 +461,7 @@ struct nvme_user_io {
 	__u16	appmask;
 };
 
-struct nvme_admin_cmd {
+struct nvme_passthru_cmd {
 	__u8	opcode;
 	__u8	flags;
 	__u16	rsvd1;
@@ -482,8 +482,11 @@ struct nvme_admin_cmd {
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
