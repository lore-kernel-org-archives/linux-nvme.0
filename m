Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE13CCA473
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 07:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CUL+EY0o8IFmm69r3ji/sQwweIJZqelgGUxZWiP3WN4=; b=FCEq+dksHHOgfPNmA49zWKN7KO
	TqhHJIh28uyn2nfToIalY6tYKCkmDr4ScGfkVbMkaAUkzOF+6i7wc62/xafv4Hvw4Dw1X+UjkBW+G
	JI1S5G7NY8SZXwJIjvHWIJLQv7cN8yaX8uGlCPPl0lPM6EQ+JgXUz32Mm8rMW/l+Xn9MNPQGg9EzB
	llJiNm1MTfD6p07Wlw4/uh9zL1ltv0j1iy3//P1EnI6rxPikaO5GtIW/YwtiwLKzXk1zbI7ZlIHQ9
	rNqMAOZ5UIc1Y2CI9U0egPKkNBie0RYQ2r6/ghM6gjsbTSnKsfAk2ahNSXLAr+Y6MfsfrgFQc48ah
	AGiGiMBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8z5K-006vIh-EF; Wed, 06 Jul 2022 07:04:30 +0000
Received: from [2001:4bb8:189:3c4a:f22c:c36a:4e84:c723] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8z51-006uzw-DV; Wed, 06 Jul 2022 07:04:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: dm-devel@redhat.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 07/16] block: pass a gendisk to blk_queue_clear_zone_settings
Date: Wed,  6 Jul 2022 09:03:41 +0200
Message-Id: <20220706070350.1703384-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706070350.1703384-1-hch@lst.de>
References: <20220706070350.1703384-1-hch@lst.de>
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
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-settings.c | 2 +-
 block/blk-zoned.c    | 4 +++-
 block/blk.h          | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 35b7bba306a83..8bb9eef5310eb 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -946,7 +946,7 @@ void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 		blk_queue_zone_write_granularity(q,
 						queue_logical_block_size(q));
 	} else {
-		blk_queue_clear_zone_settings(q);
+		disk_clear_zone_settings(disk);
 	}
 }
 EXPORT_SYMBOL_GPL(disk_set_zoned);
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 90a5c9cc80ab3..82a4fa89678ce 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -622,8 +622,10 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 }
 EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
 
-void blk_queue_clear_zone_settings(struct request_queue *q)
+void disk_clear_zone_settings(struct gendisk *disk)
 {
+	struct request_queue *q = disk->queue;
+
 	blk_mq_freeze_queue(q);
 
 	blk_queue_free_zone_bitmaps(q);
diff --git a/block/blk.h b/block/blk.h
index 58ad50cacd2d5..7482a3a441dd9 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -406,10 +406,10 @@ static inline int blk_iolatency_init(struct request_queue *q) { return 0; }
 
 #ifdef CONFIG_BLK_DEV_ZONED
 void blk_queue_free_zone_bitmaps(struct request_queue *q);
-void blk_queue_clear_zone_settings(struct request_queue *q);
+void disk_clear_zone_settings(struct gendisk *disk);
 #else
 static inline void blk_queue_free_zone_bitmaps(struct request_queue *q) {}
-static inline void blk_queue_clear_zone_settings(struct request_queue *q) {}
+static inline void disk_clear_zone_settings(struct gendisk *disk) {}
 #endif
 
 int blk_alloc_ext_minor(void);
-- 
2.30.2


