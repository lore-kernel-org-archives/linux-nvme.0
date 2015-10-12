From: hch@lst.de (Christoph Hellwig)
Date: Mon, 12 Oct 2015 09:10:11 +0200
Subject: [PATCH 8/8] nvme: move chardev and sysfs interface to common code
In-Reply-To: <1444633811-28319-1-git-send-email-hch@lst.de>
References: <1444633811-28319-1-git-send-email-hch@lst.de>
Message-ID: <1444633811-28319-9-git-send-email-hch@lst.de>

For this we need to add a proper controller init routine and a list of all
controllers that is in addition to the list of PCIe controllers, which stays
in pci.c.  Note that we remove the sysfs device when the last reference
to a controller is dropped now - the old code would have kept it around
longer, which doesn't make much sense.

This requires a new ->reset_ctrl operation to implement controleller resets,
and a new ->write_reg32 operation that is required to implement subsystem
resets.  We also now store caches copied of the NVMe compliance version and
the flag if a controller is attached to a subsystem or not in the generic
controller structure now.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 217 +++++++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h |  20 +++--
 drivers/nvme/host/pci.c  | 202 +++++--------------------------------------
 drivers/nvme/host/scsi.c |   9 +-
 4 files changed, 250 insertions(+), 198 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fceca85..0c5f0ea 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -28,11 +28,19 @@
 
 #include "nvme.h"
 
+#define NVME_MINORS		(1U << MINORBITS)
+
 static int nvme_major;
 module_param(nvme_major, int, 0);
 
+static int nvme_char_major;
+module_param(nvme_char_major, int, 0);
+
+static LIST_HEAD(nvme_ctrl_list);
 DEFINE_SPINLOCK(dev_list_lock);
 
+static struct class *nvme_class;
+
 static void nvme_free_ns(struct kref *kref)
 {
 	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
@@ -350,7 +358,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 			NULL, 0);
 }
 
-int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			struct nvme_passthru_cmd __user *ucmd)
 {
 	struct nvme_passthru_cmd cmd;
@@ -582,6 +590,12 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	u64 cap;
 	int ret, page_shift;
 
+	ret = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &ctrl->vs);
+	if (ret) {	
+		dev_err(ctrl->dev, "Reading VS failed (%d)\n", ret);
+		return ret;
+	}
+
 	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &cap);
 	if (ret) {	
 		dev_err(ctrl->dev, "Reading CAP failed (%d)\n", ret);
@@ -590,6 +604,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	page_shift = NVME_CAP_MPSMIN(cap) + 12;
 	ctrl->page_size = 1 << page_shift;
 
+	if (ctrl->vs >= NVME_VS(1, 1))
+		ctrl->subsystem = NVME_CAP_NSSRC(cap);
+
 	ret = nvme_identify_ctrl(ctrl, &id);
 	if (ret) {
 		dev_err(ctrl->dev, "Identify Controller failed (%d)\n", ret);
@@ -622,18 +639,85 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	return 0;
 }
 
-static void nvme_free_ctrl(struct kref *kref)
+static int nvme_dev_open(struct inode *inode, struct file *file)
 {
-	struct nvme_ctrl *ctrl = container_of(kref, struct nvme_ctrl, kref);
+	struct nvme_ctrl *ctrl;
+	int instance = iminor(inode);
+	int ret = -ENODEV;
 
-	ctrl->ops->free_ctrl(ctrl);
+	spin_lock(&dev_list_lock);
+	list_for_each_entry(ctrl, &nvme_ctrl_list, node) {
+		if (ctrl->instance != instance)
+			continue;
+
+		if (!ctrl->admin_q) {
+			ret = -EWOULDBLOCK;
+			break;
+		}
+		if (!kref_get_unless_zero(&ctrl->kref))
+			break;
+		file->private_data = ctrl;
+		ret = 0;
+		break;
+	}
+	spin_unlock(&dev_list_lock);
+
+	return ret;
 }
 
-void nvme_put_ctrl(struct nvme_ctrl *ctrl)
+static int nvme_dev_release(struct inode *inode, struct file *file)
 {
-	kref_put(&ctrl->kref, nvme_free_ctrl);
+	nvme_put_ctrl(file->private_data);
+	return 0;
+}
+
+static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
+		unsigned long arg)
+{
+	struct nvme_ctrl *ctrl = file->private_data;
+	void __user *argp = (void __user *)arg;
+	struct nvme_ns *ns;
+
+	switch (cmd) {
+	case NVME_IOCTL_ADMIN_CMD:
+		return nvme_user_cmd(ctrl, NULL, argp);
+	case NVME_IOCTL_IO_CMD:
+		if (list_empty(&ctrl->namespaces))
+			return -ENOTTY;
+		ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
+		return nvme_user_cmd(ctrl, ns, argp);
+	case NVME_IOCTL_RESET:
+		dev_warn(ctrl->dev, "resetting controller\n");
+		return ctrl->ops->reset_ctrl(ctrl);
+	case NVME_IOCTL_SUBSYS_RESET:
+		return nvme_reset_subsystem(ctrl);
+	default:
+		return -ENOTTY;
+	}
 }
 
