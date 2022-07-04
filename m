Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A21C43334
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jul 2022 12:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tG1EVE0y9OwsTynhs8YS6/fcmDu5zRQ8umS/BPgqfmo=; b=CPGTVPPTWAbNTBcDi4EXvizQ+I
	hXcvaWpBRxBiX56UgUR6BG6UUmTZL0qne/U574kfPM/yKo+5DUJmyZMTC/yC0nUTq1ZAZMs3old+Q
	KwdfLyhPaiGAOgrbdj96lExYBAIx5GUPbPrWBnxyfrRHc1CdVMScRl8MByJISzvpgRLUglDONPuyq
	QZkka2IquBpq1FB6b8ZPZGbVlxaxX7tF00O2hJRpkiNwDeUD4sJXEVsUkWQoCopMyKg9UCSIMtHX2
	d/Y5C37aLGs7nY6q8wVrQ1QmyuJQfXsSHMJPDph1lCxJsJ/rl7TLlsBRF3qFUnRhvJN3T8PbiSOgw
	nDGt8k4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8LTD-008t8K-Jj; Mon, 04 Jul 2022 12:46:31 +0000
Received: from [2001:4bb8:189:3c4a:8758:74d9:4df6:6417] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8LSD-008sNn-6Z; Mon, 04 Jul 2022 12:45:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: dm-devel@redhat.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 10/17] block: pass a gendisk to blk_queue_free_zone_bitmaps
Date: Mon,  4 Jul 2022 14:44:53 +0200
Message-Id: <20220704124500.155247-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220704124500.155247-1-hch@lst.de>
References: <20220704124500.155247-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Switch to a gendisk based API in preparation for moving all zone related
fields from the request_queue to the gendisk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 8 +++++---
 block/blk.h       | 4 ++--
 block/genhd.c     | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 5a97b48102221..9085f9fb3ab42 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -449,8 +449,10 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 	return ret;
 }
 
-void blk_queue_free_zone_bitmaps(struct request_queue *q)
+void disk_free_zone_bitmaps(struct gendisk *disk)
 {
+	struct request_queue *q = disk->queue;
+
 	kfree(q->conv_zones_bitmap);
 	q->conv_zones_bitmap = NULL;
 	kfree(q->seq_zones_wlock);
@@ -612,7 +614,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 		ret = 0;
 	} else {
 		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
-		blk_queue_free_zone_bitmaps(q);
+		disk_free_zone_bitmaps(disk);
 	}
 	blk_mq_unfreeze_queue(q);
 
@@ -628,7 +630,7 @@ void disk_clear_zone_settings(struct gendisk *disk)
 
 	blk_mq_freeze_queue(q);
 
-	blk_queue_free_zone_bitmaps(q);
+	disk_free_zone_bitmaps(disk);
 	blk_queue_flag_clear(QUEUE_FLAG_ZONE_RESETALL, q);
 	q->required_elevator_features &= ~ELEVATOR_F_ZBD_SEQ_WRITE;
 	q->nr_zones = 0;
diff --git a/block/blk.h b/block/blk.h
index 7482a3a441dd9..b71e22c97d773 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -405,10 +405,10 @@ static inline int blk_iolatency_init(struct request_queue *q) { return 0; }
 #endif
 
 #ifdef CONFIG_BLK_DEV_ZONED
-void blk_queue_free_zone_bitmaps(struct request_queue *q);
+void disk_free_zone_bitmaps(struct gendisk *disk);
 void disk_clear_zone_settings(struct gendisk *disk);
 #else
-static inline void blk_queue_free_zone_bitmaps(struct request_queue *q) {}
+static inline void disk_free_zone_bitmaps(struct gendisk *disk) {}
 static inline void disk_clear_zone_settings(struct gendisk *disk) {}
 #endif
 
diff --git a/block/genhd.c b/block/genhd.c
index d0bdeb93e922c..9d30f159c59ac 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1165,7 +1165,7 @@ static void disk_release(struct device *dev)
 
 	disk_release_events(disk);
 	kfree(disk->random);
-	blk_queue_free_zone_bitmaps(disk->queue);
+	disk_free_zone_bitmaps(disk);
 	xa_destroy(&disk->part_tbl);
 
 	disk->queue->disk = NULL;
-- 
2.30.2


