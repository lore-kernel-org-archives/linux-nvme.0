Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A1AC61DD8
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:10:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4884B22240
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X7lcfrba";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YQQqHRpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4884B22240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VshlXo6pqMplf0JC5shGKiDW/euwaO84JXguqffeWqc=; b=X7lcfrbaDSoHmPW1srU7sFgFY
	tIGTbXPF2szzORt1Cv/kXZmOva6G//dvUU/rIfQ7KmbOOPJvGi/hJ3Ac5jYipMBXGWoV+BQuBvmWu
	izIsW/PNd7uoOeksleWv24mLYx8GScvMFiIu+/QSzE62XRO6hjbI4cAmLOHQBNwJf83ZOkkCF10JM
	DuhNUzGdfCqTBdcWuGm82LAgUCAPtAVrXWzhWchhmIROwqs+LfEcOJEfwv1snxoH6pWcdLpTBDQK/
	DY/cyn038h3O7vXB3B4ONT1y7ZR28lBL531TUaazN6UJXg2GZ2mJX/gEnigIgaKwRMr85kyqhYJam
	HpfGrPe9Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keg8j-0001oX-Fr; Mon, 16 Nov 2020 15:09:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyY-0003su-IL
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:59:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=B9SmRAKqCfACKKyGENFkBsseQWLE7CqM6G32RVvIzu4=; b=YQQqHRpSkrytYfsEPQgYxForVD
 ablAk/WRbGXtgxrxwNPGmkrzt1O8iJfhT5R2bc9kw1ILZs2JspT6CnDAtWi6H1YUByvbdA5f9WyhN
 uCO93gIlHgtuIV9TH2X+F3LmXC0K4QQezeb3WfKxjzE/QxnV9BXZKeQZppJYBgbbWJVaY6WHdV6Wz
 o3+F4X3jMir+rU9NgAMuiknEYgx5X5aTQ7lEP6wvCebgL1xLVb4qQYSvAXNIGsZclY1CJa85yva1t
 3ZOV/mD9/yBkT9Ag7uKj999ThoEG+ydI187GuglZeRckSc1dxAQ1vI9VhLWGyx3iMOWxNRPx1e+V1
 8b8xJE+w==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyW-00043h-2j; Mon, 16 Nov 2020 14:59:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 52/78] block: switch gendisk lookup to a simple xarray
Date: Mon, 16 Nov 2020 15:57:43 +0100
Message-Id: <20201116145809.410558-53-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Now that bdev_map is only used for finding gendisks, we can use
a simple xarray instead of the regions tracking structure for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/genhd.c         | 208 ++++++++----------------------------------
 include/linux/genhd.h |   7 --
 2 files changed, 37 insertions(+), 178 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index dc8690bc281c16..4a224a3c8e1071 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -27,15 +27,7 @@
 
 static struct kobject *block_depr;
 
-struct bdev_map {
-	struct bdev_map *next;
-	dev_t dev;
-	unsigned long range;
-	struct module *owner;
-	struct kobject *(*probe)(dev_t, int *, void *);
-	int (*lock)(dev_t, void *);
-	void *data;
-} *bdev_map[255];
+static DEFINE_XARRAY(bdev_map);
 static DEFINE_MUTEX(bdev_map_lock);
 
 /* for extended dynamic devt allocation, currently only one major is used */
@@ -646,85 +638,26 @@ static char *bdevt_str(dev_t devt, char *buf)
 	return buf;
 }
 
