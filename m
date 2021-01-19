Return-Path: <SRS0=ulAu=GW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7BAC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 13:17:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A193023132
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 13:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A193023132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qTLIf0ywYbc8sV0b9UCJjTjVLYqkl/A3ttP5UGRn6JQ=; b=MeLZ23CUwJv+plQpnw5b+PR6s
	4gsNVAG4sWT9gwQD4G/KEPxMTnHh3Q+gKc9eYPYmYsglCrjkCmECFInBI5JHYo2FRd3qmlJTGrh5u
	dHz9/wIUyCe2CbbgYHfwDGjizp6AdCEI1XaAcGcYtR5j2B0G5TOjOfSvNgz95n6Cz8e7dEVGPTAAG
	80MK0v9PRMrjR9k+/DKp7a5gpE7Go4/m+pf5zi2XzTwCuQw1zewSGKG79MYGM6AJetna3Lvq+gueQ
	T63zfVVXEXEWmEEbOvD6ZyhjeNuntJ2ZL9cU9wQ2ul/Bp+GnhoxG/ikBazFat4uk6YCkjhjc6WjnS
	+9WqK9UHw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1qt8-0005kf-2D; Tue, 19 Jan 2021 13:17:38 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1qt3-0005iE-J8
 for linux-nvme@lists.infradead.org; Tue, 19 Jan 2021 13:17:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611062253; x=1642598253;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=y6dOEwqLpl0B2L45bIDXFCcME1XrSfA+Q8mO9kbSPHc=;
 b=NJb6ds3TF2Og04h4UmVKWGxc8IDzSDjKFBhY19zcPwlvziRx2bLmqeCK
 7iu3OW6o97gM28n8Tv2q1SaAnLMQogSO0AztACQTF+k74FVmVdokTJPRL
 II14Dp3IZSbkM9H+51ZXDLYUS9PlmYfYvt645oDR54FUD9OEbHh07bRPe
 PDn6qDEwyOov4baRgRf/5UPKsvYs+nx4NQSFSUeGfkXAfk+jWp/C81gO0
 SkJebSKjYLvA0+tFBiR/fJ9i4b8Nmsg/JjI4Q/frhYDws9X5JBBkXue5/
 Hey7VwpJIKedxhqh6ut6a9ZuPgHBhsBXQbe4Dg8SPYibzex1H9jeSBJo+ g==;
IronPort-SDR: FxsT06H8WLcY7TWx1MdGF3sFMcQdrWJY2Wl0fnvC2+oMT3ijXEynl9BsvTXxgCZDXcWLuLOmRH
 U0F8jvYCcJsItEO3KXBlEMJYkKRGMYbRA0rBw51zeDvgzcqvCBqUN6bshT2wSvv8cqtAWKGzNc
 OJLLFyUtwFP8Hz3S35i4iPAhO/qBvppcG4NEq/uu+tuyDucmvHo+WCFnm6gb3T3AXW60ji7AKs
 GStBdf6bgjfIuL01BEh/JqFD9EJbO2HTRuRoisBxBk01z+QKswCzM4UFrCIs+x1k0HkwM8D9tY
 wEo=
X-IronPort-AV: E=Sophos;i="5.79,358,1602518400"; d="scan'208";a="268116822"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 21:17:27 +0800
IronPort-SDR: Ow9htY8zYRTtgs9jNI9bgsp4IWH+pW+LGk/553jG2zX9WGiktj/jgLIL5dgIqnZrGfN8p/kVC9
 1Ap/xjti/OKj+fHclm9TDB6HOuQ7jOtQdrv+QoMOt6Go4v6nA95kLfK/gKpKWu68GgB5mzOYTd
 5/wXsrsZcC5seUCD/eGcRx7qpcyOAP/QEwXuBEebVK8B5UfYVPugu/8DRCDUtjRIiHiPYf1Ip3
 U9vvIEdovnGJPEgutqxe35w5GZHsgHeyF48ISuUa2ewfPLO1pxnEInM5O6mWm+2stR+sGEL6ZL
 gcXXf8cFzT65H60AZiJ5RFT0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2021 05:02:04 -0800
