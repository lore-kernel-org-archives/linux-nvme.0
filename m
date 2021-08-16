Return-Path: <SRS0=M7ZW=NH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA28C4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 13:28:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D868A63292
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 13:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D868A63292
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ViDsCnBpzTBFgv2WRpEIUdyIqfPecZCfZZNg/an+EMI=; b=KggqAor3A6WjWz
	zei2sc0FFz72a2vUQItOy27hvFg4tUFmeXethtH8zepMWtKGTaYXat6Bdxl9nsS4vLWm/rIcmJ/Ns
	+dA+ubhCf99bTKEtBrok2n+hh3/e2fmJAw7hC4G92tMP8hi9GKWDROEMLnEbWU/uLARnMJVn14wST
	4PCY+/Df7akQ+7WY2laKxhFP/cH3QNf0Dg3WtBit/+0fOJ+I6NuZ9xpbJ1D42tblOexBfXuo5jVgq
	PWWT0sAtIBRsVqQdvkjYuB2LjXUGaxHEtGWpInhX2t7RSqffI99laHLZs/wBLJsTlnwkFziSOlru9
	YQcQ/nOOy7t7zYqkBgnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mFcf0-00H7IR-01; Mon, 16 Aug 2021 13:28:14 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFcey-00H7HN-BK
 for linux-nvme@bombadil.infradead.org; Mon, 16 Aug 2021 13:28:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=FFcZLSiuWIHs24l1Onz0blvcgt4rcIjls/wQmp0eRcw=; b=qaJoaYgYZ36tiVcIzsRhnvelsk
 aCCL4+nwsOO8AreE5DJE0yA9aHQf7x32KoD6wH7hX7xtcT2fE2XgUN4D17jPAdj7sfdMGA60ztZKR
 rU5jN43stqECAUq0g9a4QFqyKXg+hUpQfH8PCc2uBFYg/+YOaCxNp39jCAjctMDjQBls6oAQ3+59C
 heF/AC+ZP42bwsFBAror7Bo2cuIEiEXm3vLYn7RjjXvzE3mHIBp6ehHe4A+zOKeEaGiBrQfeZAPiD
 FWYvfnC/gdQ11iI9to+NGTzq4w1pmqw8pXme4ZlhpYIj52JWjCyVabCNs/QGCxSNYmAqC4qJYpd5H
 6NXds8tw==;
Received: from [2001:4bb8:188:1b1:3731:604a:a6cd:dc60] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFcdw-001PE0-Vo; Mon, 16 Aug 2021 13:27:37 +0000
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
Subject: [PATCH 6/9] block: remove the minors argument to __alloc_disk_node
Date: Mon, 16 Aug 2021 15:19:07 +0200
Message-Id: <20210816131910.615153-7-hch@lst.de>
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

This was a leftover from the legacy alloc_disk interface.  Switch
the scsi ULPs and dasd to set ->minors directly like all other
drivers and remove the argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>	[dasd]
---
 block/blk-mq.c                  | 2 +-
 block/genhd.c                   | 6 ++----
 drivers/s390/block/dasd_genhd.c | 4 ++--
 drivers/scsi/sd.c               | 3 ++-
 drivers/scsi/sr.c               | 3 ++-
 include/linux/genhd.h           | 3 +--
 6 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c56e43e6992..8ac30c343c06 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3143,7 +3143,7 @@ struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
 	if (IS_ERR(q))
 		return ERR_CAST(q);
 
-	disk = __alloc_disk_node(0, set->numa_node, lkclass);
+	disk = __alloc_disk_node(set->numa_node, lkclass);
 	if (!disk) {
 		blk_cleanup_queue(q);
 		return ERR_PTR(-ENOMEM);
diff --git a/block/genhd.c b/block/genhd.c
index 2ad2b25dfc87..caeda726189c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1254,8 +1254,7 @@ dev_t blk_lookup_devt(const char *name, int partno)
 	return devt;
 }
 
