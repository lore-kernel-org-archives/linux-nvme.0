Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0218FD1F9B7
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 10:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qChLaZR5s/GOpATx/ro3bLhyDBLy5vLepXdMy3KpsPw=; b=Ad4Cjl/UU3A1MKvRLWVxjPBVHC
	81Herpm1U/yIZq8JY3kG9MLex3ztChigPzAi1eeh9r2METAurq6oYu+bgEM766tK93TJAYuZNufD+
	fnoKffd8f8/8cRoOhKkIosUUR23QKi4rXPaKp64q1ZgmZ2RQ06xLFDOg1GfG7qY41O2JMqta7VPo7
	o1IvVP8dlWRbPlKSMFp9+LKTyBcTFTT7xgv6wbofJKillmxFsqXIwgahBRaKCC2iK7y6YrpE6V9kD
	oLlMU3KpQjZGGf1xoAgCLiQ+e1cDY9H6OH0bEmW0QdjZeGmuxr21/GAHdQlVsTMuLpQJkzgp9dACt
	mcsUd4Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR6sY-00000007rlo-2M7U;
	Thu, 04 Dec 2025 10:48:06 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR6sX-00000007rlX-2Wlb;
	Thu, 04 Dec 2025 10:48:05 +0000
Date: Thu, 4 Dec 2025 02:48:05 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [RFC v2 04/11] block: introduce dma token backed bio type
Message-ID: <aTFm5dHzH3IRID8o@infradead.org>
References: <cover.1763725387.git.asml.silence@gmail.com>
 <12530de6d1907afb44be3e76e7668b935f1fd441.1763725387.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12530de6d1907afb44be3e76e7668b935f1fd441.1763725387.git.asml.silence@gmail.com>
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

> diff --git a/block/bio.c b/block/bio.c
> index 7b13bdf72de0..8793f1ee559d 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -843,6 +843,11 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
>  		bio_clone_blkg_association(bio, bio_src);
>  	}
>  
> +	if (bio_flagged(bio_src, BIO_DMA_TOKEN)) {
> +		bio->dma_token = bio_src->dma_token;
> +		bio_set_flag(bio, BIO_DMA_TOKEN);
> +	}

Historically __bio_clone itself does not clone the payload, just the
bio.  But we got rid of the callers that want to clone a bio but not
the payload long time ago.

I'd suggest a prep patch that moves assigning bi_io_vec from
bio_alloc_clone and bio_init_clone into __bio_clone, and given that they
are the same field that'll take carw of the dma token as well.
Alternatively do it in an if/else that the compiler will hopefully
optimize away.

> @@ -1349,6 +1366,10 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
>  		bio_iov_bvec_set(bio, iter);
>  		iov_iter_advance(iter, bio->bi_iter.bi_size);
>  		return 0;
> +	} else if (iov_iter_is_dma_token(iter)) {

No else after an return please.

> +++ b/block/blk-merge.c
> @@ -328,6 +328,29 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
>  	unsigned nsegs = 0, bytes = 0, gaps = 0;
>  	struct bvec_iter iter;
>  
> +	if (bio_flagged(bio, BIO_DMA_TOKEN)) {

Please split the dmabuf logic into a self-contained
helper here.

> +		int offset = offset_in_page(bio->bi_iter.bi_bvec_done);
> +
> +		nsegs = ALIGN(bio->bi_iter.bi_size + offset, PAGE_SIZE);
> +		nsegs >>= PAGE_SHIFT;

Why are we hardcoding PAGE_SIZE based "segments" here?

> +
> +		if (offset & lim->dma_alignment || bytes & len_align_mask)
> +			return -EINVAL;
> +
> +		if (bio->bi_iter.bi_size > max_bytes) {
> +			bytes = max_bytes;
> +			nsegs = (bytes + offset) >> PAGE_SHIFT;
> +			goto split;
> +		} else if (nsegs > lim->max_segments) {

No else after a goto either.

