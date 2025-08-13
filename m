Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28D4CA0EE8
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 16:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MNulkym1VO/iEYD2CujqqAgvHZ3F5pqZy3I/uKi6NfE=; b=lxtxXTxApCUwzVpYjwe67q/lG6
	BjPL3JB0IEtbfkpMswGd2nVIy/CT9CPM+I19U2mtCYXmBWznCv2jNYJWBCUpAEg4h10oNPOF/Nx/v
	gsCqR6Y4m2D8/AEQIHRLQ/GWzPXYbZtl5hFPFofeLCw83q1wm6v6E3qA1ENJH5i9tlYqgNkzc/zLz
	IVl7kopl5BYWlmLPVxsi1VYReqyJmWSim2awMzVX7tkHNDx2ODlxHZbFOoZJWIOr4KcmmZKjvL77z
	egQUoovUtwPb+fpWxIOvxwo3iFcR0/F7KyagH+ZYsGl4/SyR7UUymzhjFLaNnRMzabHZAWbIA9TP3
	RWxNochA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umETP-0000000EQlS-120w;
	Wed, 13 Aug 2025 16:37:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umDpN-0000000EGlA-2I3W
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 15:55:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4746A227AA8; Wed, 13 Aug 2025 17:55:46 +0200 (CEST)
Date: Wed, 13 Aug 2025 17:55:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv7 7/9] blk-integrity: use iterator for mapping sg
Message-ID: <20250813155546.GA14275@lst.de>
References: <20250813153153.3260897-1-kbusch@meta.com> <20250813153153.3260897-8-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813153153.3260897-8-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_085549_870643_7B4039A7 
X-CRM114-Status: GOOD (  26.12  )
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

On Wed, Aug 13, 2025 at 08:31:51AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Modify blk_rq_map_integrity_sg to use the blk-mq mapping iterator. This
> produces more efficient code and converges the integrity mapping
> implementations to reduce future maintenance burdens.
> 
> The function implementation moves from blk-integrity.c to blk-mq-dma.c
> in order to use the types and functions private to that file. 
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-integrity.c | 58 -------------------------------------------
>  block/blk-mq-dma.c    | 45 +++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 58 deletions(-)
> 
> diff --git a/block/blk-integrity.c b/block/blk-integrity.c
> index 056b8948369d5..dd97b27366e0e 100644
> --- a/block/blk-integrity.c
> +++ b/block/blk-integrity.c
> @@ -122,64 +122,6 @@ int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
>  				   NULL);
>  }
>  
> -/**
> - * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
> - * @rq:		request to map
> - * @sglist:	target scatterlist
> - *
> - * Description: Map the integrity vectors in request into a
> - * scatterlist.  The scatterlist must be big enough to hold all
> - * elements.  I.e. sized using blk_rq_count_integrity_sg() or
> - * rq->nr_integrity_segments.
> - */
> -int blk_rq_map_integrity_sg(struct request *rq, struct scatterlist *sglist)
> -{
> -	struct bio_vec iv, ivprv = { NULL };
> -	struct request_queue *q = rq->q;
> -	struct scatterlist *sg = NULL;
> -	struct bio *bio = rq->bio;
> -	unsigned int segments = 0;
> -	struct bvec_iter iter;
> -	int prev = 0;
> -
> -	bio_for_each_integrity_vec(iv, bio, iter) {
> -		if (prev) {
> -			if (!biovec_phys_mergeable(q, &ivprv, &iv))
> -				goto new_segment;
> -			if (sg->length + iv.bv_len > queue_max_segment_size(q))
> -				goto new_segment;
> -
> -			sg->length += iv.bv_len;
> -		} else {
> -new_segment:
> -			if (!sg)
> -				sg = sglist;
> -			else {
> -				sg_unmark_end(sg);
> -				sg = sg_next(sg);
> -			}
> -
> -			sg_set_page(sg, iv.bv_page, iv.bv_len, iv.bv_offset);
> -			segments++;
> -		}
> -
> -		prev = 1;
> -		ivprv = iv;
> -	}
> -
> -	if (sg)
> -		sg_mark_end(sg);
> -
> -	/*
> -	 * Something must have been wrong if the figured number of segment
> -	 * is bigger than number of req's physical integrity segments
> -	 */
> -	BUG_ON(segments > rq->nr_integrity_segments);
> -	BUG_ON(segments > queue_max_integrity_segments(q));
> -	return segments;
> -}
> -EXPORT_SYMBOL(blk_rq_map_integrity_sg);
> -
>  int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
>  			      ssize_t bytes)
>  {
> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> index 60a244a129c3c..660b5e200ccf6 100644
> --- a/block/blk-mq-dma.c
> +++ b/block/blk-mq-dma.c
> @@ -379,4 +379,49 @@ bool blk_rq_integrity_dma_map_iter_next(struct request *req,
>  	return blk_dma_map_direct(req, dma_dev, iter, &vec);
>  }
>  EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_next);
> +
> +/**
> + * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
> + * @rq:		request to map
> + * @sglist:	target scatterlist
> + *
> + * Description: Map the integrity vectors in request into a
> + * scatterlist.  The scatterlist must be big enough to hold all
> + * elements.  I.e. sized using blk_rq_count_integrity_sg() or
> + * rq->nr_integrity_segments.
> + */
> +int blk_rq_map_integrity_sg(struct request *rq, struct scatterlist *sglist)
> +{
> +	struct request_queue *q = rq->q;
> +	struct scatterlist *sg = NULL;
> +	struct bio *bio = rq->bio;
> +	unsigned int segments = 0;
> +	struct phys_vec vec;
> +
> +	struct blk_map_iter iter = {

The empty line above is a bit odd.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

