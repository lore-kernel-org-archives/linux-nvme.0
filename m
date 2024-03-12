Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F3AC54E58
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 14:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hrCyrsnBfOo+yPYfkugdSsWlzoyaaYdrCNbfvGS6+ZU=; b=kJUVgpsEg1FLzamiA9idnpwIFJ
	/xRy+H4qLbbxsoWTi0jUSVEMBi6NW2AspdbC+ZPnVMFWf7DdNoQaLoiXxx2C1My5vayumHCb84+6M
	oJHEz3c20m9uOhJrE98tA3MspCPoQexLaXiUju19srzGq9ma+6Pr87o7MdHoAmlXzfNS2qk6UiTBG
	Adl2afFUACnxM6vn6vjdjzXVcsTmEy8cak6WTGZ3/PRYXAOJG4fgFRPL65mhjrKnNUgkFtwiGJ089
	BHDwuJeFcdcx8UWmMq1ILY4wsm+PBtQLVSHU9PSwmTITyCzyDCad9WVR4FMKILDVxdnZyx3I2cxQ6
	BWcD0nHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3Qg-00000006DAx-45jZ;
	Tue, 12 Mar 2024 14:48:34 +0000
Received: from [50.226.187.238] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3Qc-00000006D87-2mRe;
	Tue, 12 Mar 2024 14:48:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 4/5] block: move await_bio_chain to bio.c
Date: Tue, 12 Mar 2024 08:48:25 -0600
Message-Id: <20240312144826.1045212-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312144826.1045212-1-hch@lst.de>
References: <20240312144826.1045212-1-hch@lst.de>
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

we'll want to use it from more than blk-lib.c, so this seems like
the better place.  Also rename it so that the name starts with bio_.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c     | 20 ++++++++++++++++++++
 block/blk-lib.c | 28 ++++------------------------
 block/blk.h     |  1 +
 3 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 32ff538b29e564..33972deed87fb3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1396,6 +1396,26 @@ int submit_bio_wait(struct bio *bio)
 }
 EXPORT_SYMBOL(submit_bio_wait);
 
+static void bio_wait_end_io(struct bio *bio)
+{
+	complete(bio->bi_private);
+	bio_put(bio);
+}
+
+/*
+ * bio_await_chain - ends @bio and waits for every chained bio to complete
+ */
+void bio_await_chain(struct bio *bio)
+{
+	DECLARE_COMPLETION_ONSTACK_MAP(done,
+			bio->bi_bdev->bd_disk->lockdep_map);
+
+	bio->bi_private = &done;
+	bio->bi_end_io = bio_wait_end_io;
+	bio_endio(bio);
+	blk_wait_io(&done);
+}
+
 void __bio_advance(struct bio *bio, unsigned bytes)
 {
 	if (bio_integrity(bio))
diff --git a/block/blk-lib.c b/block/blk-lib.c
index fd97f4dd34e7f4..8021bc3831d56a 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -35,26 +35,6 @@ static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
 	return round_down(UINT_MAX, discard_granularity) >> SECTOR_SHIFT;
 }
 
-static void await_bio_endio(struct bio *bio)
-{
-	complete(bio->bi_private);
-	bio_put(bio);
-}
-
-/*
- * await_bio_chain - ends @bio and waits for every chained bio to complete
- */
-static void await_bio_chain(struct bio *bio)
-{
-	DECLARE_COMPLETION_ONSTACK_MAP(done,
-			bio->bi_bdev->bd_disk->lockdep_map);
-
-	bio->bi_private = &done;
-	bio->bi_end_io = await_bio_endio;
-	bio_endio(bio);
-	blk_wait_io(&done);
-}
-
 struct bio *blk_alloc_discard_bio(struct block_device *bdev,
 		sector_t *sector, sector_t *nr_sects, gfp_t gfp_mask)
 {
@@ -93,7 +73,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	}
 
 	if (*biop)
-		await_bio_chain(*biop);
+		bio_await_chain(*biop);
 	return -EINTR;
 }
 EXPORT_SYMBOL(__blkdev_issue_discard);
@@ -158,7 +138,7 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector += len;
 		cond_resched();
 		if (fatal_signal_pending(current)) {
-			await_bio_chain(bio);
+			bio_await_chain(bio);
 			return -EINTR;
 		}
 	}
@@ -206,7 +186,7 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 		}
 		cond_resched();
 		if (fatal_signal_pending(current)) {
-			await_bio_chain(bio);
+			bio_await_chain(bio);
 			return -EINTR;
 		}
 	}
@@ -352,7 +332,7 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 		nr_sects -= len;
 		cond_resched();
 		if (fatal_signal_pending(current)) {
-			await_bio_chain(bio);
+			bio_await_chain(bio);
 			ret = -EINTR;
 			bio = NULL;
 			break;
diff --git a/block/blk.h b/block/blk.h
index a19b7b42e6503c..78528bfbd58c37 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -38,6 +38,7 @@ void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 void blk_queue_start_drain(struct request_queue *q);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
 void submit_bio_noacct_nocheck(struct bio *bio);
+void bio_await_chain(struct bio *bio);
 
 static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
 {
-- 
2.39.2


