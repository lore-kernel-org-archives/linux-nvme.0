Return-Path: <SRS0=ZjMq=ND=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A505C4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Aug 2021 08:06:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF9E461038
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Aug 2021 08:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF9E461038
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3xD+X9p8M262gZNa0GZx9Ptjn6jBnwucCAY6Accml3k=; b=1rBcLwOxqLSPgX
	RGevHkVYjEQr0X4KqLM7Z0f/w+3ERBHZlHjNNCu29YOg6eHzM2dMfikSDEBDveQEy5/bqj0CCURJS
	WX1XI6gnCvJ7hydC/leTsEIBJGAsBfHGHJ6DGzRJJ04lCkbcJJr6HRnPOCDP00qSOBn3CxRyYX3gH
	HLMeAM/ZsdeohJ2PSxabpLXUqZOoFQ2eDyEvNmlBYq96hJK0WzR5IblBlNKkv2ZXMnWohGd1e5n8Y
	8OownzIal6oUHSRoQlrMyGLNSwZwcSA/gM2Ec2Aq6ZNgq707Bu5pAYcmNjkpwILfNiWXV3ZiNyIJO
	SfTkRs6YGcSMzSJRDXYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mE5j9-0092i3-Nw; Thu, 12 Aug 2021 08:06:11 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mE5XV-008zuV-Jf
 for linux-nvme@bombadil.infradead.org; Thu, 12 Aug 2021 07:54:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=uaupnpZqgkdsEv1d7dBROnBxde2r/Xnr+A4i9lLbLyA=; b=jR9xLmqFlk6X8mov0qYs7INKoo
 Qmnv9iMuUD2bS6VfzIT7fx/wbck/gESBgxxS6oiwiplMSSWuWd8P1JY72ZsnJKL8MrES64yzbunin
 pVjjYAAkJPeZaPBbnwoOpK4/8f3FDR3L0bX/oOVeh8fujS0vDKLAcpRP3x+Oyniu+xSFnoZf/auye
 0no3+Pttx9CdvAFGiXgxuszofFUEvygaaVL12TErzXCtC6UVNisZQHurZX0kakfZvsxS9+BTisaVS
 cFynLe0ta3woucPhWU4Ldwq+QzpYXAhEeBZUH8FFaexjcrig3vIzw93F3JuJGXiygs+79DFhOxP79
 qati3hGw==;
Received: from [2001:4bb8:184:6215:d7d:1904:40de:694d] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mE5Wa-00EJ8k-OK; Thu, 12 Aug 2021 07:53:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Doug Gilbert <dgilbert@interlog.com>,
 =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org
Subject: [PATCH 7/8] block: pass a request_queue to __blk_alloc_disk
Date: Thu, 12 Aug 2021 09:46:41 +0200
Message-Id: <20210812074642.18592-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210812074642.18592-1-hch@lst.de>
References: <20210812074642.18592-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Pass in a request_queue and assign disk->queue in __blk_alloc_disk to
ensure struct gendisk always has a valid ->queue pointer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c                  | 3 +--
 block/genhd.c                   | 7 ++++---
 drivers/s390/block/dasd_genhd.c | 4 ++--
 drivers/scsi/sd.c               | 4 ++--
 drivers/scsi/sr.c               | 4 ++--
 include/linux/genhd.h           | 3 ++-
 6 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b9021d801f28..9aa208af12fa 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3143,12 +3143,11 @@ struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
 	if (IS_ERR(q))
 		return ERR_CAST(q);
 
-	disk = __alloc_disk_node(set->numa_node, lkclass);
+	disk = __alloc_disk_node(q, set->numa_node, lkclass);
 	if (!disk) {
 		blk_cleanup_queue(q);
 		return ERR_PTR(-ENOMEM);
 	}
-	disk->queue = q;
 	return disk;
 }
 EXPORT_SYMBOL(__blk_mq_alloc_disk);
diff --git a/block/genhd.c b/block/genhd.c
index 395013545137..283cf0c649e1 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1263,7 +1263,8 @@ dev_t blk_lookup_devt(const char *name, int partno)
 	return devt;
 }
 
