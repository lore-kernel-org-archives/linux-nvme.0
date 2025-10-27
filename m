Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76166CCF9EB
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 07:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=08yixNAx1vyS6tGO/eYtmH0OULZBT84biDBgDN25zRI=; b=ibF2eZqICmfEjf/Hmx6S5LMSkT
	A3DVaJy6u7dqy4gi7ZRcGSWhjMBD+yGPV9fB613snRLmpjgKF+A93TiZfFiPmo8OlVwJPn+FpA+bJ
	K3GADHjAVf/wzwvx/IwiTuibhSvwGhThVsq05oB6n5cNHKAsoAzx6788FWGY0YO5WWUJ4EC0bV8tk
	Kv9yCO91mAdMe2FxGbcgD3U3Rb56gMU656+LybPdwPcfwbhat0rysO719oMSIgj8eIkmltCq6X98W
	vI6TNRF5rrNmwXgeS60yMDK3p2DU07cPP4VsWnsO4lUsFQ8IbmI8hmXHr+NFZQnY1AvEkZBXSYXZr
	lAQ8/c2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDHyu-0000000DIgk-0LH9;
	Mon, 27 Oct 2025 07:49:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDHyr-0000000DIg0-1csN
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 07:49:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 62E1D227A87; Mon, 27 Oct 2025 08:49:23 +0100 (CET)
Date: Mon, 27 Oct 2025 08:49:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] block-dma: properly take MMIO path
Message-ID: <20251027074922.GA14543@lst.de>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com> <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_004929_571177_3E5BB32C 
X-CRM114-Status: GOOD (  18.64  )
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

> +	switch (iter.p2pdma.map) {
> +	case PCI_P2PDMA_MAP_BUS_ADDR:
> +		iod->flags |= IOD_DATA_P2P;
> +		break;
> +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +		iod->flags |= IOD_DATA_MMIO;
> +		break;
> +	default:
> +		return BLK_STS_RESOURCE;

I almost wonder if we should just the pci_p2pdma_map_type values into
place.  But that's a future cleanup, I'd rather get this going now.

> +static inline bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
> +		struct dma_iova_state *state, size_t mapped_len,
> +		enum pci_p2pdma_map_type map)
>  {
> -	if (is_p2p)
> +	if (map == PCI_P2PDMA_MAP_BUS_ADDR)
>  		return true;
>  
>  	if (dma_use_iova(state)) {
> +		unsigned int attrs = 0;
> +
> +		if (map == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
> +			attrs |= DMA_ATTR_MMIO;
> +
>  		dma_iova_destroy(dma_dev, state, mapped_len, rq_dma_dir(req),
> -				 0);
> +				 attrs);

The only thing in req that is used now is the data directrion.  I'd be
almost tempted to just pass that and lift this to dma-mapping.h.

But I guess we could just do that in a follow on to not drag in
another subsystem.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

