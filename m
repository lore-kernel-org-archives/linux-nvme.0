Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE79CEB2EE
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Nov 2025 18:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t09AVASPF1DDcKvjot4mSuOzxPKTmHC9Kpf2W46kTcg=; b=PR9WPkuTaxbv7Wbf0HEattvuV1
	+XslNUYlNDwnnvRCXaHwKF0eiCGCz72N3aIGqUP5sIK5aA5CHJM/sPaksxa98cYaHGD4Fi/zIpkS5
	PshaGnLr+v/p/lmN01gWu6s2mRrOk9ZyqWk1SaEBo5oCS4NhTbFXz3yjBK1PAfczc3xjQVtuGiTxv
	C1gykXGr6EiUhoDCn2S0Af+nD8zA4OtcD4IettLqTgxyFBIsZS9aabiOhWkv/I1ZjhDYsUUayHfLb
	8N0Wy7rjpdApHIPR1oEEkWu8kCXZUEzfpkwk7uyzwT5xkYT/t4KRLqiCiOW/cC5pm2pSkmCqygjvj
	SBbRn6xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKKeo-0000000DyYq-279j;
	Sat, 15 Nov 2025 18:05:54 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKKen-0000000DyYf-2GuE
	for linux-nvme@lists.infradead.org;
	Sat, 15 Nov 2025 18:05:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9291B60179;
	Sat, 15 Nov 2025 18:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4263C4CEF5;
	Sat, 15 Nov 2025 18:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763229952;
	bh=wvUeJI+DQ6+5SXIRBrGQ2XvF6W1kb5RLVw8OzwUxO2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnAsuQdZQfdOUNV6MATOCoxHSrFYsX/MdUFL323mV8HqIbd81xoVr3bdvJ9HPebH5
	 oSq7BQJfVu+IrWONB0rgCtP1kBJxSoZA7AZDWY8MO1g7Y9Db0ynAFK5teKdlyJLiKk
	 UMaVWoKFq03YtsKj7N4HPlpWfR2BBGWa/I9smxKJpF6BS9Qastb7uCIMf+feT2E4TT
	 wvo+VJroVt9iiU3fENZveCa6i7CT/gJEeHAnMPRFQaiXUEeNmc5cTneDzwTpeyWnS8
	 UrdvVTl5MMOTiHdcZLlYKD24Z74zwq5oXSLgxS/2j4NQqzxTtQZ6lf3xgIgazSAAXj
	 kHXzLEUW5S9oQ==
Date: Sat, 15 Nov 2025 20:05:47 +0200
From: Leon Romanovsky <leon@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251115180547.GC147495@unreal>
References: <20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org>
 <20251115-nvme-phys-types-v1-1-c0f2e5e9163d@kernel.org>
 <20251115173341.4a59c97f@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115173341.4a59c97f@pumpkin>
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

On Sat, Nov 15, 2025 at 05:33:41PM +0000, David Laight wrote:
> On Sat, 15 Nov 2025 18:22:45 +0200
> Leon Romanovsky <leon@kernel.org> wrote:
> 
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > This patch changes the length variables from unsigned int to size_t.
> > Using size_t ensures that we can handle larger sizes, as size_t is
> > always equal to or larger than the previously used u32 type.
> 
> Where are requests larger than 4GB going to come from?

The main goal is to reuse phys_vec structure. It is going to represent PCI
regions exposed through VFIO DMABUF interface. Their length is more than u32.

> 
> > Originally, u32 was used because blk-mq-dma code evolved from
> > scatter-gather implementation, which uses unsigned int to describe length.
> > This change will also allow us to reuse the existing struct phys_vec in places
> > that don't need scatter-gather.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  block/blk-mq-dma.c      | 14 +++++++++-----
> >  drivers/nvme/host/pci.c |  4 ++--
> >  2 files changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> > index e9108ccaf4b0..cc3e2548cc30 100644
> > --- a/block/blk-mq-dma.c
> > +++ b/block/blk-mq-dma.c
> > @@ -8,7 +8,7 @@
> >  
> >  struct phys_vec {
> >  	phys_addr_t	paddr;
> > -	u32		len;
> > +	size_t		len;
> >  };
> >  
> >  static bool __blk_map_iter_next(struct blk_map_iter *iter)
> > @@ -112,8 +112,8 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
> >  		struct phys_vec *vec)
> >  {
> >  	enum dma_data_direction dir = rq_dma_dir(req);
> > -	unsigned int mapped = 0;
> >  	unsigned int attrs = 0;
> > +	size_t mapped = 0;
> >  	int error;
> >  
> >  	iter->addr = state->addr;
> > @@ -296,8 +296,10 @@ int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
> >  	blk_rq_map_iter_init(rq, &iter);
> >  	while (blk_map_iter_next(rq, &iter, &vec)) {
> >  		*last_sg = blk_next_sg(last_sg, sglist);
> > -		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
> > -				offset_in_page(vec.paddr));
> > +
> > +		WARN_ON_ONCE(overflows_type(vec.len, unsigned int));
> 
> I'm not at all sure you need that test.
> blk_map_iter_next() has to guarantee that vec.len is valid.
> (probably even less than a page size?)
> Perhaps this code should be using a different type for the addr:len pair?

I added this test for future proof, this is why it doesn't "return" on
overflow, but prints dump stack and continues. It can't happen.

> 
> > +		sg_set_page(*last_sg, phys_to_page(vec.paddr),
> > +			    (unsigned int)vec.len, offset_in_page(vec.paddr));
> 
> You definitely don't need the explicit cast.

We degrade type from u64 to u32. Why don't we need cast?

Thanks

