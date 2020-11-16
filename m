Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF73FC5519F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:05:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A6FD2344C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cm+seSIk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="trr8ifok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6FD2344C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wWunA/t+JSF7CoMlxGFN0SqDRFiMhh+kiYNPzVUnkR8=; b=cm+seSIkQsVRsbjli95uVfvf2
	dJZuvd83wztLstxSatg0fwHfP9F/C3aeq+LOb3JCMHt2BCQ4BrWeaTsiaR3hNIFtJ+GoCEtvMNy+u
	Axr/f48CDuBrHBmN/tWtFdk9BRIIpqELWlLVkYiLuFCtGOsrrDma7l+HEcZxheLaEnn9JrHLq0HR2
	aEqvzc8eu5StCSkeJKlV28ww0V2auj107hCnlL/Krs0cEVCtdtnC/z+uVI69CnOix/K/BTnEx4nhb
	HtTdMPIJs0stZBfzTHdHsYzAElfbrvsC4Oz/feHrHlxSQpxKoHFmKF9r7XgotCMqfXpaUC1978x1j
	A/kKYMopw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keg4V-0000Nq-4V; Mon, 16 Nov 2020 15:05:35 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyA-0003fY-Rv
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:59:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=HSHstTA5FBmItbRjwbt8hMTbGvjYX3IcG/k6MZ54c5g=; b=trr8ifokY9kZUYDsLpSU9II+9M
 8iOgO1nNBoSZITeSO6bl6xy7/7QVmOV+Wp/IF2eAc4UazTh4EZjMGH7xMC2tlJ1cltl+f6HNJiFqt
 M+MdbLlrB1hAhEhOqTv8IbtoPMg0JuE4E3FFqf/AKsqROtJ5cBZEB1aT1wtbW/JeaGVhyB/xyhrIU
 XjIGpFSG04CEPTZ4UHcdMJuKrv28ynGnyrFeKY7MrJa4DjTd0KsoYD9H2QWkllN8Kh9efXfFFayRp
 wpgPnaDMPtCgTAFS90qS+ULgU0+e254709WuXfRit4EQSdOHjhmneOoyscxZi13M+fEKAYvQXhDsO
 VcvGE4yA==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefy9-0003wb-0o; Mon, 16 Nov 2020 14:59:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 36/78] block: open code kobj_map into in block/genhd.c
Date: Mon, 16 Nov 2020 15:57:27 +0100
Message-Id: <20201116145809.410558-37-hch@lst.de>
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
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Copy and paste the kobj_map functionality in the block code in preparation
for completely rewriting it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 130 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 117 insertions(+), 13 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 8180195b76634b..482f7b89802010 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -17,7 +17,6 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/kmod.h>
-#include <linux/kobj_map.h>
 #include <linux/mutex.h>
 #include <linux/idr.h>
 #include <linux/log2.h>
@@ -29,6 +28,16 @@
 static DEFINE_MUTEX(block_class_lock);
 static struct kobject *block_depr;
 
+struct bdev_map {
+	struct bdev_map *next;
+	dev_t dev;
+	unsigned long range;
+	struct module *owner;
+	struct kobject *(*probe)(dev_t, int *, void *);
+	int (*lock)(dev_t, void *);
+	void *data;
+} *bdev_map[255];
+
 /* for extended dynamic devt allocation, currently only one major is used */
 #define NR_EXT_DEVT		(1 << MINORBITS)
 
@@ -517,8 +526,6 @@ void unregister_blkdev(unsigned int major, const char *name)
 
 EXPORT_SYMBOL(unregister_blkdev);
 
