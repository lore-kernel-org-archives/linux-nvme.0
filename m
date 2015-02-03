From: keith.busch@intel.com (Keith Busch)
Date: Tue,  3 Feb 2015 13:48:33 -0700
Subject: [PATCH] NVMe: Register management handle under nvme class
Message-ID: <1422996513-4596-1-git-send-email-keith.busch@intel.com>

This creates a new class type for nvme devices to register their
management character devices with. This is so we do not rely on miscdev
to provide enough minors for as many nvme devices some people plan to
use. The previous limit was approximately 60 controllers, depending on
the platform and kernel. Now the limit is 1M, which ought to be enough
for anybody.

Since we have a new device class, it makes sense to attach the block
devices under this as well, so part of this patch moves the management
handle initialization prior to the namespaces discovery.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   79 ++++++++++++++++++++++++++++++++-------------
 include/linux/nvme.h      |    3 +-
 2 files changed, 57 insertions(+), 25 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 36912d1..16222d8 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -42,6 +42,7 @@
 #include <scsi/sg.h>
 #include <asm-generic/io-64-nonatomic-lo-hi.h>
 
+#define NVME_MINORS		(1U << MINORBITS)
 #define NVME_Q_DEPTH		1024
 #define NVME_AQ_DEPTH		64
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
@@ -69,6 +70,9 @@ MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown")
 static int nvme_major;
 module_param(nvme_major, int, 0);
 
+static int nvme_char_major;
+module_param(nvme_char_major, int, 0);
+
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
@@ -79,6 +83,8 @@ static struct workqueue_struct *nvme_workq;
 static wait_queue_head_t nvme_kthread_wait;
 static struct notifier_block nvme_nb;
 
+static struct class *nvme_class;
+
 static void nvme_reset_failed_dev(struct work_struct *ws);
 static int nvme_process_cq(struct nvme_queue *nvmeq);
 
@@ -2138,7 +2144,7 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 	disk->fops = &nvme_fops;
 	disk->private_data = ns;
 	disk->queue = ns->queue;
-	disk->driverfs_dev = &dev->pci_dev->dev;
+	disk->driverfs_dev = dev->device;
 	disk->flags = GENHD_FL_EXT_DEVT;
 	sprintf(disk->disk_name, "nvme%dn%d", dev->instance, nsid);
 
@@ -2724,6 +2730,7 @@ static void nvme_free_dev(struct kref *kref)
 	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
 
 	pci_dev_put(dev->pci_dev);
+	put_device(dev->device);
 	nvme_free_namespaces(dev);
 	nvme_release_instance(dev);
 	blk_mq_free_tag_set(&dev->tagset);
@@ -2735,11 +2742,23 @@ static void nvme_free_dev(struct kref *kref)
 
 static int nvme_dev_open(struct inode *inode, struct file *f)
 {
-	struct nvme_dev *dev = container_of(f->private_data, struct nvme_dev,
-								miscdev);
-	kref_get(&dev->kref);
-	f->private_data = dev;
-	return 0;
+	struct nvme_dev *dev;
+	int instance = iminor(inode);
+	int ret = -ENODEV;
+
+	spin_lock(&dev_list_lock);
+	list_for_each_entry(dev, &dev_list, node) {
+		if (dev->instance == instance) {
+			if (!kref_get_unless_zero(&dev->kref))
+				break;
+			f->private_data = dev;
+			ret = 0;
+			break;
+		}
+	}
+	spin_unlock(&dev_list_lock);
+
+	return ret;
 }
 
 static int nvme_dev_release(struct inode *inode, struct file *f)
@@ -2951,29 +2970,26 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto release_pools;
 
-	if (dev->online_queues > 1)
-		result = nvme_dev_add(dev);
-	if (result)
+	dev->device = device_create(nvme_class, &pdev->dev,
+				MKDEV(nvme_char_major, dev->instance),
+				dev, "nvme%d", dev->instance);
+	if (IS_ERR(dev->device)) {
+		result = PTR_ERR(dev->device);
 		goto shutdown;
+	}
+	get_device(dev->device);
 
-	scnprintf(dev->name, sizeof(dev->name), "nvme%d", dev->instance);
-	dev->miscdev.minor = MISC_DYNAMIC_MINOR;
-	dev->miscdev.parent = &pdev->dev;
-	dev->miscdev.name = dev->name;
-	dev->miscdev.fops = &nvme_dev_fops;
-	result = misc_register(&dev->miscdev);
+	if (dev->online_queues > 1)
+		result = nvme_dev_add(dev);
 	if (result)
-		goto remove;
+		goto device_del;
 
 	nvme_set_irq_hints(dev);
-
 	dev->initialized = 1;
 	return 0;
 
- remove:
-	nvme_dev_remove(dev);
-	nvme_dev_remove_admin(dev);
-	nvme_free_namespaces(dev);
+ device_del:
+	device_destroy(nvme_class, MKDEV(nvme_char_major, dev->instance));
  shutdown:
 	nvme_dev_shutdown(dev);
  release_pools:
@@ -3016,10 +3032,10 @@ static void nvme_remove(struct pci_dev *pdev)
 
 	pci_set_drvdata(pdev, NULL);
 	flush_work(&dev->reset_work);
-	misc_deregister(&dev->miscdev);
 	nvme_dev_shutdown(dev);
 	nvme_dev_remove(dev);
 	nvme_dev_remove_admin(dev);
+	device_destroy(nvme_class, MKDEV(nvme_char_major, dev->instance));
 	nvme_free_queues(dev, 0);
 	nvme_release_prp_pools(dev);
 	kref_put(&dev->kref, nvme_free_dev);
@@ -3103,11 +3119,26 @@ static int __init nvme_init(void)
 	else if (result > 0)
 		nvme_major = result;
 
+	result = __register_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme",
+							&nvme_dev_fops);
+	if (result < 0)
+		goto unregister_blkdev;
+	else if (result > 0)
+		nvme_char_major = result;
+
+	nvme_class = class_create(THIS_MODULE, "nvme");
+	if (!nvme_class)
+		goto unregister_chrdev;
+
 	result = pci_register_driver(&nvme_driver);
 	if (result)
-		goto unregister_blkdev;
+		goto destroy_class;
 	return 0;
 
+ destroy_class:
+	class_destroy(nvme_class);
+ unregister_chrdev:
+	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
  unregister_blkdev:
 	unregister_blkdev(nvme_major, "nvme");
  kill_workq:
@@ -3121,6 +3152,8 @@ static void __exit nvme_exit(void)
 	unregister_hotcpu_notifier(&nvme_nb);
 	unregister_blkdev(nvme_major, "nvme");
 	destroy_workqueue(nvme_workq);
+	class_destroy(nvme_class);
+	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
 	BUG_ON(nvme_thread && !IS_ERR(nvme_thread));
 	_nvme_check_size();
 }
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index e1fcea0..42a1a36 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -17,7 +17,6 @@
 
 #include <uapi/linux/nvme.h>
 #include <linux/pci.h>
-#include <linux/miscdevice.h>
 #include <linux/kref.h>
 #include <linux/blk-mq.h>
 
@@ -91,7 +90,7 @@ struct nvme_dev {
 	struct nvme_bar __iomem *bar;
 	struct list_head namespaces;
 	struct kref kref;
-	struct miscdevice miscdev;
+	struct device *device;
 	work_func_t reset_workfn;
 	struct work_struct reset_work;
 	char name[12];
-- 
1.7.10.4
