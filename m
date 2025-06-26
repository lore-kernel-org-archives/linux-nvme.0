Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1B6C7115B
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jun 2025 05:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z35hDM7dpq6aV1ePwwSaLN+3F+D6ppHhW+njeys+6bs=; b=W4QyBp4xyvx7QJ5m0SxWm5m2AU
	ErvDsR4l/iQ342N3V8fCCQ2LOKTOOGrV0XzDJWTvkNFfKwMH+SildNQY3Bna2wEHacRgmjNA67VLe
	S7Jz4Ypa8FGoHhm9pjDhJQcbs1hp1GP8c/sf21enD9mHvy7YOmGAIx3HQDq/mPjuvrL3QCbHOVzmC
	n7XDEITPJjjXWEudiRZ684nERnCCoqldsqU6Py6VPkvm+/q6KAf7jZt+iDEAvnUGI6RwVjXkXaht5
	+w3Gz+zwwOUKD+kzDHnRYbgPmtywDny2/KQhHb56hi7DGFbOsZ16okqmpqpfjMVtu/E5oe84qHEsN
	YLbO6Pfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUeke-0000000Ac8f-2rA4;
	Thu, 26 Jun 2025 05:02:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUekb-0000000Ac89-0rjj
	for linux-nvme@lists.infradead.org;
	Thu, 26 Jun 2025 05:02:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B92DB68B05; Thu, 26 Jun 2025 07:02:02 +0200 (CEST)
Date: Thu, 26 Jun 2025 07:02:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, leon@kernel.org, joshi.k@samsung.com,
	sagi@grimberg.me
Subject: Re: [PATCH 1/2] blk-integrity: add scatter-less DMA mapping helpers
Message-ID: <20250626050202.GA23248@lst.de>
References: <20250625204445.1802483-1-kbusch@meta.com> <aFxnbP68tZj6zQyb@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFxnbP68tZj6zQyb@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_220217_533467_20FAD436 
X-CRM114-Status: GOOD (  22.41  )
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

On Wed, Jun 25, 2025 at 03:17:32PM -0600, Keith Busch wrote:
> > +		next = mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
> 
> And then this should be:
> 
> 		next = mp_bvec_iter_bvec(bip->bip_vec, iter->iter);
> 
> Obviously I didn't test merging bio's into plugged requests...

So, testing was the main reason I have skipped this in the initial
conversion, as I could not come up with good coverage of multi-segment
integrity metadata.  Anuj promised we'd get good test coverage once the
PI query ioctl lands, so the plan was to do it just after that.

I had written some code before I realized that, but it never really got
finished, but one thing I did was to trying figure out how we implement
the iterator without too much code duplication.  The below is what I came
up with - it adds two branches to the fast path, but otherwise shares the
entire dma iterator and I think also makes it very clear which bio_vec
table to use.  Maybe this is useful for the next version?  My next step
would have been to convert the scatterlist mapping to use the new common
helper and unify the code with the data mapping, and then implement the
new API (hopefully also sharing most of the code from the data mapping).

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 82bae475dfa4..24667d199525 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -10,28 +10,34 @@ struct phys_vec {
 };
 
 static bool blk_map_iter_next(struct request *req, struct req_iterator *iter,
-			      struct phys_vec *vec)
+			      struct phys_vec *vec, bool integrity)
 {
+	struct bio_vec *base;
 	unsigned int max_size;
 	struct bio_vec bv;
 
-	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
-		if (!iter->bio)
-			return false;
-		vec->paddr = bvec_phys(&req->special_vec);
-		vec->len = req->special_vec.bv_len;
-		iter->bio = NULL;
-		return true;
+	if (integrity) {
+		base = iter->bio->bi_integrity->bip_vec;
+	} else {
+		if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
+			if (!iter->bio)
+				return false;
+			vec->paddr = bvec_phys(&req->special_vec);
+			vec->len = req->special_vec.bv_len;
+			iter->bio = NULL;
+			return true;
+		}
+		base = iter->bio->bi_io_vec;
 	}
 
 	if (!iter->iter.bi_size)
 		return false;
 
-	bv = mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+	bv = mp_bvec_iter_bvec(base, iter->iter);
 	vec->paddr = bvec_phys(&bv);
 	max_size = get_max_segment_size(&req->q->limits, vec->paddr, UINT_MAX);
 	bv.bv_len = min(bv.bv_len, max_size);
-	bio_advance_iter_single(iter->bio, &iter->iter, bv.bv_len);
+	bvec_iter_advance_single(base, &iter->iter, bv.bv_len);
 
 	/*
 	 * If we are entirely done with this bi_io_vec entry, check if the next
@@ -46,15 +52,19 @@ static bool blk_map_iter_next(struct request *req, struct req_iterator *iter,
 				break;
 			iter->bio = iter->bio->bi_next;
 			iter->iter = iter->bio->bi_iter;
+			if (integrity)
+				base = iter->bio->bi_integrity->bip_vec;
+			else
+				base = iter->bio->bi_io_vec;
 		}
 
-		next = mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+		next = mp_bvec_iter_bvec(base, iter->iter);
 		if (bv.bv_len + next.bv_len > max_size ||
 		    !biovec_phys_mergeable(req->q, &bv, &next))
 			break;
 
 		bv.bv_len += next.bv_len;
-		bio_advance_iter_single(iter->bio, &iter->iter, next.bv_len);
+		bvec_iter_advance_single(base, &iter->iter, next.bv_len);
 	}
 
 	vec->len = bv.bv_len;
@@ -95,7 +105,7 @@ int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
 	if (iter.bio)
 		iter.iter = iter.bio->bi_iter;
 
-	while (blk_map_iter_next(rq, &iter, &vec)) {
+	while (blk_map_iter_next(rq, &iter, &vec, false)) {
 		*last_sg = blk_next_sg(last_sg, sglist);
 		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
 				offset_in_page(vec.paddr));