-/*
- * Register device numbers dev..(dev+range-1)
- * range must be nonzero
- * The hash chain is sorted on range, so that subranges can override.
- */
-void blk_register_region(dev_t devt, unsigned long range, struct module *module,
-			 struct kobject *(*probe)(dev_t, int *, void *),
-			 int (*lock)(dev_t, void *), void *data)
-{
-	unsigned n = MAJOR(devt + range - 1) - MAJOR(devt) + 1;
-	unsigned index = MAJOR(devt);
-	unsigned i;
-	struct bdev_map *p;
-
-	n = min(n, 255u);
-	p = kmalloc_array(n, sizeof(struct bdev_map), GFP_KERNEL);
-	if (p == NULL)
-		return;
-
-	for (i = 0; i < n; i++, p++) {
-		p->owner = module;
-		p->probe = probe;
-		p->lock = lock;
-		p->dev = devt;
-		p->range = range;
-		p->data = data;
-	}
+static void blk_register_region(struct gendisk *disk)
+{
+	int i;
 
 	mutex_lock(&bdev_map_lock);
-	for (i = 0, p -= n; i < n; i++, p++, index++) {
-		struct bdev_map **s = &bdev_map[index % 255];
-		while (*s && (*s)->range < range)
-			s = &(*s)->next;
-		p->next = *s;
-		*s = p;
+	for (i = 0; i < disk->minors; i++) {
+		if (xa_insert(&bdev_map, disk_devt(disk) + i, disk, GFP_KERNEL))
+			WARN_ON_ONCE(1);
 	}
 	mutex_unlock(&bdev_map_lock);
 }
-EXPORT_SYMBOL(blk_register_region);
 
-void blk_unregister_region(dev_t devt, unsigned long range)
+static void blk_unregister_region(struct gendisk *disk)
 {
-	unsigned n = MAJOR(devt + range - 1) - MAJOR(devt) + 1;
-	unsigned index = MAJOR(devt);
-	unsigned i;
-	struct bdev_map *found = NULL;
+	int i;
 
 	mutex_lock(&bdev_map_lock);
-	for (i = 0; i < min(n, 255u); i++, index++) {
-		struct bdev_map **s;
-		for (s = &bdev_map[index % 255]; *s; s = &(*s)->next) {
-			struct bdev_map *p = *s;
-			if (p->dev == devt && p->range == range) {
-				*s = p->next;
-				if (!found)
-					found = p;
-				break;
-			}
-		}
-	}
+	for (i = 0; i < disk->minors; i++)
+		xa_erase(&bdev_map, disk_devt(disk) + i);
 	mutex_unlock(&bdev_map_lock);
-	kfree(found);
-}
-EXPORT_SYMBOL(blk_unregister_region);
-
-static struct kobject *exact_match(dev_t devt, int *partno, void *data)
-{
-	struct gendisk *p = data;
-
-	return &disk_to_dev(p)->kobj;
-}
-
-static int exact_lock(dev_t devt, void *data)
-{
-	struct gendisk *p = data;
-
-	if (!get_disk_and_module(p))
-		return -1;
-	return 0;
 }
 
 static void disk_scan_partitions(struct gendisk *disk)
@@ -870,8 +803,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 		ret = bdi_register(bdi, "%u:%u", MAJOR(devt), MINOR(devt));
 		WARN_ON(ret);
 		bdi_set_owner(bdi, dev);
-		blk_register_region(disk_devt(disk), disk->minors, NULL,
-				    exact_match, exact_lock, disk);
+		blk_register_region(disk);
 	}
 	register_disk(parent, disk, groups);
 	if (register_queue)
@@ -984,7 +916,7 @@ void del_gendisk(struct gendisk *disk)
 	blk_unregister_queue(disk);
 	
 	if (!(disk->flags & GENHD_FL_HIDDEN))
-		blk_unregister_region(disk_devt(disk), disk->minors);
+		blk_unregister_region(disk);
 	/*
 	 * Remove gendisk pointer from idr so that it cannot be looked up
 	 * while RCU period before freeing gendisk is running to prevent
@@ -1050,54 +982,22 @@ static void request_gendisk_module(dev_t devt)
 		request_module("block-major-%d", MAJOR(devt));
 }
 
-static struct gendisk *lookup_gendisk(dev_t dev, int *partno)
+static bool get_disk_and_module(struct gendisk *disk)
 {
-	struct kobject *kobj;
-	struct bdev_map *p;
-	unsigned long best = ~0UL;
-
-retry:
-	mutex_lock(&bdev_map_lock);
-	for (p = bdev_map[MAJOR(dev) % 255]; p; p = p->next) {
-		struct kobject *(*probe)(dev_t, int *, void *);
-		struct module *owner;
-		void *data;
-
-		if (p->dev > dev || p->dev + p->range - 1 < dev)
-			continue;
-		if (p->range - 1 >= best)
-			break;
-		if (!try_module_get(p->owner))
-			continue;
-		owner = p->owner;
-		data = p->data;
-		probe = p->probe;
-		best = p->range - 1;
-		*partno = dev - p->dev;
-
-		if (!probe) {
-			mutex_unlock(&bdev_map_lock);
-			module_put(owner);
-			request_gendisk_module(dev);
-			goto retry;
-		}
+	struct module *owner;
 
-		if (p->lock && p->lock(dev, data) < 0) {
-			module_put(owner);
-			continue;
-		}
-		mutex_unlock(&bdev_map_lock);
-		kobj = probe(dev, partno, data);
-		/* Currently ->owner protects _only_ ->probe() itself. */
+	if (!disk->fops)
+		return false;
+	owner = disk->fops->owner;
+	if (owner && !try_module_get(owner))
+		return false;
+	if (!kobject_get_unless_zero(&disk_to_dev(disk)->kobj)) {
 		module_put(owner);
-		if (kobj)
-			return dev_to_disk(kobj_to_dev(kobj));
-		goto retry;
+		return false;
 	}
-	mutex_unlock(&bdev_map_lock);
-	return NULL;
-}
+	return true;
 
