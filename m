Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D80CD343C
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 18:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g6bSPzVLbqKXOQ/VKMKdGtaEzqcbL63Z6lm+bn+kdwg=; b=KQEfQ8zAJwAWYsAmpFF9CdogwG
	mRz/9mbSunwKjni7GHz0si56WqNRMhLM8ypEMf6WC2K32SmA6DdYPHeXtSvmiBtELj2pxo3y9akVz
	XIOh1KMZPLM4SQeC883YfTSp85utcZkyq80UVXNa/6ddGQJHIF6w2Q7sIkhESbhpTbbV9wHbK7nNq
	SPYRB3JpAGs7/5z91ZgmCGfDlQhCRD3niW1UOoJZc4VUETxHzVI0pTLsbfKQHXfaSOennJzFCWdin
	IoLYs8eX0QpaDfOb6seO1t0SisXMwEvR9Sl9yTARiO33HPONOOIOcEnZC94x3NNFE0eSR8pQU91gA
	Zt07zFbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJFcJ-00000009Lz7-010J;
	Wed, 12 Nov 2025 18:30:51 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJFcI-00000009Lyv-0aCE
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 18:30:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 264EB601A5;
	Wed, 12 Nov 2025 18:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627D5C4CEF7;
	Wed, 12 Nov 2025 18:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762972247;
	bh=CNUuHy/bpt4vT9lybSu7TmV/AB42+O/pew00JBqknEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0q3oWbEBImXCu7pv/1N4lXSKrIYXeALiciQ7vUEJAcW7Z3DHOQldOJ4COJS2eNj6
	 gJfu6pqiBaDj1+NWy2dV/IpBi2v2qTC7Rxc7TF+lXc4+rfEBNWe/5f+mUhmHOYxoBo
	 EL2mH54mGM86fUWRoJlEFNGD8qYocRntJqvvhfH5wmDLxZn9yOW7pBz93QaQCV/XjP
	 JNR11E4iY11h1gXstnR5sLOVnaCLcJcGFNvvH1SYFfRsFpw2aScDmQdYaz1hKtabqf
	 TmC/dsqZAjGvDQnj6PGzibnqjMLLYucIypQwafYwbSYXwDgxAj+XOJ/xA34qPq8E6f
	 RqjgKNcuDdlLw==
Date: Wed, 12 Nov 2025 20:30:42 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] block-dma: properly take MMIO path
Message-ID: <20251112183042.GA10544@unreal>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>
 <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>
 <aRSbzwpS2AuP92_n@kbusch-mbp>
 <20251112151604.GF17382@unreal>
 <aRSmZ6IisXDmI9Yg@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRSmZ6IisXDmI9Yg@kbusch-mbp>
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

On Wed, Nov 12, 2025 at 10:23:19AM -0500, Keith Busch wrote:
> On Wed, Nov 12, 2025 at 05:16:04PM +0200, Leon Romanovsky wrote:
> > On Wed, Nov 12, 2025 at 09:38:07AM -0500, Keith Busch wrote:
> > > On Mon, Oct 27, 2025 at 09:30:21AM +0200, Leon Romanovsky wrote:
> > > > @@ -732,13 +746,20 @@ static void nvme_unmap_metadata(struct request *req)
> > > >  		return;
> > > >  	}
> > > >  
> > > > -	if (!blk_rq_integrity_dma_unmap(req, dma_dev, &iod->meta_dma_state,
> > > > -					iod->meta_total_len)) {
> > > > +	if (iod->flags & IOD_META_P2P)
> > > > +		map = PCI_P2PDMA_MAP_BUS_ADDR;
> > > > +	if (iod->flags & IOD_META_MMIO) {
> > > > +		map = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
> > > > +		attrs |= DMA_ATTR_MMIO;
> > > > +	}
> > > 
> > > This should be an 'else if' no?
> > 
> > We can't have both IOD_META_P2P and IOD_META_MMIO. It can be only one or
> > IOD_META_P2P or IOD_META_MMIO. In this case "else if' is not necessary.
> 
> I get that and I'm not saying this is a bug, but it just looks odd.

Sorry, I didn't get the intent.

Thanks

> You're checking the conditions as if they're independent of each other
> when they're not. If the first 'if' is true, there's no need to test the
> second one as we know it's false, but this code flow will test it
> anyway.

