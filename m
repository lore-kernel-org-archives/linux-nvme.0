Return-Path: <SRS0=c2UW=74=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F9EC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 23:35:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56713206DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 23:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MBMNjW9K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YR1PpEBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56713206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A0UnbI6Y/9MgXlMTh5f5jKpeVb+dKATxmeXjnBM1fg8=; b=MBMNjW9KyWdmvn
	a/aP0rirSrQth3cnVdFbKOwD+qeE1gT0qG51w5yiUwyLrdf7a4L5ZC3OkGfnkkq6gahZ6kZLZM3JX
	I30bv75ZxBM5w4zK5TDSoG+RBGgYPzWggJrmAVLmgWJ51cXJ18MOBIFonSjy/OGVVM76GgU4nZ9Qv
	yMGOUAeNOro4Fk4a70IEqNUXmcH6PyYjMcYFEGto6/qbaWU/Tdxp6DI/8n+bS18AvuGAzEfm5GaQg
	k5Z7mDzwbcr+N9h3lpT7cbNPClRUGLjzEe+8a2zx61egg+Ibb7grzdi2DGS3PU93DtJm9JEvq6I1m
	G0TSBhY/CWD+1VmjgAGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jkydi-0005JT-6t; Mon, 15 Jun 2020 23:35:42 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkydL-00050A-Ok
 for linux-nvme@lists.infradead.org; Mon, 15 Jun 2020 23:35:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592264120; x=1623800120;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZpbFMAmySpvBozRPQvGrKys6x+U74lWtkvJm8fSa6eA=;
 b=YR1PpEBcrZbV4pESlxyzj2JoWaELtjwRCeUjQpVmriI4bZNLyvSxSM7H
 /4Kavlh+sT5dVul09GIC5srX8GvR6BBACltspNdr18MlHvwlnRQ8CHMZ+
 Q1ixh7lbOvfkhK9+O4WkF01ARksneahBouStUrCbYM/hESBiS6kV8gBj6
 kb0GwSWGFQbn71GHf0dOV2AWdim8qJuVY1Sn9hoX7ZgNHSUrWdUQP67dZ
 9Qzuv4/c/zbcXs+LSN0q4xlQqtU4UdgEzBS9R8JJ3yG7Lc1w82XGoCTtS
 BcGgbvgoc47L8zFms5V/DzdtR/WVNyWfd/iIIEcxV4Ujou4K+XU/S94Pg w==;
IronPort-SDR: Tlw4C/prOfqsvjOUlz/ojlaKACiiMfSNyB+CYK2yUq+2uVL7aQQ3TS57dNQUI+AuqKjDYQp2JY
 eXtyJkwQtE6V8IaF8++TsArSeurjDpfhPWBOxZD1fiy60AO1P9+Kv+Q3K6x/ru7XOlTKZ9FTi+
 6mXoEcYiGex2JHLGNipJjKJJxVtiMfwTjjH0I9MgG4j0Xz4121kStLQ3ucUPS72UqEE68LknxV
 1kgnUZ7Gm/Ww339Po0fI5M4TrEnawi6QWFU+LIQQni1NbDlQ2GczSnQe6RCvSR5jH/mfLlmk60
 Vug=
X-IronPort-AV: E=Sophos;i="5.73,516,1583164800"; d="scan'208";a="144394456"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 07:35:18 +0800
IronPort-SDR: tJV6vf9yX2sMYVIYU2ubrLfKIACcpv7jGYgpg7QWzAn6VfJr3enZKe8mKZmU5uJDEQei/3BE89
 rUrUnIVCwZpAjoW0MGFr1pZ+KztsHjS2g=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2020 16:24:34 -0700
IronPort-SDR: d1tJr2vjjXbQf9DPO7wQAGFAV4uVB2bLOfEHpus8iwV2d7pMixn8MGzZuE468clxoLbgZgfdL/
 OXaT1ndeIb7Q==
