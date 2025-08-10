Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC02C87FCF
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Aug 2025 14:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i1wEdKl0FVE+e0uHATkGUybmVZahnonnzYs80gvQAKo=; b=ysvfD0vWKBfp3HCt9nDmsM/gO8
	hZVJSD+UhfRw2efUJEmgvlxiCZmOfoH3mEA3991mNwS20w33TSMowLydhnhW7d9qXUTfOm1V7y6Xr
	wUNDdW81naldnTqEQJpFuhhLq8Runuum6cfI412UfmJZAo+rp4hbf8pAQdiZEma5kiY1mLuDjgFpi
	jzftXF89vy4b0v/2PS1d3NALTR9O4N0BSbnL72ba6JR/486Qu1yEu+DNoEfcgIcfHgKYeFKUNM2ho
	55V7cSMMw4p+WgJu/TJ1r9ikxwrXPT/8nSyvvgwmUc6716Xo2xBsLZrvO9QLkjaEuRqCdhrMgGdPB
	fWsVvtIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul6r1-00000005gOl-3xmV;
	Sun, 10 Aug 2025 14:16:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul6qz-00000005gO2-0f4p
	for linux-nvme@lists.infradead.org;
	Sun, 10 Aug 2025 14:16:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1F4EA227A87; Sun, 10 Aug 2025 16:16:44 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:16:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 6/8] blk-mq-dma: add support for mapping integrity
 metadata
Message-ID: <20250810141643.GG4262@lst.de>
References: <20250808155826.1864803-1-kbusch@meta.com> <20250808155826.1864803-7-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808155826.1864803-7-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_071653_342505_DFA56F0F 
X-CRM114-Status: GOOD (  17.52  )
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

On Fri, Aug 08, 2025 at 08:58:24AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide integrity metadata helpers equivalent to the data payload
> helpers for iterating a request for dma setup.

Can you please also convert the SG mapping helpers to use the low-level
iterator first like I've done for the data path?  That ensures we have
less code to maintain, common behavior and also smaller kernel binaries.

> +static bool __blk_map_iter_next(struct blk_map_iter *iter)
> +{
> +	if (iter->iter.bi_size)
> +		return true;
> +	if (!iter->bio || !iter->bio->bi_next)
> +		return false;
> +
> +	iter->bio = iter->bio->bi_next;
> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> +	if (iter->is_integrity) {
> +		iter->iter = iter->bio->bi_integrity->bip_iter;
> +		iter->bvec = iter->bio->bi_integrity->bip_vec;
> +		return true;
> +	}
> +#endif
> +	iter->iter = iter->bio->bi_iter;
> +	iter->bvec = iter->bio->bi_io_vec;
> +	return true;

I wonder if we should use the bio_integrity() that would introduce two
(probably optimized down to one by the compiler) extra branches for the 
integrity mapping that are easily predicted, but make the think look much
nicer as it would kill the ifdef and the ugly structure around it:

	if (iter->is_integrity) {
		iter->iter = bio_integrity(iter->bio)->bip_iter;
		iter->bvec = bio_integrity(iter->bio)->bip_vec;
	} else {
		iter->iter = iter->bio->bi_iter;
		iter->bvec = iter->bio->bi_io_vec;
	}

	return true;

> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> +bool blk_rq_integrity_dma_map_iter_start(struct request *req,
> +		struct device *dma_dev,  struct dma_iova_state *state,
> +		struct blk_dma_iter *iter)

Can you please add a kerneldoc comment here, which could be easily
adapter from the data mapping path.

> +bool blk_rq_integrity_dma_map_iter_next(struct request *req,
> +               struct device *dma_dev, struct blk_dma_iter *iter)

Same here.


