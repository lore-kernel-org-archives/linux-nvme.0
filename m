From: scott.bauer@intel.com (Scott Bauer)
Date: Mon, 13 Feb 2017 09:11:09 -0700
Subject: [PATCH V5 1/4] block: sed-opal: change ioctl to take user pointer
 instead of unsinged long
In-Reply-To: <1487002272-17940-1-git-send-email-scott.bauer@intel.com>
References: <1487002272-17940-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1487002272-17940-2-git-send-email-scott.bauer@intel.com>

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
---
 block/sed-opal.c         | 6 ++++--
 drivers/nvme/host/core.c | 3 ++-
 include/linux/sed-opal.h | 4 ++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index bf1406e..2448d4a 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -2344,9 +2344,11 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
 }
 EXPORT_SYMBOL(opal_unlock_from_suspend);
 
-int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr)
+int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 {
-	void __user *arg = (void __user *)ptr;
+	void *ioctl_ptr;
+	int ret = -ENOTTY;
+	unsigned int cmd_size = _IOC_SIZE(cmd);
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d9f4903..04c48e7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -811,7 +811,8 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 			return nvme_nvm_ioctl(ns, cmd, arg);
 #endif
 		if (is_sed_ioctl(cmd))
-			return sed_ioctl(&ns->ctrl->opal_dev, cmd, arg);
+			return sed_ioctl(&ns->ctrl->opal_dev, cmd,
+					 (void __user *) arg);
 		return -ENOTTY;
 	}
 }
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index af1a85e..205d520 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -132,7 +132,7 @@ struct opal_dev {
 #ifdef CONFIG_BLK_SED_OPAL
 bool opal_unlock_from_suspend(struct opal_dev *dev);
 void init_opal_dev(struct opal_dev *opal_dev, sec_send_recv *send_recv);
-int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr);
+int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *ioctl_ptr);
 
 static inline bool is_sed_ioctl(unsigned int cmd)
 {
@@ -160,7 +160,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 }
 
 static inline int sed_ioctl(struct opal_dev *dev, unsigned int cmd,
-			    unsigned long ptr)
+			    void __user *ioctl_ptr)
 {
 	return 0;
 }
-- 
2.7.4