-static struct kobj_map *bdev_map;
-
 /**
  * blk_mangle_minor - scatter minor numbers apart
  * @minor: minor number to mangle
@@ -645,16 +652,60 @@ void blk_register_region(dev_t devt, unsigned long range, struct module *module,
 			 struct kobject *(*probe)(dev_t, int *, void *),
 			 int (*lock)(dev_t, void *), void *data)
 {
-	kobj_map(bdev_map, devt, range, module, probe, lock, data);
-}
+	unsigned n = MAJOR(devt + range - 1) - MAJOR(devt) + 1;
+	unsigned index = MAJOR(devt);
+	unsigned i;
+	struct bdev_map *p;
+
+	n = min(n, 255u);
+	p = kmalloc_array(n, sizeof(struct bdev_map), GFP_KERNEL);
+	if (p == NULL)
+		return;
 
+	for (i = 0; i < n; i++, p++) {
+		p->owner = module;
+		p->probe = probe;
+		p->lock = lock;
+		p->dev = devt;
+		p->range = range;
+		p->data = data;
+	}
+
+	mutex_lock(&block_class_lock);
+	for (i = 0, p -= n; i < n; i++, p++, index++) {
+		struct bdev_map **s = &bdev_map[index % 255];
+		while (*s && (*s)->range < range)
+			s = &(*s)->next;
+		p->next = *s;
+		*s = p;
+	}
+	mutex_unlock(&block_class_lock);
+}
 EXPORT_SYMBOL(blk_register_region);
 
 void blk_unregister_region(dev_t devt, unsigned long range)
 {
-	kobj_unmap(bdev_map, devt, range);
-}
+	unsigned n = MAJOR(devt + range - 1) - MAJOR(devt) + 1;
+	unsigned index = MAJOR(devt);
+	unsigned i;
+	struct bdev_map *found = NULL;
 
+	mutex_lock(&block_class_lock);
+	for (i = 0; i < min(n, 255u); i++, index++) {
+		struct bdev_map **s;
+		for (s = &bdev_map[index % 255]; *s; s = &(*s)->next) {
+			struct bdev_map *p = *s;
+			if (p->dev == devt && p->range == range) {
+				*s = p->next;
+				if (!found)
+					found = p;
+				break;
+			}
+		}
+	}
+	mutex_unlock(&block_class_lock);
+	kfree(found);
+}
 EXPORT_SYMBOL(blk_unregister_region);
 
 static struct kobject *exact_match(dev_t devt, int *partno, void *data)
@@ -976,6 +1027,47 @@ static ssize_t disk_badblocks_store(struct device *dev,
 	return badblocks_store(disk->bb, page, len, 0);
 }
 
+static struct gendisk *lookup_gendisk(dev_t dev, int *partno)
+{
+	struct kobject *kobj;
+	struct bdev_map *p;
+	unsigned long best = ~0UL;
+
+retry:
+	mutex_lock(&block_class_lock);
+	for (p = bdev_map[MAJOR(dev) % 255]; p; p = p->next) {
+		struct kobject *(*probe)(dev_t, int *, void *);
+		struct module *owner;
+		void *data;
+
+		if (p->dev > dev || p->dev + p->range - 1 < dev)
+			continue;
+		if (p->range - 1 >= best)
+			break;
+		if (!try_module_get(p->owner))
+			continue;
+		owner = p->owner;
+		data = p->data;
+		probe = p->probe;
+		best = p->range - 1;
+		*partno = dev - p->dev;
+		if (p->lock && p->lock(dev, data) < 0) {
+			module_put(owner);
+			continue;
+		}
+		mutex_unlock(&block_class_lock);
+		kobj = probe(dev, partno, data);
+		/* Currently ->owner protects _only_ ->probe() itself. */
+		module_put(owner);
+		if (kobj)
+			return dev_to_disk(kobj_to_dev(kobj));
+		goto retry;
+	}
+	mutex_unlock(&block_class_lock);
+	return NULL;
+}
+
+
 /**
  * get_gendisk - get partitioning information for a given device
  * @devt: device to get partitioning information for
@@ -993,11 +1085,7 @@ struct gendisk *get_gendisk(dev_t devt, int *partno)
 	might_sleep();
 
 	if (MAJOR(devt) != BLOCK_EXT_MAJOR) {
-		struct kobject *kobj;
-
-		kobj = kobj_lookup(bdev_map, devt, partno);
-		if (kobj)
-			disk = dev_to_disk(kobj_to_dev(kobj));
+		disk = lookup_gendisk(devt, partno);
 	} else {
 		struct hd_struct *part;
 
@@ -1210,6 +1298,22 @@ static struct kobject *base_probe(dev_t devt, int *partno, void *data)
 	return NULL;
 }
 
+static void bdev_map_init(void)
+{
+	struct bdev_map *base;
+	int i;
+
+	base = kzalloc(sizeof(*base), GFP_KERNEL);
+	if (!base)
+		panic("cannot allocate bdev_map");
+
+	base->dev = 1;
+	base->range = ~0 ;
+	base->probe = base_probe;
+	for (i = 0; i < 255; i++)
+		bdev_map[i] = base;
+}
+
 static int __init genhd_device_init(void)
 {
 	int error;
@@ -1218,7 +1322,7 @@ static int __init genhd_device_init(void)
 	error = class_register(&block_class);
 	if (unlikely(error))
 		return error;
-	bdev_map = kobj_map_init(base_probe, &block_class_lock);
+	bdev_map_init();
 	blk_dev_init();
 
 	register_blkdev(BLOCK_EXT_MAJOR, "blkext");
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
