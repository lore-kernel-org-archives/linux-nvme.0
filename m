From: keith.busch@intel.com (Keith Busch)
Date: Wed, 25 Jul 2012 16:07:55 -0600
Subject: [PATCH] NVMe: replace nvme_ns with nvme_dev for user admin
Message-ID: <1343254075-439-1-git-send-email-keith.busch@intel.com>

The function nvme_user_admin_command does not require a namespace to proceed.
Replace with the nvme_dev structure so that it can be called from contexts that
do not have a namespace.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 38b9c73..ff0cfda 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -1151,10 +1151,9 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	return status;
 }
 
-static int nvme_user_admin_cmd(struct nvme_ns *ns,
+static int nvme_user_admin_cmd(struct nvme_dev *dev,
 					struct nvme_admin_cmd __user *ucmd)
 {
-	struct nvme_dev *dev = ns->dev;
 	struct nvme_admin_cmd cmd;
 	struct nvme_command c;
 	int status, length;
@@ -1209,7 +1208,7 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
 	case NVME_IOCTL_ID:
 		return ns->ns_id;
 	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_admin_cmd(ns, (void __user *)arg);
+		return nvme_user_admin_cmd(ns->dev, (void __user *)arg);
 	case NVME_IOCTL_SUBMIT_IO:
 		return nvme_submit_io(ns, (void __user *)arg);
 	default:
-- 
1.7.0.4
