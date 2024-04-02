Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975C6CD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 12:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eQtZLXPqf76N9/EfLVgKPwJGOsJOnSS5oN7sGCRXcVE=; b=BCiva+M+w57D7aoSpzzWhHlPof
	R/pGz79QtDP7AWokoHaRr/mawcTA7QQdjkXvKbOF8aPzrYEEyAI5chuhOZIs6BnWRZ4CbcSmIQ96Q
	04L0bqHNBwrsulAIn4eX9wOHNX9G1qwoRMZXpXaUvaguzsXQTZFk+QM3mb8rAakvsz2SMRadoIy8s
	zBH0TijAVDXUEtNyASyYVl2RHCBbWzHpB/2sDAM7L4CPTgSEQO2vy4zbNapD2KP9XQZN5brGw6FV9
	bBV6LuvOxFtfvAzLXM1fRhJXFEkLe0cf+ySdJiXLNYmeD3aKgg2KO1ghgYMLo9H69YZiip6233Zgm
	pCYAgYxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdQB-0000000B6G8-2tLi;
	Tue, 02 Apr 2024 12:39:23 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdQ5-0000000B6AY-3DrU
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 12:39:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6E87CCE1B36;
	Tue,  2 Apr 2024 12:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFD5C433F1;
	Tue,  2 Apr 2024 12:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712061554;
	bh=SWcDmYUAOAy6ZmoLjJbiaC3tg+KjYcY2XdCTfbTFYxE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sucqGG3YvkRvEL7m9V4RFyLBZsW+skb8DCVL5QdG22VEfo/YVgDyBZzQQmPsyjSqV
	 Ha9j23ENEAl9V+q7fW+mfJwrYhrgFki2qeONpxs7aMMNaNM6crDN+GKwcwdzYdICGd
	 3ZzimkTFs/Z96w+A8db1IaTFKLHBhFIVkavH++GJ434m2tOdzmR+tmXuxwQlcrTnUc
	 Xb1/AsvuqL4nWNpCiLWAmsitJy0lhznEa3rPDxGS0o0zePwGbLY1KOAZxubR/0YsR1
	 H+6FkqIY0qMXzkTrDzPuNkCQvHVqP3hIXlCoZRmr4iHZJ7o3qvVGYcs1kH7QG0CDj3
	 a5+SsJblLxxLg==
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
Subject: [PATCH v4 03/28] block: Introduce blk_zone_update_request_bio()
Date: Tue,  2 Apr 2024 21:38:42 +0900
Message-ID: <20240402123907.512027-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402123907.512027-1-dlemoal@kernel.org>
References: <20240402123907.512027-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_053918_468642_4F6F528F 
X-CRM114-Status: GOOD (  15.60  )
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

On completion of a zone append request, the request sector indicates the
location of the written data. This value must be returned to the user
through the BIO iter sector. This is done in 2 places: in
blk_complete_request() and in blk_update_request(). Introduce the inline
helper function blk_zone_update_request_bio() to avoid duplicating
this BIO update for zone append requests, and to compile out this
helper call when CONFIG_BLK_DEV_ZONED is not enabled.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 11 +++++------
 block/blk.h    | 19 ++++++++++++++++++-
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index fcbf0953a179..88b541e8873f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -821,8 +821,7 @@ static void blk_complete_request(struct request *req)
 		/* Completion has already been traced */
 		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
 
-		if (req_op(req) == REQ_OP_ZONE_APPEND)
-			bio->bi_iter.bi_sector = req->__sector;
+		blk_zone_update_request_bio(req, bio);
 
 		if (!is_flush)
 			bio_endio(bio);
@@ -923,10 +922,10 @@ bool blk_update_request(struct request *req, blk_status_t error,
 		bio_advance(bio, bio_bytes);
 
 		/* Don't actually finish bio if it's part of flush sequence */
-		if (!bio->bi_iter.bi_size && !is_flush) {
-			if (req_op(req) == REQ_OP_ZONE_APPEND)
-				bio->bi_iter.bi_sector = req->__sector;
-			bio_endio(bio);
+		if (!bio->bi_iter.bi_size) {
+			blk_zone_update_request_bio(req, bio);
+			if (!is_flush)
+				bio_endio(bio);
 		}
 
 		total_bytes += bio_bytes;
diff --git a/block/blk.h b/block/blk.h
index d9f584984bc4..17786052f32d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -408,12 +408,29 @@ static inline struct bio *blk_queue_bounce(struct bio *bio,
 
 #ifdef CONFIG_BLK_DEV_ZONED
 void disk_free_zone_bitmaps(struct gendisk *disk);
+static inline void blk_zone_update_request_bio(struct request *rq,
+					       struct bio *bio)
+{
+	/*
+	 * For zone append requests, the request sector indicates the location
+	 * at which the BIO data was written. Return this value to the BIO
+	 * issuer through the BIO iter sector.
+	 */
+	if (req_op(rq) == REQ_OP_ZONE_APPEND)
+		bio->bi_iter.bi_sector = rq->__sector;
+}
 int blkdev_report_zones_ioctl(struct block_device *bdev, unsigned int cmd,
 		unsigned long arg);
 int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 		unsigned int cmd, unsigned long arg);
 #else /* CONFIG_BLK_DEV_ZONED */
-static inline void disk_free_zone_bitmaps(struct gendisk *disk) {}
+static inline void disk_free_zone_bitmaps(struct gendisk *disk)
+{
+}
+static inline void blk_zone_update_request_bio(struct request *rq,
+					       struct bio *bio)
+{
+}
 static inline int blkdev_report_zones_ioctl(struct block_device *bdev,
 		unsigned int cmd, unsigned long arg)
 {
-- 
2.44.0


