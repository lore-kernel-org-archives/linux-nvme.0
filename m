Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03B9C54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 23:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B2cqZbDJobgrAlQUN+X6Gc/N/G77Yt6hRBbHc0B6Byw=; b=MPD9M2+4W+5/Je3hJxNXF/PWcJ
	1D57ZoTmd0Gh2x8ps4msJ1rRRs3lpcWRnkUkKi/A7cOTLZhzMAuqyg2zN5+VIhzZ54Hter/ScU/tz
	3JLUeLAYT/9qq97F/gSimtMu/NMvZSwEE9ALj7FPq8UmbCCsh6Uhdo8p5nQNWdB1crswisRPYj/FR
	POxGQpIl7hlAm3tSUTyPJxq9XcrvUVfVQnxyaMx+pwlzVkq7kVD7vvC06+U/r8m8sM6Zvp7Oh3Ww2
	/bbMCef/RY7LEcDq/Rt5azvWToJsLyHN8hbkUJIdpRTiDLXkjqr+IFFhUMHv/lLgeqTjmYOXzguV4
	xhscFMrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riMv7-00000006llr-0M57;
	Thu, 07 Mar 2024 23:13:01 +0000
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riKrh-00000006N9R-3aIr
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 21:01:23 +0000
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-22002fbbd6bso632831fac.3
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 13:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709845280; x=1710450080; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B2cqZbDJobgrAlQUN+X6Gc/N/G77Yt6hRBbHc0B6Byw=;
        b=XiBc7/TvdUqqTbF0iw3XsCGh3YaDD0I/tkbgWbfUiREIQsEjvCpHqhZDEJsXn3zb3M
         veAhA9i6tE23V6hxvl+QpBjUh7pJEgJwhjyim4EGbU0bFnwSRWH1pn6oeZcxVhIQ3jdk
         RJ0+FgxoreKHeC/hJHUldFzp693McuX2IQUnBsESUnzRnIokFL7OXoxWg5K4ux1IG2ee
         fcEtaD8XVy2XQ9lUHQwa3aXEsEOrCCiI1cAU5nLJ4BYrHm5x3LPpnf57QZp5gz+Jc+ml
         NE2CBb5kqqxz/wG+/xSekGA1sQ7rqaMN3t5+/i9r0LhiA+DKM5yw7JfffffBCP8JG5Ly
         6Brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709845280; x=1710450080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2cqZbDJobgrAlQUN+X6Gc/N/G77Yt6hRBbHc0B6Byw=;
        b=UPnQQdecjWM+JjhqDfr0wu4mLRHx/2pKw/Z0khrPX7l+XonMZ+JF0H9rI5DdhiqCau
         0WowSRZ7E0SWnPus3mXQw9hhEj8gXOIRvTnp03Jfsr/LA6eOVbyIUTLU5d+o0QgjfbQn
         WpN7JTeU458FQ5PUd8ptKdcaf2VJudIATO2jV4iIMi2XaoP/2badYuiUSr9aYCSS3N9Z
         TjaJ7GcWVOPXhID7pu+w5/Z2CacLE3LuVQxezqCVKi6baT4mcAl6oBgfoylz8Rab1zWy
         EwrA6hvQPLxqr8SVsMIhJM6VFA/HkAqG08xR89qvjFgfQ87VmbtGS1MFEW8/JS9jSJyS
         esMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0mAx5QuSZ9k9V56/TzzKY4Zr69tt3ZPzhRuWnhQsYpenfjeKne8iwy9jfNXXQsQAMaSNiNV3nJtlwBsSF+CaKZUPaoVGYpLhQTOjWAeU=
X-Gm-Message-State: AOJu0Yydfc59fCXTqCw9Hh4zhLUy64E71wYcz0Rc9CZAslRIHKxLySbw
	y30ufI+XI51esulsiXoL5W1QBD0aJeN1LucTuO3qvWyLl7THG/Qu8+u3haU7KaA=
X-Google-Smtp-Source: AGHT+IHVDDnrRb4IzGsRrjreYb2lzNqXBjfY5dZE5DynfGK6hFbMLsAKifeob/DJ0ED9qSx2chYugA==
X-Received: by 2002:a05:6870:8a06:b0:21e:a40e:7465 with SMTP id p6-20020a0568708a0600b0021ea40e7465mr1134062oaq.24.1709845279574;
        Thu, 07 Mar 2024 13:01:19 -0800 (PST)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id mt9-20020a0568706b0900b00220b0891304sm3660721oab.1.2024.03.07.13.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 13:01:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1riKrc-004Zwv-Aq;
	Thu, 07 Mar 2024 17:01:16 -0400
Date: Thu, 7 Mar 2024 17:01:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
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
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
Message-ID: <20240307210116.GQ9225@ziepe.ca>
References: <cover.1709635535.git.leon@kernel.org>
 <47afacda-3023-4eb7-b227-5f725c3187c2@arm.com>
 <20240305122935.GB36868@unreal>
 <20240306144416.GB19711@lst.de>
 <20240306154328.GM9225@ziepe.ca>
 <20240306162022.GB28427@lst.de>
 <20240306174456.GO9225@ziepe.ca>
 <20240306221400.GA8663@lst.de>
 <20240307000036.GP9225@ziepe.ca>
 <20240307150505.GA28978@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307150505.GA28978@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_130122_015043_EE554A77 
X-CRM114-Status: GOOD (  57.93  )
X-Mailman-Approved-At: Thu, 07 Mar 2024 15:12:59 -0800
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

