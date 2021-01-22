Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2CDC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 08:00:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6B1230FC
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 08:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6B1230FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DJ+MSb/NCCEX03X860u+d0gHNcHs6aZZ3nrSVxQePYk=; b=LLuqofjbAsnJJAA1zK1zxD97P
	u8iYwI6kIqKYC2UBtXNhU01qOb220ijm/UI5/X7hbvo32CgsvTX+wZ7jxf6gAsMh6B/OO7gk1oj9t
	/EDbphi/X7uJfR3PzqPx/o0kNBwfZ9LQtwFCHl3udzLxhyfsnG4MI9LNBGUDGrJecLE9ML8/BLmGN
	s4F18kENVg15IYLKgfbeqoojdu2M/E0EOvoQJ+pkqp5QjZPLrle5QQC5H3Q3RTre1+Baj4aFvZhfg
	d6Au2RuEdEI6MRsGXpKwtRtCHwIf1CUc7oGcJdH95ARgMnaF1Pm7G9rqs+ddFDUojWroKzJxiGjMu
	5O+aYW9EQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2rMo-0003SX-Pd; Fri, 22 Jan 2021 08:00:26 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2rMk-0003Py-5J
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 08:00:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611302422; x=1642838422;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9WSfllpGuQIiffbbN5+v7zOqg6HXUAMGib9qjyX/9zo=;
 b=aUX9kpCz10daCqjo296yGGvvXAZ8wdZ/qN5NRUYLGjo1E9iQRQ/fCNT1
 IgRMfsv9685nRcLQSy6N24hQnZB9DYqByBqoe9aiE6P4/Em2YtJ/95Crg
 R4AGqL3MoRCxd+duGfk8/M0Mfnl1mY//rsmR4Sl0OZMzF6D+SIwDwJLSG
 q25dki/Yq3zDo9REKX37xppWpAkCWRZHHEoazJOFtqBZ714320/KS1FGA
 OTm3sM4kjh7L/gDz/f7T4YfvobIINXzheuHrbtLanD4+dsSinCR5rerH2
 YBKVXghf0FNvt9yir17WV9mA5rwW4pLRbc73C4F1Kobo/lF+ZUY5QK9vj w==;
IronPort-SDR: xXqrkOPqLGD9BUZMN7y/ymfEHdIQvxq6CKxSLQDtM2zOP4nwdqNI3rdhsZ/DxPMSsnT7rr/zOg
 0u/JqgrlDBgsjXx7z3znvBuru/sjSIXHFZXvS5AY5I7N4pV3/jIwJKOApKMfDfJFI1A/WIOg4z
 FkU1LmM94iAoPXeHrESl+QtEVB4k2yMm/GPMC3mddaQGXAO8/mb+aWXrZZhhbtKuIGlMvHhB44
 gVoG3XfeIABflObKsvk1RtQwZxzLy23fQUNNRtFMRWgoRqUHiDGen6YJRXZ4YoF692CWR3RRt5
 Zs0=
X-IronPort-AV: E=Sophos;i="5.79,366,1602518400"; d="scan'208";a="158062033"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 16:00:18 +0800
IronPort-SDR: 28Vi9EfT1jKpyteQT9ss6/NrWL2W5vpV+s64MdeFEnxYZVS7xo1D42yhhj4xWEwWca1k+cogtk
 E0eDo0dya7YPNNYW+5xRczE4u8SKzUH/obhIgNoe/pJMHQQJblIohPcoj4xt3Rf3QW2KjbAH5r
 4G8p0dJaadIrPBaOY3NWioF3pbu2vpqZR2FNylKz3WpzzA8yDTGbCv9NzXaJru/QmruPBS48Ir
 tr9pOhALTn6dIL8xU7LbHsB33O0ZvFK+Tf/1SARwAusSs7vPx3JYItVmaPFSSXrgDsP16J8j5c
 zR9/8TAR8rLzfrHufuCNyonL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2021 23:42:49 -0800
