Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB566C30653
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jul 2024 07:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TOWEFNPLCPH2NjVWmElBI7VnpkJseOiXr3UYCCHK9eY=; b=V4VEKxgxt5B70N3b0yICdN2qXy
	uUFePjXdGHDr8dIjz4rjoC/qOmo59rBshqXCttJfJ2FILBTWK9OaG1twPVtY2KQLxR+yKHMHpC9uF
	zCXhncfkip2M9QJm1fOIVWaUWwAkYsxtFeVYvbxN3Put6Lepv3AZZBcI70KvmhB0/3XR6PrsxAysj
	L7lnDmvUafCohkmyVWM6Ii3wKuAZA6/UDKfMNBte4rp7prdBYdHWBQskb018Dh3mGYeCvaxxDsiw0
	9itcMFe2BUQyQ54+7X4R3kUYIUZJXko5nEBZhFsY1Q1Qyl9Gmb7U8WxK0W6EMGtFsjmkfwUhUrsQG
	zxPhDnTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPHDJ-0000000CURM-0GyL;
	Thu, 04 Jul 2024 07:49:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPHDF-0000000CUQN-1Lq0
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jul 2024 07:49:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 52B5468AA6; Thu,  4 Jul 2024 09:48:56 +0200 (CEST)
Date: Thu, 4 Jul 2024 09:48:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Keith Busch <kbusch@kernel.org>, "Zeng, Oak" <oak.zeng@intel.com>,
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
Message-ID: <20240704074855.GA26913@lst.de>
References: <cover.1719909395.git.leon@kernel.org> <20240703054238.GA25366@lst.de> <20240703105253.GA95824@unreal> <20240703143530.GA30857@lst.de> <20240703155114.GB95824@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703155114.GB95824@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_004905_530783_FB118410 
X-CRM114-Status: GOOD (  20.72  )
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

On Wed, Jul 03, 2024 at 06:51:14PM +0300, Leon Romanovsky wrote:
> If we put aside this issue, do you think that the proposed API is the right one?

I haven't look at it in detail yet, but from a quick look there is a
few things to note:


1) The amount of code needed in nvme worries me a bit.  Now NVMe a messy
driver due to the stupid PRPs vs just using SGLs, but needing a fair
amount of extra boilerplate code in drivers is a bit of a warning sign.
I plan to look into this to see if I can help on improving it, but for
that I need a working version first.


2) The amount of seemingly unrelated global headers pulled into other
global headers.  Some of this might just be sloppiness, e.g. I can't
see why dma-mapping.h would actually need iommu.h to start with,
but pci.h in dma-map-ops.h is a no-go.

3) which brings me to real layering violations.  dev_is_untrusted and
dev_use_swiotlb are DMA API internals, no way I'd ever want to expose
them. dma-map-ops.h is a semi-internal header only for implementations
of the dma ops (as very clearly documented at the top of that file),
it must not be included by drivers.  Same for swiotlb.h.

Not quite as concerning, but doing an indirect call for each map
through dma_map_ops in addition to the iommu ops is not every efficient.
We've through for a while to allow direct calls to dma-iommu similar
how we do direct calls to dma-direct from the core mapping.c code.
This might be a good time to do that as a prep step for this work.


