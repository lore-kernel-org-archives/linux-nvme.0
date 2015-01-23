From: axboe@fb.com (Jens Axboe)
Date: Fri, 23 Jan 2015 08:24:30 -0700
Subject: [PATCH/RFC] NVMe: add support for doing offline/online of attached
 namespaces
Message-ID: <20150123152430.GA6107@kernel.dk>

Add two new ioctls for the char control device:

- NVME_IOCTL_OFFLINE_DISK will offline namespaces/disks and leave only
  the admin queue and char dev running.

- NVME_IOCTL_ONLINE_DISK will do discovery and add namespaces and disks
  back into the system.

The intended use case is for safely doing a format or firmware upgrade,
where device and hardware characteristics could change substantially
beyond just device size and block size.

This is an RFC patch. The goal is as listed, being able to detach any
namespaces and bdevs from a device, so we just have the admin part left.
I'm open to alternative suggestions on how to handle this. Solutions
that include rmmod/modprobe if the driver wont work if you have more
than one NVMe device in a system.

I've run this through various stress testing, and it seems to hold up
fine.

Signed-off-by: Jens Axboe <axboe at fb.com>

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 3eaa0becc52d..5d83292276c8 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -80,6 +80,7 @@ static struct notifier_block nvme_nb;
 
 static void nvme_reset_failed_dev(struct work_struct *ws);
 static int nvme_process_cq(struct nvme_queue *nvmeq);
+static void nvme_set_irq_hints(struct nvme_dev *dev);
 
 struct async_cmd_info {
 	struct kthread_work work;
@@ -1808,6 +1809,21 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
 #define nvme_compat_ioctl	NULL
 #endif
 
+static int put_ns(struct nvme_ns *ns)
+{
+	if (atomic_dec_and_test(&ns->ref)) {
+		kfree(ns);
+		return 1;
+	}
+
+	return 0;
+}
+
+static void get_ns(struct nvme_ns *ns)
+{
+	atomic_inc(&ns->ref);
+}
+
 static int nvme_open(struct block_device *bdev, fmode_t mode)
 {
 	int ret = 0;
@@ -1819,6 +1835,10 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
 		ret = -ENXIO;
 	else if (!kref_get_unless_zero(&ns->dev->kref))
 		ret = -ENXIO;
+
+	if (!ret)
+		get_ns(ns);
+
 	spin_unlock(&dev_list_lock);
 
 	return ret;
@@ -1832,6 +1852,7 @@ static void nvme_release(struct gendisk *disk, fmode_t mode)
 	struct nvme_dev *dev = ns->dev;
 
 	kref_put(&dev->kref, nvme_free_dev);
+	put_ns(ns);
 }
 
 static int nvme_getgeo(struct block_device *bd, struct hd_geometry *geo)
@@ -1956,6 +1977,7 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 	queue_flag_set_unlocked(QUEUE_FLAG_SG_GAPS, ns->queue);
 	ns->dev = dev;
 	ns->queue->queuedata = ns;
+	atomic_set(&ns->ref, 1);
 
 	disk = alloc_disk_node(0, node);
 	if (!disk)
@@ -1992,7 +2014,7 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
  out_free_queue:
 	blk_cleanup_queue(ns->queue);
  out_free_ns:
-	kfree(ns);
+	put_ns(ns);
 	return NULL;
 }
 
@@ -2467,12 +2489,16 @@ static void nvme_dev_remove(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns;
 
+	mutex_lock(&dev->dev_lock);
+
 	list_for_each_entry(ns, &dev->namespaces, list) {
 		if (ns->disk->flags & GENHD_FL_UP)
 			del_gendisk(ns->disk);
 		if (!blk_queue_dying(ns->queue))
 			blk_cleanup_queue(ns->queue);
 	}
+
+	mutex_unlock(&dev->dev_lock);
 }
 
 static int nvme_setup_prp_pools(struct nvme_dev *dev)
