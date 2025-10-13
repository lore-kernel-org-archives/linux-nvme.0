Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B60CCD185
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 19:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MnEC9NT58nFbHVbm62s/uxLDOferPB/6qHO/ZygFdiI=; b=oHAVTLRFkMZ6Xx5mNdj7K5c9CU
	YF853H3uXxNyTxbVICVYYVeVLM9EpZROjHIb0+lAm9+v45+9VjrXYV0XCokCP90sNgYJx17yyPgsL
	inn1h+7A7L6qx3NO+2LWn9BamgaP1zZr1GO0jW9xMyNMj6letrxciCbll5hQj9O2MwREKj16WI5IO
	rDanh0Re7FWLlQqDV2DXr4zKlUiW/FNLXgjLmw28XMXTWfcj1XRuHp+I0bKL2VAkCiowGq7eR3lmw
	F2EEYwaxXxPtNmVr4Nsz1rnsPv/K9uUPx3ZA5SdAbov+Y9zC9Fe8qKCE0/o+UeBL+geN57ASLJQTK
	H12QQ/ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8OJa-0000000EICu-2Dpu;
	Mon, 13 Oct 2025 19:34:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8OJV-0000000EICJ-1ku0
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 19:34:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E394640A6D;
	Mon, 13 Oct 2025 19:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DD2C4CEE7;
	Mon, 13 Oct 2025 19:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760384072;
	bh=7KebO7qMBUi4ynKKJUC5JxpmX0egvUjIKJ5fNHDrHTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sGDLXz4qgVQ4ccV3AQZfLjKfRMJwh62Utb6Gms8YvC9UROIq8aEcAGlPhfibZ1hlG
	 2GHTZaSEX0a3+poTuwTTUiG34WC0HHw/mTPyn1SY/5fr2+JSXtnN4JHoMONa1FXzXY
	 dS7YH0iAsDVUyxmgc/AeNZV0haSHyTQovHNdwBvkMnqJI+xTMot+qSWSruy772abPO
	 38F667TOJH3FxAZE+E0uLO5ZyAudmXnzKi95BpHhXQTeQ9quI7pHXyPVM/MfBsmU5n
	 Yiwj/fGi6f2gCTKzJwVJK4EY+vINQmk53o6aLp9zRrUsywf2KnYIajvSq6pcjPIIsb
	 0O2878r5cyxGw==
Date: Mon, 13 Oct 2025 13:34:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/4] block-dma: properly take MMIO path
Message-ID: <aO1URj3B3IUHX4Ge@kbusch-mbp>
References: <cover.1760369219.git.leon@kernel.org>
 <cf4f6dfee380351e68932d4d114422364097dda5.1760369219.git.leon@kernel.org>
 <aO1MfsuWeteOsBve@kbusch-mbp>
 <20251013192940.GC14552@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013192940.GC14552@unreal>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_123433_476320_C4A133A6 
X-CRM114-Status: GOOD (  19.14  )
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

On Mon, Oct 13, 2025 at 10:29:40PM +0300, Leon Romanovsky wrote:
> On Mon, Oct 13, 2025 at 01:01:18PM -0600, Keith Busch wrote:
> > On Mon, Oct 13, 2025 at 06:34:11PM +0300, Leon Romanovsky wrote:
> > >  static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
> > >  		struct blk_dma_iter *iter, struct phys_vec *vec)
> > >  {
> > > +	unsigned int attrs = 0;
> > > +
> > > +	if (req->cmd_flags & REQ_MMIO)
> > > +		attrs |= DMA_ATTR_MMIO;
> > 
> > Since data and integrity paylods use these same functions and may point
> > to different kinds of memory, I think you'd have to pass the 'attrs'
> > from the caller since it knows which flags to check for MMIO dma.
> 
> I think that hunk will fix it.
> 
> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> index 38f5c34ca223..8af88ba97c7a 100644
> --- a/block/blk-mq-dma.c
> +++ b/block/blk-mq-dma.c
> @@ -88,9 +88,11 @@ static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
>  static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
>                 struct blk_dma_iter *iter, struct phys_vec *vec)
>  {
> +       struct bio_integrity_payload *bip = bio_integrity(req->bio);
>         unsigned int attrs = 0;
> 
> -       if (req->cmd_flags & REQ_MMIO)
> +       if ((!bip && req->cmd_flags & REQ_MMIO) ||
> +           bio_integrity_flagged(req->bio, BIP_MMIO))
>                 attrs |= DMA_ATTR_MMIO;

If cmd_flags has REQ_MMIO set, but the integrity flag doesn't have
BIP_MMIO set, you will skip setting DMA_ATTR_MMIO, but I think we need
that set when this is called for the data payload.

