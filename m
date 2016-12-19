From: scott.bauer@intel.com (Scott Bauer)
Date: Mon, 19 Dec 2016 12:35:47 -0700
Subject: [PATCH v3 3/5] fs: Wire up SED/Opal to ioctl
In-Reply-To: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1482176149-2257-4-git-send-email-scott.bauer@intel.com>

Adds a new sed_context pointer to file struct, for char devs who wish
to suppor SED.
Adds ioctl handling code.

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
Signed-off-by: Rafael Antognolli <Rafael.Antognolli at intel.com>
---
 fs/ioctl.c         | 3 +++
 include/linux/fs.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index cb9b029..77def42 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -15,6 +15,7 @@
 #include <linux/writeback.h>
 #include <linux/buffer_head.h>
 #include <linux/falloc.h>
+#include <linux/sed.h>
 #include "internal.h"
 
 #include <asm/ioctls.h>
@@ -679,6 +680,8 @@ int do_vfs_ioctl(struct file *filp, unsigned int fd, unsigned int cmd,
 	default:
 		if (S_ISREG(inode->i_mode))
 			error = file_ioctl(filp, cmd, arg);
+		else if (is_sed_ioctl(cmd))
+			error = fdev_sed_ioctl(filp, cmd, arg);
 		else
 			error = vfs_ioctl(filp, cmd, arg);
 		break;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2ba0743..75a99e5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -55,6 +55,7 @@ struct workqueue_struct;
 struct iov_iter;
 struct fscrypt_info;
 struct fscrypt_operations;
+struct sed_context;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -853,6 +854,7 @@ struct file {
 #ifdef CONFIG_SECURITY
 	void			*f_security;
 #endif
+	struct sed_context      *f_sedctx;
 	/* needed for tty driver, and maybe others */
 	void			*private_data;
 
-- 
2.7.4
