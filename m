Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39D9CD129B
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 05:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sH/rJBmec2H/V6uTjsSDHAV7plt/9d/SM9mC9sUdduc=; b=JraqjdAa1mTgjAqUeQAxw3eVD9
	9Ifld5jORLfps0O+uqv8T660SBN0z7edK4wy6STj+oacq9jEw8CgHwtwLuaUoZhr1MmqmVZEcFIFW
	ngz8EJIFlV5phhGGSROcknAoEvMsU5gtzvACJiS0xfIlK9LycAZrbtfiHUbdVb7t10hBWVahzg+kd
	28R4woBenTJgzR+0SaAbGWieD9GK7PYvPNcTwDL+3JQ8hniUlIZQzqOGD9Jkh1rO123BhEXcdTQwX
	Mh8ANr0m+Bau1eJK268gvuo9/rLZxzKhPYfaMN767vh4fKa5Kibodnwt5PqiJXl5jyxYIJiULJpvT
	wVpomyEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rscST-00000005LPr-3289;
	Fri, 05 Apr 2024 05:49:49 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsbPP-00000005BO1-1TZF
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 04:42:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 89758CE3609;
	Fri,  5 Apr 2024 04:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAA5C43394;
	Fri,  5 Apr 2024 04:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712292153;
	bh=4RbyB8pFOPbUmrxzF0LMuyx+NzUUMMPFHXg4fpzXXi8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=V8dtMirqrCqlGrAeqQ0KhfM9yFKGh0/EejASaEyNN0is5FKlgsYfDqcrKuMTSrjJA
	 3dPDVf3SBxXnBkCJbYm/rKdWmcDsGZJ8SZFqO149nP+rlqUPURxf3BUm7owydh8eqm
	 m6RgcbdxSUiHnCftUQplOhM+znmhQPf31zOPPXF4vKLM6kzdVKsfN4Wzzl6W4KfZpC
	 e2XML+fDPbXmztJ1C8J1N2SO3+XSB1TWqoFyRbau3p4J6/V0hjuOGi8sX1h1U0OdAX
	 CdnFrx/FOcGyKvSBnADskkk5jZo09To73biRJZA7Z2CatvkoGjmHPlI9RrKXD5mxPU
	 zK1Bdrj1nYXbQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 16/28] null_blk: Introduce zone_append_max_sectors attribute
Date: Fri,  5 Apr 2024 13:41:55 +0900
Message-ID: <20240405044207.1123462-17-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405044207.1123462-1-dlemoal@kernel.org>
References: <20240405044207.1123462-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_214235_968528_1BDD7D8D 
X-CRM114-Status: GOOD (  19.69  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add the zone_append_max_sectors configfs attribute and module parameter
to allow configuring the maximum number of 512B sectors of zone append
operations. This attribute is meaningful only for zoned null block
devices.

If not specified, the default is unchanged and the zoned device max
append sectors limit is set to the device max sectors limit.
If a non 0 value is used for this attribute, which is the default,
then native support for zone append operations is enabled.
Setting a 0 value disables native zone append operations support to
instead use the block layer emulation.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
---
 drivers/block/null_blk/main.c     | 10 +++++++++-
 drivers/block/null_blk/null_blk.h |  1 +
 drivers/block/null_blk/zoned.c    | 20 +++++++++++++++++---
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 71c39bcd872c..a5a50ba6ad9f 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -253,6 +253,11 @@ static unsigned int g_zone_max_active;
 module_param_named(zone_max_active, g_zone_max_active, uint, 0444);
 MODULE_PARM_DESC(zone_max_active, "Maximum number of active zones when block device is zoned. Default: 0 (no limit)");
 
+static int g_zone_append_max_sectors = INT_MAX;
+module_param_named(zone_append_max_sectors, g_zone_append_max_sectors, int, 0444);
+MODULE_PARM_DESC(zone_append_max_sectors,
+		 "Maximum size of a zone append command (in 512B sectors). Specify 0 for zone append emulation");
+
 static struct nullb_device *null_alloc_dev(void);
 static void null_free_dev(struct nullb_device *dev);
 static void null_del_dev(struct nullb *nullb);
@@ -436,6 +441,7 @@ NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);
 NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);
 NULLB_DEVICE_ATTR(zone_max_open, uint, NULL);
 NULLB_DEVICE_ATTR(zone_max_active, uint, NULL);