-struct gendisk *__alloc_disk_node(int node_id, struct lock_class_key *lkclass)
+struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
+		struct lock_class_key *lkclass)
 {
 	struct gendisk *disk;
 
@@ -1286,6 +1287,7 @@ struct gendisk *__alloc_disk_node(int node_id, struct lock_class_key *lkclass)
 	disk_to_dev(disk)->type = &disk_type;
 	device_initialize(disk_to_dev(disk));
 	inc_diskseq(disk);
+	disk->queue = q;
 	lockdep_init_map(&disk->lockdep_map, "(bio completion)", lkclass, 0);
 
 	return disk;
@@ -1308,12 +1310,11 @@ struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass)
 	if (!q)
 		return NULL;
 
-	disk = __alloc_disk_node(node, lkclass);
+	disk = __alloc_disk_node(q, node, lkclass);
 	if (!disk) {
 		blk_cleanup_queue(q);
 		return NULL;
 	}
-	disk->queue = q;
 	return disk;
 }
 EXPORT_SYMBOL(__blk_alloc_disk);
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 6e44515b4d33..fa966e0db6ca 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -40,7 +40,8 @@ int dasd_gendisk_alloc(struct dasd_block *block)
 	if (base->devindex >= DASD_PER_MAJOR)
 		return -EBUSY;
 
-	gdp = __alloc_disk_node(NUMA_NO_NODE, &dasd_bio_compl_lkclass);
+	gdp = __alloc_disk_node(block->request_queue, NUMA_NO_NODE,
+				&dasd_bio_compl_lkclass);
 	if (!gdp)
 		return -ENOMEM;
 
@@ -76,7 +77,6 @@ int dasd_gendisk_alloc(struct dasd_block *block)
 	    test_bit(DASD_FLAG_DEVICE_RO, &base->flags))
 		set_disk_ro(gdp, 1);
 	dasd_add_link_to_gendisk(gdp, base);
-	gdp->queue = block->request_queue;
 	block->gdp = gdp;
 	set_capacity(block->gdp, 0);
 	device_add_disk(&base->cdev->dev, block->gdp, NULL);
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 4e22d1bb6226..93e92dec77ed 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3409,7 +3409,8 @@ static int sd_probe(struct device *dev)
 	if (!sdkp)
 		goto out;
 
-	gd = __alloc_disk_node(NUMA_NO_NODE, &sd_bio_compl_lkclass);
+	gd = __alloc_disk_node(sdp->request_queue, NUMA_NO_NODE,
+			       &sd_bio_compl_lkclass);
 	if (!gd)
 		goto out_free;
 
@@ -3459,7 +3460,6 @@ static int sd_probe(struct device *dev)
 
 	gd->fops = &sd_fops;
 	gd->private_data = &sdkp->driver;
-	gd->queue = sdkp->device->request_queue;
 
 	/* defaults, until the device tells us otherwise */
 	sdp->sector_size = 512;
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 2c45b4140e67..a0df27db4d61 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -714,7 +714,8 @@ static int sr_probe(struct device *dev)
 
 	kref_init(&cd->kref);
 
-	disk = __alloc_disk_node(NUMA_NO_NODE, &sr_bio_compl_lkclass);
+	disk = __alloc_disk_node(sdev->request_queue, NUMA_NO_NODE,
+				 &sr_bio_compl_lkclass);
 	if (!disk)
 		goto fail_free;
 	mutex_init(&cd->lock);
@@ -765,7 +766,6 @@ static int sr_probe(struct device *dev)
 
 	set_capacity(disk, cd->capacity);
 	disk->private_data = &cd->driver;
-	disk->queue = sdev->request_queue;
 
 	if (register_cdrom(disk, &cd->cdi))
 		goto fail_minor;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 02c0977993f2..875be3bc8afb 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -262,7 +262,8 @@ static inline sector_t get_capacity(struct gendisk *disk)
 int bdev_disk_changed(struct gendisk *disk, bool invalidate);
 void blk_drop_partitions(struct gendisk *disk);
 
-struct gendisk *__alloc_disk_node(int node_id, struct lock_class_key *lkclass);
+struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
+		struct lock_class_key *lkclass);
 extern void put_disk(struct gendisk *disk);
 struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass);
 
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
