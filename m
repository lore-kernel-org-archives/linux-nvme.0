Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88EEC6FD1F
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 22:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JGqzUGhdWzxNRZfpPnkopvOYOGGkyEkyp/xSmTZjR+E=; b=3dh71riXyUZQCUpqxKj1XZx4W1
	eeYTJfn9mGygJLgPCb2giUul36uDe4XlXuROzQijSc7uDSxyt98ea2UtALVECA9Cke6zNPDLGO5+b
	P45XaQWZ+e/xfupddQUMThVLFMQy4vwsXMAxlJg98o6EG+7xPRJOI/tAAOeB2Vi3Inldw4mh0qtnq
	DQplQLY35oLxEJsOUm1GQ0VLrFJH8sGfu2C8ZpxUHoNKLkHfKigc2bLCO2qOgplvPta6QIesA2pmM
	SkD+HM90ZRfE+7M6uX6MgGP0dUL5I8TfxQVHMeksNPw1KdFgc5Xi/UZiZ5BGyu+GGT0A9JfekUTBG
	2aIxIXYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnR78-00000004zrD-3YXp;
	Thu, 21 Mar 2024 22:42:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnR4B-00000004z6o-3I5y
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 22:39:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 879B968BEB; Thu, 21 Mar 2024 23:39:11 +0100 (CET)
Date: Thu, 21 Mar 2024 23:39:10 +0100
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
Message-ID: <20240321223910.GA22663@lst.de>
References: <20240306162022.GB28427@lst.de> <20240306174456.GO9225@ziepe.ca> <20240306221400.GA8663@lst.de> <20240307000036.GP9225@ziepe.ca> <20240307150505.GA28978@lst.de> <20240307210116.GQ9225@ziepe.ca> <20240308164920.GA17991@lst.de> <20240308202342.GZ9225@ziepe.ca> <20240309161418.GA27113@lst.de> <20240319153620.GB66976@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319153620.GB66976@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_153920_159201_B258ED97 
X-CRM114-Status: GOOD (  31.22  )
X-Mailman-Approved-At: Thu, 21 Mar 2024 15:42:21 -0700
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

On Tue, Mar 19, 2024 at 12:36:20PM -0300, Jason Gunthorpe wrote:
> I kind of understand your thinking on the DMA side, but I don't see
> how this is good for users of the API beyond BIO.
> 
> How will this make RDMA better? We have one MR, the MR has pages, the
> HW doesn't care about the SW distinction of p2p, swiotlb, direct,
> encrypted, iommu, etc. It needs to create one HW page list for
> whatever user VA range was given.

Well, the hardware (as in the PCIe card) never cares.  But the setup
path for the IOMMU does, and something in the OS needs to know about
it.  So unless we want to stash away a 'is this P2P' flag in every
page / SG entry / bvec, or a do a lookup to find that out for each
of them we need to manage chunks at these boundaries.  And that's
what I'm proposing.

> Or worse, whatever thing is inside a DMABUF from a DRM
> driver. DMABUF's can have a (dynamic!) mixture of P2P and regular
> AFAIK based on the GPU's migration behavior.

And that's fine.  We just need to track it efficiently.

> 
> Or triple worse, ODP can dynamically change on a page by page basis
> the type depending on what hmm_range_fault() returns.

Same.  If this changes all the time you need to track it.  And we
should find a way to shared the code if we have multiple users for it.

But most DMA API consumers will never see P2P, and when they see it
it will be static.  So don't build the DMA API to automically do
the (not exactly super cheap) checks and add complexity for it.

> So I take it as a requirement that RDMA MUST make single MR's out of a
> hodgepodge of page types. RDMA MRs cannot be split. Multiple MR's are
> not a functional replacement for a single MR.

But MRs consolidate multiple dma addresses anyway.

> Go back to the start of what are we trying to do here:
>  1) Make a DMA API that can support hmm_range_fault() users in a
>     sensible and performant way
>  2) Make a DMA API that can support RDMA MR's backed by DMABUF's, and
>     user VA's without restriction
>  3) Allow to remove scatterlist from BIO paths
>  4) Provide a DMABUF API that is not scatterlist that can feed into
>     the new DMA API - again supporting DMABUF's hodgepodge of types.
> 
> I'd like to do all of these things. I know 3 is your highest priority,
> but it is my lowest :)

Well, 3 an 4.  And 3 is not just limited to bio, but all the other
pointless scatterlist uses.


