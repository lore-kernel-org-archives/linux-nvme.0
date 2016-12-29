From: scott.bauer@intel.com (Scott Bauer)
Date: Thu, 29 Dec 2016 12:26:52 -0700
Subject: [PATCH v4 3/6] block: add ioctl interface for interfacing with Opal
 library
In-Reply-To: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1483039615-22407-4-git-send-email-scott.bauer@intel.com>

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
Signed-off-by: Rafael Antognolli <Rafael.Antognolli at intel.com>
---
 block/sed-ioctl.c | 164 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 block/sed-ioctl.c

diff --git a/block/sed-ioctl.c b/block/sed-ioctl.c
new file mode 100644
index 0000000..d17a84f
--- /dev/null
+++ b/block/sed-ioctl.c
@@ -0,0 +1,164 @@
+/*
+ * Copyright ? 2016 Intel Corporation
+ *
+ * Authors:
+ *    Rafael Antognolli <rafael.antognolli at intel.com>
+ *    Scott  Bauer      <scott.bauer at intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/blkdev.h>
+#include <linux/sed.h>
+#include <linux/sed-opal.h>
+#include <asm/uaccess.h>
+
+static int sed_opal_save(struct sed_context *sed_ctx, void __user *arg)
+{
+	struct opal_lock_unlock lk_unlk;
+
+	if (copy_from_user(&lk_unlk, arg, sizeof(lk_unlk)))
+	    return -EFAULT;
+	return opal_save(sed_ctx, &lk_unlk);
+}
+
+static int sed_opal_lock_unlock(struct sed_context *sed_ctx, void __user *arg)
+{
+	struct opal_lock_unlock lk_unlk;
+
+	if (copy_from_user(&lk_unlk, arg, sizeof(lk_unlk)))
+		return -EFAULT;
+	return opal_lock_unlock(sed_ctx, &lk_unlk);
+}
+
+static int sed_opal_take_ownership(struct sed_context *sed_ctx, void __user *arg)
+{
+	struct opal_key opal_key;
+
+	if (copy_from_user(&opal_key, arg, sizeof(opal_key)))
+		return -EFAULT;
+	return opal_take_ownership(sed_ctx, &opal_key);
+}
+
+static int sed_opal_activate_lsp(struct sed_context *sed_ctx, void __user *arg)
+{
+	struct opal_key opal_key;
+
+	if (copy_from_user(&opal_key, arg, sizeof(opal_key)))
+		return -EFAULT;
+	return opal_activate_lsp(sed_ctx, &opal_key);
+}
+
+static int sed_opal_set_pw(struct sed_context *sed_ctx, void __user *arg)
+{
+	struct opal_new_pw opal_pw;
+	if (copy_from_user(&opal_pw, arg, sizeof(opal_pw)))
+		return -EFAULT;
+	return opal_set_new_pw(sed_ctx, &opal_pw);
+}
+
+static int sed_opal_activate_user(struct sed_context *sed_ctx, void __user *arg)
+{
+	struct opal_session_info session;
+	if (copy_from_user(&session, arg, sizeof(session)))
+		return -EFAULT;
+	return opal_activate_user(sed_ctx, &session);
+}
+
+static int sed_opal_reverttper(struct sed_context *sed_ctx, void __user *arg)
+{
+	struct opal_key opal_key;
+
+	if (copy_from_user(&opal_key, arg, sizeof(opal_key)))
+		return -EFAULT;
+	return opal_reverttper(sed_ctx, &opal_key);
+}
+
+static int sed_opal_setup_locking_range(struct sed_context *sed_ctx,
+					void __user *arg)
+{
+	struct opal_user_lr_setup lrs;
+	if (copy_from_user(&lrs, arg, sizeof(lrs)))
+		return -EFAULT;
+	return opal_setup_locking_range(sed_ctx, &lrs);
+}
+
+static int sed_opal_adduser_to_lr(struct sed_context *sed_ctx, void __user *arg)
+{
+	struct opal_lock_unlock lk_unlk;
+
+	if (copy_from_user(&lk_unlk, arg, sizeof(lk_unlk)))
+		return -EFAULT;
+	return opal_add_user_to_lr(sed_ctx, &lk_unlk);
+}
+
+static int sed_opal_do_mbr(struct sed_context *sed_ctx, void __user *arg)
+{
+	struct opal_mbr_data mbr;
+	if (copy_from_user(&mbr, arg, sizeof(mbr)))
+		return -EFAULT;
+	return opal_enable_disable_shadow_mbr(sed_ctx, &mbr);
+}
+
+static int sed_opal_erase_lr(struct sed_context *sed_ctx, void __user *arg)
+{
+	struct opal_session_info session;
+	if (copy_from_user(&session, arg, sizeof(session)))
+		return -EFAULT;
+	return opal_erase_locking_range(sed_ctx, &session);
+}
+
+static int sed_opal_secure_erase_lr(struct sed_context *sed_ctx, void __user *arg)
+{
+	struct opal_session_info session;
+	if (copy_from_user(&session, arg, sizeof(session)))
+		return -EFAULT;
+	return opal_secure_erase_locking_range(sed_ctx, &session);
+}
+
+int sed_ioctl(struct sed_context *sed_ctx, unsigned int cmd, unsigned long arg)
+{
+	void __user *ptr = (void __user *)arg;
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (!sed_ctx->supported) {
+		pr_err("Not supported\n");
+		return -ENOTSUPP;
+	}
+
+	switch (cmd) {
+	case IOC_OPAL_SAVE:
+		return sed_opal_save(sed_ctx, ptr);
+	case IOC_OPAL_LOCK_UNLOCK:
+		return sed_opal_lock_unlock(sed_ctx, ptr);
+	case IOC_OPAL_TAKE_OWNERSHIP:
+		return sed_opal_take_ownership(sed_ctx, ptr);
+	case IOC_OPAL_ACTIVATE_LSP:
+		return sed_opal_activate_lsp(sed_ctx, ptr);
+	case IOC_OPAL_SET_PW:
+		return sed_opal_set_pw(sed_ctx, ptr);
+	case IOC_OPAL_ACTIVATE_USR:
+		return sed_opal_activate_user(sed_ctx, ptr);
+	case IOC_OPAL_REVERT_TPR:
+		return sed_opal_reverttper(sed_ctx, ptr);
+	case IOC_OPAL_LR_SETUP:
+		return sed_opal_setup_locking_range(sed_ctx, ptr);
+	case IOC_OPAL_ADD_USR_TO_LR:
+		return sed_opal_adduser_to_lr(sed_ctx, ptr);
+	case IOC_OPAL_ENABLE_DISABLE_MBR:
+		return sed_opal_do_mbr(sed_ctx, ptr);
+	case IOC_OPAL_ERASE_LR:
+		return sed_opal_erase_lr(sed_ctx, ptr);
+	case IOC_OPAL_SECURE_ERASE_LR:
+		return sed_opal_secure_erase_lr(sed_ctx, ptr);
+	}
+	return -ENOTTY;
+}
+EXPORT_SYMBOL_GPL(sed_ioctl);
-- 
2.7.4
