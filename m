From: keith.busch@intel.com (Keith Busch)
Date: Tue, 27 Nov 2012 15:10:50 -0700
Subject: [PATCH v2] NVMe: Add a character device for each nvme device
Message-ID: <1354054250-361-1-git-send-email-keith.busch@intel.com>

Registers a miscellaneous device for each nvme controller probed. This
creates character device files as /dev/nvmeN, where N is the device
instance, and supports nvme admin ioctl commands so devices without
namespaces can be managed.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |   77 +++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index f9ad514..cab6a96 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -31,6 +31,7 @@
 #include <linux/kdev_t.h>
 #include <linux/kthread.h>
 #include <linux/kernel.h>
+#include <linux/miscdevice.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -75,6 +76,9 @@ struct nvme_dev {
 	struct msix_entry *entry;
 	struct nvme_bar __iomem *bar;
 	struct list_head namespaces;
+	struct kref kref;
+	struct miscdevice miscdev;
+	char name[8];
 	char serial[20];
 	char model[40];
 	char firmware_rev[8];
@@ -1624,6 +1628,55 @@ static void nvme_release_instance(struct nvme_dev *dev)
 	spin_unlock(&dev_list_lock);
 }
 
+static void nvme_free_dev(struct kref *kref)
+{
+	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
+	nvme_dev_remove(dev);
+	pci_disable_msix(dev->pci_dev);
+	iounmap(dev->bar);
+	nvme_release_instance(dev);
+	nvme_release_prp_pools(dev);
+	pci_disable_device(dev->pci_dev);
+	pci_release_regions(dev->pci_dev);
+	kfree(dev->queues);
+	kfree(dev->entry);
+	kfree(dev);
+}
+
+static int nvme_dev_open(struct inode *inode, struct file *f)
+{
+	struct nvme_dev *dev = f->private_data;
+	kref_get(&dev->kref);
+	f->private_data = dev;
+	return 0;
+}
+
+static int nvme_dev_release(struct inode *inode, struct file *f)
+{
+	struct nvme_dev *dev = f->private_data;
+	kref_put(&dev->kref, nvme_free_dev);
+	return 0;
+}
+
+static long nvme_dev_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	struct nvme_dev *dev = f->private_data;
+	switch (cmd) {
+	case NVME_IOCTL_ADMIN_CMD:
+		return nvme_user_admin_cmd(dev, (void __user *)arg);
+	default:
+		return -ENOTTY;
+	}
+}
+
+static const struct file_operations nvme_dev_fops = {
+	.owner		= THIS_MODULE,
+	.open		= nvme_dev_open,
+	.release	= nvme_dev_release,
+	.unlocked_ioctl	= nvme_dev_ioctl,
+	.compat_ioctl	= nvme_dev_ioctl,
+};
+
 static int __devinit nvme_probe(struct pci_dev *pdev,
 						const struct pci_device_id *id)
 {
@@ -1683,8 +1736,20 @@ static int __devinit nvme_probe(struct pci_dev *pdev,
 	if (result)
 		goto delete;
 
+	scnprintf(dev->name, sizeof(dev->name), "nvme%d", dev->instance);
+	dev->miscdev.minor = MISC_DYNAMIC_MINOR;
+	dev->miscdev.parent = &pdev->dev;
+	dev->miscdev.name = dev->name;
+	dev->miscdev.fops = &nvme_dev_fops;
+	result = misc_register(&dev->miscdev);
+	if (result)
+		goto remove;
+
+	kref_init(&dev->kref);
 	return 0;
 
+ remove:
+	nvme_dev_remove(dev);
  delete:
 	spin_lock(&dev_list_lock);
 	list_del(&dev->node);
@@ -1710,16 +1775,8 @@ static int __devinit nvme_probe(struct pci_dev *pdev,
 static void __devexit nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-	nvme_dev_remove(dev);
-	pci_disable_msix(pdev);
-	iounmap(dev->bar);
-	nvme_release_instance(dev);
-	nvme_release_prp_pools(dev);
-	pci_disable_device(pdev);
-	pci_release_regions(pdev);
-	kfree(dev->queues);
-	kfree(dev->entry);
-	kfree(dev);
+	misc_deregister(&dev->miscdev);
+	kref_put(&dev->kref, nvme_free_dev);
 }
 
 /* These functions are yet to be implemented */
-- 
1.7.0.4

Contrast this with the previous character device patch that created its own
class and device, which I think was the wrong thing to do.
