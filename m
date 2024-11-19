Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D38AD44150
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 12:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IuHLWbXl17oUwGr2uJNRZmdZTGTpCXDRWm/qYEw8Z8A=; b=EkAJy3XA7BJfn8QXC1PJTrTri+
	SakXdUrImINeo1pXViXzs1SSl4p3luIxAr78FQmVoTkI6k0u3x6W2p9rVF5xVWimRZ7XaiyUYpyC6
	vHaCzgd62iAPLqQj1STXRqgGnZXOO/c9GSHwv4iU9i2q2iPSyHqR+RduLslIMvamDidYhz6V728FB
	8euCE4rm67J3yDTXWpN10Oubi9UN60ZUok2el8g1vF8sVbP74h4i2hzoV/Ql7Xhh+0+t9+zp33xtF
	T5ChiBzyvxExVmWjjXlT41Xgu2k7Ua+c2+27Wkfbox6VPshQn9cKKTQhdF3rLKlcCoA+5Nix7AG7o
	5cqX6Txg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNA7-0000000CJ2K-3iuo;
	Tue, 19 Nov 2024 12:16:55 +0000
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNA6-0000000CIyz-02Zh;
	Tue, 19 Nov 2024 12:16:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Jan Kara <jack@suse.cz>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH 06/15] block: add a bi_write_stream field
Date: Tue, 19 Nov 2024 13:16:20 +0100
Message-ID: <20241119121632.1225556-7-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119121632.1225556-1-hch@lst.de>
References: <20241119121632.1225556-1-hch@lst.de>
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

Add the ability to pass a write stream for placement control in the bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c                 | 2 ++
 block/blk-crypto-fallback.c | 1 +
 block/blk-merge.c           | 4 ++++
 block/bounce.c              | 1 +
 include/linux/blk_types.h   | 1 +
 5 files changed, 9 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 699a78c85c75..2aa86edc7cd6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -251,6 +251,7 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	bio->bi_flags = 0;
 	bio->bi_ioprio = 0;
 	bio->bi_write_hint = 0;
+	bio->bi_write_stream = 0;
 	bio->bi_status = 0;
 	bio->bi_iter.bi_sector = 0;
 	bio->bi_iter.bi_size = 0;
@@ -827,6 +828,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio_set_flag(bio, BIO_CLONED);
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_write_hint = bio_src->bi_write_hint;
+	bio->bi_write_stream = bio_src->bi_write_stream;
 	bio->bi_iter = bio_src->bi_iter;
 
 	if (bio->bi_bdev) {
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 29a205482617..66762243a886 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -173,6 +173,7 @@ static struct bio *blk_crypto_fallback_clone_bio(struct bio *bio_src)
 		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_ioprio		= bio_src->bi_ioprio;
 	bio->bi_write_hint	= bio_src->bi_write_hint;
+	bio->bi_write_stream	= bio_src->bi_write_stream;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index e01383c6e534..1e5327fb6c45 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -866,6 +866,8 @@ static struct request *attempt_merge(struct request_queue *q,
 
 	if (req->bio->bi_write_hint != next->bio->bi_write_hint)
 		return NULL;
+	if (req->bio->bi_write_stream != next->bio->bi_write_stream)
+		return NULL;
 	if (req->bio->bi_ioprio != next->bio->bi_ioprio)
 		return NULL;
 	if (!blk_atomic_write_mergeable_rqs(req, next))
@@ -987,6 +989,8 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 		return false;
 	if (rq->bio->bi_write_hint != bio->bi_write_hint)
 		return false;
+	if (rq->bio->bi_write_stream != bio->bi_write_stream)
+		return false;
 	if (rq->bio->bi_ioprio != bio->bi_ioprio)
 		return false;
 	if (blk_atomic_write_mergeable_rq_bio(rq, bio) == false)
diff --git a/block/bounce.c b/block/bounce.c
index 0d898cd5ec49..fb8f60f114d7 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -170,6 +170,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src)
 		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_ioprio		= bio_src->bi_ioprio;
 	bio->bi_write_hint	= bio_src->bi_write_hint;
+	bio->bi_write_stream	= bio_src->bi_write_stream;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index dce7615c35e7..4ca3449ce9c9 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -220,6 +220,7 @@ struct bio {
 	unsigned short		bi_flags;	/* BIO_* below */
 	unsigned short		bi_ioprio;
 	enum rw_hint		bi_write_hint;
+	u8			bi_write_stream;
 	blk_status_t		bi_status;
 	atomic_t		__bi_remaining;
 
-- 
2.45.2


