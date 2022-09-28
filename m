Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B7CC32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 17:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=huGelRfYV4xfgZxXlge2ASn7B961mrjAW1M47mxW1tA=; b=WBztHJcuOWyg56AHab/OvupB/Z
	rwRfGsbwoWGxpuUryywE1DxP38GtFPiLLyaw3zFnl188bQtxrT6PQi/lypp05A/5M7KNqPsSokWRV
	mIDgEK1xwyIC/lhzihLYGNwoGb6aeMJOktxB0hk5QEUBHH5b0Bt9APPm8dGIr9Hk/UXhZYl78SHPp
	99gxvuAlQlrtVnvWnafOk/Hm4MKNY/u57uNTK5Y5f4OJp5Iu6UYASiWar2s3gak6b1Kkukqyijo9r
	yrENmtOJYLk8npwaGzKNUbR5fkznwGhZh9cc1ffc8My9bpiBDkMsUIihtgh2ydzZjO7KtqXJrq6gx
	6Kauf2+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odb38-00HQDu-6y; Wed, 28 Sep 2022 17:40:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odb34-00HQDD-VX
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 17:40:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8233B68BEB; Wed, 28 Sep 2022 19:40:39 +0200 (CEST)
Date: Wed, 28 Sep 2022 19:40:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH for-next v10 6/7] block: extend functionality to map
 bvec iterator
Message-ID: <20220928174039.GD17153@lst.de>
References: <20220927173610.7794-1-joshi.k@samsung.com> <CGME20220927174639epcas5p22b46aed144d81d82b2a9b9de586808ac@epcas5p2.samsung.com> <20220927173610.7794-7-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173610.7794-7-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_104043_327960_083AF00E 
X-CRM114-Status: GOOD (  25.99  )
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

On Tue, Sep 27, 2022 at 11:06:09PM +0530, Kanchan Joshi wrote:
> Extend blk_rq_map_user_iov so that it can handle bvec iterator.
> It  maps the pages from bvec iterator into a bio and place the bio into
> request.
> 
> This helper will be used by nvme for uring-passthrough path when IO is
> done using pre-mapped buffers.

Can we avoid duplicating some of the checks?  Something like the below
incremental patch.  Note that this now also allows the copy path for
all kinds of iov_iters, but as the copy from/to iter code is safe
and the sanity check was just or the map path that should be fine.
It's best split into a prep patch, though.

---
diff --git a/block/blk-map.c b/block/blk-map.c
index a1aa8dacb02bc..c51de30767403 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -549,26 +549,16 @@ int blk_rq_append_bio(struct request *rq, struct bio *bio)
 EXPORT_SYMBOL(blk_rq_append_bio);
 
 /* Prepare bio for passthrough IO given ITER_BVEC iter */
-static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter,
-				bool *copy)
+static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
 {
 	struct request_queue *q = rq->q;
-	size_t nr_iter, nr_segs, i;
-	struct bio *bio = NULL;
-	struct bio_vec *bv, *bvecs, *bvprvp = NULL;
+	size_t nr_iter = iov_iter_count(iter);
+	size_t nr_segs = iter->nr_segs;
+	struct bio_vec *bvecs, *bvprvp = NULL;
 	struct queue_limits *lim = &q->limits;
 	unsigned int nsegs = 0, bytes = 0;
-	unsigned long align = q->dma_pad_mask | queue_dma_alignment(q);
-
-	/* see if we need to copy pages due to any weird situation */
-	if (blk_queue_may_bounce(q))
-		goto out_copy;
-	else if (iov_iter_alignment(iter) & align)
-		goto out_copy;
-	/* virt-alignment gap is checked anyway down, so avoid extra loop here */
-
-	nr_iter = iov_iter_count(iter);
-	nr_segs = iter->nr_segs;
+	struct bio *bio;
+	size_t i;
 
 	if (!nr_iter || (nr_iter >> SECTOR_SHIFT) > queue_max_hw_sectors(q))
 		return -EINVAL;
@@ -586,14 +576,15 @@ static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter,
 	/* loop to perform a bunch of sanity checks */
 	bvecs = (struct bio_vec *)iter->bvec;
 	for (i = 0; i < nr_segs; i++) {
-		bv = &bvecs[i];
+		struct bio_vec *bv = &bvecs[i];
+
 		/*
 		 * If the queue doesn't support SG gaps and adding this
 		 * offset would create a gap, fallback to copy.
 		 */
 		if (bvprvp && bvec_gap_to_prev(lim, bvprvp, bv->bv_offset)) {
 			bio_map_put(bio);
-			goto out_copy;
+			return -EREMOTEIO;
 		}
 		/* check full condition */
 		if (nsegs >= nr_segs || bytes > UINT_MAX - bv->bv_len)
@@ -611,9 +602,6 @@ static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter,
 put_bio:
 	bio_map_put(bio);
 	return -EINVAL;
-out_copy:
-	*copy = true;
-	return 0;
 }
 
 /**
@@ -635,33 +623,35 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 			struct rq_map_data *map_data,
 			const struct iov_iter *iter, gfp_t gfp_mask)
 {
-	bool copy = false;
+	bool copy = false, map_bvec = false;
 	unsigned long align = q->dma_pad_mask | queue_dma_alignment(q);
 	struct bio *bio = NULL;
 	struct iov_iter i;
 	int ret = -EINVAL;
 
-	if (iov_iter_is_bvec(iter)) {
-		ret = blk_rq_map_user_bvec(rq, iter, &copy);
-		if (ret != 0)
-			goto fail;
-		if (copy)
-			goto do_copy;
-		return ret;
-	}
-	if (!iter_is_iovec(iter))
-		goto fail;
-
 	if (map_data)
 		copy = true;
 	else if (blk_queue_may_bounce(q))
 		copy = true;
 	else if (iov_iter_alignment(iter) & align)
 		copy = true;
+	else if (iov_iter_is_bvec(iter))
+		map_bvec = true;
+	else if (!iter_is_iovec(iter))
+		copy = true;
 	else if (queue_virt_boundary(q))
 		copy = queue_virt_boundary(q) & iov_iter_gap_alignment(iter);
 
-do_copy:
+	if (map_bvec) {
+		ret = blk_rq_map_user_bvec(rq, iter);
+		if (!ret)
+			return 0;
+		if (ret != -EREMOTEIO)
+			goto fail;
+		/* fall back to copying the data on limits mismatches */
+		copy = true;
+	}
+
 	i = *iter;
 	do {
 		if (copy)