WDCIronportException: Internal
Received: from unknown (HELO redsun51.ssa.fujisawa.hgst.com) ([10.149.66.26])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Jun 2020 16:35:16 -0700
From: Keith Busch <keith.busch@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/5] null_blk: introduce zone capacity for zoned device
Date: Tue, 16 Jun 2020 08:34:21 +0900
Message-Id: <20200615233424.13458-3-keith.busch@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200615233424.13458-1-keith.busch@wdc.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200615_163519_826686_2618BD00 
X-CRM114-Status: GOOD (  15.21  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <damien.lemoal@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Aravind Ramesh <aravind.ramesh@wdc.com>,
 Christoph Hellwig <hch@lst.de>,
 =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Aravind Ramesh <aravind.ramesh@wdc.com>

Allow emulation of a zoned device with a per zone capacity smaller than
the zone size as as defined in the Zoned Namespace (ZNS) Command Set
specification. The zone capacity defaults to the zone size if not
specified and must be smaller than the zone size otherwise.

Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
---
 drivers/block/null_blk.h       |  2 ++
 drivers/block/null_blk_main.c  |  9 ++++++++-
 drivers/block/null_blk_zoned.c | 17 +++++++++++++++--
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 81b311c9d781..7eadf190528c 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -44,11 +44,13 @@ struct nullb_device {
 	unsigned int nr_zones;
 	struct blk_zone *zones;
 	sector_t zone_size_sects;
+	sector_t zone_capacity_sects;
 
 	unsigned long size; /* device size in MB */
 	unsigned long completion_nsec; /* time in ns to complete a request */
 	unsigned long cache_size; /* disk cache size in MB */
 	unsigned long zone_size; /* zone size in MB if device is zoned */
+	unsigned long zone_capacity; /* zone cap in MB if device is zoned */
 	unsigned int zone_nr_conv; /* number of conventional zones */
 	unsigned int submit_queues; /* number of submission queues */
 	unsigned int home_node; /* home node for the device */
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 87b31f9ca362..54c5b5df399d 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -200,6 +200,10 @@ static unsigned long g_zone_size = 256;
 module_param_named(zone_size, g_zone_size, ulong, S_IRUGO);
 MODULE_PARM_DESC(zone_size, "Zone size in MB when block device is zoned. Must be power-of-two: Default: 256");
 
+static unsigned long g_zone_capacity;
+module_param_named(zone_capacity, g_zone_capacity, ulong, 0444);
+MODULE_PARM_DESC(zone_capacity, "Zone capacity in MB when block device is zoned. Can be less than or equal to zone size. Default: Zone size");
+
 static unsigned int g_zone_nr_conv;
 module_param_named(zone_nr_conv, g_zone_nr_conv, uint, 0444);
 MODULE_PARM_DESC(zone_nr_conv, "Number of conventional zones when block device is zoned. Default: 0");
@@ -341,6 +345,7 @@ NULLB_DEVICE_ATTR(mbps, uint, NULL);
 NULLB_DEVICE_ATTR(cache_size, ulong, NULL);
 NULLB_DEVICE_ATTR(zoned, bool, NULL);
 NULLB_DEVICE_ATTR(zone_size, ulong, NULL);
+NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);
 NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
@@ -457,6 +462,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_badblocks,
 	&nullb_device_attr_zoned,
 	&nullb_device_attr_zone_size,
+	&nullb_device_attr_zone_capacity,
 	&nullb_device_attr_zone_nr_conv,
 	NULL,
 };
@@ -510,7 +516,7 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
-	return snprintf(page, PAGE_SIZE, "memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_nr_conv\n");
+	return snprintf(page, PAGE_SIZE, "memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -571,6 +577,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->use_per_node_hctx = g_use_per_node_hctx;
 	dev->zoned = g_zoned;
 	dev->zone_size = g_zone_size;
+	dev->zone_capacity = g_zone_capacity;
 	dev->zone_nr_conv = g_zone_nr_conv;
 	return dev;
 }
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 624aac09b005..b05832eb21b2 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -28,7 +28,17 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 		return -EINVAL;
 	}
 
+	if (!dev->zone_capacity)
+		dev->zone_capacity = dev->zone_size;
+
+	if (dev->zone_capacity > dev->zone_size) {
+		pr_err("null_blk: zone capacity %lu more than its size %lu\n",
+					dev->zone_capacity, dev->zone_size);
+		return -EINVAL;
+	}
+
 	dev->zone_size_sects = dev->zone_size << ZONE_SIZE_SHIFT;
+	dev->zone_capacity_sects = dev->zone_capacity << ZONE_SIZE_SHIFT;
 	dev->nr_zones = dev_size >>
 				(SECTOR_SHIFT + ilog2(dev->zone_size_sects));
 	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct blk_zone),
@@ -60,7 +70,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 
 		zone->start = zone->wp = sector;
 		zone->len = dev->zone_size_sects;
-		zone->capacity = zone->len;
+		zone->capacity = dev->zone_capacity_sects;
 		zone->type = BLK_ZONE_TYPE_SEQWRITE_REQ;
 		zone->cond = BLK_ZONE_COND_EMPTY;
 
@@ -187,6 +197,9 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 			return BLK_STS_IOERR;
 		}
 
+		if (zone->wp + nr_sectors > zone->start + zone->capacity)
+			return BLK_STS_IOERR;
+
 		if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
 			zone->cond = BLK_ZONE_COND_IMP_OPEN;
 
@@ -195,7 +208,7 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 			return ret;
 
 		zone->wp += nr_sectors;
-		if (zone->wp == zone->start + zone->len)
+		if (zone->wp == zone->start + zone->capacity)
 			zone->cond = BLK_ZONE_COND_FULL;
 		return BLK_STS_OK;
 	default:
-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
