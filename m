Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFAFC43458
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jul 2026 19:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1FpL4WUmWFei6Nrd4vePrJQcJLiUUV2Fb3+2p1inoVs=; b=YzrCJ1hIf0hV/o675srDIUVayo
	Rltj3oRXW49Qjn1EJmyevITRLEJhzqFzBk81VEX+qtDzn1jpzGWkSoGgvvuRazwaBaBpMEdjdezrF
	nFyZCUwlYYFLObW1TESpNckEKM0StbnLl7ohktVZiDVi76F3iUShZlyrIzzONflQ7+3vvbZ5DdHNt
	JK02GEDmcMdlgicXNxFcRyUX4ehmmTYHw7iCWLG2R2/1Fvzvln4XPjG0RfYJE1tagpamJhrCglB3V
	HVlDZ2Le9ed7PIJxMwH/uoiY24QxlonbFeHuYDJmrYJXGX5BFSwE1jFtCRsfmbEIg5Vvw8GpDTDfa
	sUd15row==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6QH-00000008ivy-1WEr;
	Sat, 04 Jul 2026 19:53:09 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6QF-00000008iui-3gLF
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jul 2026 19:53:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1F62B61371;
	Sat,  4 Jul 2026 19:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75FD1F000E9;
	Sat,  4 Jul 2026 19:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194786;
	bh=1FpL4WUmWFei6Nrd4vePrJQcJLiUUV2Fb3+2p1inoVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JKlDDY8150KEk8TH9saEzRJac0guinUj9WaTe0AEgETybWxhsAdR98DyWdHRx4la2
	 HCwe/avjUI0pBBqGjzz2Su4uGTLHuStqBmqZujQBanW2/g++DowjckdKqLmuha+Z/F
	 qs0oUTkecOP8UiYlhzharbzr4kvqdlH/kCWNCQtFhKrCtsJPTURx69DkLwGD/Uymet
	 FDATUJPb+ZawZymAtVFzmvCtx07c7YgIEnEd61Qhz9EvPQaAawCIvr0aicEX6wzATt
	 GxPz7sgZubYsyzdAsVJlUryPkFD7Brnm7t+y1rS/Ke94UzoeolFsJA42K8249dgkB1
	 k8vC1YaY9Vhjw==
From: Yu Kuai <yukuai@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alasdair Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>,
	Coly Li <colyli@fygo.io>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Josef Bacik <josef@toxicpanda.com>,
	Yu Kuai <yukuai@fygo.io>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	dm-devel@lists.linux.dev,
	linux-bcache@vger.kernel.org
Subject: [RFC PATCH v1 07/17] block: support non-blocking bio allocation with a bdev
Date: Sun,  5 Jul 2026 03:51:14 +0800
Message-ID: <20260704195124.1375075-8-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260704195124.1375075-1-yukuai@kernel.org>
References: <20260704195124.1375075-1-yukuai@kernel.org>
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

From: Yu Kuai <yukuai@fygo.io>

bio_alloc_clone(), bio_init_clone(), and bio_alloc_bioset() can be called
with non-blocking GFP masks.  Passing a bdev into bio initialization may
need to associate blkcg state and, after missing blkg creation is serialized
by q->blkcg_mutex, that association can sleep.

Keep the generic block layer simple by letting bio_alloc_bioset() handle this
case directly.  Non-blocking allocations initialize the bio without a bdev,
set the bdev fields, and associate the blkg with nowait=true.  If the needed
blkg is missing and would have to be created, allocation fails normally so the
caller can retry from a blocking context.

Blocking callers keep the existing allocation-time association behavior.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 block/bio.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b74e9961c8ee..863ae73a4222 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -259,6 +259,20 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 }
 EXPORT_SYMBOL(bio_init);
 
+static bool bio_init_nowait(struct bio *bio, struct block_device *bdev,
+		struct bio_vec *table, unsigned short max_vecs, blk_opf_t opf)
+{
+	bio_init(bio, NULL, table, max_vecs, opf);
+	if (bdev) {
+		bio_set_dev_no_blkg(bio, bdev);
+		if (bio_associate_blkg(bio, true))
+			return true;
+		bio_uninit(bio);
+		return false;
+	}
+	return true;
+}
+
 /**
  * bio_reset - reinitialize a bio
  * @bio:	bio to reset
@@ -599,12 +613,25 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 		}
 	}
 
-	if (nr_vecs && nr_vecs <= BIO_INLINE_VECS)
-		bio_init_inline(bio, bdev, nr_vecs, opf);
-	else
-		bio_init(bio, bdev, bvecs, nr_vecs, opf);
+	if (nr_vecs && nr_vecs <= BIO_INLINE_VECS) {
+		bvecs = bio_inline_vecs(bio);
+		if (gfpflags_allow_blocking(saved_gfp))
+			bio_init(bio, bdev, bvecs, nr_vecs, opf);
+		else if (!bio_init_nowait(bio, bdev, bvecs, nr_vecs, opf))
+			goto fail_free_bio;
+	} else {
+		if (gfpflags_allow_blocking(saved_gfp))
+			bio_init(bio, bdev, bvecs, nr_vecs, opf);
+		else if (!bio_init_nowait(bio, bdev, bvecs, nr_vecs, opf))
+			goto fail_free_bio;
+	}
 	bio->bi_pool = bs;
 	return bio;
+
+fail_free_bio:
+	bio->bi_pool = bs;
+	bio_put(bio);
+	return NULL;
 }
 EXPORT_SYMBOL(bio_alloc_bioset);
 
@@ -857,7 +884,9 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 		if (bio->bi_bdev == bio_src->bi_bdev &&
 		    bio_flagged(bio_src, BIO_REMAPPED))
 			bio_set_flag(bio, BIO_REMAPPED);
-		bio_clone_blkg_association(bio, bio_src, false);
+		if (!bio_clone_blkg_association(bio, bio_src,
+					!gfpflags_allow_blocking(gfp)))
+			return -ENOMEM;
 	}
 
 	if (bio_crypt_clone(bio, bio_src, gfp) < 0)
@@ -913,9 +942,14 @@ EXPORT_SYMBOL(bio_alloc_clone);
 int bio_init_clone(struct block_device *bdev, struct bio *bio,
 		struct bio *bio_src, gfp_t gfp)
 {
+	bool blocking = gfpflags_allow_blocking(gfp);
 	int ret;
 
-	bio_init(bio, bdev, bio_src->bi_io_vec, 0, bio_src->bi_opf);
+	if (blocking)
+		bio_init(bio, bdev, bio_src->bi_io_vec, 0, bio_src->bi_opf);
+	else if (!bio_init_nowait(bio, bdev, bio_src->bi_io_vec, 0,
+				bio_src->bi_opf))
+		return -ENOMEM;
 	ret = __bio_clone(bio, bio_src, gfp);
 	if (ret)
 		bio_uninit(bio);
-- 
2.51.0


