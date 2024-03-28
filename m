Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54620C47DD9
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 00:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LHQ8zpB/WK5gfPQscr5MkWJFBIxxR7IP+6yWIyPJJNw=; b=bQ/LYwzrT1g/Db1tcm/jz6JeTr
	0FhLgQyxcfrXR2wtTdwTj5INR6+/8dpscCMjAoyqXcFzeAvhb8hcMzd6lTlpw6o1E0XpnyMP5PR6k
	zAU+/yvmj7ptCK0px7/EdQN013Z/0CvIRjDZ1I3zdi+ocqd2HDvjptXNSXvTM2OM4r/C2Zo8KRpnn
	XC5dg/xomQEELBdymfiL47Tj5UiV037MSaVVgAUleF7468OgVDbHjZeI8mttLQkPPtiOMbTpCZhqz
	cSQAviYJu46Y8gqs3nUKzvoWytVRcqzi7LFyvXzTh5ceUcvPWosUUa9pAkdJks33mkqj6pzMrxHuT
	sTl35NGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdtb-0000000Bo7E-1Z5l;
	Thu, 28 Mar 2024 00:45:31 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdsr-0000000Bnbb-2T3h
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 00:44:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DCD8461705;
	Thu, 28 Mar 2024 00:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E33DC433C7;
	Thu, 28 Mar 2024 00:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586684;
	bh=kZvGhC1PA/qyHmOpbm6mW4dvYWiynQxFrzJJxazakic=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZMppAAwB6d52zIf+kHEnujYoSdaVYfftC6Trt5kmvvmvHMh3pFlaCUHJzlqnEQw9N
	 q4IyOga+EuOh2ATtYFNNpzyrDi9eZzIJ4Uh5q/zG+2HJGneEaxF2nsBOB7Zwih3M2/
	 QVBhEp3gZMVGE2YUynDdiEPyOzqYUXSPgWjJoNRId3DSWaxBReDRYTSR64AsAlztwD
	 oMrWXvsMIIYuBV5dabbb1oMySpnpBm3GKSBUf/X4LTm84tTxXfi6a7U4tSJPxeomka
	 5PURNLEu9sAaMgDorxkEsmgSjqARXUnhd2BrQaRdoe5J4v5+UcgeHaeIsAzAunWw1O
	 vNYDMH2hN053Q==
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
Subject: [PATCH v3 18/30] null_blk: Introduce zone_append_max_sectors attribute
Date: Thu, 28 Mar 2024 09:43:57 +0900
Message-ID: <20240328004409.594888-19-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328004409.594888-1-dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_174445_945176_760AA9A8 
X-CRM114-Status: GOOD (  20.03  )
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
---
 drivers/block/null_blk/main.c     | 12 ++++++++++--
 drivers/block/null_blk/null_blk.h |  1 +
 drivers/block/null_blk/zoned.c    | 22 +++++++++++++++++++---
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 71c39bcd872c..cd6519360dbc 100644
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
@@ -1953,7 +1961,7 @@ static int null_add_dev(struct nullb_device *dev)
 
 	rv = add_disk(nullb->disk);
 	if (rv)
-		goto out_ida_free;
+		goto out_cleanup_zone;
 
 	mutex_lock(&lock);
 	list_add_tail(&nullb->list, &nullb_list);
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
index 8e217f8fadcd..159746b0661c 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -62,6 +62,7 @@ int null_init_zoned_dev(struct nullb_device *dev,
 			struct queue_limits *lim)
 {
 	sector_t dev_capacity_sects, zone_capacity_sects;
+	sector_t zone_append_max_bytes;
 	struct nullb_zone *zone;
 	sector_t sector = 0;
 	unsigned int i;
@@ -103,6 +104,12 @@ int null_init_zoned_dev(struct nullb_device *dev,
 			dev->zone_nr_conv);
 	}
 
+	zone_append_max_bytes =
+		ALIGN_DOWN(dev->zone_append_max_sectors << SECTOR_SHIFT,
+			   dev->blocksize);
+	dev->zone_append_max_sectors =
+		min(zone_append_max_bytes >> SECTOR_SHIFT, zone_capacity_sects);
+
 	/* Max active zones has to be < nbr of seq zones in order to be enforceable */
 	if (dev->zone_max_active >= dev->nr_zones - dev->zone_nr_conv) {
 		dev->zone_max_active = 0;
@@ -154,7 +161,7 @@ int null_init_zoned_dev(struct nullb_device *dev,
 
 	lim->zoned = true;
 	lim->chunk_sectors = dev->zone_size_sects;
-	lim->max_zone_append_sectors = dev->zone_size_sects;
+	lim->max_zone_append_sectors = dev->zone_append_max_sectors;
 	lim->max_open_zones = dev->zone_max_open;
 	lim->max_active_zones = dev->zone_max_active;
 	return 0;
@@ -163,10 +170,16 @@ int null_init_zoned_dev(struct nullb_device *dev,
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
@@ -365,6 +378,9 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 
 	trace_nullb_zone_op(cmd, zno, zone->cond);
 
+	if (WARN_ON_ONCE(append && !dev->zone_append_max_sectors))
+		return BLK_STS_IOERR;
+
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
 		if (append)
 			return BLK_STS_IOERR;
-- 
2.44.0


