Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E567C87FC5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jul 2025 07:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9xhjdxuTzomjH+Q1oZF/1NuMyw3X5IuTJaS3hxNlidM=; b=exwvUTQ2AsK6cn/eUMCp6vkzZq
	C8J0cP7wuvLejFl8/JSrmGdIAinY5t9vAqobQVFxDCpC/IuE5AMlQ9Goxz0CCg49lk2w1YgN34DFC
	SV3SmcoZInn8pU9qYXHRvO72E2WJpLikKUJ9PRaUPDZubV0AQvbVKNENhsc4pQ38v+RPWElDrFZJD
	o6lZSADgQJZE6MRcrrllA/jRZbYeGB3DyFVllSC/ROER8K2MbnOLtuSLl0EB1R6UlLsYDrLZI328d
	jPaz4TRQsZ4whhjxh5WCBsPG2uz6oIj8RPXTLs6UiT57aHVhuMXMgnPSQZC4E2mTCkbyUDA7bFH52
	XFgtFJpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udlF9-0000000GXmA-02yV;
	Mon, 21 Jul 2025 07:47:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udlEp-0000000GXeh-10BJ
	for linux-nvme@lists.infradead.org;
	Mon, 21 Jul 2025 07:47:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 555EE68B05; Mon, 21 Jul 2025 09:46:58 +0200 (CEST)
Date: Mon, 21 Jul 2025 09:46:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 6/7] blk-mq-dma: add support for mapping integrity
 metadata
Message-ID: <20250721074658.GG32034@lst.de>
References: <20250720184040.2402790-1-kbusch@meta.com> <20250720184040.2402790-7-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720184040.2402790-7-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_004707_426847_9C34C23C 
X-CRM114-Status: GOOD (  17.73  )
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

On Sun, Jul 20, 2025 at 11:40:39AM -0700, Keith Busch wrote:
> +static bool blk_dma_iter_next(struct blk_dma_iter *iter)

This is at the blk_map_iter level and one level below dma, so it
should not have a dma in the name.  I'm not entirely sure what a good
name is, though.  Maybe blk_map_iter_next_bio wich was the original
intention behind the refactored loop, although it isn't quite true
with the later !iter->iter.bi_bvec_done addition.

> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> +bool blk_rq_integrity_dma_map_iter_start(struct request *req,
> +		struct device *dma_dev,  struct dma_iova_state *state,
> +		struct blk_dma_iter *iter)
> +{
> +	unsigned len = bio_integrity_bytes(&req->q->limits.integrity,
> +					   blk_rq_sectors(req));
> +	iter->iter = req->bio->bi_integrity->bip_iter;
> +	iter->bvec = req->bio->bi_integrity->bip_vec;
> +	iter->integrity = true;
> +	return blk_dma_map_iter_start(req, dma_dev, state, iter, len);
> +}
> +EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_start);
> +
> +bool blk_rq_integrity_dma_map_iter_next(struct request *req,
> +               struct device *dma_dev, struct blk_dma_iter *iter)

The wans kernel doc comments that can be mostly copy and pasted
from the data mapping version.

Also it would be great to convert the integrity sg mapping and
count macros to blk_dma_map_iter_ just like I did for the data
version.

> +bool blk_rq_integrity_dma_map_iter_start(struct request *req,
> +		struct device *dma_dev,  struct dma_iova_state *state,
> +		struct blk_dma_iter *iter)
> +{
> +	return false;
> +}
> +bool blk_rq_integrity_dma_map_iter_next(struct request *req,

As you've probably noticed from the buildbot these need to be inline.

> @@ -18,6 +18,7 @@ struct blk_dma_iter {
>  	struct bvec_iter		iter;
>  	struct bio			*bio;
>  	struct pci_p2pdma_map_state	p2pdma;
> +	bool				integrity;

Add an is_ prefix for the new field?  Or replace it with checks
for ->bvec (or ->bvec_table as it should be) != bio->bi_io_vec?


