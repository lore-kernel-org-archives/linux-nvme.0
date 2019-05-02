From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Thu,  2 May 2019 14:47:53 +0300
Subject: [PATCH v2 02/10] vfio/mdev: add .request callback
In-Reply-To: <20190502114801.23116-1-mlevitsk@redhat.com>
References: <20190502114801.23116-1-mlevitsk@redhat.com>
Message-ID: <20190502114801.23116-3-mlevitsk@redhat.com>

This will allow the hotplug to be enabled for mediated devices

Signed-off-by: Maxim Levitsky <mlevitsk at redhat.com>
---
 drivers/vfio/mdev/vfio_mdev.c | 11 +++++++++++
 include/linux/mdev.h          |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/vfio/mdev/vfio_mdev.c b/drivers/vfio/mdev/vfio_mdev.c
index d230620fe02d..17aa76de0764 100644
--- a/drivers/vfio/mdev/vfio_mdev.c
+++ b/drivers/vfio/mdev/vfio_mdev.c
@@ -101,6 +101,16 @@ static int vfio_mdev_mmap(void *device_data, struct vm_area_struct *vma)
 	return parent->ops->mmap(mdev, vma);
 }
 
+static void vfio_mdev_request(void *device_data, unsigned int count)
+{
+	struct mdev_device *mdev = device_data;
+	struct mdev_parent *parent = mdev->parent;
+
+	if (unlikely(!parent->ops->request))
+		return;
+	parent->ops->request(mdev, count);
+}
+
 static const struct vfio_device_ops vfio_mdev_dev_ops = {
 	.name		= "vfio-mdev",
 	.open		= vfio_mdev_open,
@@ -109,6 +119,7 @@ static const struct vfio_device_ops vfio_mdev_dev_ops = {
 	.read		= vfio_mdev_read,
 	.write		= vfio_mdev_write,
 	.mmap		= vfio_mdev_mmap,
+	.request	= vfio_mdev_request,
 };
 
 static int vfio_mdev_probe(struct device *dev)
diff --git a/include/linux/mdev.h b/include/linux/mdev.h
index d7aee90e5da5..6f315cb9575c 100644
--- a/include/linux/mdev.h
+++ b/include/linux/mdev.h
@@ -13,6 +13,9 @@
 #ifndef MDEV_H
 #define MDEV_H
 
+#include <linux/uuid.h>
+#include <linux/device.h>
+
 struct mdev_device;
 
 /**
@@ -81,6 +84,7 @@ struct mdev_parent_ops {
 	long	(*ioctl)(struct mdev_device *mdev, unsigned int cmd,
 			 unsigned long arg);
 	int	(*mmap)(struct mdev_device *mdev, struct vm_area_struct *vma);
+	void	(*request)(struct mdev_device *mdev, unsigned int count);
 };
 
 /* interface for exporting mdev supported type attributes */
-- 
2.17.2
