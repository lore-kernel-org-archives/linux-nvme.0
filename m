From: scott.bauer@intel.com (Scott Bauer)
Date: Wed, 22 Feb 2017 10:15:06 -0700
Subject: [PATCH 1/3] block/sed-opal: Introduce free_opal_dev to free the
 structure and clean up state
In-Reply-To: <1487783708-16285-1-git-send-email-scott.bauer@intel.com>
References: <1487783708-16285-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1487783708-16285-2-git-send-email-scott.bauer@intel.com>

Before we free the opal structure we need to clean up any saved
locking ranges that the user had told us to unlock from a suspend.

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 block/sed-opal.c         | 30 ++++++++++++++++++++++++++++++
 include/linux/sed-opal.h |  5 +++++
 2 files changed, 35 insertions(+)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 8935575..020bf3e 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1987,6 +1987,28 @@ static int check_opal_support(struct opal_dev *dev)
 	return ret;
 }
 
+static void clean_opal_dev(struct opal_dev *dev)
+{
+
+	struct opal_suspend_data *suspend, *next;
+
+	mutex_lock(&dev->dev_lock);
+	list_for_each_entry_safe(suspend, next, &dev->unlk_lst, node) {
+		list_del(&suspend->node);
+		kfree(suspend);
+	}
+	mutex_unlock(&dev->dev_lock);
+}
+
+void free_opal_dev(struct opal_dev *dev)
+{
+	if (!dev)
+		return;
+	clean_opal_dev(dev);
+	kfree(dev);
+}
+EXPORT_SYMBOL(free_opal_dev);
+
 struct opal_dev *init_opal_dev(void *data, sec_send_recv *send_recv)
 {
 	struct opal_dev *dev;
@@ -2141,6 +2163,14 @@ static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal)
 	setup_opal_dev(dev, revert_steps);
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
+
+	/*
+	 * If we successfully reverted lets clean
+	 * any saved locking ranges.
+	 */
+	if (!ret)
+		clean_opal_dev(dev);
+
 	return ret;
 }
 
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index deee23d..04b124f 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -27,6 +27,7 @@ typedef int (sec_send_recv)(void *data, u16 spsp, u8 secp, void *buffer,
 		size_t len, bool send);
 
 #ifdef CONFIG_BLK_SED_OPAL
+void free_opal_dev(struct opal_dev *dev);
 bool opal_unlock_from_suspend(struct opal_dev *dev);
 struct opal_dev *init_opal_dev(void *data, sec_send_recv *send_recv);
 int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *ioctl_ptr);
@@ -51,6 +52,10 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	return false;
 }
 #else
+static inline void free_opal_dev(struct opal_dev *dev)
+{
+}
+
 static inline bool is_sed_ioctl(unsigned int cmd)
 {
 	return false;
-- 
2.7.4
