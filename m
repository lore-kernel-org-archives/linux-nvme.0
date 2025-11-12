Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4E4CCFA1A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 15:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/mBQkIEvuG1q/Zo/McOIlyu0XldAbnbojbKnK29Ndu8=; b=rM9L2In0S40caaIjT6S+0Gep0m
	DgH6HPA0kIAON2TmQtWGFgKexJmvn/7noqTwcbWN7LjQnuZCJ1TsnaN7wE0Z8etmmhytv2dFjzaba
	s9vD6Vlek07JHUtYX2NG9F55ju7YWgqSSZCr6Q46NcIbRgeoOTrDEPX3hlYPyoc+W8rMWAFo0CQuE
	r6Hl/x4QBk5bo3Jr+T1ut7c25QE8iQeCHew2bqKxD3sLqSOeoUXLg9bqQ9Zx6wC8bCgHjBBooVmQi
	Z2ffQzT2sUtbSiXPq1PAGRmbCUdrS2Mem3acBJIqz+UuENd5vDK2iOiyYEazKuTXzY0EgldGQxJge
	cRI5Gd6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJCgt-0000000937W-3VKl;
	Wed, 12 Nov 2025 15:23:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJCgt-0000000936X-1sKZ
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 15:23:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8E605601AF;
	Wed, 12 Nov 2025 15:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E66FC4CEF5;
	Wed, 12 Nov 2025 15:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762961002;
	bh=R68lyaKZuVdiD0o54Fj+yYa5Ky9uRQ3jNdQoHZ6wcYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXvh2aY/29WbplAxXgCKqpBoHSFrIZsLF14u/GH2RNc2nvmjhsNFyHhoDKqu8SjKt
	 7SLpjGixVVKsWks/qOXJEIa6jFmdeq2Fg5FxkjWZQMCSmWAkPta6dcYn6EtuaYiROT
	 oxCx8HLP4TURdJLrTsZfYlFISg1dhgxGtiXrSgaj4Jplf6Pyxwpe0MDeLWqhWT3oC2
	 A8i5L1MDaYazR35NjIwgzWj7Y8ys7/C67wK+mfQpnVZ2DYHKksAV6bvRVbJVpN6aD0
	 8kG7hlQpqbbT7Ht2ju9vtDV/zFnVK9cMsRrOMltCezhNDJDq/QtMHoISbkWisYWX0v
	 9EhQVaE3OuWbw==
Date: Wed, 12 Nov 2025 10:23:19 -0500
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] block-dma: properly take MMIO path
Message-ID: <aRSmZ6IisXDmI9Yg@kbusch-mbp>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>
 <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>
 <aRSbzwpS2AuP92_n@kbusch-mbp>
 <20251112151604.GF17382@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112151604.GF17382@unreal>
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

On Wed, Nov 12, 2025 at 05:16:04PM +0200, Leon Romanovsky wrote:
> On Wed, Nov 12, 2025 at 09:38:07AM -0500, Keith Busch wrote:
> > On Mon, Oct 27, 2025 at 09:30:21AM +0200, Leon Romanovsky wrote:
> > > @@ -732,13 +746,20 @@ static void nvme_unmap_metadata(struct request *req)
> > >  		return;
> > >  	}
> > >  
> > > -	if (!blk_rq_integrity_dma_unmap(req, dma_dev, &iod->meta_dma_state,
> > > -					iod->meta_total_len)) {
> > > +	if (iod->flags & IOD_META_P2P)
> > > +		map = PCI_P2PDMA_MAP_BUS_ADDR;
> > > +	if (iod->flags & IOD_META_MMIO) {
> > > +		map = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
> > > +		attrs |= DMA_ATTR_MMIO;
> > > +	}
> > 
> > This should be an 'else if' no?
> 
> We can't have both IOD_META_P2P and IOD_META_MMIO. It can be only one or
> IOD_META_P2P or IOD_META_MMIO. In this case "else if' is not necessary.

I get that and I'm not saying this is a bug, but it just looks odd.
You're checking the conditions as if they're independent of each other
when they're not. If the first 'if' is true, there's no need to test the
second one as we know it's false, but this code flow will test it
anyway.

