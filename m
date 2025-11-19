Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0286BCF34B0
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Nov 2025 13:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d7KZd2LInMDyIh6RIrHI6zc2/afrtFcaNk86Ecz0fRo=; b=PeZq+NWLkDRLMhH1ugkA4tLZEk
	Ke+ZziTJXLQuVgkmrMhWrosD2K6cWZOmLouM6RsBg2fmAeZ0rncpVH0m4l2aeAZPGwYPGJJHeaLGW
	0pSNZ8hTQ0bbsa7PG5Gy+wOdixatwcngM4AT6DjsFeaLbHSbiSTeXQGNno7LOwKMKYCPmuMIF6eOq
	fp+Hr046IZFEU18dV1hRhrA44izNxzETYWUFbka2+W+yBXdbHQKUBTAQNNdcgfnj9YPcl6MCCco22
	R4qElC+39LKJcilYgaSD4n2SOV81AhDHtf1FfvTCsKjB44RmIWoM3ASRTQz2RJOMqgSro/7Od/y+E
	smPL4YkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLihZ-00000003KWi-1TJT;
	Wed, 19 Nov 2025 13:58:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLihY-00000003KW9-0QLl
	for linux-nvme@lists.infradead.org;
	Wed, 19 Nov 2025 13:58:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1BFB760169;
	Wed, 19 Nov 2025 13:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBB3C4AF09;
	Wed, 19 Nov 2025 13:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763560706;
	bh=ZJMRoWNDVSvg2ELqZhSj0MYsT3uXuatCNruN91d8KZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0QZ0z4oFik1hKykUihU+68Oxa7XG5dwGBEBOE5chOgV1H/fpsbuaC0N7RwZ3uBJZ
	 6NQ/WK7++1X6MR8ZwBmjFrUZ1+e8moGP93HumNh60hRzzeVsvehwPRG1JOzurCyUqF
	 JMxMPatoCFYQJnHDG7YT/fKkHeNMgJllhvvDo0QGe2AWKiLSUhPNxrSo5kDlUX6NrJ
	 g+haK8MtFmhG1fWvX+CzqmU+xIXaJCrCePu711PqeLqldbmpdLi2XsPdP4TxzVOY3N
	 byeJxedETGMzbIbqhjRkhPqEox+eM8c8ohR4StaJhQlB7Sfs77/T/KdEuvs2efNgDI
	 iph0OqcZnXflg==
Date: Wed, 19 Nov 2025 15:58:21 +0200
From: Leon Romanovsky <leon@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251119135821.GH18335@unreal>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
 <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
 <20251118050311.GA21569@lst.de>
 <20251119095516.GA13783@unreal>
 <20251119133615.2eefb7db@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119133615.2eefb7db@pumpkin>
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

On Wed, Nov 19, 2025 at 01:36:15PM +0000, David Laight wrote:
> On Wed, 19 Nov 2025 11:55:16 +0200
> Leon Romanovsky <leon@kernel.org> wrote:
> 
> > On Tue, Nov 18, 2025 at 06:03:11AM +0100, Christoph Hellwig wrote:
> > > On Mon, Nov 17, 2025 at 09:22:43PM +0200, Leon Romanovsky wrote:  
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > 
> > > > This patch changes the length variables from unsigned int to size_t.
> > > > Using size_t ensures that we can handle larger sizes, as size_t is
> > > > always equal to or larger than the previously used u32 type.
> > > > 
> > > > Originally, u32 was used because blk-mq-dma code evolved from
> > > > scatter-gather implementation, which uses unsigned int to describe length.
> > > > This change will also allow us to reuse the existing struct phys_vec in places
> > > > that don't need scatter-gather.
> > > > 
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > > ---
> > > >  block/blk-mq-dma.c      | 8 ++++++--
> > > >  drivers/nvme/host/pci.c | 4 ++--
> > > >  2 files changed, 8 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> > > > index e9108ccaf4b0..e7d9b54c3eed 100644
> > > > --- a/block/blk-mq-dma.c
> > > > +++ b/block/blk-mq-dma.c
> > > > @@ -8,7 +8,7 @@
> > > >  
> > > >  struct phys_vec {
> > > >  	phys_addr_t	paddr;
> > > > -	u32		len;
> > > > +	size_t		len;
> > > >  };  
> > > 
> > > So we're now going to increase memory usage by 50% again after just
> > > reducing it by removing the scatterlist?  
> > 
> > It is slightly less.
> > 
> > Before this change: 96 bits
> 
> Did you actually look?

No, I simply performed sizeof(phys_addr_t) + sizeof(size_t).

> There will normally be 4 bytes of padding at the end of the structure.
> 
> About the only place where it will be 12 bytes is a 32bit system with
> 64bit phyaddr that aligns 64bit items on 32bit boundaries - so x86.

So does it mean that Christoph's comment about size increase is not correct?

Thanks

> 
> 	David
> 
> > After this change (on 64bits system): 128 bits.
> > 
> > It is 33% increase per-structure.
> > 
> > So what is the resolution? Should I drop this patch or not?
> > 
> > Thanks 
> > 
> 

