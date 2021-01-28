Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACB9C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 04:48:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB4B64DD8
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 04:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB4B64DD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cnXACB1Ei9jiDGliNDQFiMXQvVaiCWK7C9RzBjQitH0=; b=xRaES7+TFDLeoio7gYTitsAKZ
	cDKarcyChYZQwSMij+n3HoRUkozTiP2Uc3FXRyRXXubq84aJeqwiqp6ogdGMSj4Rq5AqKqVSd6MdY
	uN4yWMzzxd4HjJPKwud7rbzXWJOC5zHAQS7ClBz3Lj/xE37P8ZEdiELBqfXH6int6eqAbLCWl6heS
	8Ad3DIf03S5NyyWbudtDVfKNTR6zP9fKghr86cj4G78aD8sxRAdEuacZ3x2UcXvd23XH0e1twcg+c
	DPQOYIoh95wbinM5D06SqSCCEErDJYzfiK7u1kb3gINhYtIkvuLxiU9J1W2NcG7plxPODQHrQgIyO
	mR99nQw8Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4zDq-0002Ao-Ms; Thu, 28 Jan 2021 04:47:58 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4zDc-00025x-N6
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 04:47:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611809264; x=1643345264;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FYa88HT0yWBywxqBZGFR8tCz7AMVDuJCnFOsRnimI0M=;
 b=XTCeQ5TfrYa6K3FQ5TG7D6hoLAf5aauNFBTTTb06Y1lkcFUxhhFetebw
 QwQrmyLziYBAMc1UlqWzYZSoLKlyJAR2gFOZ38C9KHWD8yvMmmL+kgOP8
 vRy7n//FMBUuFHAlGBI0YwVwfKveghCJfvS6CzyJsgmZAP+RzcgB2/q9L
 dsVIT2KJdags9oiNWJlB05mPmXgCam8gl75HQ7psGkMNjXfPCjytesnFG
 Nwc6zTKWhHRexy/8oedllI5FCzM8LsW8QV2islGqdmcMNbBlD9SDWAzl/
 3rCfleHZxdwHfhnBS/W1oNt6HKSyNMV8LBrssBYGVMNE/S5lEYBKyw2/o w==;
IronPort-SDR: YeSWWxdFuNLG8lf83IKFY8nWObuy2GUYOnRG8pBYViHCPpldXiv3LHcvMCcpYMmUC3i2lX2r/7
 sSwVZS3KCpYMHYO4NzXCNTH+4vQ/CqoT1R1dVMlU/L8nz+u6ieyl7IVqqpdRI43nHj1SGoYwbc
 nb74bL5EK/3Z3Un4Y6cnKsf8rCsol+YeFFiDyFMkPe3aeAHABBieBKCyJzCRN0F8lIYVSAqxL/
 3PYhlFwGO0Bpc+aqmLLbT0GZvMjQ8k7oUEOOCN49jejaKyjQoDZtUS0e3cdDP/b2iLdWuHJTji
 eLA=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; d="scan'208";a="158509630"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 12:47:43 +0800
IronPort-SDR: e1aWMFapuXaNIC+Un4ObD+ds3+QFaPczvBxUAy7JfyKmy6Ly2H1dmCs3Fxqp6L0nRnBS0ICI/L
 fkpNnlClNFwxS2PJeNjoKXuOht2TawxntAWSCUsYWoFWa72GlUxrTXXyicd4oTKcqpwKEW93Cu
 04Vp66S3pSXwKfm2lU44Kp5ujt9TNkPmvpw3IBt2loISTl6gXLx/7wYDVptw3aOldNqlQ0JbiH
 q33pKRKNkzQdJF/cU8YNMy9fpI1KqcPwAkVgFce1JlJWKxXPo5r7mwNDMRIFES4GFbtc8pEdyd
 OD0sxjnrS1gq+hv4j/47S0pD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2021 20:32:04 -0800
