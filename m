Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959D0D132BD
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 12:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e2URs7fX78avpuvJr5WeUG9Vud8YYYnwuRfSvXvCeDo=; b=zeW5o5xMhcqeYG2tDk6C0iWofk
	wIFmUCpK0heUgRRPewXSNr44KouoLd8qM11GJPlXXvyKClh3arqi+LO/rMEfC5ANOPBglWDXTVshv
	7bsvKNksA7AOHhNw/V46pSR4TRPuxnIxzSxuFFzDVQKdh+LcsioBQiqTU5bIMvETYeoHuY2Gdj7A0
	BfTWWWS+KL8ivaYslQc0NviohkmCd9ESDhlYR+VKw+52nS/pSs7PGFaajECmvFtm1a7ylAcV1RbGn
	D/0FVi4PhaGbeXGIMRXg/Uhuv+XtzcGftGcy3aa32JLjTONrpt3dT7uXuIHbSwOAGJCdzohQwn3Db
	gdFwU00g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7wa1-0000000DkcK-454H;
	Mon, 04 Nov 2024 12:53:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7wZy-0000000Dkb2-0zCm
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 12:53:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D6983227AAF; Mon,  4 Nov 2024 13:53:02 +0100 (CET)
Date: Mon, 4 Nov 2024 13:53:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leonro@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 07/17] dma-mapping: Implement link/unlink ranges API
Message-ID: <20241104125302.GA11168@lst.de>
References: <cover.1730298502.git.leon@kernel.org> <f8c7f160c9ae97fef4ccd355f9979727552c7374.1730298502.git.leon@kernel.org> <51c5a5d5-6f90-4c42-b0ef-b87791e00f20@arm.com> <20241104091048.GA25041@lst.de> <20241104121924.GC35848@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104121924.GC35848@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_045310_447250_EEDEA96A 
X-CRM114-Status: GOOD (  22.00  )
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

On Mon, Nov 04, 2024 at 08:19:24AM -0400, Jason Gunthorpe wrote:
> > That's a good point.  Only mapped through host bridge P2P can even
> > end up here, so the address is a perfectly valid physical address
> > in the host.  But I'm not sure if all arch_sync_dma_for_device
> > implementations handle IOMMU memory fine.
> 
> I was told on x86 if you do a cache flush operation on MMIO there is a
> chance it will MCE. Recently had some similar discussions about ARM
> where it was asserted some platforms may have similar.

On x86 we never flush caches for DMA operations anyway, so x86 isn't
really the concern here, but architectures that do cache incoherent DMA
to PCIe devices.  Which isn't a whole lot as most SOCs try to avoid that
for PCIe even if they lack DMA coherent for lesser peripherals, but I bet
there are some on arm/arm64 and maybe riscv or mips.

> It would be safest to only call arch flushing calls on memory that is
> mapped cachable. We can assume that a P2P target is never CPU
> mapped cachable, regardless of how the DMA is routed.

Yes.  I.e. force DMA_ATTR_SKIP_CPU_SYNC for P2P.