+static const struct file_operations nvme_dev_fops = {
+	.owner		= THIS_MODULE,
+	.open		= nvme_dev_open,
+	.release	= nvme_dev_release,
+	.unlocked_ioctl	= nvme_dev_ioctl,
+	.compat_ioctl	= nvme_dev_ioctl,
+};
+
+static ssize_t nvme_sysfs_reset(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	int ret;
+
+	ret = ctrl->ops->reset_ctrl(ctrl);
+	if (ret < 0)
+		return ret;
+	return count;
+}
+static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
+
 static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
 {
 	struct nvme_ns *nsa = container_of(a, struct nvme_ns, list);
@@ -795,6 +879,106 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 		nvme_ns_remove(ns);
 }
 
+static DEFINE_IDA(nvme_instance_ida);
+
+static int nvme_set_instance(struct nvme_ctrl *ctrl)
+{
+	int instance, error;
+
+	do {
+		if (!ida_pre_get(&nvme_instance_ida, GFP_KERNEL))
+			return -ENODEV;
+
+		spin_lock(&dev_list_lock);
+		error = ida_get_new(&nvme_instance_ida, &instance);
+		spin_unlock(&dev_list_lock);
+	} while (error == -EAGAIN);
+
+	if (error)
+		return -ENODEV;
+
+	ctrl->instance = instance;
+	return 0;
+}
+
+static void nvme_release_instance(struct nvme_ctrl *ctrl)
+{
+	spin_lock(&dev_list_lock);
+	ida_remove(&nvme_instance_ida, ctrl->instance);
+	spin_unlock(&dev_list_lock);
+}
+
+static void nvme_free_ctrl(struct kref *kref)
+{
+	struct nvme_ctrl *ctrl = container_of(kref, struct nvme_ctrl, kref);
+
+	spin_lock(&dev_list_lock);
+	list_del(&ctrl->node);
+	spin_unlock(&dev_list_lock);
+
+	put_device(ctrl->device);
+	nvme_release_instance(ctrl);
+	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
+
+	ctrl->ops->free_ctrl(ctrl);
+}
+
+void nvme_put_ctrl(struct nvme_ctrl *ctrl)
+{
+	kref_put(&ctrl->kref, nvme_free_ctrl);
+}
+
+/*
+ * Initialize a NVMe controller structures.  This needs to be called during
+ * earliest initialization so that we have the initialized structured around
+ * during probing.
+ */
+int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
+		const struct nvme_ctrl_ops *ops, u16 vendor,
+		unsigned long quirks)
+{
+	int ret;
+
+	INIT_LIST_HEAD(&ctrl->namespaces);
+	kref_init(&ctrl->kref);
+	ctrl->dev = dev;
+	ctrl->ops = ops;
+	ctrl->vendor = vendor;
+	ctrl->quirks = quirks;
+
+	ret = nvme_set_instance(ctrl);
+	if (ret)
+		goto out;
+
+	ctrl->device = device_create(nvme_class, ctrl->dev,
+				MKDEV(nvme_char_major, ctrl->instance),
+				dev, "nvme%d", ctrl->instance);
+	if (IS_ERR(ctrl->device)) {
+		ret = PTR_ERR(ctrl->device);
+		goto out_release_instance;
+	}
+	get_device(ctrl->device);
+	dev_set_drvdata(ctrl->device, dev);
+
+	ret = device_create_file(ctrl->device, &dev_attr_reset_controller);
+	if (ret)
+		goto out_put_device;
+
+	spin_lock(&dev_list_lock);
+	list_add_tail(&ctrl->node, &nvme_ctrl_list);
+	spin_unlock(&dev_list_lock);
+
+	return 0;
+
+out_put_device:
+	put_device(ctrl->device);
+	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
+out_release_instance:
+	nvme_release_instance(ctrl);
+out:
+	return ret;
+}
+
 int __init nvme_core_init(void)
 {
 	int result;
@@ -805,10 +989,31 @@ int __init nvme_core_init(void)
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
+	if (IS_ERR(nvme_class)) {
+		result = PTR_ERR(nvme_class);
+		goto unregister_chrdev;
+	}
+
 	return 0;
+
+ unregister_chrdev:
+	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
+ unregister_blkdev:
+	unregister_blkdev(nvme_major, "nvme");
+	return result;
 }
 
 void __exit nvme_core_exit(void)
 {
 	unregister_blkdev(nvme_major, "nvme");
+	class_destroy(nvme_class);
+	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1025444..5d45ca2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -19,8 +19,6 @@
 #include <linux/kref.h>
 #include <linux/blk-mq.h>
 
-struct nvme_passthru_cmd;
-
 extern unsigned char nvme_io_timeout;
 #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
 
@@ -48,6 +46,7 @@ struct nvme_ctrl {
 	struct blk_mq_tag_set *tagset;
 	struct list_head namespaces;
 	struct device *device;	/* char device */
+	struct list_head node;
 
 	char name[12];
 	char serial[20];
@@ -60,6 +59,8 @@ struct nvme_ctrl {
 	u16 abort_limit;
 	u8 event_limit;
 	u8 vwc;
+	u32 vs;
+	bool subsystem;
 	u16 vendor;
 	unsigned long quirks;
 };
@@ -87,7 +88,9 @@ struct nvme_ns {
 struct nvme_ctrl_ops {
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
+	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	bool (*io_incapable)(struct nvme_ctrl *ctrl);
+	int (*reset_ctrl)(struct nvme_ctrl *ctrl);
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
 };
 
@@ -111,11 +114,21 @@ static inline bool nvme_io_incapable(struct nvme_ctrl *ctrl)
 	return val & NVME_CSTS_CFS;
 }
 
+static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
+{
+	if (!ctrl->subsystem)
+		return -ENOTTY;
+	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
+}
+
 static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
 {
 	return (sector >> (ns->lba_shift - 9));
 }
 
+int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
+		const struct nvme_ctrl_ops *ops, u16 vendor,
+		unsigned long quirks);
 void nvme_put_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_identify(struct nvme_ctrl *ctrl);
 
@@ -144,9 +157,6 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
 extern spinlock_t dev_list_lock;
 
-int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			struct nvme_passthru_cmd __user *ucmd);
-
 struct sg_io_hdr;
 
 int nvme_sg_io(struct nvme_ns *ns, struct sg_io_hdr __user *u_hdr);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6ae6419..f581019 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -38,13 +38,10 @@
 #include <linux/slab.h>
 #include <linux/t10-pi.h>
 #include <linux/types.h>
