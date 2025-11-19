Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094ABCF3187
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Nov 2025 09:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N3St2NZBhXRGn9n9RacTN/Cn2H10NSydjlI4KDiDHIA=; b=pwS92fNGt+BUptBDfPJJ1U/YyG
	1KdSqddQGHPNY66k+PRsvQeoUVSNt44Y6cxvU5edoW+jhqXmSlbx9Tu15rS+/kaqDEtb7g1irSTlX
	yhgwmD8iCFmojnUWU1a3MO+eDxU6WJQPZ3LnfOBDPq0ZjwS10p//4L53n9/jKcz+v6Q3oaqY1ShID
	gfpBG9CZUMgA1pT4lf9cZjiNKOzVIADusYrkMsXJtbDHTWgr6tBuJ884tnJaYzjowxNgjes4Xh/2z
	vyt2Gkz0oZ790hTTHuPkqEXhvC+9mUulyIq56Aux7Mb2XCp8VCbtTFY1AM4LY9qYgJEOUY61d4apC
	+uceiotw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLeuK-00000002uKd-2x4T;
	Wed, 19 Nov 2025 09:55:24 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLeuJ-00000002uKH-304r
	for linux-nvme@lists.infradead.org;
	Wed, 19 Nov 2025 09:55:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D584B60123;
	Wed, 19 Nov 2025 09:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9E4C2BCB8;
	Wed, 19 Nov 2025 09:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546122;
	bh=mrVGDGmdBwi9bp1Ejm5GWoCivDI1+7VKZSTga3B+PrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=alOJWxNcB+IkVtIDy2pVEUyd3HFS7OmaPY1pgPwYQvu0rHyh4x9n+9brKyMNnQv/v
	 Qq/pe+VC1Nn/fpd6n+LbqNwfMRfVwcZyFTRG9+u0KDEVY3w/5Nv8tE9d3P22QKl/hD
	 ztmwVEfvJ0g6Z2VTO63PE09RkTkimEuutWrCDWxFDze1ym4BLGuNL9hxxXIht6x24v
	 CYHHKFl99vhFfpGb9egB0srcRsR/HhSNEixF0MUs7KHQ+lo8AjkCSqBApb9DMnEPwH
	 M8L5MtlUI6wysxhIXBD2Z4QIm/rkq6+k+Vo8w9R9p7oCQKVHOUgpNF1oEmeNXonWg1
	 E0y9b6mcngrEQ==
Date: Wed, 19 Nov 2025 11:55:16 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251119095516.GA13783@unreal>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
 <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
 <20251118050311.GA21569@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118050311.GA21569@lst.de>
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

On Tue, Nov 18, 2025 at 06:03:11AM +0100, Christoph Hellwig wrote:
> On Mon, Nov 17, 2025 at 09:22:43PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > This patch changes the length variables from unsigned int to size_t.
> > Using size_t ensures that we can handle larger sizes, as size_t is
> > always equal to or larger than the previously used u32 type.
> > 
> > Originally, u32 was used because blk-mq-dma code evolved from
> > scatter-gather implementation, which uses unsigned int to describe length.
> > This change will also allow us to reuse the existing struct phys_vec in places
> > that don't need scatter-gather.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > ---
> >  block/blk-mq-dma.c      | 8 ++++++--
> >  drivers/nvme/host/pci.c | 4 ++--
> >  2 files changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> > index e9108ccaf4b0..e7d9b54c3eed 100644
> > --- a/block/blk-mq-dma.c
> > +++ b/block/blk-mq-dma.c
> > @@ -8,7 +8,7 @@
> >  
> >  struct phys_vec {
> >  	phys_addr_t	paddr;
> > -	u32		len;
> > +	size_t		len;
> >  };
> 
> So we're now going to increase memory usage by 50% again after just
> reducing it by removing the scatterlist?

It is slightly less.

Before this change: 96 bits
After this change (on 64bits system): 128 bits.

It is 33% increase per-structure.

So what is the resolution? Should I drop this patch or not?

Thanks 

