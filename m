From: keith.busch@intel.com (Keith Busch)
Date: Thu,  2 Aug 2012 13:10:06 -0600
Subject: [PATCH] NVMe: Add a character device for each nvme device
Message-ID: <1343934606-2268-1-git-send-email-keith.busch@intel.com>

Registers a character device for the nvme module and creates character
files as /dev/nvmeN for each nvme device probed, where N is the device
instance. The character devices support nvme admin ioctl commands so
that nvme devices without namespaces can be managed.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |   96 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 3278fbd..3d13d4b 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -20,6 +20,7 @@
 #include <linux/bio.h>
 #include <linux/bitops.h>
 #include <linux/blkdev.h>
+#include <linux/cdev.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
@@ -45,6 +46,7 @@
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
 #define NVME_MINORS 64
+#define NVME_MAX_DEVS 1024
 #define NVME_IO_TIMEOUT	(5 * HZ)
 #define ADMIN_TIMEOUT	(60 * HZ)
 
@@ -54,9 +56,15 @@ module_param(nvme_major, int, 0);
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
+static int nvme_char_major;
+module_param(nvme_char_major, int, 0);
+
 static DEFINE_SPINLOCK(dev_list_lock);
 static LIST_HEAD(dev_list);
 static struct task_struct *nvme_thread;
+static struct class *nvme_char_cl;
+
+static void nvme_remove_dev(struct kref *kref);
 
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
@@ -75,6 +83,7 @@ struct nvme_dev {
 	struct msix_entry *entry;
 	struct nvme_bar __iomem *bar;
 	struct list_head namespaces;
+	struct kref kref;
 	char serial[20];
 	char model[40];
 	char firmware_rev[8];
@@ -1226,6 +1235,54 @@ static const struct block_device_operations nvme_fops = {
 	.compat_ioctl	= nvme_ioctl,
 };
 
+static int nvme_char_open(struct inode *inode, struct file *f)
+{
+	struct nvme_dev *dev;
+	int instance = iminor(f->f_dentry->d_inode);
+
+	spin_lock(&dev_list_lock);
+	list_for_each_entry(dev, &dev_list, node) {
+		if (dev->instance == instance) {
+			kref_get(&dev->kref);
+			f->private_data = dev;
+			break;
+		}
+	}
+	spin_unlock(&dev_list_lock);
+
+	if (!f->private_data)
+		return -ENXIO;
+
+	return 0;
+}
+
+static int nvme_char_release(struct inode *inode, struct file *f)
+{
+	struct nvme_dev *dev = f->private_data;
+	kref_put(&dev->kref, nvme_remove_dev);
+	return 0;
+}
+
+static long nvme_char_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	struct nvme_dev *dev = f->private_data;
+
+	switch (cmd) {
+	case NVME_IOCTL_ADMIN_CMD:
+		return nvme_user_admin_cmd(dev, (void __user *)arg);
+	default:
+		return -ENOTTY;
+	}
+}
+
+static const struct file_operations nvme_char_fops = {
+	.owner		= THIS_MODULE,
+	.open		= nvme_char_open,
+	.release	= nvme_char_release,
+	.unlocked_ioctl	= nvme_char_ioctl,
+	.compat_ioctl	= nvme_char_ioctl,
+};
+
 static void nvme_timeout_ios(struct nvme_queue *nvmeq)
 {
 	int depth = nvmeq->q_depth - 1;
@@ -1664,6 +1721,11 @@ static int __devinit nvme_probe(struct pci_dev *pdev,
 	if (result)
 		goto delete;
 
+	kref_init(&dev->kref);
+
+	device_create(nvme_char_cl, &pdev->dev,
+					MKDEV(nvme_char_major, dev->instance),
+					NULL, "nvme%d", dev->instance);
 	return 0;
 
  delete:
@@ -1688,21 +1750,28 @@ static int __devinit nvme_probe(struct pci_dev *pdev,
 	return result;
 }
 
-static void __devexit nvme_remove(struct pci_dev *pdev)
+static void nvme_remove_dev(struct kref *kref)
 {
-	struct nvme_dev *dev = pci_get_drvdata(pdev);
+	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
 	nvme_dev_remove(dev);
-	pci_disable_msix(pdev);
+	device_destroy(nvme_char_cl, MKDEV(nvme_char_major, dev->instance));
+	pci_disable_msix(dev->pci_dev);
 	iounmap(dev->bar);
 	nvme_release_instance(dev);
 	nvme_release_prp_pools(dev);
-	pci_disable_device(pdev);
-	pci_release_regions(pdev);
+	pci_disable_device(dev->pci_dev);
+	pci_release_regions(dev->pci_dev);
 	kfree(dev->queues);
 	kfree(dev->entry);
 	kfree(dev);
 }
 
+static void __devexit nvme_remove(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+	kref_put(&dev->kref, nvme_remove_dev);
+}
+
 /* These functions are yet to be implemented */
 #define nvme_error_detected NULL
 #define nvme_dump_registers NULL
@@ -1753,11 +1822,24 @@ static int __init nvme_init(void)
 	else if (result > 0)
 		nvme_major = result;
 
+	result = __register_chrdev(nvme_char_major, 0, NVME_MAX_DEVS, "nvme",
+							&nvme_char_fops);
+	if (result < 0)
+		goto unregister_blkdev;
+	else if (result > 0)
+		nvme_char_major = result;
+	nvme_char_cl = class_create(THIS_MODULE, "nvme");
+	if (!nvme_char_cl)
+		goto unregister_chrdev;
 	result = pci_register_driver(&nvme_driver);
 	if (result)
-		goto unregister_blkdev;
+		goto destroy_class;
 	return 0;
 
+ destroy_class:
+	class_destroy(nvme_char_cl);
+ unregister_chrdev:
+	__unregister_chrdev(nvme_char_major, 0, NVME_MAX_DEVS, "nvme");
  unregister_blkdev:
 	unregister_blkdev(nvme_major, "nvme");
  kill_kthread:
@@ -1768,6 +1850,8 @@ static int __init nvme_init(void)
 static void __exit nvme_exit(void)
 {
 	pci_unregister_driver(&nvme_driver);
+	class_destroy(nvme_char_cl);
+	__unregister_chrdev(nvme_char_major, 0, NVME_MAX_DEVS, "nvme");
 	unregister_blkdev(nvme_major, "nvme");
 	kthread_stop(nvme_thread);
 }
-- 
1.7.0.4