-#include <scsi/sg.h>
 #include <asm-generic/io-64-nonatomic-lo-hi.h>
 
-#include <uapi/linux/nvme_ioctl.h>
 #include "nvme.h"
 
-#define NVME_MINORS		(1U << MINORBITS)
 #define NVME_Q_DEPTH		1024
 #define NVME_AQ_DEPTH		256
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
@@ -63,9 +60,6 @@ static unsigned char shutdown_timeout = 5;
 module_param(shutdown_timeout, byte, 0644);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
 
-static int nvme_char_major;
-module_param(nvme_char_major, int, 0);
-
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
@@ -78,8 +72,6 @@ static struct task_struct *nvme_thread;
 static struct workqueue_struct *nvme_workq;
 static wait_queue_head_t nvme_kthread_wait;
 
-static struct class *nvme_class;
-
 struct nvme_dev;
 struct nvme_queue;
 
@@ -1622,15 +1614,6 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	return result;
 }
 
-static int nvme_subsys_reset(struct nvme_dev *dev)
-{
-	if (!dev->subsystem)
-		return -ENOTTY;
-
-	writel(0x4E564D65, dev->bar + NVME_REG_NSSR); /* "NVMe" */
-	return 0;
-}
-
 static int nvme_kthread(void *data)
 {
 	struct nvme_dev *dev, *next;
@@ -2224,42 +2207,11 @@ static void nvme_release_prp_pools(struct nvme_dev *dev)
 	dma_pool_destroy(dev->prp_small_pool);
 }
 