@@ -2528,20 +2554,39 @@ static void nvme_release_instance(struct nvme_dev *dev)
 	spin_unlock(&dev_list_lock);
 }
 
+static void nvme_remove_free_ns(struct nvme_ns *ns)
+{
+	struct gendisk *disk = ns->disk;
+	int free_disk;
+
+	spin_lock(&dev_list_lock);
+
+	free_disk = put_ns(ns);
+	if (free_disk)
+		disk->private_data = NULL;
+
+	spin_unlock(&dev_list_lock);
+
+	if (free_disk)
+		put_disk(disk);
+}
+
 static void nvme_free_namespaces(struct nvme_dev *dev)
 {
-	struct nvme_ns *ns, *next;
+	mutex_lock(&dev->dev_lock);
 
-	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
-		list_del(&ns->list);
+	while (!list_empty(&dev->namespaces)) {
+		struct nvme_ns *ns;
 
-		spin_lock(&dev_list_lock);
-		ns->disk->private_data = NULL;
-		spin_unlock(&dev_list_lock);
+		ns = list_first_entry(&dev->namespaces, struct nvme_ns, list);
+		list_del(&ns->list);
 
-		put_disk(ns->disk);
-		kfree(ns);
+		mutex_unlock(&dev->dev_lock);
+		nvme_remove_free_ns(ns);
+		mutex_lock(&dev->dev_lock);
 	}
+
+	mutex_unlock(&dev->dev_lock);
 }
 
 static void nvme_free_dev(struct kref *kref)
@@ -2552,6 +2597,7 @@ static void nvme_free_dev(struct kref *kref)
 	nvme_free_namespaces(dev);
 	nvme_release_instance(dev);
 	blk_mq_free_tag_set(&dev->tagset);
+	mutex_destroy(&dev->dev_lock);
 	kfree(dev->queues);
 	kfree(dev->entry);
 	kfree(dev);
@@ -2573,6 +2619,94 @@ static int nvme_dev_release(struct inode *inode, struct file *f)
 	return 0;
 }
 
+static int nvme_dev_online_disk(struct nvme_dev *dev)
+{
+	int result;
+
+	mutex_lock(&dev->dev_lock);
+
+	if (dev->queue_count != 1) {
+		result = -EBUSY;
+		goto err;
+	}
+
+	result = nvme_setup_io_queues(dev);
+	if (result)
+		goto err;
+
+	nvme_set_irq_hints(dev);
+
+	result = nvme_dev_add(dev);
+	if (result < 0)
+		nvme_free_queues(dev, 1);
+
+err:
+	mutex_unlock(&dev->dev_lock);
+	return result;
+}
+
+static int nvme_offline_ns(struct nvme_ns *ns)
+{
+	struct request_queue *q = ns->queue;
+
+	if (blk_queue_dying(q))
+		return -ENODEV;
+
+	blk_mq_freeze_queue(q);
+	queue_flag_set_unlocked(QUEUE_FLAG_DYING, q);
+	blk_mq_unfreeze_queue(q);
+
+	if (ns->disk->flags & GENHD_FL_UP)
+		del_gendisk(ns->disk);
+
+	blk_cleanup_queue(ns->queue);
+	nvme_remove_free_ns(ns);
+	return 0;
+}
+
+static int nvme_dev_offline_disk(struct nvme_dev *dev)
+{
+	struct nvme_ns *ns;
+	int i, ns_free, q_free;
+
+	ns_free = q_free = 0;
+
+	mutex_lock(&dev->dev_lock);
+
+	while (!list_empty(&dev->namespaces)) {
+		ns = list_first_entry(&dev->namespaces, struct nvme_ns, list);
+		list_del(&ns->list);
+
+		if (!nvme_offline_ns(ns))
+			ns_free++;
+	}
+
+	for (i = dev->queue_count - 1; i >= 1; i--) {
+		struct nvme_queue *nvmeq = dev->queues[i];
+
+		nvme_suspend_queue(nvmeq);
+		nvme_clear_queue(nvmeq);
+		q_free++;
+	}
+
+	nvme_free_queues(dev, 1);
+
+	/*
+	 * If we freed namespaces, we know we have an allocated tag set.
+	 */
+	if (dev->tagset.nr_hw_queues && ns_free) {
+		blk_mq_free_tag_set(&dev->tagset);
+		dev->tagset.nr_hw_queues = 0;
+	}
+
+	mutex_unlock(&dev->dev_lock);
+
+	if (q_free || ns_free)
+		return 0;
+
+	return -ENXIO;
+}
+
 static long nvme_dev_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 {
 	struct nvme_dev *dev = f->private_data;
@@ -2582,10 +2716,18 @@ static long nvme_dev_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	case NVME_IOCTL_ADMIN_CMD:
 		return nvme_user_cmd(dev, NULL, (void __user *)arg);
 	case NVME_IOCTL_IO_CMD:
-		if (list_empty(&dev->namespaces))
+		mutex_lock(&dev->dev_lock);
+		if (list_empty(&dev->namespaces)) {
+			mutex_unlock(&dev->dev_lock);
 			return -ENOTTY;
+		}
 		ns = list_first_entry(&dev->namespaces, struct nvme_ns, list);
+		mutex_unlock(&dev->dev_lock);
 		return nvme_user_cmd(dev, ns, (void __user *)arg);
+	case NVME_IOCTL_ONLINE_DISK:
+		return nvme_dev_online_disk(dev);
+	case NVME_IOCTL_OFFLINE_DISK:
+		return nvme_dev_offline_disk(dev);
 	default:
 		return -ENOTTY;
 	}