On Thu, Mar 07, 2024 at 04:05:05PM +0100, Christoph Hellwig wrote:
> On Wed, Mar 06, 2024 at 08:00:36PM -0400, Jason Gunthorpe wrote:
> > > 
> > > I don't think you can do without dma_addr_t storage.  In most cases
> > > your can just store the dma_addr_t in the LE/BE encoded hardware
> > > SGL, so no extra storage should be needed though.
> > 
> > RDMA (and often DRM too) generally doesn't work like that, the driver
> > copies the page table into the device and then the only reason to have
> > a dma_addr_t storage is to pass that to the dma unmap API. Optionally
> > eliminating long term dma_addr_t storage would be a worthwhile memory
> > savings for large long lived user space memory registrations.
> 
> It's just kinda hard to do.  For aligned IOMMU mapping you'd only
> have one dma_addr_t mappings (or maybe a few if P2P regions are
> involved), so this probably doesn't matter.  For direct mappings
> you'd have a few, but maybe the better answer is to use THP
> more aggressively and reduce the number of segments.

Right, those things have all been done. 100GB of huge pages is still
using a fair amount of memory for storing dma_addr_t's.

It is hard to do perfectly, but I think it is not so bad if we focus
on the direct only case and simple systems that can exclude swiotlb
early on.

> > > > So are you thinking something more like a driver flow of:
> > > > 
> > > >   .. extent IO and get # aligned pages and know if there is P2P ..
> > > >   dma_init_io(state, num_pages, p2p_flag)
> > > >   if (dma_io_single_range(state)) {
> > > >        // #2, #4
> > > >        for each io()
> > > > 	    dma_link_aligned_pages(state, io range)
> > > >        hw_sgl = (state->iova, state->len)
> > > >   } else {
> > > 
> > > I think what you have a dma_io_single_range should become before
> > > the dma_init_io.  If we know we can't coalesce it really just is a
> > > dma_map_{single,page,bvec} loop, no need for any extra state.
> > 
> > I imagine dma_io_single_range() to just check a flag in state.
> > 
> > I still want to call dma_init_io() for the non-coalescing cases
> > because all the flows, regardless of composition, should be about as
> > fast as dma_map_sg is today.
> 
> If all flows includes multiple non-coalesced regions that just makes
> things very complicated, and that's exactly what I'd want to avoid.

I don't see how to avoid it unless we say RDMA shouldn't use this API,
which is kind of the whole point from my perspective..

I want an API that can handle all the same complexity as dma_map_sg()
without forcing the use of scatterlist. Instead "bring your own
datastructure". This is the essence of what we discussed.

An API that is inferior to dma_map_sg() is really problematic to use
with RDMA.

> > That means we need to always pre-allocate the IOVA in any case where
> > the IOMMU might be active - even on a non-coalescing flow.
> > 
> > IOW, dma_init_io() always pre-allocates IOVA if the iommu is going to
> > be used and we can't just call today's dma_map_page() in a loop on the
> > non-coalescing side and pay the overhead of Nx IOVA allocations.
> > 
> > In large part this is for RDMA, were a single P2P page in a large
> > multi-gigabyte user memory registration shouldn't drastically harm the
> > registration performance by falling down to doing dma_map_page, and an
> > IOVA allocation, on a 4k page by page basis.
> 
> But that P2P page needs to be handled very differently, as with it
> we can't actually use a single iova range.  So I'm not sure how that
> is even supposed to work.  If you have
> 
>  +-------+-----+-------+
>  | local | P2P | local |
>  +-------+-----+-------+
> 
> you need at least 3 hw SGL entries, as the IOVA won't be contigous.

Sure, 3 SGL entries is fine, that isn't what I'm pointing at

I'm saying that today if you give such a scatterlist to dma_map_sg()
it scans it and computes the IOVA space need, allocates one IOVA
space, then subdivides that single space up into the 3 HW SGLs you
show.

If you don't preserve that then we are calling, 4k at a time, a
dma_map_page() which is not anywhere close to the same outcome as what
dma_map_sg did. I may not get contiguous IOVA, I may not get 3 SGLs,
and we call into the IOVA allocator a huge number of times.

It needs to work following the same basic structure of dma_map_sg,
unfolding that logic into helpers so that the driver can provide
the data structure:

 - Scan the io ranges and figure out how much IOVA needed
   (dma_io_summarize_range)
 - Allocate the IOVA (dma_init_io)
 - Scan the io ranges again generate the final HW SGL
   (dma_io_link_page)
 - Finish the iommu batch (dma_io_done_mapping)

And you can make that pattern work for all the other cases too.

So I don't see this as particularly worse, calling some other API
instead of dma_map_page is not really a complexity on the
driver. Calling dma_init_io every time is also not a complexity. The
DMA API side is a bit more, but not substantively different logic from
what dma_map_sg already does.

Otherwise what is the alternative? How do I keep these complex things
working in RDMA and remove scatterlist?

> > The other thing that got hand waved here is how does dma_init_io()
> > know which of the 6 states we are looking at? I imagine we probably
> > want to do something like:
> > 
> >    struct dma_io_summarize summary = {};
> >    for each io()
> >         dma_io_summarize_range(&summary, io range)
> >    dma_init_io(dev, &state, &summary);
> >    if (state->single_range) {
> >    } else {
> >    }
> >    dma_io_done_mapping(&state); <-- flush IOTLB once
> 
> That's why I really just want 2 cases.  If the caller guarantees the
> range is coalescable and there is an IOMMU use the iommu-API like
> API, else just iter over map_single/page.

But how does the caller even know if it is coalescable? Other than the
trivial case of a single CPU range, that is a complicated detail based
on what pages are inside the range combined with the capability of the
device doing DMA. I don't see a simple way for the caller to figure
this out. You need to sweep every page and collect some information on
it. The above is to abstract that detail.

It was simpler before the confidential compute stuff :(

Jason

