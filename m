Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEF7CCD185
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Oct 2025 04:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NqPtnS/BC+cTD60beV8Brq1XtCzeUnNakjg6i7dbEgE=; b=Q41OOtYRlFko+B3gr9rmA0IWpR
	v+qIW8C7rwkmiCnOtUx3QJ9GESYdEZitBJVCl97ojaK1xSyp5r96ZTEadU4BMcYaT6/rbM74b85l+
	+sN+j3YW2kt1yBq6NskKOSEPyKNpSDpXoshvQdEjCAaLogUGdFo0VQTuGik2yUGrALCRzbybdEfp4
	OkpwtigCvf9J3t1RH3hIE2zc7Sl37rj2bwvg5yK9pkGx2j52DPDMlxCOBp6Q/rGkI5b4CnQKuYO/x
	aeNFoaoHfeEzBKxjsnSz04+A+lZlWBB3ZtsMOHo43eY9XIFoyzBOrg/s0yDOEiLBhOVAXHYJRcj49
	hK93u0/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8syV-00000000PPb-2Fcw;
	Wed, 15 Oct 2025 04:18:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8syS-00000000PNv-41Wc
	for linux-nvme@lists.infradead.org;
	Wed, 15 Oct 2025 04:18:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F114227A87; Wed, 15 Oct 2025 06:18:46 +0200 (CEST)
Date: Wed, 15 Oct 2025 06:18:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@nvidia.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/4] block-dma: properly take MMIO path
Message-ID: <20251015041846.GB7073@lst.de>
References: <cover.1760369219.git.leon@kernel.org> <cf4f6dfee380351e68932d4d114422364097dda5.1760369219.git.leon@kernel.org> <aO1MfsuWeteOsBve@kbusch-mbp> <20251013192940.GC14552@unreal> <aO1URj3B3IUHX4Ge@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO1URj3B3IUHX4Ge@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251014_211853_149490_5FE5B58E 
X-CRM114-Status: GOOD (  25.61  )
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

On Mon, Oct 13, 2025 at 01:34:30PM -0600, Keith Busch wrote:
> On Mon, Oct 13, 2025 at 10:29:40PM +0300, Leon Romanovsky wrote:
> > On Mon, Oct 13, 2025 at 01:01:18PM -0600, Keith Busch wrote:
> > > On Mon, Oct 13, 2025 at 06:34:11PM +0300, Leon Romanovsky wrote:
> > > >  static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
> > > >  		struct blk_dma_iter *iter, struct phys_vec *vec)
> > > >  {
> > > > +	unsigned int attrs = 0;
> > > > +
> > > > +	if (req->cmd_flags & REQ_MMIO)
> > > > +		attrs |= DMA_ATTR_MMIO;
> > > 
> > > Since data and integrity paylods use these same functions and may point
> > > to different kinds of memory, I think you'd have to pass the 'attrs'
> > > from the caller since it knows which flags to check for MMIO dma.
> > 
> > I think that hunk will fix it.
> > 
> > diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> > index 38f5c34ca223..8af88ba97c7a 100644
> > --- a/block/blk-mq-dma.c
> > +++ b/block/blk-mq-dma.c
> > @@ -88,9 +88,11 @@ static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
> >  static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
> >                 struct blk_dma_iter *iter, struct phys_vec *vec)
> >  {
> > +       struct bio_integrity_payload *bip = bio_integrity(req->bio);
> >         unsigned int attrs = 0;
> > 
> > -       if (req->cmd_flags & REQ_MMIO)
> > +       if ((!bip && req->cmd_flags & REQ_MMIO) ||
> > +           bio_integrity_flagged(req->bio, BIP_MMIO))
> >                 attrs |= DMA_ATTR_MMIO;
> 
> If cmd_flags has REQ_MMIO set, but the integrity flag doesn't have
> BIP_MMIO set, you will skip setting DMA_ATTR_MMIO, but I think we need
> that set when this is called for the data payload.

Yes, we just need to check the relevant flag in the caller
and pass it in.  Or maybe just stash it in  struct blk_dma_iter.

