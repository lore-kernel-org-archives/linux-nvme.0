Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B436CCF9EB
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 07:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G4a0HgmKvPBC4IW9TJrOMZXQQ0n93uaGBo/za+xeAwM=; b=CPOVI8nxSoA+l53jCgS/h2jUNl
	uEsyK1EAwewYsFhkkPMvbQk2vVNHQrYiRxB3Sekk5yE9INpGxQrTM2IGpCP3mJeaMuvQTZix805S/
	RwgDAXaXt5jufOa2dVcSdTNQmGRiseYAmVKRpQnekp/iVuat1SitsKKP7kelCBELT6bqD97GEijmR
	n4Ps2TFoklUbN3X48Zj2HgXabpkNGZL9UA/0+THZJL+Ck8Pnc6+yrbXaGv2/raMgttErme9xKHIsj
	zE80sHHjExXq80g4HA1Ym3qMlGglgd67JHbt3tlt3ZAIZYzOBtDT+0xFaO8xTFdpzfe9MX5xY96V+
	cqhUINgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDI6r-0000000DJae-1jCV;
	Mon, 27 Oct 2025 07:57:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDI6p-0000000DJaS-2uuA
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 07:57:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D79386037D;
	Mon, 27 Oct 2025 07:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241B2C4CEF1;
	Mon, 27 Oct 2025 07:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761551862;
	bh=8Pzj6eA9ly1d9tF2fE60ZmbtYhCY2uo2nMNhehrxgU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L45dkNDwCYLNVZuROPPeyuyrbaHkF+rrcv+Ur7i9rMIcU1hAfa2zdIct0wI3pBqMl
	 puWpEVZlrrS4mR8znz14FAVUm48cnR6V1G8G01dkVbNuUOoKYgNawswkU5pYBVXqJn
	 wpKBQWEdypZif8+OpOZtVEY/NO818uQ7+lZk+HLx/Q6CGGSsZaDCGav9v7gGrpXMsi
	 VZcRA7Z7+26gENuPg6m4sDky34TTmT9Cu/l9YWHKwlUMHetim/xs6VLjQNXVo9YxzS
	 +n7zIP2i/OKTftSNi03L0u9zkMoomzJAE8LZdskrUOW7RVJERP6tzsZoRc7rr2HONV
	 xdeGHnv3taAog==
Date: Mon, 27 Oct 2025 09:57:38 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] block-dma: properly take MMIO path
Message-ID: <20251027075738.GF12554@unreal>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>
 <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>
 <20251027074922.GA14543@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027074922.GA14543@lst.de>
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

On Mon, Oct 27, 2025 at 08:49:22AM +0100, Christoph Hellwig wrote:
> > +	switch (iter.p2pdma.map) {
> > +	case PCI_P2PDMA_MAP_BUS_ADDR:
> > +		iod->flags |= IOD_DATA_P2P;
> > +		break;
> > +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> > +		iod->flags |= IOD_DATA_MMIO;
> > +		break;
> > +	default:
> > +		return BLK_STS_RESOURCE;
> 
> I almost wonder if we should just the pci_p2pdma_map_type values into
> place.  But that's a future cleanup, I'd rather get this going now.

I thought about it, but decided to use flags as more space efficient.
PCI_P2PDMA_MAP_BUS_ADDR == 3 and PCI_P2PDMA_MAP_THRU_HOST_BRIDGE == 4.
It means that will need to occupy 6 bits (extra u8 IOD field), while
this flags encoding takes only 4 bits (without extra IOD field).

> 
> > +static inline bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
> > +		struct dma_iova_state *state, size_t mapped_len,
> > +		enum pci_p2pdma_map_type map)
> >  {
> > -	if (is_p2p)
> > +	if (map == PCI_P2PDMA_MAP_BUS_ADDR)
> >  		return true;
> >  
> >  	if (dma_use_iova(state)) {
> > +		unsigned int attrs = 0;
> > +
> > +		if (map == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
> > +			attrs |= DMA_ATTR_MMIO;
> > +
> >  		dma_iova_destroy(dma_dev, state, mapped_len, rq_dma_dir(req),
> > -				 0);
> > +				 attrs);
> 
> The only thing in req that is used now is the data directrion.  I'd be
> almost tempted to just pass that and lift this to dma-mapping.h.
> 
> But I guess we could just do that in a follow on to not drag in
> another subsystem.
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks

