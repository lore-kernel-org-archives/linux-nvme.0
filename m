Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A645DE77188
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jan 2025 07:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nfOzmNYg5Jb7eOtrEGMFecQW7RyfBHtxFoVVtj4oml4=; b=uFat0EFobuanagQ3rKPqmCjawt
	edT65Xw5kLhrM6AdNKyryxYBYMQIl80zQc7weQMAghym6DD0GO/Jtf1K1vhFO45zPLnieI2cAcTWi
	LwzBN0QhyD9kuwNuly54v3U8a7AeFRyUJvhuLYVc4III/wYU8Kpf8MOtq2jjZ+byO2/aMX6yfzqMj
	sxDEHE5boFp1oy/uMvvDLLx+EpPQdZLOU9zbHuzPM5pqzjUSjfu7tK6ZQv5ko05SF6Qli+xhpxhy7
	XfQHOxL5SDQNn4fAgCzfuC+lB76MFDanJo/M0t2EfzAFui+9YNwWa0IG6Y+wSCuPnpJISt+K2NzgJ
	f+O3eXwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTcH4-0000000CMxj-0zid;
	Fri, 03 Jan 2025 07:39:14 +0000
Received: from [2001:4bb8:2dc:484c:63c3:48c7:ceee:8370] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tTcCQ-0000000CM5k-29rT;
	Fri, 03 Jan 2025 07:34:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: [PATCH 2/2] block: remove blk_rq_bio_prep
Date: Fri,  3 Jan 2025 08:33:58 +0100
Message-ID: <20250103073417.459715-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250103073417.459715-1-hch@lst.de>
References: <20250103073417.459715-1-hch@lst.de>
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

There is not real point in a helper just to assign three values to four
fields, especially when the surrounding code is working on the
neighbor fields directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-map.c        | 10 ++++++----
 block/blk-mq.c         |  4 +++-
 include/linux/blk-mq.h |  8 --------
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 67a2da3b7ed9..d2f22744b3d1 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -490,17 +490,19 @@ int blk_rq_append_bio(struct request *rq, struct bio *bio)
 		return ret;
 	}
 
-	if (!rq->bio) {
-		blk_rq_bio_prep(rq, bio, nr_segs);
-	} else {
+	if (rq->bio) {
 		if (!ll_back_merge_fn(rq, bio, nr_segs))
 			return -EINVAL;
 		rq->biotail->bi_next = bio;
 		rq->biotail = bio;
-		rq->__data_len += (bio)->bi_iter.bi_size;
+		rq->__data_len += bio->bi_iter.bi_size;
 		bio_crypt_free_ctx(bio);
+		return 0;
 	}
 
+	rq->nr_phys_segments = nr_segs;
+	rq->bio = rq->biotail = bio;
+	rq->__data_len = bio->bi_iter.bi_size;
 	return 0;
 }
 EXPORT_SYMBOL(blk_rq_append_bio);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 16feec6c11ab..2e6132f778fd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2658,8 +2658,10 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
 	if (bio->bi_opf & REQ_RAHEAD)
 		rq->cmd_flags |= REQ_FAILFAST_MASK;
 
+	rq->bio = rq->biotail = bio;
 	rq->__sector = bio->bi_iter.bi_sector;
-	blk_rq_bio_prep(rq, bio, nr_segs);
+	rq->__data_len = bio->bi_iter.bi_size;
+	rq->nr_phys_segments = nr_segs;
 	if (bio_integrity(bio))
 		rq->nr_integrity_segments = blk_rq_count_integrity_sg(rq->q,
 								      bio);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2322b54a86ed..a0a9007cc1e3 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -968,14 +968,6 @@ static inline void blk_mq_cleanup_rq(struct request *rq)
 		rq->q->mq_ops->cleanup_rq(rq);
 }
 
-static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
-		unsigned int nr_segs)
-{
-	rq->nr_phys_segments = nr_segs;
-	rq->__data_len = bio->bi_iter.bi_size;
-	rq->bio = rq->biotail = bio;
-}
-
 void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
 		struct lock_class_key *key);
 
-- 
2.45.2