+NULLB_DEVICE_ATTR(zone_append_max_sectors, uint, NULL);
 NULLB_DEVICE_ATTR(virt_boundary, bool, NULL);
 NULLB_DEVICE_ATTR(no_sched, bool, NULL);
 NULLB_DEVICE_ATTR(shared_tags, bool, NULL);
@@ -580,6 +586,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_zone_nr_conv,
 	&nullb_device_attr_zone_max_open,
 	&nullb_device_attr_zone_max_active,
+	&nullb_device_attr_zone_append_max_sectors,
 	&nullb_device_attr_zone_readonly,
 	&nullb_device_attr_zone_offline,
 	&nullb_device_attr_virt_boundary,
@@ -671,7 +678,7 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
 			"shared_tags,size,submit_queues,use_per_node_hctx,"
 			"virt_boundary,zoned,zone_capacity,zone_max_active,"
 			"zone_max_open,zone_nr_conv,zone_offline,zone_readonly,"
-			"zone_size\n");
+			"zone_size,zone_append_max_sectors\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -751,6 +758,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->zone_nr_conv = g_zone_nr_conv;
 	dev->zone_max_open = g_zone_max_open;
 	dev->zone_max_active = g_zone_max_active;
+	dev->zone_append_max_sectors = g_zone_append_max_sectors;
 	dev->virt_boundary = g_virt_boundary;
 	dev->no_sched = g_no_sched;
 	dev->shared_tags = g_shared_tags;
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 477b97746823..a9c5df650ddb 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -82,6 +82,7 @@ struct nullb_device {
 	unsigned int zone_nr_conv; /* number of conventional zones */
 	unsigned int zone_max_open; /* max number of open zones */
 	unsigned int zone_max_active; /* max number of active zones */
+	unsigned int zone_append_max_sectors; /* Max sectors per zone append command */
 	unsigned int submit_queues; /* number of submission queues */
 	unsigned int prev_submit_queues; /* number of submission queues before change */
 	unsigned int poll_queues; /* number of IOPOLL submission queues */
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 8e217f8fadcd..0b2af273adaf 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -103,6 +103,11 @@ int null_init_zoned_dev(struct nullb_device *dev,
 			dev->zone_nr_conv);
 	}
 
+	dev->zone_append_max_sectors =
+		min(ALIGN_DOWN(dev->zone_append_max_sectors,
+			       dev->blocksize >> SECTOR_SHIFT),
+		    zone_capacity_sects);
+
 	/* Max active zones has to be < nbr of seq zones in order to be enforceable */
 	if (dev->zone_max_active >= dev->nr_zones - dev->zone_nr_conv) {
 		dev->zone_max_active = 0;
@@ -154,7 +159,7 @@ int null_init_zoned_dev(struct nullb_device *dev,
 
 	lim->zoned = true;
 	lim->chunk_sectors = dev->zone_size_sects;
-	lim->max_zone_append_sectors = dev->zone_size_sects;
+	lim->max_zone_append_sectors = dev->zone_append_max_sectors;
 	lim->max_open_zones = dev->zone_max_open;
 	lim->max_active_zones = dev->zone_max_active;
 	return 0;
@@ -163,10 +168,16 @@ int null_init_zoned_dev(struct nullb_device *dev,
 int null_register_zoned_dev(struct nullb *nullb)
 {
 	struct request_queue *q = nullb->q;
+	struct gendisk *disk = nullb->disk;
 
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
-	nullb->disk->nr_zones = bdev_nr_zones(nullb->disk->part0);
-	return blk_revalidate_disk_zones(nullb->disk, NULL);
+	disk->nr_zones = bdev_nr_zones(disk->part0);
+
+	pr_info("%s: using %s zone append\n",
+		disk->disk_name,
+		queue_emulates_zone_append(q) ? "emulated" : "native");
+
+	return blk_revalidate_disk_zones(disk, NULL);
 }
 
 void null_free_zoned_dev(struct nullb_device *dev)
@@ -365,6 +376,9 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 
 	trace_nullb_zone_op(cmd, zno, zone->cond);
 
+	if (WARN_ON_ONCE(append && !dev->zone_append_max_sectors))
+		return BLK_STS_IOERR;
+
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
 		if (append)
 			return BLK_STS_IOERR;
-- 
2.44.0


