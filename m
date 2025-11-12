Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32181CCFA1A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 15:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lQiv90K2uFRyKlMQO/Q84R4YV0BtGOfxJ4juf729uKA=; b=bmcxpX80sKOjmTHwOKHrIA4hH+
	Bv98ooilkJ/bFzIqv+1sU6JbrgzUjHZqN5tMexM8PMQTAX96TgDreTE1EuGOwnh1q0dqA1lc4Dnln
	6lACv98a8srhD7AS6UoApgTdRrF2WRnXDNWTQmBYIQD3o+T0PCGhLavacepQ3uemCmktld19RQSvA
	1AtIY0MZm6jlI4KzicPglhK13cPdvcgXUgKPFjo7DXCVqpYApfT1pCa0LC+limV+io7pWtsDthaOj
	24cYDEjXYYak7Rz3B6Ae6PMN7T3QHYa+9kPdOaoSSXdeHZ6AuS2W8mwJmSL4rXO7g2A9txrzZvHwm
	VXyk7n5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJCZw-000000091fz-0RDc;
	Wed, 12 Nov 2025 15:16:12 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJCZu-000000091fo-2J6S
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 15:16:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8DDEC601B0;
	Wed, 12 Nov 2025 15:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE8BC4CEF1;
	Wed, 12 Nov 2025 15:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762960569;
	bh=vzrBhlBN+G4m8xbDXYXnTlmh3Zk67K2c6rZJh+4k460=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V2Xf993Uag6Ne/cYPOKmf0Nv7zxzm5iuuxwnJPuCB8n+3JPk48w/eBcEdMeFDHMIZ
	 LjIgxtK2KhKkFk9sjHQY/2d9ONqBWsrEcyOFwY0saKHliNb8JqhLodBixQUKVGFd0J
	 Fb5iAuoV0sIsz3f61Z5a8yBM2BsDifa3dSATli2oIUWxAO6n05f3IFwNZvVgcJTDa0
	 dE5XqyU+IB2gxfHaHaXu1vcwf0F44hFF343Oaq5HuEjnevnR8IGyuitCWSjC5BEkaj
	 S9wtY4E2lxwGZxDbftwRCrKULTwLTddzVVIiQ3/ZxISF4jbTkzw4h6nPR+zgNxct0b
	 BWftzdUj10Iog==
Date: Wed, 12 Nov 2025 17:16:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] block-dma: properly take MMIO path
Message-ID: <20251112151604.GF17382@unreal>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>
 <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>
 <aRSbzwpS2AuP92_n@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRSbzwpS2AuP92_n@kbusch-mbp>
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

On Wed, Nov 12, 2025 at 09:38:07AM -0500, Keith Busch wrote:
> On Mon, Oct 27, 2025 at 09:30:21AM +0200, Leon Romanovsky wrote:
> > @@ -732,13 +746,20 @@ static void nvme_unmap_metadata(struct request *req)
> >  		return;
> >  	}
> >  
> > -	if (!blk_rq_integrity_dma_unmap(req, dma_dev, &iod->meta_dma_state,
> > -					iod->meta_total_len)) {
> > +	if (iod->flags & IOD_META_P2P)
> > +		map = PCI_P2PDMA_MAP_BUS_ADDR;
> > +	if (iod->flags & IOD_META_MMIO) {
> > +		map = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
> > +		attrs |= DMA_ATTR_MMIO;
> > +	}
> 
> This should be an 'else if' no?

We can't have both IOD_META_P2P and IOD_META_MMIO. It can be only one or
IOD_META_P2P or IOD_META_MMIO. In this case "else if' is not necessary.

> 

<...>

> > @@ -1036,6 +1067,17 @@ static blk_status_t nvme_map_data(struct request *req)
> >  	if (!blk_rq_dma_map_iter_start(req, dev->dev, &iod->dma_state, &iter))
> >  		return iter.status;
> >  
> > +	switch (iter.p2pdma.map) {
> > +	case PCI_P2PDMA_MAP_BUS_ADDR:
> > +		iod->flags |= IOD_DATA_P2P;
> > +		break;
> > +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> > +		iod->flags |= IOD_DATA_MMIO;
> > +		break;
> > +	default:
> > +		return BLK_STS_RESOURCE;
> > +	}
> 
> Why is it an error if the data isn't a P2PDMA type?

This is probably bug, I was supposed to handle PCI_P2PDMA_MAP_NONE case too.

Thanks

