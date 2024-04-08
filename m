Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1921ECD1292
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 02:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NAzB5YfXqi5UrM7aBkh8gL5vPuBJ4EzoejBg8DKABSw=; b=jaWPOT0K04CrSLTq1h9zqTdYh9
	xsDg2uPc8nlue0VElW6R2xKu4OyYHfsFBnKfPGmvjsrdJeKtaErRd7yuIKPmui158cjftNKAxoTHM
	ZGnBc8OzifGz7LD+7cVIBq1qpBRoB2Pnjk3qag486EXTUHlqW7LZWKDTL7dMS4+/gTtguCzKzIHD1
	sqgjo+OcpQJT+xzbXZG3EifOVjN4OxZFD/D/yYCB2q3Jt5uM5wiqynyBpbtp9ln4BZp7d5VTn2Dsu
	DEZUSoxcYaRRmumGk1xmPursCJMqiAVpA7Mococn0D9m1XTIIYDRttjnSz7IWGyFPmk/2FcP6aA8p
	hixND66w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtf0z-0000000E5Pt-0Z6g;
	Mon, 08 Apr 2024 02:45:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rte1L-0000000DvW0-3Gg2
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 01:42:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9307E60DE8;
	Mon,  8 Apr 2024 01:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F06DC433C7;
	Mon,  8 Apr 2024 01:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712540523;
	bh=QOV+zkL37kOcX6meYmcdfK9cZIvUVPoX4nh2HY33pnY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PQzQzI4ToxuxPPyrR82FGmGpYtnjv3XIxuSK685iwe4bGy1LhEHVh66pvWhXlPBr7
	 wDPF7+MEPpDKnqKeeHNRZHgdMEe3SQWUIwZvlLKIqphgBlzdGItCerT1ijL/hcSE8C
	 b3yjDG1xFZqallfWL/fs5rWRpQ7jM7rjPybjdCXU0XsJo5a5lhc5dYe9PAzQplYQ5Y
	 o66wd8uh5S4Q3iLKodAmGa0AKTOIhln1paUeKn8/mrE8Ctmt4NPE4fQbJbboYGTfvG
	 OVO3YOmrHw07XU/915ebjk5TgUXxRYRISXs2/84EJYEWHOqtvrOGoHeAXsqOlr2U63
	 5FuWEObxS1Ubg==
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
Subject: [PATCH v7 17/28] null_blk: Introduce fua attribute
Date: Mon,  8 Apr 2024 10:41:17 +0900
Message-ID: <20240408014128.205141-18-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408014128.205141-1-dlemoal@kernel.org>
References: <20240408014128.205141-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_184204_164520_80C0241E 
X-CRM114-Status: GOOD (  17.27  )
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

Add the fua configfs attribute and module parameter to allow
configuring if the device supports FUA or not. Using this attribute
has an effect on the null_blk device only if memory backing is enabled
together with a write cache (cache_size option).

This new attribute allows configuring a null_blk device with a write
cache but without FUA support. This is convenient to test the block
layer flush machinery.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
Tested-by: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/block/null_blk/main.c     | 12 ++++++++++--
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 14e9aa867afe..993e9e8a7e69 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -225,6 +225,10 @@ static unsigned long g_cache_size;
 module_param_named(cache_size, g_cache_size, ulong, 0444);
 MODULE_PARM_DESC(mbps, "Cache size in MiB for memory-backed device. Default: 0 (none)");
 
+static bool g_fua = true;
+module_param_named(fua, g_fua, bool, 0444);
+MODULE_PARM_DESC(zoned, "Enable/disable FUA support when cache_size is used. Default: true");
+
 static unsigned int g_mbps;
 module_param_named(mbps, g_mbps, uint, 0444);
 MODULE_PARM_DESC(mbps, "Limit maximum bandwidth (in MiB/s). Default: 0 (no limit)");
@@ -446,6 +450,7 @@ NULLB_DEVICE_ATTR(virt_boundary, bool, NULL);
 NULLB_DEVICE_ATTR(no_sched, bool, NULL);
 NULLB_DEVICE_ATTR(shared_tags, bool, NULL);
 NULLB_DEVICE_ATTR(shared_tag_bitmap, bool, NULL);
+NULLB_DEVICE_ATTR(fua, bool, NULL);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
 {
@@ -593,6 +598,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_no_sched,
 	&nullb_device_attr_shared_tags,
 	&nullb_device_attr_shared_tag_bitmap,
+	&nullb_device_attr_fua,
 	NULL,
 };
 
@@ -671,7 +677,7 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
 	return snprintf(page, PAGE_SIZE,
-			"badblocks,blocking,blocksize,cache_size,"
+			"badblocks,blocking,blocksize,cache_size,fua,"
 			"completion_nsec,discard,home_node,hw_queue_depth,"
 			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
 			"poll_queues,power,queue_mode,shared_tag_bitmap,"
@@ -763,6 +769,8 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->no_sched = g_no_sched;
 	dev->shared_tags = g_shared_tags;
 	dev->shared_tag_bitmap = g_shared_tag_bitmap;
+	dev->fua = g_fua;
+
 	return dev;
 }
 
@@ -1920,7 +1928,7 @@ static int null_add_dev(struct nullb_device *dev)
 
 	if (dev->cache_size > 0) {
 		set_bit(NULLB_DEV_FL_CACHE, &nullb->dev->flags);
-		blk_queue_write_cache(nullb->q, true, true);
+		blk_queue_write_cache(nullb->q, true, dev->fua);
 	}
 
 	nullb->q->queuedata = nullb;
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index a9c5df650ddb..3234e6c85eed 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -105,6 +105,7 @@ struct nullb_device {
 	bool no_sched; /* no IO scheduler for the device */
 	bool shared_tags; /* share tag set between devices for blk-mq */
 	bool shared_tag_bitmap; /* use hostwide shared tags */
+	bool fua; /* Support FUA */
 };
 
 struct nullb {
-- 
2.44.0


