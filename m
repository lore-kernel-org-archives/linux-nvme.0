From: santoshsy@gmail.com (Santosh Y)
Date: Mon, 30 Dec 2013 15:57:19 +0530
Subject: [PATCH RFC 4/5] NVMe: Stale node cleanup based on reference count
In-Reply-To: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>
References: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>
Message-ID: <1388399240-13828-5-git-send-email-santoshsy@gmail.com>

This patch maintains reference count for namespaces that are still
being referenced by user applications during surprise removal.
Once the reference count is zero, the instance release and cleanup will be
handled.

Signed-off-by: Ravi Kumar <ravi.android at gmail.com>
Signed-off-by: Santosh Y <santoshsy at gmail.com>

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index cd37335..48698b7 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -51,6 +51,10 @@
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
 #define ADMIN_TIMEOUT	(60 * HZ)
 
+#ifdef CONFIG_BLK_DEV_NVME_HP
+#define NVME_MINORS 64
+#endif
+
 static int nvme_major;
 module_param(nvme_major, int, 0);
 
@@ -62,6 +66,11 @@ static LIST_HEAD(dev_list);
 static struct task_struct *nvme_thread;
 static struct workqueue_struct *nvme_workq;
 
+#ifdef CONFIG_BLK_DEV_NVME_HP
+static DEFINE_SPINLOCK(stalen_lock);
+static LIST_HEAD(stalen_list);
+#endif
+
 static void nvme_reset_failed_dev(struct work_struct *ws);
 
 struct async_cmd_info {
@@ -1737,6 +1746,11 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
 
+#ifdef CONFIG_BLK_DEV_NVME_HP
+	if (!ns || (test_bit(NVME_HOT_REM, &ns->dev->hp_flag)) ||
+		!bdev->bd_disk || !(bdev->bd_disk->flags & GENHD_FL_UP))
+		return -ENODEV;
+#endif
 	switch (cmd) {
 	case NVME_IOCTL_ID:
 		force_successful_syscall_return();
@@ -1770,8 +1784,42 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
 #define nvme_compat_ioctl	NULL
 #endif
 
+#ifdef CONFIG_BLK_DEV_NVME_HP
+static int nvme_bd_open(struct block_device *bdev, fmode_t mode)
+{
+	struct nvme_ns *ns;
+	int err = -ENODEV;
+
+	if (!bdev || !bdev->bd_disk ||
+		!bdev->bd_disk->private_data)
+		goto out;
+	if ((bdev->bd_disk->flags & GENHD_FL_UP)) {
+		ns = (struct nvme_ns *)bdev->bd_disk->private_data;
+		atomic_inc(&ns->refcount);
+		err = 0;
+	}
+out:
+	return err;
+}
+static void nvme_bd_release(struct gendisk *gdisk, fmode_t mode)
+{
+	struct nvme_ns *ns;
+
+	if (!gdisk || !gdisk->private_data)
+		goto out;
+	ns = (struct nvme_ns *)gdisk->private_data;
+	atomic_dec(&ns->refcount);
+out:
+	return;
+}
+#endif
+
 static const struct block_device_operations nvme_fops = {
 	.owner		= THIS_MODULE,
+#ifdef CONFIG_BLK_DEV_NVME_HP
+	.open           = nvme_bd_open,
+	.release        = nvme_bd_release,
+#endif
 	.ioctl		= nvme_ioctl,
 	.compat_ioctl	= nvme_compat_ioctl,
 };
@@ -1805,6 +1853,9 @@ static void nvme_resubmit_bios(struct nvme_queue *nvmeq)
 static int nvme_kthread(void *data)
 {
 	struct nvme_dev *dev, *next;
+#ifdef CONFIG_BLK_DEV_NVME_HP
+	unsigned long flags  = 0;
+#endif
 
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -1827,14 +1878,22 @@ static int nvme_kthread(void *data)
 				struct nvme_queue *nvmeq = dev->queues[i];
 				if (!nvmeq)
 					continue;
+#ifdef CONFIG_BLK_DEV_NVME_HP
+				spin_lock_irqsave(&nvmeq->q_lock, flags);
+#else
 				spin_lock_irq(&nvmeq->q_lock);
+#endif
 				if (nvmeq->q_suspended)
 					goto unlock;
 				nvme_process_cq(nvmeq);
 				nvme_cancel_ios(nvmeq, true);
 				nvme_resubmit_bios(nvmeq);
  unlock:
+#ifdef CONFIG_BLK_DEV_NVME_HP
+				spin_unlock_irqrestore(&nvmeq->q_lock, flags);
+#else
 				spin_unlock_irq(&nvmeq->q_lock);
+#endif
 			}
 		}
 		spin_unlock(&dev_list_lock);
@@ -1843,6 +1902,33 @@ static int nvme_kthread(void *data)
 	return 0;
 }
 
