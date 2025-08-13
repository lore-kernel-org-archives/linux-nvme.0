Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3EFCA0EE3
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 07:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LgrQYuLHFrQO5i7Cgmlp2Snb6/9M3P+HmQeQwWm/iGo=; b=E2YQ9ns+WzgXXTuYCb+JDabj3u
	OI0nu8OvqZTLmb+KC/XNVTxuJ1cyhH/ds4ozLBzwoPbWpPgQgtaHb9ahMbIYongCOHOfUamTHpvhB
	nMArbQweZl3FMSahsmlXEStnfYNu+ANWiPupatDU0SyvYekqU+/Aa3XGOPIVbkvyMubCUPDVLGZGh
	S37n9rGe45Uiv1/QqiFwTyDrAHHm0WIIc7pAPMF2+iX7MbqaeLAFfD0BQeaRAeIr9d+QghDTdOZFL
	wSg7FcFSeMcmL0miXzp3a3oMeNunpkz6QkeCDV5vNoTzBAgWYv60maKNylGPy5B8RoFnXSvvqH4RG
	Wk0LnZWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um66S-0000000CxJz-39QH;
	Wed, 13 Aug 2025 07:40:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um5Jk-0000000Cq3z-0cZf
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 06:50:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 99004227A87; Wed, 13 Aug 2025 08:50:24 +0200 (CEST)
Date: Wed, 13 Aug 2025 08:50:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCHv6 6/8] blk-mq-dma: add support for mapping integrity
 metadata
Message-ID: <20250813065024.GA11825@lst.de>
References: <20250812135210.4172178-1-kbusch@meta.com> <20250812135210.4172178-7-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812135210.4172178-7-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_235036_326730_D068CC1A 
X-CRM114-Status: GOOD (  24.78  )
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

On Tue, Aug 12, 2025 at 06:52:08AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide integrity metadata helpers equivalent to the data payload
> helpers for iterating a request for dma setup.

This actually does two things:

  1) convert the existing SG helpers
  2) add the new helpers

Which probably should be split into a separate patches, and all of them
could use a more detailed commit log.

> +	struct blk_map_iter iter;
> +	struct phys_vec vec;
> +
> +	iter = (struct blk_map_iter) {
> +		.bio = bio,
> +		.iter = bio_integrity(bio)->bip_iter,
> +		.bvecs = bio_integrity(bio)->bip_vec,
> +		.is_integrity = true,
> +	};

Just initialize iter at declaration time:

> +	struct blk_map_iter iter = {
> +		.bio = bio,
> +		.iter = bio_integrity(bio)->bip_iter,
> +		.bvecs = bio_integrity(bio)->bip_vec,
> +		.is_integrity = true,
> +	};

> +static bool __blk_map_iter_next(struct blk_map_iter *iter)
> +{
> +	if (iter->iter.bi_size)
> +		return true;
> +	if (!iter->bio || !iter->bio->bi_next)
> +		return false;
> +
> +	iter->bio = iter->bio->bi_next;
> +	if (iter->is_integrity) {
> +		iter->iter = bio_integrity(iter->bio)->bip_iter;
> +		iter->bvecs = bio_integrity(iter->bio)->bip_vec;
> +	} else {
> +		iter->iter = iter->bio->bi_iter;
> +		iter->bvecs = iter->bio->bi_io_vec;
> +	}
> +	return true;
> +}

This seems unused, even with all patches applied.

> -static inline struct scatterlist *
> -blk_next_sg(struct scatterlist **sg, struct scatterlist *sglist)
> -{
> -	if (!*sg)
> -		return sglist;
> -
> -	/*
> -	 * If the driver previously mapped a shorter list, we could see a
> -	 * termination bit prematurely unless it fully inits the sg table
> -	 * on each mapping. We KNOW that there must be more entries here
> -	 * or the driver would be buggy, so force clear the termination bit
> -	 * to avoid doing a full sg_init_table() in drivers for each command.
> -	 */
> -	sg_unmark_end(*sg);
> -	return sg_next(*sg);
> -}

Maybe just add the metadata mapping helpers into this file instead of
moving stuff around?

> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -449,4 +449,30 @@ static inline bool blk_mq_can_poll(struct request_queue *q)
>  		q->tag_set->map[HCTX_TYPE_POLL].nr_queues;
>  }
>  
> +struct phys_vec {
> +	phys_addr_t	paddr;
> +	u32		len;
> +};

Leon has a patch to move this to linux/types.h, which if we have to
move it is probably a better place.

Otherwise this looks good.