-static DEFINE_IDA(nvme_instance_ida);
-
-static int nvme_set_instance(struct nvme_dev *dev)
-{
-	int instance, error;
-
-	do {
-		if (!ida_pre_get(&nvme_instance_ida, GFP_KERNEL))
-			return -ENODEV;
-
-		spin_lock(&dev_list_lock);
-		error = ida_get_new(&nvme_instance_ida, &instance);
-		spin_unlock(&dev_list_lock);
-	} while (error == -EAGAIN);
-
-	if (error)
-		return -ENODEV;
-
-	dev->ctrl.instance = instance;
-	return 0;
-}
-
-static void nvme_release_instance(struct nvme_dev *dev)
-{
-	spin_lock(&dev_list_lock);
-	ida_remove(&nvme_instance_ida, dev->ctrl.instance);
-	spin_unlock(&dev_list_lock);
-}
-
 static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
 
 	put_device(dev->dev);
-	put_device(ctrl->device);
-	nvme_release_instance(dev);
 	if (dev->tagset.tags)
 		blk_mq_free_tag_set(&dev->tagset);
 	if (dev->ctrl.admin_q)
@@ -2269,69 +2221,6 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	kfree(dev);
 }
 
-static int nvme_dev_open(struct inode *inode, struct file *f)
-{
-	struct nvme_dev *dev;
-	int instance = iminor(inode);
-	int ret = -ENODEV;
-
-	spin_lock(&dev_list_lock);
-	list_for_each_entry(dev, &dev_list, node) {
-		if (dev->ctrl.instance == instance) {
-			if (!dev->ctrl.admin_q) {
-				ret = -EWOULDBLOCK;
-				break;
-			}
-			if (!kref_get_unless_zero(&dev->ctrl.kref))
-				break;
-			f->private_data = dev;
-			ret = 0;
-			break;
-		}
-	}
-	spin_unlock(&dev_list_lock);
-
-	return ret;
-}
-
-static int nvme_dev_release(struct inode *inode, struct file *f)
-{
-	struct nvme_dev *dev = f->private_data;
-	nvme_put_ctrl(&dev->ctrl);
-	return 0;
-}
-
-static long nvme_dev_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
-{
-	struct nvme_dev *dev = f->private_data;
-	struct nvme_ns *ns;
-
-	switch (cmd) {
-	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(&dev->ctrl, NULL, (void __user *)arg);
-	case NVME_IOCTL_IO_CMD:
-		if (list_empty(&dev->ctrl.namespaces))
-			return -ENOTTY;
-		ns = list_first_entry(&dev->ctrl.namespaces, struct nvme_ns, list);
-		return nvme_user_cmd(&dev->ctrl, ns, (void __user *)arg);
-	case NVME_IOCTL_RESET:
-		dev_warn(dev->dev, "resetting controller\n");
-		return nvme_reset(dev);
-	case NVME_IOCTL_SUBSYS_RESET:
-		return nvme_subsys_reset(dev);
-	default:
-		return -ENOTTY;
-	}
-}
-
-static const struct file_operations nvme_dev_fops = {
-	.owner		= THIS_MODULE,
-	.open		= nvme_dev_open,
-	.release	= nvme_dev_release,
-	.unlocked_ioctl	= nvme_dev_ioctl,
-	.compat_ioctl	= nvme_dev_ioctl,
-};
-
 static void nvme_probe_work(struct work_struct *work)
 {
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, probe_work);
@@ -2483,21 +2372,6 @@ static int nvme_reset(struct nvme_dev *dev)
 	return ret;
 }
 