@@ -2750,6 +2892,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto free;
 
 	INIT_LIST_HEAD(&dev->namespaces);
+	mutex_init(&dev->dev_lock);
 	dev->reset_workfn = nvme_reset_failed_dev;
 	INIT_WORK(&dev->reset_work, nvme_reset_workfn);
 	dev->pci_dev = pci_dev_get(pdev);
@@ -2767,8 +2910,11 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto release_pools;
 
-	if (dev->online_queues > 1)
+	if (dev->online_queues > 1) {
+		mutex_lock(&dev->dev_lock);
 		result = nvme_dev_add(dev);
+		mutex_unlock(&dev->dev_lock);
+	}
 	if (result)
 		goto shutdown;
 
@@ -2799,6 +2945,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_release_instance(dev);
  put_pci:
 	pci_dev_put(dev->pci_dev);
+	mutex_destroy(&dev->dev_lock);
  free:
 	kfree(dev->queues);
 	kfree(dev->entry);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 19a5d4b23209..78c9f60c09df 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -90,6 +90,7 @@ struct nvme_dev {
 	struct msix_entry *entry;
 	struct nvme_bar __iomem *bar;
 	struct list_head namespaces;
+	struct mutex dev_lock;
 	struct kref kref;
 	struct miscdevice miscdev;
 	work_func_t reset_workfn;
@@ -123,6 +124,8 @@ struct nvme_ns {
 	int ms;
 	u64 mode_select_num_blocks;
 	u32 mode_select_block_len;
+
+	atomic_t ref;
 };
 
 /*
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index 26386cf3db44..c42b2b296614 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -555,5 +555,8 @@ struct nvme_passthru_cmd {
 #define NVME_IOCTL_ADMIN_CMD	_IOWR('N', 0x41, struct nvme_admin_cmd)
 #define NVME_IOCTL_SUBMIT_IO	_IOW('N', 0x42, struct nvme_user_io)
 #define NVME_IOCTL_IO_CMD	_IOWR('N', 0x43, struct nvme_passthru_cmd)
+#define NVME_IOCTL_ONLINE_DISK	_IO('N', 0x44)
+#define NVME_IOCTL_OFFLINE_DISK	_IO('N', 0x45)
+
 
 #endif /* _UAPI_LINUX_NVME_H */

-- 
Jens Axboe
