Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE41C5B572
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 15:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jm7PcU8Aa1TRTh8v7z0Hd1RwXA20VkWp1Jxa2fvIwWM=; b=R04gKr+BhwesFq1m/0umXscLuq
	tzJfay2+6jQMa6NQI2hH02mQe6Nae1waoqiA8l0yCaZYAA4M3UBUEEXe75wLq/50qm3iVOzDZtY+B
	wVkTgT0L+sJQWYuy/p3+tY7RDmGHloZLMzbf4Xl45j3T56Le618f9adssdDquGVYhEmNZcVCgNTPb
	vIqrYP2dvQPfNNvK7lhT/gVU/zLag5mwmwmaWr7f/J/JrxmUuauBzUPkntALOJK6pdY9JnpehuTS8
	1q60mChES4WGzWyhxk4YjlgTw2iwg+ugl9pHbZ5L/IXZVrMiXvJJaJD665AyIfMtHiq016IeokPJY
	t4HV0U3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvysq-00000006MTC-0Wle;
	Mon, 17 Aug 2026 15:04:16 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvyso-00000006MT6-0Fpn
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 15:04:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 31E40601FB;
	Mon, 17 Aug 2026 15:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C691F00A3E;
	Mon, 17 Aug 2026 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786979052;
	bh=jm7PcU8Aa1TRTh8v7z0Hd1RwXA20VkWp1Jxa2fvIwWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VQ7zjmLQEkog4fy0l/zQG1M2x9CmrCLxOMaTLPcjSOOxXJXxZYrg3ZWbcSd0TH2PA
	 FOYIe9rQM5vQ2a4y4Z0WQFL308LwfGp+KdZOjX/en57jr7K+GG9pTwUHkq+DGZqKaY
	 IFKbEOeRSi6oUSTwDgY3nljN6e7Skdr8zM+XsCSRFhjtEyoln8DA1Yl9u5F6RotcBL
	 i2BhuURMAf/Hpji64nGxPzT1JmqF/WRW7VfgMyAz2y4u2Z7AbLGsKHAXQYbiGGu9hS
	 g8XBfyK7BWvbuO2rpCvf0rHfQUmam6rwOGe7StIsjng4BAsUYyDq4o0NXbc9XqLxrT
	 m1xZdBbCNObcg==
Date: Mon, 17 Aug 2026 09:04:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Eric Auger <eauger@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, Jeff Moyer <jmoyer@redhat.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Message-ID: <aoMi6y2qsnRVembg@kbusch-mbp>
References: <20251014150456.2219261-1-kbusch@meta.com>
 <20251014150456.2219261-2-kbusch@meta.com>
 <1805eed3-90ec-4f62-9d71-e3f898a464ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1805eed3-90ec-4f62-9d71-e3f898a464ad@redhat.com>
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

On Mon, Aug 17, 2026 at 03:23:14PM +0200, Eric Auger wrote:
> >  
> > diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> > index 449950029872a..94d3461b5bc8e 100644
> > --- a/block/blk-mq-dma.c
> > +++ b/block/blk-mq-dma.c
> > @@ -79,8 +79,7 @@ static bool blk_map_iter_next(struct request *req, struct blk_map_iter *iter,
> >  static inline bool blk_can_dma_map_iova(struct request *req,
> >  		struct device *dma_dev)
> >  {
> > -	return !((queue_virt_boundary(req->q) + 1) &
> > -		dma_get_merge_boundary(dma_dev));
> > +	return !(req_phys_gap_mask(req) & dma_get_merge_boundary(dma_dev));
> 
> I observe a regression on RHEL due to that change in
> blk_can_dma_map_iova() with a 64kB host. This also occurs with upstream
> (7.2-rc7).
> 
> For an NVME device blk_can_dma_map_iova() now returns trues while it did
> not before. And it seems it shouldn't because it then causes some errors
> on the dma_iova_link() path due to unaligned iova:
> 
> [ 4486.655564] iommu: unaligned: iova 0x14c34000 pa 0x000010764d790000
> size 0x1d0000 min_pagesz 0x10000
> 
> It occurs when launching a 4kB guest with virtio-blk.
> 
> I traced:
> nvme 0015:01:00.0: req_phys_gap_mask=0xffffffffffff0000,
> queue_virt_boundary+1=0x1, get_merge_boundary=0xffff

The first thing that looks odd to me here is the page offset in the iova
isn't reflected in the pa, so I think something in the construction
isn't setting it up the first vector correctly.

Thanks for the notice, I'm looking into it.

