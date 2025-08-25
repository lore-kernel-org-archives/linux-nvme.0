Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA05FCA0FED
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Aug 2025 15:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H97IW4yLW8X5kx49pR9Pd/DSwq2doQEkPk1XM5QP8h0=; b=qpqLdSgS1dKyLL2ojX82xkxVJF
	NC5Wq4fz8cGmhWLTbfTMSbcHsA0R9Ben0Q0vyixOr4a4ui5S3l4zN7/k96OXoJlRtUr1CqrMBOhn4
	snB5ws68axW22+uLpJEvGNiJUQgrJWBB14+3s4BMCwhC7GN6+Ejk30kOicyk/7U14V6t/DEvpuXev
	/wrdwFsj2lEEjFlDDW9V9HKQGnwA4ZjrsIMmxp2pKxSfAqyzdoGwOVcTI8MnnCkWb3pc/YQB+xqGJ
	FytVR7ZMHP5qApZCvX/UySV9sgaGHOPrkqb+jjJJwHfwCqTEyM2wH+mPl7fnyL12lZhZobGjFJE4T
	QIaBlURw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqYio-00000008QX1-32RW;
	Mon, 25 Aug 2025 15:02:58 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqXX8-000000088cd-2phP;
	Mon, 25 Aug 2025 13:46:50 +0000
Date: Mon, 25 Aug 2025 06:46:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 1/2] block: accumulate segment page gaps per bio
Message-ID: <aKxpSorluMXgOFEI@infradead.org>
References: <20250821204420.2267923-1-kbusch@meta.com>
 <20250821204420.2267923-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821204420.2267923-2-kbusch@meta.com>
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

On Thu, Aug 21, 2025 at 01:44:19PM -0700, Keith Busch wrote:
> +static inline unsigned int bvec_seg_gap(struct bio_vec *bv, struct bio_vec *bvprv)

Nit: overly long line.

> +{
> +	return ((bvprv->bv_offset + bvprv->bv_len) & (PAGE_SIZE - 1)) |
> +			bv->bv_offset;

But what's actually more important is a good name, and a good comment.
Without much of an explanation this just looks like black magic :)

Also use the chance to document why all this is PAGE_SIZE based and
not based on either the iommu granule size or the virt boundary.

> +		if (bvprvp) {
> +			if (bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
> +				goto split;
> +			page_gaps |= bvec_seg_gap(&bv, &bvprv);
> +		}
>  
>  		if (nsegs < lim->max_segments &&
>  		    bytes + bv.bv_len <= max_bytes &&
> @@ -326,6 +335,7 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
>  	}
>  
>  	*segs = nsegs;
> +	bio->bi_pg_bit = ffs(page_gaps);

Caling this "bit" feels odd.  I guess the idea is that you only care
about power of two alignments?  I think this would be much easier
with the whole theory of operation spelled out somewhere in detail,
including why the compression to the set bits works, why the PAGE
granularity matters, why we only need to set this bit when splitting
but not on bios that never gets split or at least looped over for
splitting decisions.

>  	enum rw_hint		bi_write_hint;
>  	u8			bi_write_stream;
>  	blk_status_t		bi_status;
> +
> +	/*
> +	 * The page gap bit indicates the lowest set bit in any page address
> +	 * offset between all bi_io_vecs. This field is initialized only after
> +	 * splitting to the hardware limits.
> +	 */
> +	u8			bi_pg_bit;

Maybe move this one up so that all the field only set on the submission
side stay together?


