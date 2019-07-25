From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 25 Jul 2019 11:23:21 -0600
Subject: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
In-Reply-To: <20190725172335.6825-1-logang@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
Message-ID: <20190725172335.6825-3-logang@deltatee.com>

cdev_get_by_path() attempts to retrieve a struct cdev from
a path name. It is analagous to blkdev_get_by_path().

This will be necessary to create a nvme_ctrl_get_by_path()to
support NVMe-OF passthru.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Cc: Greg Kroah-Hartman <gregkh at linuxfoundation.org>
Cc: Alexander Viro <viro at zeniv.linux.org.uk>
---
 fs/char_dev.c        | 34 ++++++++++++++++++++++++++++++++++
 include/linux/cdev.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 5cc53bd5f654..25037d642ff8 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -22,6 +22,7 @@
 #include <linux/mutex.h>
 #include <linux/backing-dev.h>
 #include <linux/tty.h>
+#include <linux/namei.h>
 
 #include "internal.h"
 
@@ -403,6 +404,38 @@ static struct cdev *cdev_lookup(struct inode *inode)
 	return p;
 }
 
+struct cdev *cdev_get_by_path(const char *pathname)
+{
+	struct inode *inode;
+	struct cdev *cdev;
+	struct path path;
+	int error;
+
+	if (!pathname || !*pathname)
+		return ERR_PTR(-EINVAL);
+
+	error = kern_path(pathname, LOOKUP_FOLLOW, &path);
+	if (error)
+		return ERR_PTR(error);
+
+	if (!may_open_dev(&path)) {
+		cdev = ERR_PTR(-EACCES);
+		goto out;
+	}
+
+	inode = d_backing_inode(path.dentry);
+	if (!S_ISCHR(inode->i_mode)) {
+		cdev = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	cdev = cdev_lookup(inode);
+
+out:
+	path_put(&path);
+	return cdev;
+}
+
 /*
  * Called every time a character special file is opened
  */
@@ -690,5 +723,6 @@ EXPORT_SYMBOL(cdev_add);
 EXPORT_SYMBOL(cdev_set_parent);
 EXPORT_SYMBOL(cdev_device_add);
 EXPORT_SYMBOL(cdev_device_del);
+EXPORT_SYMBOL(cdev_get_by_path);
 EXPORT_SYMBOL(__register_chrdev);
 EXPORT_SYMBOL(__unregister_chrdev);
diff --git a/include/linux/cdev.h b/include/linux/cdev.h
index 0e8cd6293deb..c7f2df2ca69a 100644
--- a/include/linux/cdev.h
+++ b/include/linux/cdev.h
@@ -24,6 +24,7 @@ void cdev_init(struct cdev *, const struct file_operations *);
 
 struct cdev *cdev_alloc(void);
 
+struct cdev *cdev_get_by_path(const char *pathname);
 void cdev_put(struct cdev *p);
 
 int cdev_add(struct cdev *, dev_t, unsigned);
-- 
2.20.1
