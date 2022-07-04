Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C5CC43334
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jul 2022 12:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hY/TLm17O1t6frYZ+GU+/nVg2wObFZY0QQXRSW6j4qc=; b=UeZ/5qD1W97PztiRU9EDNqHTZK
	OOjWR0dbK+AI2nMFfw5DhCHO4L716BbIdkq2z0W5F/ioa2oOVTDdZ+AMpO//lvkvVHPSddWurFcds
	rkpIezpowogIULkf3y6xMT0v1Ti0+drDRdrFJ9VKdGZ2b8ttv4l53oJkieV50Pyck57plAwmSkMv5
	T7cQyODqVcZw5ESEz9l3AXu9nR3xZdpyMX0jhc5EUP/2tES02yZl8sKh6imC9xBzynct2u3CZRMeG
	6fD5H5pvjZ7kCCh9EGznks5v2jnkh8xt9vDBF8feHwax+oLYplqsD2PaFtWQpirZGKG3EwOcvF03A
	pu8BMtlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8LTR-008tGG-Ly; Mon, 04 Jul 2022 12:46:45 +0000
Received: from [2001:4bb8:189:3c4a:8758:74d9:4df6:6417] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8LSF-008sPW-Sf; Mon, 04 Jul 2022 12:45:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: dm-devel@redhat.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 11/17] block: remove queue_max_open_zones and queue_max_active_zones
Date: Mon,  4 Jul 2022 14:44:54 +0200
Message-Id: <20220704124500.155247-12-hch@lst.de>
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

Always use the bdev based helpers instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c      |  4 ++--
 include/linux/blkdev.h | 37 ++++++++++---------------------------
 2 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 7590810cf13fc..5ce72345ac666 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -330,12 +330,12 @@ static ssize_t queue_nr_zones_show(struct request_queue *q, char *page)
 
 static ssize_t queue_max_open_zones_show(struct request_queue *q, char *page)
 {
-	return queue_var_show(queue_max_open_zones(q), page);
+	return queue_var_show(bdev_max_open_zones(q->disk->part0), page);
 }
 
 static ssize_t queue_max_active_zones_show(struct request_queue *q, char *page)
 {
-	return queue_var_show(queue_max_active_zones(q), page);
+	return queue_var_show(bdev_max_active_zones(q->disk->part0), page);
 }
 
 static ssize_t queue_nomerges_show(struct request_queue *q, char *page)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ddf8353488fc8..a14cc3e46e6ad 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -704,21 +704,22 @@ static inline void blk_queue_max_open_zones(struct request_queue *q,
 	q->max_open_zones = max_open_zones;
 }
 
-static inline unsigned int queue_max_open_zones(const struct request_queue *q)
-{
-	return q->max_open_zones;
-}
-
 static inline void blk_queue_max_active_zones(struct request_queue *q,
 		unsigned int max_active_zones)
 {
 	q->max_active_zones = max_active_zones;
 }
 
-static inline unsigned int queue_max_active_zones(const struct request_queue *q)
+static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
+{
+	return bdev->bd_disk->queue->max_open_zones;
+}
+
+static inline unsigned int bdev_max_active_zones(struct block_device *bdev)
 {
-	return q->max_active_zones;
+	return bdev->bd_disk->queue->max_active_zones;
 }
+
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
 {
@@ -734,11 +735,11 @@ static inline unsigned int blk_queue_zone_no(struct request_queue *q,
 {
 	return 0;
 }
-static inline unsigned int queue_max_open_zones(const struct request_queue *q)
+static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	return 0;
 }
-static inline unsigned int queue_max_active_zones(const struct request_queue *q)
+static inline unsigned int bdev_max_active_zones(struct block_device *bdev)
 {
 	return 0;
 }
@@ -1316,24 +1317,6 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 	return 0;
 }
 
-static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
-{
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (q)
-		return queue_max_open_zones(q);
-	return 0;
-}
-
-static inline unsigned int bdev_max_active_zones(struct block_device *bdev)
-{
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (q)
-		return queue_max_active_zones(q);
-	return 0;
-}
-
 static inline int queue_dma_alignment(const struct request_queue *q)
 {
 	return q ? q->dma_alignment : 511;
-- 
2.30.2


