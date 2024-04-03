Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8CBCD1288
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 08:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k0Rho8VKdOC/3iaCWDm2R/PW0KPbMgi+1ydT+QBinJI=; b=U7t24ae7FhfY947qehKgf/HAet
	EzsAS1FFK4BoZmypYcALfqYY/OwZ25G3xOLoCIg7HOdVdkONaF15PM/TcdnW5hHBCzN0FwHbMOCi2
	ai8y7ycPluiE5VohhPdmPUepCq+W/da5biy2w7+4wvO5em5N2ljuqkF782XxdA1Xf9qs7FRHnF03d
	lr7KJD0bN5P+sZJIQ1KkAuIev8OZSwJ/JtVRTOjE9q1Lqt2OeTjkoyLljsYY9yZT7HEYsxwhUVR6/
	q9j/9fvw+KsA4sPWNQedopnRleLZXErzjR1krMdSbRICyvxQ1e1pvKAs7tWK8i4643owPAFTiZG7g
	vNF8EejQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwDE-0000000Eyt8-21Rn;
	Wed, 03 Apr 2024 08:43:16 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwD1-0000000Eyg2-2Jeu
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 08:43:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CF1346134E;
	Wed,  3 Apr 2024 08:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD4EC433B1;
	Wed,  3 Apr 2024 08:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712133782;
	bh=wVo0ZqXyRzJKUABEP7Wolj7hvAogx2h4xbYsKoizMIc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=h3HS7ds6U9vEVten47VBvzx6pmp7xIcTCneulCOOE0MH8Ly/t38+Z4U1dLJrJiMBm
	 DpYux/JqvCpjsfOT67r1v8OGnNbYTVgRF04JuysjcZrKFguq+OaeYcvTc52A/4BGqK
	 Xr7MzTTLYRqpfLH+wBp+XfptAW8JovG1hdvxHfNAsDzHnb2kie+PCUDeGS8ecLvK3y
	 NQPPhZAopovdkzKeF7wdT4m2/Ra0SEs5wjSZNGuMU7beM9fEd/rYsgT1SRj4ehg05W
	 Rg1UyjH0tJQuYPv3nLCXiEfLZkdV8JFYmg0HroIWFfjNOcAgmAshOUNLtqkSwJDjtx
	 3qskh1Wzgx03Q==
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
Subject: [PATCH v5 08/28] block: Fake max open zones limit when there is no limit
Date: Wed,  3 Apr 2024 17:42:27 +0900
Message-ID: <20240403084247.856481-9-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403084247.856481-1-dlemoal@kernel.org>
References: <20240403084247.856481-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_014303_779097_0DE7CFB6 
X-CRM114-Status: GOOD (  18.68  )
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
---
 block/blk-zoned.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 9c9600642299..3dceeaaeb973 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1502,6 +1502,38 @@ struct blk_revalidate_zone_args {
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
@@ -1702,17 +1734,14 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
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


