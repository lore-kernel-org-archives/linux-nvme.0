Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE1DC48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 16:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/3/geJlHAvUbwYkCgoJhG+S6+t0cTirLphXUduy2mi8=; b=vhoj1E0HNewGaXzUCjDQwh+VlL
	f5JsqAAr84WxJczHSyQYCj+MLtedy4VbXRxLdszQKaJc1/LYo+C/MxWDuGIVkHDDX1t+ag5ZEjH2I
	poYlJ8W/lCjJOuVlmbii/JDJGIyn/GXbXQ4WcrEuMg1Ddtm0AhzLA0BSKrGwNW+ToB2R+TOCB4d2n
	vfUHCmz4ThPXFXKbk9gtbAZxVVAxUjijQVJRlypjP2SEmbo+pM5L45rHJ1cVflaa3MUrhWETZFsDX
	XrG0UnSRBDmRxW7+nj77y8VpwMl7FWd9ip1lz4By0KwvXAAPe5AjdpsAS+ie3Xug/QMTKUfDFkro9
	UFfwuERA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riGJ9-00000005QAC-0f93;
	Thu, 07 Mar 2024 16:09:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhzWY-000000022nh-3ZDH
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 22:14:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B087E68C4E; Wed,  6 Mar 2024 23:14:00 +0100 (CET)
Date: Wed, 6 Mar 2024 23:14:00 +0100
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
Message-ID: <20240306221400.GA8663@lst.de>
References: <cover.1709635535.git.leon@kernel.org> <47afacda-3023-4eb7-b227-5f725c3187c2@arm.com> <20240305122935.GB36868@unreal> <20240306144416.GB19711@lst.de> <20240306154328.GM9225@ziepe.ca> <20240306162022.GB28427@lst.de> <20240306174456.GO9225@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306174456.GO9225@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_141407_288917_A33C0717 
X-CRM114-Status: GOOD (  26.21  )
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

On Wed, Mar 06, 2024 at 01:44:56PM -0400, Jason Gunthorpe wrote:
> There is a list of interesting cases this has to cover:
> 
>  1. Direct map. No dma_addr_t at unmap, multiple HW SGLs
>  2. IOMMU aligned map, no P2P. Only IOVA range at unmap, single HW SGLs
>  3. IOMMU aligned map, P2P. Only IOVA range at unmap, multiple HW SGLs
>  4. swiotlb single range. Only IOVA range at unmap, single HW SGL
>  5. swiotlb multi-range. All dma_addr_t's at unmap, multiple HW SGLs.
>  6. Unaligned IOMMU. Only IOVA range at unmap, multiple HW SGLs
> 
> I think we agree that 1 and 2 should be optimized highly as they are
> the common case. That mainly means no dma_addr_t storage in either

I don't think you can do without dma_addr_t storage.  In most cases
your can just store the dma_addr_t in the LE/BE encoded hardware
SGL, so no extra storage should be needed though.

> 3 is quite similar to 1, but it has the IOVA range at unmap.

Can you explain what P2P case you mean?  The switch one with the
bus address is indeed basically the same, just with potentioally a
different offset, while the through host bridge case is the same
as a normal iommu map.

> 
> 4 is basically the same as 2 from the driver's viewpoint

I'd actually treat it the same as one.

> 5 is the slowest and has the most overhead.

and 5 could be broken into multiple 4s at least for now.  Or do you
have a different dfinition of range here?

> So are you thinking something more like a driver flow of:
> 
>   .. extent IO and get # aligned pages and know if there is P2P ..
>   dma_init_io(state, num_pages, p2p_flag)
>   if (dma_io_single_range(state)) {
>        // #2, #4
>        for each io()
> 	    dma_link_aligned_pages(state, io range)
>        hw_sgl = (state->iova, state->len)
>   } else {

I think what you have a dma_io_single_range should become before
the dma_init_io.  If we know we can't coalesce it really just is a
dma_map_{single,page,bvec} loop, no need for any extra state.

And we're back to roughly the proposal I sent out years ago.

> This is not quite what you said, we split the driver flow based on
> needing 1 HW SGL vs need many HW SGL.

That's at least what I intended to say, and I'm a little curious as what
it came across.