IronPort-SDR: 0oVG0mj91l2paTkiruhXY0NLpDEAOufckmQKQsdFJ0lpG/49KUqhA5FHJpoF/+QlLkV/KiBs7K
 CueKvt3YUppgUWmnY8fQJ/VQ5yJ121BRbERqdkQ75sOIzFyUggQlwZ3KpWuZ5XQv2L6Uq/dov2
 WL9ZR2qhxwdG9NK7DWwpZediKbLMoZjRaPe3Wr8Ge+LUiYVxqrcH00aX0x7TflAtDdV2IqCzBw
 h8PRA6g94gX1caLa6RKvgm0pxOcjm9Mmil0xw7ch2NhQ2Nxd4GGZFTvcvX+Av5r1gwDFyq098n
 NME=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jan 2021 05:17:27 -0800
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 1/2] block: introduce zone_write_granularity limit
Date: Tue, 19 Jan 2021 22:17:22 +0900
Message-Id: <20210119131723.1637853-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210119131723.1637853-1-damien.lemoal@wdc.com>
References: <20210119131723.1637853-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210119_081733_773192_E91F3366 
X-CRM114-Status: GOOD (  22.97  )
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
size. The nvme driver zns support use this helper to set the new limit
to the logical block size of the zoned namespace.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 Documentation/block/queue-sysfs.rst |  7 +++++++
 block/blk-settings.c                | 28 ++++++++++++++++++++++++++++
 block/blk-sysfs.c                   |  7 +++++++
 drivers/nvme/host/zns.c             |  1 +
 drivers/scsi/sd_zbc.c               | 10 ++++++++++
 include/linux/blkdev.h              |  3 +++
 6 files changed, 56 insertions(+)

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
index 43990b1d148b..6be6ed9485e3 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -60,6 +60,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->io_opt = 0;
 	lim->misaligned = 0;
 	lim->zoned = BLK_ZONED_NONE;
+	lim->zone_write_granularity = 0;
 }
 EXPORT_SYMBOL(blk_set_default_limits);
 
@@ -366,6 +367,31 @@ void blk_queue_physical_block_size(struct request_queue *q, unsigned int size)
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
+	if (WARN_ON(!blk_queue_is_zoned(q)))
+		return;
+
+	q->limits.zone_write_granularity = size;
+
+	if (q->limits.zone_write_granularity < q->limits.logical_block_size)
+		q->limits.zone_write_granularity = q->limits.logical_block_size;
+
+	if (q->limits.zone_write_granularity < q->limits.io_min)
+		q->limits.zone_write_granularity = q->limits.io_min;
+}
+EXPORT_SYMBOL_GPL(blk_queue_zone_write_granularity);
+
 /**
  * blk_queue_alignment_offset - set physical block alignment offset
  * @q:	the request queue for the device
@@ -631,6 +657,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 			t->discard_granularity;
 	}
 
+	t->zone_write_granularity = max(t->zone_write_granularity,
+					b->zone_write_granularity);
 	t->zoned = max(t->zoned, b->zoned);
 	return ret;
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b513f1683af0..7ea3dd4d876b 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -219,6 +219,11 @@ static ssize_t queue_write_zeroes_max_show(struct request_queue *q, char *page)
 		(unsigned long long)q->limits.max_write_zeroes_sectors << 9);
 }
 
+static ssize_t queue_zone_write_granularity_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(q->limits.zone_write_granularity, page);
+}
+
 static ssize_t queue_zone_append_max_show(struct request_queue *q, char *page)
 {
 	unsigned long long max_sectors = q->limits.max_zone_append_sectors;
@@ -585,6 +590,7 @@ QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
 QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
+QUEUE_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
 
 QUEUE_RO_ENTRY(queue_zoned, "zoned");
 QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
@@ -639,6 +645,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
+	&queue_zone_write_granularity_entry.attr,
 	&queue_nonrot_entry.attr,
 	&queue_zoned_entry.attr,
 	&queue_nr_zones_entry.attr,
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
index cf07b7f93579..41d602f7e62e 100644
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
+	else
+		blk_queue_zone_write_granularity(q, sdkp->device->sector_size);
+
 	/* READ16/WRITE16 is mandatory for ZBC disks */
 	sdkp->device->use_16_for_rw = 1;
 	sdkp->device->use_10_for_rw = 0;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f94ee3089e01..011b3d2cd273 100644
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
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
