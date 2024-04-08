Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8399DCD1292
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 01:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DtSlS9cnQCP+mXOUh1X8rMlC9u4knUynDK/aEj6nKfM=; b=sclbPvGBJ+0Sk8p2vYniR3fGhz
	/XBibrBWN7wML/tM7qu7XS0SkJC8XS3QAhLYdx3b34qfZkMcrQLyujjzNzhFICRL1XEYQyu3uOswP
	eEcY4t8vu5XfzQL+cIHaDq/K5f9qQSQACdqS91yGAyK78y5JDtOa/kIXbr3X7iHY5gtJP61q9HRiz
	Bo/EJoQz+GmOH5qH7jZMzFxTnapdeZXzR4Le7AGYvSq16QmViaP/if3vrVKo17/1FZ7yYuNDF6I9G
	uDPhDCIgY6+5y88cDJg6cy9/3rrhe/cCG9WB7S5Y9hhaT7kmAowVZADjEv4sV/PBEjNKC9n+LZ8fM
	S6rzCTcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rte1M-0000000DvaT-0h4x;
	Mon, 08 Apr 2024 01:42:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rte15-0000000DvLG-1eBU
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 01:41:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D5FB260DD9;
	Mon,  8 Apr 2024 01:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13E7C43390;
	Mon,  8 Apr 2024 01:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712540506;
	bh=Rwq2mnKZRd162vu4g/073SX1zLVjveI02uqeQ4ww6l4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Zs483dIrLiA4486fSjxiTnmxvnrqtDh/9F5qkpN3ju8mybc92IiB9dPKl6HJDVI6c
	 mxKYId4piNgwM8+UZH06T1Epx6Vqj9vFkHt4Ptt6+/Jbp4Nf8ktT0Gsqo+6lZfNNO/
	 u3vSTgE4lGi759h2VYkp+7/FS74/4vYpTCmeTnJmffAP/AEhAyn34i706Uh8FV6t4m
	 oW06b/0nQmX5qiwB/exQcSDdGPZ0bOujysdL1MAC/CRJynEGIcjt8oelXR5cFTGJNU
	 Kze8OtJP5IWgPVVcTf4DWlnX5bA3I4yeh6Y/jpomv2Osh2qps/oDLfenkFks/kKA1A
	 FrnztyEVr+YQA==
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
Subject: [PATCH v7 08/28] block: Fake max open zones limit when there is no limit
Date: Mon,  8 Apr 2024 10:41:08 +0900
Message-ID: <20240408014128.205141-9-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408014128.205141-1-dlemoal@kernel.org>
References: <20240408014128.205141-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_184147_719132_76631336 
X-CRM114-Status: GOOD (  19.25  )
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

For a zoned block device that has no limit on the number of open zones
and no limit on the number of active zones, the zone write plug mempool
is created with a size of 128 zone write plugs. For such case, set the
device max_open_zones queue limit to this value to indicate to the user
the potential performance penalty that may happen when writing
simultaneously to more zones than the mempool size.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
Tested-by: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/blk-zoned.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index fefcebd70445..4b21a1ec00d4 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1503,6 +1503,38 @@ struct blk_revalidate_zone_args {
 	sector_t	sector;
 };
 
+/*
+ * Update the disk zone resources information and device queue limits.
+ * The disk queue is frozen when this is executed.
+ */
+static int disk_update_zone_resources(struct gendisk *disk,
+				      struct blk_revalidate_zone_args *args)
+{
+	struct request_queue *q = disk->queue;
+	struct queue_limits lim;
+
+	disk->nr_zones = args->nr_zones;
+	disk->zone_capacity = args->zone_capacity;
+	swap(disk->seq_zones_wlock, args->seq_zones_wlock);
+	swap(disk->conv_zones_bitmap, args->conv_zones_bitmap);
+
+	/*
+	 * If the device has no limit on the maximum number of open and active
+	 * zones, set its max open zone limit to the mempool size to indicate
+	 * to the user that there is a potential performance impact due to
+	 * dynamic zone write plug allocation when simultaneously writing to
+	 * more zones than the size of the mempool.
+	 */
+	if (disk->zone_wplugs_pool) {
+		lim = queue_limits_start_update(q);
+		if (!lim.max_open_zones && !lim.max_active_zones)
+			lim.max_open_zones = disk->zone_wplugs_pool->min_nr;
+		return queue_limits_commit_update(q, &lim);
+	}
+
+	return 0;
+}
+
 /*
  * Helper function to check the validity of zones of a zoned block device.
  */
@@ -1703,17 +1735,14 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 	 */
 	blk_mq_freeze_queue(q);
 	if (ret > 0) {
-		disk->nr_zones = args.nr_zones;
-		disk->zone_capacity = args.zone_capacity;
-		swap(disk->seq_zones_wlock, args.seq_zones_wlock);
-		swap(disk->conv_zones_bitmap, args.conv_zones_bitmap);
+		ret = disk_update_zone_resources(disk, &args);
 		if (update_driver_data)
 			update_driver_data(disk);
-		ret = 0;
 	} else {
 		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
-		disk_free_zone_resources(disk);
 	}
+	if (ret)
+		disk_free_zone_resources(disk);
 	blk_mq_unfreeze_queue(q);
 
 	kfree(args.seq_zones_wlock);
-- 
2.44.0