-static ssize_t nvme_sysfs_reset(struct device *dev,
-				struct device_attribute *attr, const char *buf,
-				size_t count)
-{
-	struct nvme_dev *ndev = dev_get_drvdata(dev);
-	int ret;
-
-	ret = nvme_reset(ndev);
-	if (ret < 0)
-		return ret;
-
-	return count;
-}
-static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
-
 static int nvme_pci_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 {
 	*val = readl(to_nvme_dev(ctrl)->bar + off);
@@ -2510,6 +2384,12 @@ static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	return 0;
 }
 
+static int nvme_pci_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
+{
+	writel(val, to_nvme_dev(ctrl)->bar + off);
+	return 0;
+}
+
 static bool nvme_pci_io_incapable(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
@@ -2517,10 +2397,17 @@ static bool nvme_pci_io_incapable(struct nvme_ctrl *ctrl)
 	return !dev->bar || dev->online_queues < 2;
 }
 
+static int nvme_pci_reset_ctrl(struct nvme_ctrl *ctrl)
+{
+	return nvme_reset(to_nvme_dev(ctrl));
+}
+
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.reg_read32		= nvme_pci_reg_read32,
 	.reg_read64		= nvme_pci_reg_read64,
+	.reg_write32		= nvme_pci_reg_write32,
 	.io_incapable		= nvme_pci_io_incapable,
+	.reset_ctrl		= nvme_pci_reset_ctrl,
 	.free_ctrl		= nvme_pci_free_ctrl,
 };
 
@@ -2545,52 +2432,28 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!dev->queues)
 		goto free;
 
-	INIT_LIST_HEAD(&dev->ctrl.namespaces);
-	INIT_WORK(&dev->reset_work, nvme_reset_work);
 	dev->dev = get_device(&pdev->dev);
 	pci_set_drvdata(pdev, dev);
 
-	dev->ctrl.vendor = pdev->vendor;
-	dev->ctrl.ops = &nvme_pci_ctrl_ops;
-	dev->ctrl.dev = dev->dev;
-	dev->ctrl.quirks = id->driver_data;
+	INIT_LIST_HEAD(&dev->node);
+	INIT_WORK(&dev->scan_work, nvme_dev_scan);
+	INIT_WORK(&dev->probe_work, nvme_probe_work);
+	INIT_WORK(&dev->reset_work, nvme_reset_work);
 
-	result = nvme_set_instance(dev);
+	result = nvme_setup_prp_pools(dev);
 	if (result)
 		goto put_pci;
 
-	result = nvme_setup_prp_pools(dev);
+	result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
+			pdev->vendor, id->driver_data);
 	if (result)
-		goto release;
-
-	kref_init(&dev->ctrl.kref);
-	dev->ctrl.device = device_create(nvme_class, &pdev->dev,
-				MKDEV(nvme_char_major, dev->ctrl.instance),
-				dev, "nvme%d", dev->ctrl.instance);
-	if (IS_ERR(dev->ctrl.device)) {
-		result = PTR_ERR(dev->ctrl.device);
 		goto release_pools;
-	}
-	get_device(dev->ctrl.device);
-	dev_set_drvdata(dev->ctrl.device, dev);
 
