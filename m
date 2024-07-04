Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CF0C38150
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jul 2024 13:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FiW+P+gEbk03re9caf8GbaZIS2rrKaSGcFy9JQgS9RY=; b=pFKkHU7oLqyQATT1RCqg8IDgYS
	v/Wh/Ft1wuaGYCRsHWNtQEuAp+WculqA3NVaytLuZ3j129p6kPRIGHOQqowzE5VIK8bwtWBFRYgVN
	uRr1jXolFW2IOAmPXDOUJc948elCTkZOoyYMuG3gZIGqdeRNGCiC7bH23bTK1XCDTbKs5UWWwUpsw
	A5ADAfeqfIpSiluyOgJXqW/Y2NU3OcwGnkMl5tl2o4Q0p1KrT4TNSM+HSxuwSMmiEMWZKfGwj1cgH
	wIGwIMtTnB7pJFl88vlnQnR3LyqZRUZQ7Gk5qrfeSQpJ9BBfVC0VfAQ9wIKVaRQ35Y6oHWmc/Fnvg
	C4+LSGsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPMMO-0000000DG6a-2kpZ;
	Thu, 04 Jul 2024 13:18:52 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPMMK-0000000DG5c-3n0H
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jul 2024 13:18:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1DBFFCE33EF;
	Thu,  4 Jul 2024 13:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0368AC3277B;
	Thu,  4 Jul 2024 13:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720099124;
	bh=nkzC1R2Sn6KADvFNDPp0hrnIwln3xVG+eb9R42IPSdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/KR/8A6xd5D4R/wyMmVXVBhTLC00uoxpBMQxG4XlqhIi5KAQVaC2WfSC/JKuTQBK
	 kEFxwYczrrp8jHD/rU7Io7O7FanCrAZSqBu/PdOnbPEDswb3D7N14ui//u++auZfNR
	 SUqz2Rl1HBcmgvgZwCQlOkR19edRQbzDh6tI/mypTJD/RTH4hYtagEvYh76WNN1/VY
	 UCe/SDCeqqwlLAKAvWNk+uJtnN8vjygt8Gaomlc3u7lhSQZuSImjGamtHE5l/qm9H/
	 l7cdU0pdx3G3PZZgD6CMT+HJGLLMzzhXBkWp2c6sJY4t+AJp3EHJFmV84AgiTky6jN
	 DmhQgo4POHvOw==
Date: Thu, 4 Jul 2024 16:18:39 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240704131839.GD95824@unreal>
References: <cover.1719909395.git.leon@kernel.org>
 <20240703054238.GA25366@lst.de>
 <20240703105253.GA95824@unreal>
 <20240703143530.GA30857@lst.de>
 <20240703155114.GB95824@unreal>
 <20240704074855.GA26913@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704074855.GA26913@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_061849_323708_C315432E 
X-CRM114-Status: GOOD (  28.33  )
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

On Thu, Jul 04, 2024 at 09:48:56AM +0200, Christoph Hellwig wrote:
> On Wed, Jul 03, 2024 at 06:51:14PM +0300, Leon Romanovsky wrote:
> > If we put aside this issue, do you think that the proposed API is the right one?
> 
> I haven't look at it in detail yet, but from a quick look there is a
> few things to note:
> 
> 
> 1) The amount of code needed in nvme worries me a bit.  Now NVMe a messy
> driver due to the stupid PRPs vs just using SGLs, but needing a fair
> amount of extra boilerplate code in drivers is a bit of a warning sign.
> I plan to look into this to see if I can help on improving it, but for
> that I need a working version first.

Chaitanya is working on this and I'll join him to help on next Sunday,
after I'll return to the office from my sick leave/

> 
> 
> 2) The amount of seemingly unrelated global headers pulled into other
> global headers.  Some of this might just be sloppiness, e.g. I can't
> see why dma-mapping.h would actually need iommu.h to start with,
> but pci.h in dma-map-ops.h is a no-go.

pci.h was pulled because I needed to call to pci_p2pdma_map_type()
in dma_can_use_iova().

> 
> 3) which brings me to real layering violations.  dev_is_untrusted and
> dev_use_swiotlb are DMA API internals, no way I'd ever want to expose
> them. dma-map-ops.h is a semi-internal header only for implementations
> of the dma ops (as very clearly documented at the top of that file),
> it must not be included by drivers.  Same for swiotlb.h.

These item shouldn't worry you and will be changed in the final version.
They are outcome of patch "RDMA/umem: Prevent UMEM ODP creation with SWIOTLB".
https://lore.kernel.org/all/d18c454636bf3cfdba9b66b7cc794d713eadc4a5.1719909395.git.leon@kernel.org/

All HMM users need such "prevention" so it will be moved to a common place.

> 
> Not quite as concerning, but doing an indirect call for each map
> through dma_map_ops in addition to the iommu ops is not every efficient.
> We've through for a while to allow direct calls to dma-iommu similar
> how we do direct calls to dma-direct from the core mapping.c code.
> This might be a good time to do that as a prep step for this work.

Sure, no problem, will start in parallel to work on this.

> 

