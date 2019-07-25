From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 25 Jul 2019 11:23:20 -0600
Subject: [PATCH v6 01/16] chardev: factor out cdev_lookup() helper
In-Reply-To: <20190725172335.6825-1-logang@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
Message-ID: <20190725172335.6825-2-logang@deltatee.com>

Create a new helper out of the code in chrdev_open() which looks up
a struct cdev from a struct inode.

This will be necessary to create a cdev_get_by_path() which is
similar to blkdev_get_by_path() and is required to allow NVMe-OF
passthru to lookup an NVMe controller cdev from a path.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Cc: Greg Kroah-Hartman <gregkh at linuxfoundation.org>
Cc: Alexander Viro <viro at zeniv.linux.org.uk>
---
 fs/char_dev.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 00dfe17871ac..5cc53bd5f654 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -367,12 +367,8 @@ void cdev_put(struct cdev *p)
 	}
 }
 
-/*
- * Called every time a character special file is opened
- */
-static int chrdev_open(struct inode *inode, struct file *filp)
+static struct cdev *cdev_lookup(struct inode *inode)
 {
-	const struct file_operations *fops;
 	struct cdev *p;
 	struct cdev *new = NULL;
 	int ret = 0;
@@ -385,7 +381,7 @@ static int chrdev_open(struct inode *inode, struct file *filp)
 		spin_unlock(&cdev_lock);
 		kobj = kobj_lookup(cdev_map, inode->i_rdev, &idx);
 		if (!kobj)
-			return -ENXIO;
+			return ERR_PTR(-ENXIO);
 		new = container_of(kobj, struct cdev, kobj);
 		spin_lock(&cdev_lock);
 		/* Check i_cdev again in case somebody beat us to it while
@@ -402,7 +398,23 @@ static int chrdev_open(struct inode *inode, struct file *filp)
 	spin_unlock(&cdev_lock);
 	cdev_put(new);
 	if (ret)
-		return ret;
+		return ERR_PTR(ret);
+
+	return p;
+}
+
+/*
+ * Called every time a character special file is opened
+ */
+static int chrdev_open(struct inode *inode, struct file *filp)
+{
+	const struct file_operations *fops;
+	struct cdev *p;
+	int ret = 0;
+
+	p = cdev_lookup(inode);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	ret = -ENXIO;
 	fops = fops_get(p->ops);
-- 
2.20.1