-	result = device_create_file(dev->ctrl.device, &dev_attr_reset_controller);
-	if (result)
-		goto put_dev;
-
-	INIT_LIST_HEAD(&dev->node);
-	INIT_WORK(&dev->scan_work, nvme_dev_scan);
-	INIT_WORK(&dev->probe_work, nvme_probe_work);
 	schedule_work(&dev->probe_work);
 	return 0;
 
- put_dev:
-	device_destroy(nvme_class, MKDEV(nvme_char_major, dev->ctrl.instance));
-	put_device(dev->ctrl.device);
  release_pools:
 	nvme_release_prp_pools(dev);
- release:
-	nvme_release_instance(dev);
  put_pci:
 	put_device(dev->dev);
  free:
@@ -2628,11 +2491,9 @@ static void nvme_remove(struct pci_dev *pdev)
 	flush_work(&dev->probe_work);
 	flush_work(&dev->reset_work);
 	flush_work(&dev->scan_work);
-	device_remove_file(dev->ctrl.device, &dev_attr_reset_controller);
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_shutdown(dev);
 	nvme_dev_remove_admin(dev);
-	device_destroy(nvme_class, MKDEV(nvme_char_major, dev->ctrl.instance));
 	nvme_free_queues(dev, 0);
 	nvme_release_cmb(dev);
 	nvme_release_prp_pools(dev);
@@ -2714,29 +2575,12 @@ static int __init nvme_init(void)
 	if (result < 0)
 		goto kill_workq;
 
-	result = __register_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme",
-							&nvme_dev_fops);
-	if (result < 0)
-		goto unregister_blkdev;
-	else if (result > 0)
-		nvme_char_major = result;
-
-	nvme_class = class_create(THIS_MODULE, "nvme");
-	if (IS_ERR(nvme_class)) {
-		result = PTR_ERR(nvme_class);
-		goto unregister_chrdev;
-	}
-
 	result = pci_register_driver(&nvme_driver);
 	if (result)
-		goto destroy_class;
+		goto core_exit;
 	return 0;
 
- destroy_class:
-	class_destroy(nvme_class);
- unregister_chrdev:
-	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
- unregister_blkdev:
+ core_exit:
 	nvme_core_exit();
  kill_workq:
 	destroy_workqueue(nvme_workq);
@@ -2748,8 +2592,6 @@ static void __exit nvme_exit(void)
 	pci_unregister_driver(&nvme_driver);
 	nvme_core_exit();
 	destroy_workqueue(nvme_workq);
-	class_destroy(nvme_class);
-	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
 	BUG_ON(nvme_thread && !IS_ERR(nvme_thread));
 	_nvme_check_size();
 }
diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index b673fe4..34c65b9 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -606,16 +606,11 @@ static int nvme_trans_device_id_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	int res;
 	int nvme_sc;
 	int xfer_len;
-	u32 vs;
 	__be32 tmp_id = cpu_to_be32(ns->ns_id);
 
-	res = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &vs);
-	if (res)
-		return res;
-
 	memset(inq_response, 0, alloc_len);
 	inq_response[1] = INQ_DEVICE_IDENTIFICATION_PAGE;    /* Page Code */
-	if (vs >= NVME_VS(1, 1)) {
+	if (ctrl->vs >= NVME_VS(1, 1)) {
 		struct nvme_id_ns *id_ns;
 		void *eui;
 		int len;
@@ -627,7 +622,7 @@ static int nvme_trans_device_id_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 
 		eui = id_ns->eui64;
 		len = sizeof(id_ns->eui64);
-		if (vs >= NVME_VS(1, 2)) {
+		if (ctrl->vs >= NVME_VS(1, 2)) {
 			if (bitmap_empty(eui, len * 8)) {
 				eui = id_ns->nguid;
 				len = sizeof(id_ns->nguid);
-- 
1.9.1
