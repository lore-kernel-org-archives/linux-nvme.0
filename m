Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8CCC02180
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 08:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZXFFMzIzsul109ol84Bm1FmobeYD7P8yzT28CIUFEC0=; b=mWndKZF10w4tckBLEedBQDFhwg
	rHfrez3cH5cMPeuNmIKUUhFxtCFeVmvhrl3FAMPi5Ojsk2zxeCk1Rxbh5x1IB6nGgeI6ttA7W3LJU
	Pzh0rJagIAcfuLQvoV1tYtj0LVtdV+hM0iW7kqwiguKttA3nNv9tONzNv48/RguMnrj+b2Hildo67
	0I3mNYLr4cRLRCFwkgB+b1AIZPQomeWmpIB7MzsHWPYlP/yU54UtAH0PWbIvQGLmkEkFp7yrlY9KZ
	KNt/1VixBfA5+ABfOr3kvaSvmC8GJC+gnwHU8VKFQ3pQ5bXPjxZjKgNDCmFgqIm5UBZEnht5sYEf4
	RNgh7DuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXyrX-0000000B74e-0m9f;
	Wed, 15 Jan 2025 08:34:55 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXyqT-0000000B6ls-0ntR
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 08:33:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5B4C6A416DE;
	Wed, 15 Jan 2025 08:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E083DC4CEE2;
	Wed, 15 Jan 2025 08:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736930028;
	bh=q//4PX+/kKs0NcRsMaK0IRFD8IgnEeYPZkHGethy6Xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCWDVkUqHQRGTYemu0OT2ih+ESCVIZ/aTGA9LOFnN2apzUXuQ6js3wGRvMvmPD0Q4
	 qPuVV2jFdCTf9DIs+hAcwNkgetPw+3PG1Lpnlw/6yRfq11aaFbmf0jL/DFWnEBrlVw
	 Ua5VHXN/Wk/lZkcpIs8HKqmwrhDVRgZOiJTe7WsPa5iJP6YN5+bhjqq5Jd10hVAZze
	 QrEQ79dFiDRigierP81hoV+aRHQMIswxIRHmBXxqXzkaq8aaF3N2iCj59qFjsa3k/F
	 66JPQhMe1Azzt9/n3bF5LnqLwPghqkXaMemOLirAJWtGi32tua3HSrRA0qNoLRzLR7
	 YnubzClMeJP7Q==
Date: Wed, 15 Jan 2025 10:33:40 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 07/17] dma-mapping: Implement link/unlink ranges API
Message-ID: <20250115083340.GL3146852@unreal>
References: <cover.1734436840.git.leon@kernel.org>
 <fa43307222f263e65ae0a84c303150def15e2c77.1734436840.git.leon@kernel.org>
 <ad2312e0-10d5-467a-be5e-75e80805b311@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad2312e0-10d5-467a-be5e-75e80805b311@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_003349_354848_AC55C72C 
X-CRM114-Status: GOOD (  24.48  )
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

On Tue, Jan 14, 2025 at 08:50:35PM +0000, Robin Murphy wrote:
> On 17/12/2024 1:00 pm, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Introduce new DMA APIs to perform DMA linkage of buffers
> > in layers higher than DMA.
> > 
> > In proposed API, the callers will perform the following steps.
> > In map path:
> > 	if (dma_can_use_iova(...))
> > 	    dma_iova_alloc()
> > 	    for (page in range)
> > 	       dma_iova_link_next(...)
> > 	    dma_iova_sync(...)
> > 	else
> > 	     /* Fallback to legacy map pages */
> >               for (all pages)
> > 	       dma_map_page(...)
> > 
> > In unmap path:
> > 	if (dma_can_use_iova(...))
> > 	     dma_iova_destroy()
> > 	else
> > 	     for (all pages)
> > 		dma_unmap_page(...)
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >   drivers/iommu/dma-iommu.c   | 259 ++++++++++++++++++++++++++++++++++++
> >   include/linux/dma-mapping.h |  32 +++++
> >   2 files changed, 291 insertions(+)

<...>

> > +static void iommu_dma_iova_unlink_range_slow(struct device *dev,
> > +		dma_addr_t addr, size_t size, enum dma_data_direction dir,
> > +		unsigned long attrs)
> > +{
> > +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> > +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> > +	struct iova_domain *iovad = &cookie->iovad;
> > +	size_t iova_start_pad = iova_offset(iovad, addr);
> > +	dma_addr_t end = addr + size;
> > +
> > +	do {
> > +		phys_addr_t phys;
> > +		size_t len;
> > +
> > +		phys = iommu_iova_to_phys(domain, addr);
> > +		if (WARN_ON(!phys))
> > +			continue;
> 
> Infinite WARN_ON loop, nice.

No problem, will change it to WARN_ON_ONCE.

> 
> > +		len = min_t(size_t,
> > +			end - addr, iovad->granule - iova_start_pad);

<...>

> > +
> > +		swiotlb_tbl_unmap_single(dev, phys, len, dir, attrs);
> 
> This is still dumb. For everything other than the first and last granule,
> either it's definitely not in SWIOTLB, or it is (per the unaligned size
> thing above) but then "len" is definitely wrong and SWIOTLB will complain.

Like Christoph said, we tested it with NVMe which uses SWIOTLB path and
despite having a lot of unaligned sizes, it worked without SWIOTLB
complains.

> 
> > +
> > +		addr += len;
> > +		iova_start_pad = 0;
> > +	} while (addr < end);
> > +}
> > +
> > +static void __iommu_dma_iova_unlink(struct device *dev,
> > +		struct dma_iova_state *state, size_t offset, size_t size,
> > +		enum dma_data_direction dir, unsigned long attrs,
> > +		bool free_iova)
> > +{
> > +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> > +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> > +	struct iova_domain *iovad = &cookie->iovad;
> > +	dma_addr_t addr = state->addr + offset;
> > +	size_t iova_start_pad = iova_offset(iovad, addr);
> > +	struct iommu_iotlb_gather iotlb_gather;
> > +	size_t unmapped;
> > +
> > +	if ((state->__size & DMA_IOVA_USE_SWIOTLB) ||
> > +	    (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)))
> > +		iommu_dma_iova_unlink_range_slow(dev, addr, size, dir, attrs);
> > +
> > +	iommu_iotlb_gather_init(&iotlb_gather);
> > +	iotlb_gather.queued = free_iova && READ_ONCE(cookie->fq_domain);
> 
> This makes things needlessly hard to follow, just keep the IOVA freeing
> separate. And by that I really mean just have unlink and free, since
> dma_iova_destroy() really doesn't seem worth the extra complexity to save
> one line in one caller...

In initial versions, I didn't implement dma_iova_destroy() and used
unlink->free calls directly. Both Jason and Christoph asked me to
provide dma_iova_destroy(), so we can reuse same iotlb_gather.

Almost all callers (except HMM-like) will use this API call.

Let's keep it.

Thanks

