From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Wed, 29 Jun 2016 16:51:37 +0200
Subject: [PATCH 2/6] null_blk: refactor to support non-gendisk devices
In-Reply-To: <1467211901-26707-1-git-send-email-m@bjorling.me>
References: <1467211901-26707-1-git-send-email-m@bjorling.me>
Message-ID: <1467211901-26707-3-git-send-email-m@bjorling.me>

With LightNVM enabled devices, the gendisk structure is not exposed
to the user. This hides the device driver specific sysfs entries, and
prevents binding of LightNVM geometry information to the device.

Refactor the device registration process, so that gendisk and
non-gendisk devices are easily managed.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 drivers/block/null_blk.c | 110 ++++++++++++++++++++++++++---------------------
 1 file changed, 61 insertions(+), 49 deletions(-)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index cab9759..3117df1 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -414,23 +414,6 @@ static void cleanup_queues(struct nullb *nullb)
 	kfree(nullb->queues);
 }
 
-static void null_del_dev(struct nullb *nullb)
-{
-	list_del_init(&nullb->list);
-
-	if (use_lightnvm)
-		nvm_unregister(nullb->disk_name);
-	else
-		del_gendisk(nullb->disk);
-	blk_cleanup_queue(nullb->q);
-	if (queue_mode == NULL_Q_MQ)
-		blk_mq_free_tag_set(&nullb->tag_set);
-	if (!use_lightnvm)
-		put_disk(nullb->disk);
-	cleanup_queues(nullb);
-	kfree(nullb);
-}
-
 #ifdef CONFIG_NVM
 
 static void null_lnvm_end_io(struct request *rq, int error)
@@ -564,10 +547,41 @@ static struct nvm_dev_ops null_lnvm_dev_ops = {
 	/* Simulate nvme protocol restriction */
 	.max_phys_sect		= 64,
 };
+
+static int null_nvm_register(struct nullb *nullb)
+{
+	return nvm_register(nullb->q, nullb->disk_name, &null_lnvm_dev_ops);
+}
+
+static void null_nvm_unregister(struct nullb *nullb)
+{
+	nvm_unregister(nullb->disk_name);
+}
 #else
-static struct nvm_dev_ops null_lnvm_dev_ops;
+static int null_nvm_register(struct nullb *nullb)
+{
+	return -EINVAL;
+}
+static void null_nvm_unregister(struct nullb *nullb) {}
 #endif /* CONFIG_NVM */
 
+static void null_del_dev(struct nullb *nullb)
+{
+	list_del_init(&nullb->list);
+
+	if (use_lightnvm)
+		null_nvm_unregister(nullb);
+	else
+		del_gendisk(nullb->disk);
+	blk_cleanup_queue(nullb->q);
+	if (queue_mode == NULL_Q_MQ)
+		blk_mq_free_tag_set(&nullb->tag_set);
+	if (!use_lightnvm)
+		put_disk(nullb->disk);
+	cleanup_queues(nullb);
+	kfree(nullb);
+}
+
 static int null_open(struct block_device *bdev, fmode_t mode)
 {
 	return 0;
@@ -640,11 +654,32 @@ static int init_driver_queues(struct nullb *nullb)
 	return 0;
 }
 
-static int null_add_dev(void)
+static int null_gendisk_register(struct nullb *nullb)
 {
 	struct gendisk *disk;
-	struct nullb *nullb;
 	sector_t size;
+
+	disk = nullb->disk = alloc_disk_node(1, home_node);
+	if (!disk)
+		return -ENOMEM;
+	size = gb * 1024 * 1024 * 1024ULL;
+	set_capacity(disk, size >> 9);
+
+	disk->flags |= GENHD_FL_EXT_DEVT | GENHD_FL_SUPPRESS_PARTITION_INFO;
+	disk->major		= null_major;
+	disk->first_minor	= nullb->index;
+	disk->fops		= &null_fops;
+	disk->private_data	= nullb;
+	disk->queue		= nullb->q;
+	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
+
+	add_disk(disk);
+	return 0;
+}
+
+static int null_add_dev(void)
+{
+	struct nullb *nullb;
 	int rv;
 
 	nullb = kzalloc_node(sizeof(*nullb), GFP_KERNEL, home_node);
@@ -716,42 +751,19 @@ static int null_add_dev(void)
 
 	sprintf(nullb->disk_name, "nullb%d", nullb->index);
 
-	if (use_lightnvm) {
-		rv = nvm_register(nullb->q, nullb->disk_name,
-							&null_lnvm_dev_ops);
-		if (rv)
-			goto out_cleanup_blk_queue;
-		goto done;
-	}
+	if (use_lightnvm)
+		rv = null_nvm_register(nullb);
+	else
+		rv = null_gendisk_register(nullb);
 
-	disk = nullb->disk = alloc_disk_node(1, home_node);
-	if (!disk) {
-		rv = -ENOMEM;
-		goto out_cleanup_lightnvm;
-	}
-	size = gb * 1024 * 1024 * 1024ULL;
-	set_capacity(disk, size >> 9);
+	if (rv)
+		goto out_cleanup_blk_queue;
 
-	disk->flags |= GENHD_FL_EXT_DEVT | GENHD_FL_SUPPRESS_PARTITION_INFO;
-	disk->major		= null_major;
-	disk->first_minor	= nullb->index;
-	disk->fops		= &null_fops;
-	disk->private_data	= nullb;
-	disk->queue		= nullb->q;
-	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
-
-	add_disk(disk);
-
-done:
 	mutex_lock(&lock);
 	list_add_tail(&nullb->list, &nullb_list);
 	mutex_unlock(&lock);
 
 	return 0;
-
-out_cleanup_lightnvm:
-	if (use_lightnvm)
-		nvm_unregister(nullb->disk_name);
 out_cleanup_blk_queue:
 	blk_cleanup_queue(nullb->q);
 out_cleanup_tags:
-- 
2.1.4
