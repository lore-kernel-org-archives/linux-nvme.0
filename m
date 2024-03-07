Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93565C54E49
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 16:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/jdV7csUtehkz2FX/YWevH16MzaUoUrWyyKnKk0ao5o=; b=bXhcnYLt7pQriNKFRhVkZz32C6
	2r0waINHF8fkpsl1Q3MLTGTxaaBF7r9ZFBFEb6x5nIU3vjZ1pnAceQcu3cGXvPmxWpHx5VKwut043
	DCnHE8g9rqEpNB+NCCwqUPSaXbpCQFImDJ2C2gDhlX65OTabWXv1gSL5pnzNpXWl0pIBPFLoUphWJ
	ZAoAacvBY8edWGBUzCu2Igz/pHb0JThwkm241oRxQcqwJlXBKj8i1ZrslW6nAa89HBwb0URtHFKLP
	yg5HJL2bKBIRPbhD9aYSL8r0PhXZsufBBew8T/EuT31GGZu4+XGaIv5d6ENbLFFNdJT6buNrt4d2q
	+NPyvFFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riGJE-00000005QDx-1Yt9;
	Thu, 07 Mar 2024 16:09:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFJ2-00000005BjQ-0euv
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 15:05:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6CF2168CFE; Thu,  7 Mar 2024 16:05:05 +0100 (CET)
Date: Thu, 7 Mar 2024 16:05:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two
 steps
Message-ID: <20240307150505.GA28978@lst.de>
References: <cover.1709635535.git.leon@kernel.org> <47afacda-3023-4eb7-b227-5f725c3187c2@arm.com> <20240305122935.GB36868@unreal> <20240306144416.GB19711@lst.de> <20240306154328.GM9225@ziepe.ca> <20240306162022.GB28427@lst.de> <20240306174456.GO9225@ziepe.ca> <20240306221400.GA8663@lst.de> <20240307000036.GP9225@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307000036.GP9225@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_070512_516660_BB74CD51 
X-CRM114-Status: GOOD (  46.91  )
X-Mailman-Approved-At: Thu, 07 Mar 2024 08:09:15 -0800
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

On Wed, Mar 06, 2024 at 08:00:36PM -0400, Jason Gunthorpe wrote:
> > 
> > I don't think you can do without dma_addr_t storage.  In most cases
> > your can just store the dma_addr_t in the LE/BE encoded hardware
> > SGL, so no extra storage should be needed though.
> 
> RDMA (and often DRM too) generally doesn't work like that, the driver
> copies the page table into the device and then the only reason to have
> a dma_addr_t storage is to pass that to the dma unmap API. Optionally
> eliminating long term dma_addr_t storage would be a worthwhile memory
> savings for large long lived user space memory registrations.

It's just kinda hard to do.  For aligned IOMMU mapping you'd only
have one dma_addr_t mappings (or maybe a few if P2P regions are
involved), so this probably doesn't matter.  For direct mappings
you'd have a few, but maybe the better answer is to use THP
more aggressively and reduce the number of segments.

> I wrote the list as from a single IO operation perspective, so all but
> 5 need to store a single IOVA range that could be stored in some
> simple non-dynamic memory along with whatever HW SGLs/etc are needed.
> 
> The point of 5 being different is because the driver has to provide a
> dynamically sized list of dma_addr_t's as storage until unmap. 5 is
> the only case that requires that full list.

No, all cases need to store one or more ranges.

> > > So are you thinking something more like a driver flow of:
> > > 
> > >   .. extent IO and get # aligned pages and know if there is P2P ..
> > >   dma_init_io(state, num_pages, p2p_flag)
> > >   if (dma_io_single_range(state)) {
> > >        // #2, #4
> > >        for each io()
> > > 	    dma_link_aligned_pages(state, io range)
> > >        hw_sgl = (state->iova, state->len)
> > >   } else {
> > 
> > I think what you have a dma_io_single_range should become before
> > the dma_init_io.  If we know we can't coalesce it really just is a
> > dma_map_{single,page,bvec} loop, no need for any extra state.
> 
> I imagine dma_io_single_range() to just check a flag in state.
> 
> I still want to call dma_init_io() for the non-coalescing cases
> because all the flows, regardless of composition, should be about as
> fast as dma_map_sg is today.

If all flows includes multiple non-coalesced regions that just makes
things very complicated, and that's exactly what I'd want to avoid.

> That means we need to always pre-allocate the IOVA in any case where
> the IOMMU might be active - even on a non-coalescing flow.
> 
> IOW, dma_init_io() always pre-allocates IOVA if the iommu is going to
> be used and we can't just call today's dma_map_page() in a loop on the
> non-coalescing side and pay the overhead of Nx IOVA allocations.
> 
> In large part this is for RDMA, were a single P2P page in a large
> multi-gigabyte user memory registration shouldn't drastically harm the
> registration performance by falling down to doing dma_map_page, and an
> IOVA allocation, on a 4k page by page basis.

But that P2P page needs to be handled very differently, as with it
we can't actually use a single iova range.  So I'm not sure how that
is even supposed to work.  If you have

 +-------+-----+-------+
 | local | P2P | local |
 +-------+-----+-------+

you need at least 3 hw SGL entries, as the IOVA won't be contigous.

> The other thing that got hand waved here is how does dma_init_io()
> know which of the 6 states we are looking at? I imagine we probably
> want to do something like:
> 
>    struct dma_io_summarize summary = {};
>    for each io()
>         dma_io_summarize_range(&summary, io range)
>    dma_init_io(dev, &state, &summary);
>    if (state->single_range) {
>    } else {
>    }
>    dma_io_done_mapping(&state); <-- flush IOTLB once

That's why I really just want 2 cases.  If the caller guarantees the
range is coalescable and there is an IOMMU use the iommu-API like
API, else just iter over map_single/page.

> Enhancing the single sgl case is not a big change, I think. It does
> seem simplifying for the driver to not have to coalesce SGLs to detect
> the single-SGL fast-path.
> 
> > > This is not quite what you said, we split the driver flow based on
> > > needing 1 HW SGL vs need many HW SGL.
> > 
> > That's at least what I intended to say, and I'm a little curious as what
> > it came across.
> 
> Ok, I was reading the discussion more about as alignment than single
> HW SGL, I think you ment alignment as implying coalescing behavior
> implying single HW SGL..

Yes.

