Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1296CEBF8A
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Nov 2025 07:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hlt5/jXiIC3xQs4PP4j0F6mWifY0na7e+hGBM/O2bO4=; b=jr9CbCyBh0iFIjzlqyxZGzuw5N
	2/xCR1LzuRxXnYGfPoc6aq1mzdKvrzzM2vb4a2I6fouegydGWTiVr1T8IAHBpIUfGqtMrjCQ3t7Sx
	Z5+wq/pM2sjkVp18xS6PVDLhEdn825p0b21aHtWoVyhpH35h7k8/j+lUPKse+hlufW/pq/HsuPwdV
	c1WXsAGM6dHRkZHvw/2XDY8DPwiWwyizvKZowEYlftaegRS8E6eFGSHjoO9wfiBrwRgqY8DqSPE46
	9ZoEvjMzHiNyacTAuGn+jumJW9mgE1BV8jlp/t1p4FzDgd+FWxDcaExWZojWCELinN0TKOtMTKlec
	lVPtfKGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKWyW-0000000EQzU-0bu7;
	Sun, 16 Nov 2025 07:15:04 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKWyS-0000000EQyl-3VbZ
	for linux-nvme@lists.infradead.org;
	Sun, 16 Nov 2025 07:15:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F278542A01;
	Sun, 16 Nov 2025 07:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65167C113D0;
	Sun, 16 Nov 2025 07:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763277299;
	bh=ZwafYmBH3NbvO+pGxsGEYLBD8i7TIkJQ2P+Z2BySlH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ja9E8EMjT6t6my/i/tmmduWO7YNutYJReSOubODzhOpk2I1XM78V0yytr6D0CpWRL
	 qN3ZGnmTcn2HzJ711XnpASL4Gbw1K5mA1YwVG2qfxrpkDLz0Jg10HU4tH94RNSg4Ht
	 p/mL6aGNTpdQVriRJM5FfkvV/WVNWmTY3SmAck49nIB8irHCYJAm4sEk2aLN6sx8pr
	 n3iZYMy47JY4MAdVAVYAdfW/lL2a16fzV4vjZDUBALEJgHfl2IkcU5WUK8VjRxMtRS
	 zaYbKpJeIisf++IeDLr4X1OL3EAP1rgv/g9ShSEsrwZID0DTgcsi9BWLVXzcvoGsda
	 tne3XDB+uH77A==
Date: Sun, 16 Nov 2025 09:14:54 +0200
From: Leon Romanovsky <leon@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251116071454.GD147495@unreal>
References: <20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org>
 <20251115-nvme-phys-types-v1-1-c0f2e5e9163d@kernel.org>
 <20251115173341.4a59c97f@pumpkin>
 <20251115180547.GC147495@unreal>
 <20251115222850.183b8557@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115222850.183b8557@pumpkin>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251115_231502_071971_A83DE32D 
X-CRM114-Status: GOOD (  55.55  )
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

On Sat, Nov 15, 2025 at 10:28:50PM +0000, David Laight wrote:
> On Sat, 15 Nov 2025 20:05:47 +0200
> Leon Romanovsky <leon@kernel.org> wrote:
> 
> > On Sat, Nov 15, 2025 at 05:33:41PM +0000, David Laight wrote:
> > > On Sat, 15 Nov 2025 18:22:45 +0200
> > > Leon Romanovsky <leon@kernel.org> wrote:
> > >   
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > 
> > > > This patch changes the length variables from unsigned int to size_t.
> > > > Using size_t ensures that we can handle larger sizes, as size_t is
> > > > always equal to or larger than the previously used u32 type.  
> > > 
> > > Where are requests larger than 4GB going to come from?  
> > 
> > The main goal is to reuse phys_vec structure. It is going to represent PCI
> > regions exposed through VFIO DMABUF interface. Their length is more than u32.
> 
> Unless you actually need to have the same structure (because some function
> is used in both places) there isn't really any need to have a single structure
> for a a phy_addr:length pair.

Actually, we do plan to use them. In RDMA and probably in DMA API also,
as I was suggested to provide general DMA map function, which will
perform mapping for array of phys_vecs.

> Indeed keeping them separate can even remove bugs.

Or introduce, it depends on the situation.

> 
> For instance (I think) blk_map_iter_next() returns an addr:len pair
> that is only only used for the following sg_set_page() call - which
> has separate parameters for phys_to_page(addr) and len.