+#ifdef CONFIG_BLK_DEV_NVME_HP
+static DEFINE_IDA(nvme_index_ida);
+
+static int nvme_get_ns_idx(void)
+{
+	int index, error;
+	do {
+		if (!ida_pre_get(&nvme_index_ida, GFP_KERNEL))
+			return -1;
+		spin_lock(&dev_list_lock);
+		error = ida_get_new(&nvme_index_ida, &index);
+		spin_unlock(&dev_list_lock);
+	} while (error == -EAGAIN);
+
+	if (error)
+		index = -1;
+	return index;
+}
+
+static void nvme_put_ns_idx(int index)
+{
+	spin_lock(&dev_list_lock);
+	ida_remove(&nvme_index_ida, index);
+	spin_unlock(&dev_list_lock);
+}
+#endif
+
 static void nvme_config_discard(struct nvme_ns *ns)
 {
 	u32 logical_block_size = queue_logical_block_size(ns->queue);
@@ -1876,7 +1962,11 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 	ns->dev = dev;
 	ns->queue->queuedata = ns;
 
+#ifdef CONFIG_BLK_DEV_NVME_HP
+	disk = alloc_disk(NVME_MINORS);
+#else
 	disk = alloc_disk(0);
+#endif
 	if (!disk)
 		goto out_free_queue;
 	ns->ns_id = nsid;
@@ -1889,12 +1979,19 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
 
 	disk->major = nvme_major;
+#ifdef CONFIG_BLK_DEV_NVME_HP
+	disk->minors = NVME_MINORS;
+	disk->first_minor = NVME_MINORS * nvme_get_ns_idx();
+#else
 	disk->first_minor = 0;
+#endif
 	disk->fops = &nvme_fops;
 	disk->private_data = ns;
 	disk->queue = ns->queue;
 	disk->driverfs_dev = &dev->pci_dev->dev;
+#ifndef CONFIG_BLK_DEV_NVME_HP
 	disk->flags = GENHD_FL_EXT_DEVT;
+#endif
 	sprintf(disk->disk_name, "nvme%dn%d", dev->instance, nsid);
 	set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
 
@@ -1912,7 +2009,13 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 
 static void nvme_ns_free(struct nvme_ns *ns)
 {
+#ifdef CONFIG_BLK_DEV_NVME_HP
+	int index = ns->disk->first_minor / NVME_MINORS;
+#endif
 	put_disk(ns->disk);
+#ifdef CONFIG_BLK_DEV_NVME_HP
+	nvme_put_ns_idx(index);
+#endif
 	blk_cleanup_queue(ns->queue);
 	kfree(ns);
 }
@@ -2352,10 +2455,27 @@ static void nvme_dev_remove(struct nvme_dev *dev)
 	struct nvme_ns *ns, *next;
 
 	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
-		list_del(&ns->list);
-		del_gendisk(ns->disk);
+		if (ns->disk->flags & GENHD_FL_UP)
+			del_gendisk(ns->disk);
+#ifdef CONFIG_BLK_DEV_NVME_HP
+		if (!(atomic_read(&ns->refcount))) {
+			list_del(&ns->list);
+			nvme_ns_free(ns);
+		} else {
+			set_bit(NVME_STALE_NODE, &dev->hp_flag);
+		}
+#else
 		nvme_ns_free(ns);
+#endif
 	}
+
+#ifdef CONFIG_BLK_DEV_NVME_HP
+	if (test_bit(NVME_STALE_NODE, &dev->hp_flag)) {
+		spin_lock(&stalen_lock);
+		list_add(&dev->stale_node, &stalen_list);
+		spin_unlock(&stalen_lock);
+	}
+#endif
 }
 
 static int nvme_setup_prp_pools(struct nvme_dev *dev)
@@ -2411,12 +2531,45 @@ static void nvme_release_instance(struct nvme_dev *dev)
 	spin_unlock(&dev_list_lock);
 }
 