-struct gendisk *__alloc_disk_node(int minors, int node_id,
-		struct lock_class_key *lkclass)
+struct gendisk *__alloc_disk_node(int node_id, struct lock_class_key *lkclass)
 {
 	struct gendisk *disk;
 
@@ -1277,7 +1276,6 @@ struct gendisk *__alloc_disk_node(int minors, int node_id,
 	if (xa_insert(&disk->part_tbl, 0, disk->part0, GFP_KERNEL))
 		goto out_destroy_part_tbl;
 
-	disk->minors = minors;
 	rand_initialize_disk(disk);
 	disk_to_dev(disk)->class = &block_class;
 	disk_to_dev(disk)->type = &disk_type;
@@ -1309,7 +1307,7 @@ struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass)
 	if (!q)
 		return NULL;
 
-	disk = __alloc_disk_node(0, node, lkclass);
+	disk = __alloc_disk_node(node, lkclass);
 	if (!disk) {
 		blk_cleanup_queue(q);
 		return NULL;
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 07a69b19dd31..6e44515b4d33 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -40,14 +40,14 @@ int dasd_gendisk_alloc(struct dasd_block *block)
 	if (base->devindex >= DASD_PER_MAJOR)
 		return -EBUSY;
 
-	gdp = __alloc_disk_node(1 << DASD_PARTN_BITS, NUMA_NO_NODE,
-				&dasd_bio_compl_lkclass);
+	gdp = __alloc_disk_node(NUMA_NO_NODE, &dasd_bio_compl_lkclass);
 	if (!gdp)
 		return -ENOMEM;
 
 	/* Initialize gendisk structure. */
 	gdp->major = DASD_MAJOR;
 	gdp->first_minor = base->devindex << DASD_PARTN_BITS;
+	gdp->minors = 1 << DASD_PARTN_BITS;
 	gdp->fops = &dasd_device_operations;
 
 	/*
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 4986086009f1..4e22d1bb6226 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3409,7 +3409,7 @@ static int sd_probe(struct device *dev)
 	if (!sdkp)
 		goto out;
 
-	gd = __alloc_disk_node(SD_MINORS, NUMA_NO_NODE, &sd_bio_compl_lkclass);
+	gd = __alloc_disk_node(NUMA_NO_NODE, &sd_bio_compl_lkclass);
 	if (!gd)
 		goto out_free;
 
@@ -3455,6 +3455,7 @@ static int sd_probe(struct device *dev)
 
 	gd->major = sd_major((index & 0xf0) >> 4);
 	gd->first_minor = ((index & 0xf) << 4) | (index & 0xfff00);
+	gd->minors = SD_MINORS;
 
 	gd->fops = &sd_fops;
 	gd->private_data = &sdkp->driver;
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index fee2bdfe6132..2c45b4140e67 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -714,7 +714,7 @@ static int sr_probe(struct device *dev)
 
 	kref_init(&cd->kref);
 
-	disk = __alloc_disk_node(1, NUMA_NO_NODE, &sr_bio_compl_lkclass);
+	disk = __alloc_disk_node(NUMA_NO_NODE, &sr_bio_compl_lkclass);
 	if (!disk)
 		goto fail_free;
 	mutex_init(&cd->lock);
@@ -731,6 +731,7 @@ static int sr_probe(struct device *dev)
 
 	disk->major = SCSI_CDROM_MAJOR;
 	disk->first_minor = minor;
+	disk->minors = 1;
 	sprintf(disk->disk_name, "sr%d", minor);
 	disk->fops = &sr_bdops;
 	disk->flags = GENHD_FL_CD | GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index ceda9b255dba..d20f101be758 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -259,8 +259,7 @@ static inline sector_t get_capacity(struct gendisk *disk)
 int bdev_disk_changed(struct gendisk *disk, bool invalidate);
 void blk_drop_partitions(struct gendisk *disk);
 
-struct gendisk *__alloc_disk_node(int minors, int node_id,
-		struct lock_class_key *lkclass);
+struct gendisk *__alloc_disk_node(int node_id, struct lock_class_key *lkclass);
 extern void put_disk(struct gendisk *disk);
 struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass);
 
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