IronPort-SDR: c2uU3xUrafHzTvInYusEBlkZFhykLUHkikWL1bY/D0HixajYtB+H/8+7/8J3BxAl+/sQkwwgen
 kOsXKwa7T6GdbPJvyDJbNSLIA0qKhAR6x6CiCVViEFKAmuOVTNS/Y1Igqw6pDguJhYlzk2igIp
 mMWnW1DuNbonLU5OmyHug7NfP9fWF/hL/EvbEdtuSz84juITF14ZEKTGzQAWf2acYNUpflkMA2
 Gck7JNM3OmoZEBBSlJxBNcf0U+gITl/bP/K78FpfJYVv5nrGesXq8uSRjiFmrhvrwNClCSqZYQ
 3no=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 Jan 2021 20:47:42 -0800
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 5/8] block: introduce zone_write_granularity limit
Date: Thu, 28 Jan 2021 13:47:30 +0900
Message-Id: <20210128044733.503606-6-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128044733.503606-1-damien.lemoal@wdc.com>
References: <20210128044733.503606-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_234744_985245_6CDBE6A4 
X-CRM114-Status: GOOD (  24.17  )
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
Cc: Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Per ZBC and ZAC specifications, host-managed SMR hard-disks mandate that
all writes into sequential write required zones be aligned to the device
physical block size. However, NVMe ZNS does not have this constraint and
allows write operations into sequential zones to be aligned to the
device logical block size. This inconsistency does not help with
software portability across device types.

To solve this, introduce the zone_write_granularity queue limit to
indicate the alignment constraint, in bytes, of write operations into
zones of a zoned block device. This new limit is exported as a
read-only sysfs queue attribute and the helper
blk_queue_zone_write_granularity() introduced for drivers to set this
limit.

The function blk_queue_set_zoned() is modified to set this new limit to
the device logical block size by default. NVMe ZNS devices as well as
zoned nullb devices use this default value as is. The scsi disk driver
is modified to execute the blk_queue_zone_write_granularity() helper to
set the zone write granularity of host-managed SMR disks to the disk
physical block size.

The accessor functions queue_zone_write_granularity() and
bdev_zone_write_granularity() are also introduced.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 Documentation/block/queue-sysfs.rst |  7 ++++++
 block/blk-settings.c                | 37 ++++++++++++++++++++++++++++-
 block/blk-sysfs.c                   |  8 +++++++
 drivers/scsi/sd_zbc.c               |  8 +++++++
 include/linux/blkdev.h              | 15 ++++++++++++
 5 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
index edc6e6960b96..4dc7f0d499a8 100644
--- a/Documentation/block/queue-sysfs.rst
+++ b/Documentation/block/queue-sysfs.rst
@@ -279,4 +279,11 @@ devices are described in the ZBC (Zoned Block Commands) and ZAC
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
index 4c974340f1a9..a1e66165adcf 100644
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
@@ -875,7 +902,15 @@ void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 		break;
 	}
 
-	disk->queue->limits.zoned = model;
+	q->limits.zoned = model;
+	if (model != BLK_ZONED_NONE) {
+		/*
+		 * Set the zone write granularity to the device logical block
+		 * size by default. The driver can change this value if needed.
+		 */
+		blk_queue_zone_write_granularity(q,
+						queue_logical_block_size(q));
+	}
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
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index cf07b7f93579..8293b29584b3 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -789,6 +789,14 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
 	blk_queue_max_active_zones(q, 0);
 	nr_zones = round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks);
 
+	/*
+	 * Per ZBC and ZAC specifications, writes in sequential write required
+	 * zones of host-managed devices must be aligned to the device physical
+	 * block size.
+	 */
+	if (blk_queue_zoned_model(q) == BLK_ZONED_HM)
+		blk_queue_zone_write_granularity(q, sdkp->physical_block_size);
+
 	/* READ16/WRITE16 is mandatory for ZBC disks */
 	sdkp->device->use_16_for_rw = 1;
 	sdkp->device->use_10_for_rw = 0;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0dea268bd61b..9149f4a5adb3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -337,6 +337,7 @@ struct queue_limits {
 	unsigned int		max_zone_append_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
+	unsigned int		zone_write_granularity;
 
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
@@ -1160,6 +1161,8 @@ extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_max_zone_append_sectors(struct request_queue *q,
 		unsigned int max_zone_append_sectors);
 extern void blk_queue_physical_block_size(struct request_queue *, unsigned int);
+void blk_queue_zone_write_granularity(struct request_queue *q,
+				      unsigned int size);
 extern void blk_queue_alignment_offset(struct request_queue *q,
 				       unsigned int alignment);
 void blk_queue_update_readahead(struct request_queue *q);
@@ -1473,6 +1476,18 @@ static inline int bdev_io_opt(struct block_device *bdev)
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