+}
 
 /**
  * get_gendisk - get partitioning information for a given device
@@ -1116,7 +1016,19 @@ struct gendisk *get_gendisk(dev_t devt, int *partno)
 	might_sleep();
 
 	if (MAJOR(devt) != BLOCK_EXT_MAJOR) {
-		disk = lookup_gendisk(devt, partno);
+		mutex_lock(&bdev_map_lock);
+		disk = xa_load(&bdev_map, devt);
+		if (!disk) {
+			mutex_unlock(&bdev_map_lock);
+			request_gendisk_module(devt);
+			mutex_lock(&bdev_map_lock);
+			disk = xa_load(&bdev_map, devt);
+		}
+		if (disk && !get_disk_and_module(disk))
+			disk = NULL;
+		if (disk)
+			*partno = devt - disk_devt(disk);
+		mutex_unlock(&bdev_map_lock);
 	} else {
 		struct hd_struct *part;
 
@@ -1320,21 +1232,6 @@ static const struct seq_operations partitions_op = {
 };
 #endif
 
-static void bdev_map_init(void)
-{
-	struct bdev_map *base;
-	int i;
-
-	base = kzalloc(sizeof(*base), GFP_KERNEL);
-	if (!base)
-		panic("cannot allocate bdev_map");
-
-	base->dev = 1;
-	base->range = ~0 ;
-	for (i = 0; i < 255; i++)
-		bdev_map[i] = base;
-}
-
 static int __init genhd_device_init(void)
 {
 	int error;
@@ -1343,7 +1240,6 @@ static int __init genhd_device_init(void)
 	error = class_register(&block_class);
 	if (unlikely(error))
 		return error;
-	bdev_map_init();
 	blk_dev_init();
 
 	register_blkdev(BLOCK_EXT_MAJOR, "blkext");
@@ -1892,35 +1788,6 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 }
 EXPORT_SYMBOL(__alloc_disk_node);
 
-/**
- * get_disk_and_module - increments the gendisk and gendisk fops module refcount
- * @disk: the struct gendisk to increment the refcount for
- *
- * This increments the refcount for the struct gendisk, and the gendisk's
- * fops module owner.
- *
- * Context: Any context.
- */
-struct kobject *get_disk_and_module(struct gendisk *disk)
-{
-	struct module *owner;
-	struct kobject *kobj;
-
-	if (!disk->fops)
-		return NULL;
-	owner = disk->fops->owner;
-	if (owner && !try_module_get(owner))
-		return NULL;
-	kobj = kobject_get_unless_zero(&disk_to_dev(disk)->kobj);
-	if (kobj == NULL) {
-		module_put(owner);
-		return NULL;
-	}
-	return kobj;
-
-}
-EXPORT_SYMBOL(get_disk_and_module);
-
 /**
  * put_disk - decrements the gendisk refcount
  * @disk: the struct gendisk to decrement the refcount for
@@ -1957,7 +1824,6 @@ void put_disk_and_module(struct gendisk *disk)
 		module_put(owner);
 	}
 }
-EXPORT_SYMBOL(put_disk_and_module);
 
 static void set_disk_ro_uevent(struct gendisk *gd, int ro)
 {
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 04f6a6bf577a90..46553d6d602563 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -338,15 +338,8 @@ int blk_add_partitions(struct gendisk *disk, struct block_device *bdev);
 int blk_drop_partitions(struct block_device *bdev);
 
 extern struct gendisk *__alloc_disk_node(int minors, int node_id);
-extern struct kobject *get_disk_and_module(struct gendisk *disk);
 extern void put_disk(struct gendisk *disk);
 extern void put_disk_and_module(struct gendisk *disk);
-extern void blk_register_region(dev_t devt, unsigned long range,
-			struct module *module,
-			struct kobject *(*probe)(dev_t, int *, void *),
-			int (*lock)(dev_t, void *),
-			void *data);
-extern void blk_unregister_region(dev_t devt, unsigned long range);
 
 #define alloc_disk_node(minors, node_id)				\
 ({									\
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