IronPort-SDR: S4GZPg3dlGc0qg5lrTOlKhI73pMqTnH5VI8yt3wy3LxXg2VyDibIIK0nU9Zg2WncDxlYuqRzzI
 ikH5nT8z1upiQntTYxJ4XYQ4n+qqOaSKeUVRkeott1eb9wh1gIMl+9ygpFrAdxrC6RTS84zJGJ
 q1T9EkJlsnGJBTni624ZX3+eapXdxsPGzPLYC2ObLk/RnepfupvClVj7p4NX0uypGFsl2Y7dJ8
 RajCzDeG3G/LUAIubXzOT4Q29t++funJ45m9yUfF4hJkTBpVupssEK+TE/BlwVO1WctVeJ/H3j
 aek=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 22 Jan 2021 00:00:17 -0800
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 1/3] block: introduce zone_write_granularity limit
Date: Fri, 22 Jan 2021 17:00:12 +0900
Message-Id: <20210122080014.174391-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122080014.174391-1-damien.lemoal@wdc.com>
References: <20210122080014.174391-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210122_030022_466521_8E21917C 
X-CRM114-Status: GOOD (  27.04  )
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
Cc: linux-scsi@vger.kernel.org, Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Per ZBC and ZAC specifications, host-managed SMR hard-disks mandate that
all writes into sequential write required zones be aligned to the device
physical block size. However, NVMe ZNS does not have this constraint and
allows write operations into sequential zones to be logical block size
aligned. This inconsistency does not help with portability of software
across device types.
To solve this, introduce the zone_write_granularity queue limit to
indicate the alignment constraint, in bytes, of write operations into
zones of a zoned block device. This new limit is exported as a
read-only sysfs queue attribute and the helper
blk_queue_zone_write_granularity() introduced for drivers to set this
limit. The scsi disk driver is modified to use this helper to set
host-managed SMR disk zone write granularity to the disk physical block
size. The ZNS support code of the NVMe driver is also modified to use
this helper to set the new limit to the logical block size of the
namespace. The nullblk driver is similarly modified too.

The accessor functions queue_zone_write_granularity() and
bdev_zone_write_granularity() are also introduced.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 Documentation/block/queue-sysfs.rst |  7 ++++++
 block/blk-settings.c                | 39 +++++++++++++++++++++++++----
 block/blk-sysfs.c                   |  8 ++++++
 drivers/block/null_blk/zoned.c      |  1 +
 drivers/nvme/host/zns.c             |  1 +
 drivers/scsi/sd_zbc.c               | 10 ++++++++
 include/linux/blkdev.h              | 15 +++++++++++
 7 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
index 2638d3446b79..c8bf8bc3c03a 100644
--- a/Documentation/block/queue-sysfs.rst
+++ b/Documentation/block/queue-sysfs.rst
@@ -273,4 +273,11 @@ devices are described in the ZBC (Zoned Block Commands) and ZAC
 do not support zone commands, they will be treated as regular block devices
 and zoned will report "none".
 
+zone_write_granularity (RO)
+---------------------------
+This indicates the alignment constraint, in bytes, for write operations in
+sequential zones of zoned block devices (devices with a zoned attributed
+that reports "host-managed" or "host-aware"). This value is always 0 for
+regular block devices.
+
 Jens Axboe <jens.axboe@oracle.com>, February 2009
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 43990b1d148b..48872b4085d4 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -60,6 +60,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->io_opt = 0;
 	lim->misaligned = 0;
 	lim->zoned = BLK_ZONED_NONE;
+	lim->zone_write_granularity = 0;
 }
 EXPORT_SYMBOL(blk_set_default_limits);
 
@@ -366,6 +367,28 @@ void blk_queue_physical_block_size(struct request_queue *q, unsigned int size)
 }
 EXPORT_SYMBOL(blk_queue_physical_block_size);
 
+/**
+ * blk_queue_zone_write_granularity - set zone write granularity for the queue
+ * @q:  the request queue for the zoned device
+ * @size:  the zone write granularity size, in bytes
+ *
+ * Description:
+ *   This should be set to the lowest possible size allowing to write in
+ *   sequential zones of a zoned block device.
+ */
+void blk_queue_zone_write_granularity(struct request_queue *q,
+				      unsigned int size)
+{
+	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
+		return;
+
+	q->limits.zone_write_granularity = size;
+
+	if (q->limits.zone_write_granularity < q->limits.logical_block_size)
+		q->limits.zone_write_granularity = q->limits.logical_block_size;
+}
+EXPORT_SYMBOL_GPL(blk_queue_zone_write_granularity);
+
 /**
  * blk_queue_alignment_offset - set physical block alignment offset
  * @q:	the request queue for the device
@@ -631,6 +654,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 			t->discard_granularity;
 	}
 
+	t->zone_write_granularity = max(t->zone_write_granularity,
+					b->zone_write_granularity);
 	t->zoned = max(t->zoned, b->zoned);
 	return ret;
 }
@@ -847,6 +872,8 @@ EXPORT_SYMBOL_GPL(blk_queue_can_use_dma_map_merging);
  */
 void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 {
+	struct request_queue *q = disk->queue;
+
 	switch (model) {
 	case BLK_ZONED_HM:
 		/*
@@ -864,18 +891,20 @@ void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 		 * partitions and zoned block device support is enabled, else
 		 * we do nothing special as far as the block layer is concerned.
 		 */
-		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) ||
-		    disk_has_partitions(disk))
-			model = BLK_ZONED_NONE;
-		break;
+		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
+		    !disk_has_partitions(disk))
+			break;
+		model = BLK_ZONED_NONE;
+		fallthrough;
 	case BLK_ZONED_NONE:
 	default:
 		if (WARN_ON_ONCE(model != BLK_ZONED_NONE))
 			model = BLK_ZONED_NONE;