+#ifdef CONFIG_BLK_DEV_NVME_HP
+static void nvme_remove_stalen(void)
+{
+	struct nvme_ns *ns, *next;
+	struct nvme_dev *dev, *dev_next;
+	int ns_count = 0, ns_free_count = 0;
+
+	list_for_each_entry_safe(dev, dev_next, &stalen_list, stale_node) {
+		list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
+			++ns_count;
+			if (ns && (!atomic_read(&ns->refcount))) {
+				list_del_init(&ns->list);
+				nvme_ns_free(ns);
+				++ns_free_count;
+			}
+		}
+
+		if (ns_count == ns_free_count)
+			clear_bit(NVME_STALE_NODE, &dev->hp_flag);
+		if (!test_bit(NVME_STALE_NODE, &dev->hp_flag)) {
+			spin_lock(&stalen_lock);
+			list_del(&dev->stale_node);
+			spin_unlock(&stalen_lock);
+			nvme_release_instance(dev);
+			kfree(dev);
+		}
+	}
+}
+#endif
+
 static void nvme_free_dev(struct kref *kref)
 {
 	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
 	kfree(dev->queues);
 	kfree(dev->entry);
-	kfree(dev);
+#ifdef CONFIG_BLK_DEV_NVME_HP
+	if (!test_bit(NVME_STALE_NODE, &dev->hp_flag))
+#endif
+		kfree(dev);
 }
 
 static int nvme_dev_open(struct inode *inode, struct file *f)
@@ -2431,6 +2584,11 @@ static int nvme_dev_open(struct inode *inode, struct file *f)
 static int nvme_dev_release(struct inode *inode, struct file *f)
 {
 	struct nvme_dev *dev = f->private_data;
+
+#ifdef CONFIG_BLK_DEV_NVME_HP
+	if (!dev)
+		return -ENODEV;
+#endif
 	kref_put(&dev->kref, nvme_free_dev);
 	return 0;
 }
@@ -2438,6 +2596,11 @@ static int nvme_dev_release(struct inode *inode, struct file *f)
 static long nvme_dev_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 {
 	struct nvme_dev *dev = f->private_data;
+
+#ifdef CONFIG_BLK_DEV_NVME_HP
+	if (!dev)
+		return -ENODEV;
+#endif
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
 		return nvme_user_admin_cmd(dev, (void __user *)arg);
@@ -2569,6 +2732,9 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	int result = -ENOMEM;
 	struct nvme_dev *dev;
 
+#ifdef CONFIG_BLK_DEV_NVME_HP
+	nvme_remove_stalen();
+#endif
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
@@ -2582,6 +2748,9 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto free;
 
 	INIT_LIST_HEAD(&dev->namespaces);
+#ifdef CONFIG_BLK_DEV_NVME_HP
+	INIT_LIST_HEAD(&dev->stale_node);
+#endif
 	dev->pci_dev = pdev;
 	pci_set_drvdata(pdev, dev);
 	result = nvme_set_instance(dev);
@@ -2652,6 +2821,7 @@ static void nvme_remove(struct pci_dev *pdev)
 		set_bit(NVME_HOT_REM, &dev->hp_flag);
 		dev_info(&pdev->dev,
 			"Surprise removal of device 0x%x\n", pdev->device);
+		dev->initialized = 0;
 	}
 	pci_dev_get(pdev);
 #endif
@@ -2661,7 +2831,10 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dev_remove(dev);
 	nvme_dev_shutdown(dev);
 	nvme_free_queues(dev, 0);
-	nvme_release_instance(dev);
+#ifdef CONFIG_BLK_DEV_NVME_HP
+	if (!test_bit(NVME_STALE_NODE, &dev->hp_flag))
+#endif
+		nvme_release_instance(dev);
 	nvme_release_prp_pools(dev);
 	kref_put(&dev->kref, nvme_free_dev);
 #ifdef CONFIG_BLK_DEV_NVME_HP
@@ -2762,6 +2935,9 @@ static int __init nvme_init(void)
 
 static void __exit nvme_exit(void)
 {
+#ifdef CONFIG_BLK_DEV_NVME_HP
+	nvme_remove_stalen();
+#endif
 	pci_unregister_driver(&nvme_driver);
 	unregister_blkdev(nvme_major, "nvme");
 	destroy_workqueue(nvme_workq);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 4ef375e..eb0d400 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -71,6 +71,7 @@ enum {
 #ifdef CONFIG_BLK_DEV_NVME_HP
 enum {
 	NVME_HOT_REM,
+	NVME_STALE_NODE,
 };
 #endif
 
@@ -105,6 +106,7 @@ struct nvme_dev {
 	u8 initialized;
 #ifdef CONFIG_BLK_DEV_NVME_HP
 	unsigned long hp_flag;
+	struct list_head stale_node;
 #endif
 };
 
@@ -123,6 +125,10 @@ struct nvme_ns {
 	int ms;
 	u64 mode_select_num_blocks;
 	u32 mode_select_block_len;
+#ifdef CONFIG_BLK_DEV_NVME_HP
+	atomic_t refcount;
+#endif
+
 };
 
 /*
-- 
1.8.3.2
