Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FC4C47DD9
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 00:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gCjUnRf0PCQdbe3hadyiCkYDwKCl0BsKfWyyd3sWm94=; b=38KHCCaVaplJNUezUOTTbmp5J4
	Hgzzfm0vBLJP6GekONAOQrWY/GGa7dCP1hZhM7PcLysb7h5e3N3iApgK0kfkvdH8jA+bbmD/HWJO8
	tGLxi6dLQ+GABgmGtQg6EirqwmMSA4Rrc/jcTXJ33p1x0XrlVeNfsV9t20fESEdNo9Sj/TPFXgvfG
	Poi/QWW/7fdNl0jWknP51jU2X3lZ2t4tkyu2loxMHXML9Qvc7WsnJoDQwQ4aJ/Dco8x3P+L+/YJB/
	QYkbSX8G7dCBd9C1St65GZKZGMOGtDUhqu3vu9tWWmW9egfSMyq55lze+Cif0kolXbCJVWSKYpbN+
	8a2E7/FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdsW-0000000BnIo-3SvU;
	Thu, 28 Mar 2024 00:44:24 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdsS-0000000BnF4-2WTN
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 00:44:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 12C9661712;
	Thu, 28 Mar 2024 00:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B71C433F1;
	Thu, 28 Mar 2024 00:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586659;
	bh=FB7w8ip95MkbH08bP0mgNxN6wWfRAQ2xFU0ZBK8h+3I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BtO/9cmFimz3FCYrD2axBILc9HG3MplqmyMQ1E4bTfJ0cZ1AGezN2sa+wvqJ3nwhn
	 iYGjZXpfetlxp2bwcF8ygt5uB34PSNXh9cpuU1lv1sY5BNS/QNOcIZcXNOivqnR6zr
	 ABRkZCfGQ+shxX5gqO/tN9VATo0U1NFOdfZqjxl3ZUI1vWrQemDKSMD/UjRdsGuHld
	 jewCjrccqvT2m6F8x00deNHjN5nDp4OGKNZbj2Fmgvb+DWndNkFKhE1ZJP2mCZezmp
	 ZFFtCMA/SjLlRY/07YHBk/oZSv+ObpRBCGbtBjVLoJRy2x+2+qTsT4sP1hkRB0cnG3
	 YOaBYlwFiiyYw==
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
Subject: [PATCH v3 04/30] block: Introduce blk_zone_update_request_bio()
Date: Thu, 28 Mar 2024 09:43:43 +0900
Message-ID: <20240328004409.594888-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328004409.594888-1-dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_174420_809449_5E3CB2EA 
X-CRM114-Status: GOOD (  14.55  )
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
---
 block/blk-mq.c | 11 +++++------
 block/blk.h    | 19 ++++++++++++++++++-
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e55af6058cbf..70dfb4af65cf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -820,11 +820,11 @@ static void blk_complete_request(struct request *req)
 		/* Completion has already been traced */
 		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
 
-		if (req_op(req) == REQ_OP_ZONE_APPEND)
-			bio->bi_iter.bi_sector = req->__sector;
-
-		if (!is_flush)
+		if (!is_flush) {
+			blk_zone_update_request_bio(req, bio);
 			bio_endio(bio);
+		}
+
 		bio = next;
 	} while (bio);
 
@@ -923,8 +923,7 @@ bool blk_update_request(struct request *req, blk_status_t error,
 
 		/* Don't actually finish bio if it's part of flush sequence */
 		if (!bio->bi_iter.bi_size && !is_flush) {
-			if (req_op(req) == REQ_OP_ZONE_APPEND)
-				bio->bi_iter.bi_sector = req->__sector;
+			blk_zone_update_request_bio(req, bio);
 			bio_endio(bio);
 		}
 
diff --git a/block/blk.h b/block/blk.h
index 5cac4e29ae17..a12cde1d45de 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -409,12 +409,29 @@ static inline struct bio *blk_queue_bounce(struct bio *bio,
 
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


