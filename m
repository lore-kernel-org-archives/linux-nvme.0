Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C81D13588
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 06:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h9Vt1G1QhAWZwYF7bg5GNJOdngfwRon2If+BJNxbKvY=; b=3+yYtM91ypJIBCL8SyH9wYz/Y/
	XkpFaUHh5HaAnnCH9U0lMlfyGUMvBARvoVe8Lj2YM/uf4EXXX2QPRgNFghlB+dEDJm/wUg09pFPDo
	2fAJkvhWJM1lGhv/LBkPPTNzNUsqfxGSYHIovvW8YztcW/PCTk45nZdF8dvqBu5rPNRLJEQekuwiQ
	AoPz0JgfQOO/9ZA1OWPqwfV5W+8qQnZBfFFR0SF0t0Kv3So75zg+IsTeKF2muQdoRg8dvgRgORKIu
	BS5iIW2WPFYaHl/3SC0ER5BHWJ5Umsz9pRucSzBZXMwXfHxn4AfkdUzv21dYhKYNFiLbkdx4V7Gjl
	xBbDNsaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5JNt-00000009kN0-0nDM;
	Mon, 28 Oct 2024 06:37:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5JNp-00000009kLT-3R6W
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 06:37:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E1AE65C59CC;
	Mon, 28 Oct 2024 06:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88BBC4CECD;
	Mon, 28 Oct 2024 06:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730097464;
	bh=JSMPxlj7Xh+b8j9DlJV8uewuubV9Tsu6U0l5WWqgJPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GwfQjiZKs0yrCxRr/DuLwVj0Hx2O01TJqsx4cOgi4xDB5heJMzcMFklB+BmqVt/Cv
	 4gTLkD3T4pLeplq55h8kscjuwFaQBaQQl3jJ+S6HDuMUb8Uo4nfwXKbBH4ZpNsFwWc
	 DtTbV7qiK3wP+pOJjE92kpgpVG2/Rp3yxPce9N57yNgHPfhuWe+jA+txqxeG7J3/WR
	 lg7fC+BqgPGzEhchM2jYymbqRn4haIlJdsIa0VzlUlQRhnfBkwl7wj8kV+Z4AwHkx2
	 BqCjnbHjv5nHEhthh0L9SPFTB5k9zIXGi2bQT8jtQ/tbnPfE55BhKbIxD3tfcRScfY
	 kTj4HSZy9GalA==
Date: Mon, 28 Oct 2024 08:37:40 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
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
Subject: Re: [PATCH 05/18] dma: Provide an interface to allow allocate IOVA
Message-ID: <20241028063740.GD1615717@unreal>
References: <cover.1730037276.git.leon@kernel.org>
 <844f3dcf9c341b8178bfbc90909ef13d11dd2193.1730037276.git.leon@kernel.org>
 <25c32551-32e2-4a44-b0ae-30ad08e06799@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25c32551-32e2-4a44-b0ae-30ad08e06799@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_233745_970007_51261B55 
X-CRM114-Status: GOOD (  30.63  )
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

On Mon, Oct 28, 2024 at 09:24:08AM +0800, Baolu Lu wrote:
> On 2024/10/27 22:21, Leon Romanovsky wrote:
> > From: Leon Romanovsky<leonro@nvidia.com>
> > 
> > The existing .map_page() callback provides both allocating of IOVA
> > and linking DMA pages. That combination works great for most of the
> > callers who use it in control paths, but is less effective in fast
> > paths where there may be multiple calls to map_page().
> > 
> > These advanced callers already manage their data in some sort of
> > database and can perform IOVA allocation in advance, leaving range
> > linkage operation to be in fast path.
> > 
> > Provide an interface to allocate/deallocate IOVA and next patch
> > link/unlink DMA ranges to that specific IOVA.
> > 
> > The API is exported from dma-iommu as it is the only implementation
> > supported, the namespace is clearly different from iommu_* functions
> > which are not allowed to be used. This code layout allows us to save
> > function call per API call used in datapath as well as a lot of boilerplate
> > code.
> > 
> > Signed-off-by: Leon Romanovsky<leonro@nvidia.com>
> > ---
> >   drivers/iommu/dma-iommu.c   | 79 +++++++++++++++++++++++++++++++++++++
> >   include/linux/dma-mapping.h | 15 +++++++
> >   2 files changed, 94 insertions(+)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index c422e36c0d66..0644152c5aad 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -1745,6 +1745,85 @@ size_t iommu_dma_max_mapping_size(struct device *dev)
> >   	return SIZE_MAX;
> >   }
> > +static bool iommu_dma_iova_alloc(struct device *dev,
> > +		struct dma_iova_state *state, phys_addr_t phys, size_t size)
> > +{
> > +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> > +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> > +	struct iova_domain *iovad = &cookie->iovad;
> > +	size_t iova_off = iova_offset(iovad, phys);
> > +	dma_addr_t addr;
> > +
> > +	if (WARN_ON_ONCE(!size))
> > +		return false;
> > +	if (WARN_ON_ONCE(size & DMA_IOVA_USE_SWIOTLB))
> > +		return false;
> > +
> > +	addr = iommu_dma_alloc_iova(domain,
> > +			iova_align(iovad, size + iova_off),
> > +			dma_get_mask(dev), dev);
> > +	if (!addr)
> > +		return false;
> > +
> > +	state->addr = addr + iova_off;
> > +	state->__size = size;
> > +	return true;
> > +}
> > +
> > +/**
> > + * dma_iova_try_alloc - Try to allocate an IOVA space
> > + * @dev: Device to allocate the IOVA space for
> > + * @state: IOVA state
> > + * @phys: physical address
> I'm curious to know why a physical address is necessary for IOVA space
> allocation. Could you please elaborate?

The proposed API is not only splitted to allow batching of DMA
operations without need of scatter-gather, but also allowed to
users without "struct *page" to use it. 

In IOMMU and DMA layers all operations are performed on physical
addresses and the API "request" to provide "struct *page" in
dma_map_sg/dma_map_page is not truly needed.

In this specific case, the physical address is used to calculate
IOVA offset, see "size_t iova_off = iova_offset(iovad, phys);" line,
which is needed for NVMe PCI/block layer, as they can have first
address to be unaligned and IOVA allocation will need an offset to
properly calculate size.

HMM and VFIO operate on page granularity and in simple case
they don't need alignment. In more advance scenarios, they will
benefit from this offset anyway as it will cause to reduce of IOVA
space.

Thanks

