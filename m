Return-Path: <SRS0=M7ZW=NH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB866C4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 13:29:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A00760F46
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 13:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9A00760F46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Oh5caTP7VXl4RYmnrtuh4FdiMZHJ1zslStdQQIyFxTg=; b=d0oEufUsqGOIsH
	jQZeJ1TvEQ++KDCLGDpO9SPJccGSYs8T6yfcFhLW21+WtKQXTGp8eXCreimhKLTrtWmVey7ONaTlU
	GZ8HC1Mve4a0mpM5PwqepqKLEEMqe/+/ELbm6JNoMQSWygeLqgWqekdJ4MOslU5ztmsgA+fHcNHyF
	PHczV0ZOmm4aO4SCBGsqiYORhhQg8H0T3MDDInn+UeIgXL80Wj8HUO8Uaalj9utSAuIQ6ORfzeVsv
	7OJkHMWMmNrA/AWa9D3YJ5vQgTKZLn4gSrILzMpsnIMk85Fz6Wq/r7+sz3unr7vUe1IPdRrPC2NpC
	TiTU5uEXsE9WfqjR3j+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mFcfo-00H7ZT-VL; Mon, 16 Aug 2021 13:29:05 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFcfm-00H7YZ-Hn
 for linux-nvme@bombadil.infradead.org; Mon, 16 Aug 2021 13:29:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=PDnZhy0QacZQFKggiG8wQPxbE9N2h5O9os3Tc7qV/9I=; b=OlvxcAF6osuKcwgJujjEEXGeUt
 iys0eiLifOMI/aV13K+zle9dsnRMjO9gNlYREiINoLOcWuXIOOy4I/55hCTbmIlLAFg/xGMrItpKv
 +KqtCoNZQeFpSXa4z5vi9PxyhtmhwGOlzr4EcmL9XWS3wwq/F1wgAm85LqWo/RoWz1vfSrGjY1/Ra
 BSjmFA+fvsnchVm7n+o8cuWbaxDilVhc32J/7RDUMynJ3PhaP4z3MDQSTa9b5YU5b9IsRKVBMDq7U
 /58bA4a7hELmC86nVItbnFPPDu8SF8Oe9kXEOseh4GmvT0U5xQ1pCg8RtCOz8PbhLvbCSg8TDhNT0
 XGDgK/MA==;
Received: from [2001:4bb8:188:1b1:3731:604a:a6cd:dc60] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFcex-001PLQ-IG; Mon, 16 Aug 2021 13:28:29 +0000
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
Subject: [PATCH 7/9] block: pass a request_queue to __blk_alloc_disk
Date: Mon, 16 Aug 2021 15:19:08 +0200
Message-Id: <20210816131910.615153-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210816131910.615153-1-hch@lst.de>
References: <20210816131910.615153-1-hch@lst.de>
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
index 8ac30c343c06..2ca7e7c94b18 100644
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
index caeda726189c..f18122ee2778 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1254,7 +1254,8 @@ dev_t blk_lookup_devt(const char *name, int partno)
 	return devt;
 }
 
-struct gendisk *__alloc_disk_node(int node_id, struct lock_class_key *lkclass)
+struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
+		struct lock_class_key *lkclass)
 {
 	struct gendisk *disk;
 
@@ -1281,6 +1282,7 @@ struct gendisk *__alloc_disk_node(int node_id, struct lock_class_key *lkclass)
 	disk_to_dev(disk)->type = &disk_type;
 	device_initialize(disk_to_dev(disk));
 	inc_diskseq(disk);
+	disk->queue = q;
 	lockdep_init_map(&disk->lockdep_map, "(bio completion)", lkclass, 0);
 #ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
 	INIT_LIST_HEAD(&disk->slave_bdevs);
@@ -1307,12 +1309,11 @@ struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass)
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
index d20f101be758..13e90e6231d8 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -259,7 +259,8 @@ static inline sector_t get_capacity(struct gendisk *disk)
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
