Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E85CCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 13:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MccvRO8LRtPsHGPmKOGwyLaP+8IO9hKAZIW171NABV8=; b=DI6wBEDnzQBgZwbRKgenTZzAte
	2BxpQRxdBX44uEjvsv8DHGQE/1McrTnsvzxx7vz4KloZ5CYInahMRfSuEwLBaQsk41BU5wsio8Cpv
	wT6w0u+yWzEij7I78pkqBq42Jie383ac67T4qrNUHrKtqfqsEriY6zi/QVpW6bCfjnrF3AxIWqgja
	ZliQxdL/+s9LCgYPC1V5gZYte6H+Ni6+2z1D6Cf7TXQpcYSMZK6YdKITM62hnwIu7jbAwnTv7CnYQ
	C5ugVOcacqkatDsgZ7qyl1yRsOtVTcAHYoU3Oz1//e7mDjYpThuAf0iU1bCNru16qW+/KwClPJunE
	qHZiZoHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuiN-00000009u1g-2vKB;
	Mon, 03 Nov 2025 13:35:19 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuiK-00000009tyy-1p2x
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 13:35:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8B43B43877;
	Mon,  3 Nov 2025 13:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B74C113D0;
	Mon,  3 Nov 2025 13:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762176915;
	bh=DbCvM7wvDP7sxu56AU4ps18FxFxQH6jlov8zvA3BaHI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=g1J5/1+emmwCBOy7Di0ciqFQ/n3E8RfygKiQMJceMpgYJ5/Pa6tCNASnugBL6u7KE
	 knhqYWAabtQXWe1suSPFRsWHLSZTWSl7DV9nkiDhtXKyPdRPToFqxYypXtwsKogPBx
	 rvpnu3ovfdiqNsnQ6oQFGERkYlgG7zKk5RlnnNOxo0ec71fFmjYSXi4hzRxZvpioGw
	 b+5LikoqLHMnPz+gv0LB25TVdYkn4oJGqvaCpA9Z58xf84pWG/RmtGtWaF1k5LPLnz
	 R2piQbaAzKoTsBgqJE5HSCOVzAPnD7sx62t0AvBJkBprxvOROAZNUDdFlVDc1z8Bff
	 i0OYPrIpeyKyA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH v2 02/15] block: freeze queue when updating zone resources
Date: Mon,  3 Nov 2025 22:31:10 +0900
Message-ID: <20251103133123.645038-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103133123.645038-1-dlemoal@kernel.org>
References: <20251103133123.645038-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_053516_529474_77FA8146 
X-CRM114-Status: GOOD (  19.07  )
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

Modify disk_update_zone_resources() to freeze the device queue before
updating the number of zones, zone capacity and other zone related
resources. The locking order resulting from the call to
queue_limits_commit_update_frozen() is preserved, that is, the queue
limits lock is first taken by calling queue_limits_start_update() before
freezing the queue, and the queue is unfrozen after executing
queue_limits_commit_update(), which replaces the call to
queue_limits_commit_update_frozen().

This change ensures that there are no in-flights I/Os when the zone
resources are updated due to a zone revalidation. In case of error when
the limits are applied, directly call disk_free_zone_resources() from
disk_update_zone_resources() while the disk queue is still frozen to
avoid needing to freeze & unfreeze the queue again in
blk_revalidate_disk_zones(), thus simplifying that function code a
little.

Fixes: 0b83c86b444a ("block: Prevent potential deadlock in blk_revalidate_disk_zones()")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 1621e8f78338..39381f2b2e94 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1557,8 +1557,13 @@ static int disk_update_zone_resources(struct gendisk *disk,
 {
 	struct request_queue *q = disk->queue;
 	unsigned int nr_seq_zones, nr_conv_zones;
-	unsigned int pool_size;
+	unsigned int pool_size, memflags;
 	struct queue_limits lim;
+	int ret = 0;
+
+	lim = queue_limits_start_update(q);
+
+	memflags = blk_mq_freeze_queue(q);
 
 	disk->nr_zones = args->nr_zones;
 	disk->zone_capacity = args->zone_capacity;
@@ -1568,11 +1573,10 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	if (nr_conv_zones >= disk->nr_zones) {
 		pr_warn("%s: Invalid number of conventional zones %u / %u\n",
 			disk->disk_name, nr_conv_zones, disk->nr_zones);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto unfreeze;
 	}
 
-	lim = queue_limits_start_update(q);
-
 	/*
 	 * Some devices can advertize zone resource limits that are larger than
 	 * the number of sequential zones of the zoned block device, e.g. a
@@ -1609,7 +1613,15 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	}
 
 commit:
-	return queue_limits_commit_update_frozen(q, &lim);
+	ret = queue_limits_commit_update(q, &lim);
+
+unfreeze:
+	if (ret)
+		disk_free_zone_resources(disk);
+
+	blk_mq_unfreeze_queue(q, memflags);
+
+	return ret;
 }
 
 static int blk_revalidate_conv_zone(struct blk_zone *zone, unsigned int idx,
@@ -1774,7 +1786,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	sector_t zone_sectors = q->limits.chunk_sectors;
 	sector_t capacity = get_capacity(disk);
 	struct blk_revalidate_zone_args args = { };
-	unsigned int noio_flag;
+	unsigned int memflags, noio_flag;
 	int ret = -ENOMEM;
 
 	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
@@ -1824,20 +1836,14 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		ret = -ENODEV;
 	}
 
-	/*
-	 * Set the new disk zone parameters only once the queue is frozen and
-	 * all I/Os are completed.
-	 */
 	if (ret > 0)
-		ret = disk_update_zone_resources(disk, &args);
-	else
-		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
-	if (ret) {
-		unsigned int memflags = blk_mq_freeze_queue(q);
+		return disk_update_zone_resources(disk, &args);
 
-		disk_free_zone_resources(disk);
-		blk_mq_unfreeze_queue(q, memflags);
-	}
+	pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
+
+	memflags = blk_mq_freeze_queue(q);
+	disk_free_zone_resources(disk);
+	blk_mq_unfreeze_queue(q, memflags);
 
 	return ret;
 }
-- 
2.51.0


