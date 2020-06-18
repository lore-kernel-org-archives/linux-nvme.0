Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65100C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 14:54:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BDE6208C3
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 14:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TWPprnRD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xRfnBuPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDE6208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cYtvsL6tArj3dSH69HDgmLhnnhDjLPqyfps8EBJVO38=; b=TWPprnRDuvsnMJ
	bR+POAFCHkB77wUS0IpwqAd+iO/NwHNQRzbyNQqdQL2QtC0klCA6VoavHCt0CMHBAhbnwIsX1EMtr
	V0ytYLHvKw2TUwZTMyAfW71DnKFLSHKQt3FUa/UPCriYxvSTet849OGWbsAm+d32Tu8jL7vfuiwr+
	ieKzf/2BTOsNEN/fQHZWw5+GflC4toXzB4RMMwUL3aXTkT8z5DsHCzXC6Q0AkJG3w/Auhsb/9r2y8
	DV9wG1vlnAA6Lcwreym8xz7Qsv+h5EjlGlZ968oSxAvVPHj8AFNS4QJUeBCjrfMQAU+KBwXIkS0oa
	8Bc+BihVaJu/8ZBIGhzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlvvs-0003k0-RU; Thu, 18 Jun 2020 14:54:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlvvb-0003Qs-02
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 14:54:08 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 18D0D2075E;
 Thu, 18 Jun 2020 14:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592492046;
 bh=YV+tl9i0l4hpz3Vlmv2brq9JsiltvYjbkzuQET+6SlY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xRfnBuPcVruSDXZD+YPhFjncSQA1QpaoCCguynPDDTe4O9+x/AuY0e07ntMqONqj7
 MdWRHHx85PzeslD0/ForSbThXvPxA6nJtF1qvvk2HI3rCh7IH2DiyJhtkrqmipbJPb
 CDC0ZnMGFGa5DTZ3aW8fEkcWOfJIe7HT7toeDxKc=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
 sagi@grimberg.me
Subject: [PATCHv2 2/5] null_blk: introduce zone capacity for zoned device
Date: Thu, 18 Jun 2020 07:53:51 -0700
Message-Id: <20200618145354.1139350-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200618145354.1139350-1-kbusch@kernel.org>
References: <20200618145354.1139350-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_075407_072289_6702A46C 
X-CRM114-Status: GOOD (  14.72  )
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
Cc: axboe@kernel.dk, Aravind Ramesh <aravind.ramesh@wdc.com>,
 Daniel Wagner <dwagner@suse.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Aravind Ramesh <aravind.ramesh@wdc.com>

Allow emulation of a zoned device with a per zone capacity smaller than
the zone size as as defined in the Zoned Namespace (ZNS) Command Set
specification. The zone capacity defaults to the zone size if not
specified and must be smaller than the zone size otherwise.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
---
 drivers/block/null_blk.h       |  1 +
 drivers/block/null_blk_main.c  | 10 +++++++++-
 drivers/block/null_blk_zoned.c | 16 ++++++++++++++--
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 81b311c9d781..daed4a9c3436 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -49,6 +49,7 @@ struct nullb_device {
 	unsigned long completion_nsec; /* time in ns to complete a request */
 	unsigned long cache_size; /* disk cache size in MB */
 	unsigned long zone_size; /* zone size in MB if device is zoned */
+	unsigned long zone_capacity; /* zone capacity in MB if device is zoned */
 	unsigned int zone_nr_conv; /* number of conventional zones */
 	unsigned int submit_queues; /* number of submission queues */
 	unsigned int home_node; /* home node for the device */
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 87b31f9ca362..a2a0e199215b 100644
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
@@ -510,7 +516,8 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
-	return snprintf(page, PAGE_SIZE, "memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_nr_conv\n");
+	return snprintf(page, PAGE_SIZE,
+			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -571,6 +578,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->use_per_node_hctx = g_use_per_node_hctx;
 	dev->zoned = g_zoned;
 	dev->zone_size = g_zone_size;
+	dev->zone_capacity = g_zone_capacity;
 	dev->zone_nr_conv = g_zone_nr_conv;
 	return dev;
 }
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 624aac09b005..3d25c9ad2383 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -28,6 +28,15 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 		return -EINVAL;
 	}
 
+	if (!dev->zone_capacity)
+		dev->zone_capacity = dev->zone_size;
+
+	if (dev->zone_capacity > dev->zone_size) {
+		pr_err("null_blk: zone capacity (%lu MB) larger than zone size (%lu MB)\n",
+					dev->zone_capacity, dev->zone_size);
+		return -EINVAL;
+	}
+
 	dev->zone_size_sects = dev->zone_size << ZONE_SIZE_SHIFT;
 	dev->nr_zones = dev_size >>
 				(SECTOR_SHIFT + ilog2(dev->zone_size_sects));
@@ -60,7 +69,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 
 		zone->start = zone->wp = sector;
 		zone->len = dev->zone_size_sects;
-		zone->capacity = zone->len;
+		zone->capacity = dev->zone_capacity << ZONE_SIZE_SHIFT;
 		zone->type = BLK_ZONE_TYPE_SEQWRITE_REQ;
 		zone->cond = BLK_ZONE_COND_EMPTY;
 
@@ -187,6 +196,9 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 			return BLK_STS_IOERR;
 		}
 
+		if (zone->wp + nr_sectors > zone->start + zone->capacity)
+			return BLK_STS_IOERR;
+
 		if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
 			zone->cond = BLK_ZONE_COND_IMP_OPEN;
 
@@ -195,7 +207,7 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
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