It is temporary, because we needed to use old SG interface. At some
point of time (after we will finish discussion/implementation of VFIO
and DMABUF), the blk_rq_map_*_sg() routines that are used for RDMA will 
be changed to do not use SG at all.

> So unless there are other place it is used it doesn't need to be
> the same structure at all.
> (Other people might disagree...)

Yes, VFIO, DMABUF and RDMA are other places, so it is better to move
that struct phys_vec to general place now, so in next cycle we will
be able to reuse it.

> 
> > 
> > >   
> > > > Originally, u32 was used because blk-mq-dma code evolved from
> > > > scatter-gather implementation, which uses unsigned int to describe length.
> > > > This change will also allow us to reuse the existing struct phys_vec in places
> > > > that don't need scatter-gather.
> > > > 
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > ---
> > > >  block/blk-mq-dma.c      | 14 +++++++++-----
> > > >  drivers/nvme/host/pci.c |  4 ++--
> > > >  2 files changed, 11 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> > > > index e9108ccaf4b0..cc3e2548cc30 100644
> > > > --- a/block/blk-mq-dma.c
> > > > +++ b/block/blk-mq-dma.c
> > > > @@ -8,7 +8,7 @@
> > > >  
> > > >  struct phys_vec {
> > > >  	phys_addr_t	paddr;
> > > > -	u32		len;
> > > > +	size_t		len;
> > > >  };
> > > >  
> > > >  static bool __blk_map_iter_next(struct blk_map_iter *iter)
> > > > @@ -112,8 +112,8 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
> > > >  		struct phys_vec *vec)
> > > >  {
> > > >  	enum dma_data_direction dir = rq_dma_dir(req);
> > > > -	unsigned int mapped = 0;
> > > >  	unsigned int attrs = 0;
> > > > +	size_t mapped = 0;
> > > >  	int error;
> > > >  
> > > >  	iter->addr = state->addr;
> > > > @@ -296,8 +296,10 @@ int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
> > > >  	blk_rq_map_iter_init(rq, &iter);
> > > >  	while (blk_map_iter_next(rq, &iter, &vec)) {
> > > >  		*last_sg = blk_next_sg(last_sg, sglist);
> > > > -		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
> > > > -				offset_in_page(vec.paddr));
> > > > +
> > > > +		WARN_ON_ONCE(overflows_type(vec.len, unsigned int));  
> > > 
> > > I'm not at all sure you need that test.
> > > blk_map_iter_next() has to guarantee that vec.len is valid.
> > > (probably even less than a page size?)
> > > Perhaps this code should be using a different type for the addr:len pair?  
> > 
> > I added this test for future proof, this is why it doesn't "return" on
> > overflow, but prints dump stack and continues. It can't happen.
> 
> No, on a large number of installed systems it prints the stack an panicks.

It will print such stack if vec.len is more than u32, which is not
supposed to be. 

> Were it to continue the effect would be all wrong anyway.
> But blk_map_iter_next() guarantees to return a sane length.

It is not guarantee. If I understand it correctly, the guarantee comes
from upper layer which limits request size because of SG limitations.

> 
> > 
> > >   
> > > > +		sg_set_page(*last_sg, phys_to_page(vec.paddr),
> > > > +			    (unsigned int)vec.len, offset_in_page(vec.paddr));  
> > > 
> > > You definitely don't need the explicit cast.  
> > 
> > We degrade type from u64 to u32. Why don't we need cast?
> 
> Because you don't need to cast pretty much all integer conversions.
> Any warnings compilers might output for such assignments really are best
> disabled.
> The more casts you add to code to remove 'silly' compiler warnings the
> harder it is to find the ones that actually have a desired effect and/or
> unwanted effects that are actually bugs.
> 
> I'm busy trying to fix a load of min_t(u32, a, b) which mask off high
> significant bits from u64 values.
> The casts got added (implicitly by using min_t() instead of min()) because
> min() required the types match - and in a lot of cases the programmer
> picked the type of the result not that of the larger parameter.
> Others are just cut&paste of another line.
> But the effect is the same, the casts add bugs rather than making the
> code better.
> 
> I've even seen:
> 	uchar_buf[0] = (unsigned char)(int_val & 0xff);
> (Presumably written to avoid compiler warnings.)
> and looked at the object code to find the compiler (not gcc) anded the
> value with 0xff for the '& 0xff', anded it with 0xff again for the cast
> and then did a memory write of the low bits.
> 
> casts could easily be the next 'bug'...

I have no such strong feelings about cast here and can remove it.

Thanks

> 
> 	David
> 
> > 
> > Thanks
> 