+		q->limits.zone_write_granularity = 0;
 		break;
 	}
 
-	disk->queue->limits.zoned = model;
+	q->limits.zoned = model;
 }
 EXPORT_SYMBOL_GPL(blk_queue_set_zoned);
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b513f1683af0..ae39c7f3d83d 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -219,6 +219,12 @@ static ssize_t queue_write_zeroes_max_show(struct request_queue *q, char *page)
 		(unsigned long long)q->limits.max_write_zeroes_sectors << 9);
 }
 
+static ssize_t queue_zone_write_granularity_show(struct request_queue *q,
+						 char *page)
+{
+	return queue_var_show(queue_zone_write_granularity(q), page);
+}
+
 static ssize_t queue_zone_append_max_show(struct request_queue *q, char *page)
 {
 	unsigned long long max_sectors = q->limits.max_zone_append_sectors;
@@ -585,6 +591,7 @@ QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
 QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
+QUEUE_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
 
 QUEUE_RO_ENTRY(queue_zoned, "zoned");
 QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
@@ -639,6 +646,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
+	&queue_zone_write_granularity_entry.attr,
 	&queue_nonrot_entry.attr,
 	&queue_zoned_entry.attr,
 	&queue_nr_zones_entry.attr,
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 535351570bb2..704d09481e0d 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -172,6 +172,7 @@ int null_register_zoned_dev(struct nullb *nullb)
 	blk_queue_max_zone_append_sectors(q, dev->zone_size_sects);
 	blk_queue_max_open_zones(q, dev->zone_max_open);
 	blk_queue_max_active_zones(q, dev->zone_max_active);
+	blk_queue_zone_write_granularity(q, dev->blocksize);
 
 	return 0;
 }
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 1dfe9a3500e3..f25311ccd996 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -113,6 +113,7 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
 	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
+	blk_queue_zone_write_granularity(q, q->limits.logical_block_size);
 free_data:
 	kfree(id);
 	return status;
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index cf07b7f93579..10e9f33cc069 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -789,6 +789,16 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
 	blk_queue_max_active_zones(q, 0);
 	nr_zones = round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks);
 
+	/*
+	 * Per ZBC and ZAC specifications, writes in sequential write required
+	 * zones of host-managed devices must be aligned to the device physical
+	 * block size.
+	 */
+	if (blk_queue_zoned_model(q) == BLK_ZONED_HM)
+		blk_queue_zone_write_granularity(q, sdkp->physical_block_size);
+	else if (blk_queue_zoned_model(q) == BLK_ZONED_HA)
+		blk_queue_zone_write_granularity(q, sdkp->device->sector_size);
+
 	/* READ16/WRITE16 is mandatory for ZBC disks */
 	sdkp->device->use_16_for_rw = 1;
 	sdkp->device->use_10_for_rw = 0;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f94ee3089e01..142e3b34be75 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -337,6 +337,7 @@ struct queue_limits {
 	unsigned int		max_zone_append_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
+	unsigned int		zone_write_granularity;
 
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
@@ -1161,6 +1162,8 @@ extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_max_zone_append_sectors(struct request_queue *q,
 		unsigned int max_zone_append_sectors);
 extern void blk_queue_physical_block_size(struct request_queue *, unsigned int);
+void blk_queue_zone_write_granularity(struct request_queue *q,
+				      unsigned int size);
 extern void blk_queue_alignment_offset(struct request_queue *q,
 				       unsigned int alignment);
 void blk_queue_update_readahead(struct request_queue *q);
@@ -1474,6 +1477,18 @@ static inline int bdev_io_opt(struct block_device *bdev)
 	return queue_io_opt(bdev_get_queue(bdev));
 }
 
+static inline unsigned int
+queue_zone_write_granularity(const struct request_queue *q)
+{
+	return q->limits.zone_write_granularity;
+}
+
+static inline unsigned int
+bdev_zone_write_granularity(struct block_device *bdev)
+{
+	return queue_zone_write_granularity(bdev_get_queue(bdev));
+}
+
 static inline int queue_alignment_offset(const struct request_queue *q)
 {
 	if (q->limits.misaligned)
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
