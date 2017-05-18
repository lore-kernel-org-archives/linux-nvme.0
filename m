From: zouming.zouming@huawei.com (Zou Ming)
Date: Thu, 18 May 2017 04:17:41 +0000
Subject: [PATCH] Add a parameter for  NVME_IOCTL_ID to get Namespaces ID
Message-ID: <1495081061-17660-1-git-send-email-zouming.zouming@huawei.com>

For distinguish return value,add a parameter for NVME_IOCTL_ID to get Namespaces ID.
---
 drivers/nvme/host/core.c        | 3 +--
 include/uapi/linux/nvme_ioctl.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3818ff6..886a031 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -769,8 +769,7 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 
 	switch (cmd) {
 	case NVME_IOCTL_ID:
-		force_successful_syscall_return();
-		return ns->ns_id;
+		return put_user(ns->ns_id, (__u32 __user *)arg);
 	case NVME_IOCTL_ADMIN_CMD:
 		return nvme_user_cmd(ns->ctrl, NULL, (void __user *)arg);
 	case NVME_IOCTL_IO_CMD:
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index 50ff21f..71eb8fd 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -55,7 +55,7 @@ struct nvme_passthru_cmd {
 
 #define nvme_admin_cmd nvme_passthru_cmd
 
-#define NVME_IOCTL_ID		_IO('N', 0x40)
+#define NVME_IOCTL_ID		_IO('N', 0x40, __u32)
 #define NVME_IOCTL_ADMIN_CMD	_IOWR('N', 0x41, struct nvme_admin_cmd)
 #define NVME_IOCTL_SUBMIT_IO	_IOW('N', 0x42, struct nvme_user_io)
 #define NVME_IOCTL_IO_CMD	_IOWR('N', 0x43, struct nvme_passthru_cmd)
-- 
2.6.4.windows.1
