Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3630AD132A2
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 09:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YmKNSBaTX9xT2FsM/UPh544hjGC89WIyu8zmdoHRF2s=; b=PX6xhOHPYfSxkU2sqRWKuoego2
	l3OSNSEmWu396UpaF0GCO1trdoHekIFPQgRbw1pb4oFAOnpKo43tv/jYVLpuFdZzTcBCyctx2yo1G
	VCK29ttwj52WN02oRYNksSC8yj32dlInGkmKA1yZgAaISaxVXO7d/z3c1CKl88Du4JRHr7/9woiqp
	c/369DC5dmlp9V6f8Ehj3ctaee7K3xVpeVdczq6Wjl/AGWslC2Nw5ife+viuDjSzYFSTaUQez+U1r
	Gu8Ixy2MgY4IBWXHHPWtmBImL3jWwcw3LQilB/wVBMCmUeXxje6XtsdkR1INOc1XNnFW7ykYIxnh2
	7ZT3ZfHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7tG1-0000000D8S1-2fYt;
	Mon, 04 Nov 2024 09:20:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7t6t-0000000D6WW-1MOx
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 09:10:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 69D09227AAD; Mon,  4 Nov 2024 10:10:49 +0100 (CET)
Date: Mon, 4 Nov 2024 10:10:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20241104091048.GA25041@lst.de>
References: <cover.1730298502.git.leon@kernel.org> <f8c7f160c9ae97fef4ccd355f9979727552c7374.1730298502.git.leon@kernel.org> <51c5a5d5-6f90-4c42-b0ef-b87791e00f20@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51c5a5d5-6f90-4c42-b0ef-b87791e00f20@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_011055_741892_770DBA85 
X-CRM114-Status: GOOD (  35.84  )
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

On Thu, Oct 31, 2024 at 09:18:07PM +0000, Robin Murphy wrote:
>>   +static int __dma_iova_link(struct device *dev, dma_addr_t addr,
>> +		phys_addr_t phys, size_t size, enum dma_data_direction dir,
>> +		unsigned long attrs)
>> +{
>> +	bool coherent = dev_is_dma_coherent(dev);
>> +
>> +	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>
> If you really imagine this can support non-coherent operation and 
> DMA_ATTR_SKIP_CPU_SYNC, where are the corresponding explicit sync 
> operations? dma_sync_single_*() sure as heck aren't going to work...
>
> In fact, same goes for SWIOTLB bouncing even in the coherent case.

No with explicit sync operations.  But plain map/unmap works, I've
actually verified that with nvme.  And that's a pretty large use
case.

>> +		arch_sync_dma_for_device(phys, size, dir);
>
> Plus if the aim is to pass P2P and whatever arbitrary physical addresses 
> through here as well, how can we be sure this isn't going to explode?

That's a good point.  Only mapped through host bridge P2P can even
end up here, so the address is a perfectly valid physical address
in the host.  But I'm not sure if all arch_sync_dma_for_device
implementations handle IOMMU memory fine.

>> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>> +	struct iova_domain *iovad = &cookie->iovad;
>> +	size_t iova_start_pad = iova_offset(iovad, phys);
>> +	size_t iova_end_pad = iova_offset(iovad, phys + size);
>
> I thought the code below was wrong until I double-checked and realised that 
> this is not what its name implies it to be...

Which variable does this refer to, and what would be a better name?

>> +		phys = iommu_iova_to_phys(domain, addr);
>> +		if (WARN_ON(!phys))
>> +			continue;
>> +		len = min_t(size_t,
>> +			end - addr, iovad->granule - iova_start_pad);
>> +
>> +		if (!dev_is_dma_coherent(dev) &&
>> +		    !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>> +			arch_sync_dma_for_cpu(phys, len, dir);
>> +
>> +		swiotlb_tbl_unmap_single(dev, phys, len, dir, attrs);
>
> How do you know that "phys" and "len" match what was originally allocated 
> and bounced in, and this isn't going to try to bounce out too much, free 
> the wrong slot, or anything else nasty? If it's not supposed to be 
> intentional that a sub-granule buffer can be linked to any offset in the 
> middle of the IOVA range as long as its original physical address is 
> aligned to the IOVA granule size(?), why try to bounce anywhere other than 
> the ends of the range at all?

Mostly because the code is simpler and unless misused it just works.
But it might be worth adding explicit checks for the start and end.

>> +static void __iommu_dma_iova_unlink(struct device *dev,
>> +		struct dma_iova_state *state, size_t offset, size_t size,
>> +		enum dma_data_direction dir, unsigned long attrs,
>> +		bool free_iova)
>> +{
>> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>> +	struct iova_domain *iovad = &cookie->iovad;
>> +	dma_addr_t addr = state->addr + offset;
>> +	size_t iova_start_pad = iova_offset(iovad, addr);
>> +	struct iommu_iotlb_gather iotlb_gather;
>> +	size_t unmapped;
>> +
>> +	if ((state->__size & DMA_IOVA_USE_SWIOTLB) ||
>> +	    (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)))
>> +		iommu_dma_iova_unlink_range_slow(dev, addr, size, dir, attrs);
>> +
>> +	iommu_iotlb_gather_init(&iotlb_gather);
>> +	iotlb_gather.queued = free_iova && READ_ONCE(cookie->fq_domain);
>
> Is is really worth the bother?

Worth what?

>> +	size = iova_align(iovad, size + iova_start_pad);
>> +	addr -= iova_start_pad;
>> +	unmapped = iommu_unmap_fast(domain, addr, size, &iotlb_gather);
>> +	WARN_ON(unmapped != size);
>> +
>> +	if (!iotlb_gather.queued)
>> +		iommu_iotlb_sync(domain, &iotlb_gather);
>> +	if (free_iova)
>> +		iommu_dma_free_iova(cookie, addr, size, &iotlb_gather);
>
> There's no guarantee that "size" is the correct value here, so this has 
> every chance of corrupting the IOVA domain.

Yes, but the same is true for every users of the iommu_* API as well.

>> +/**
>> + * dma_iova_unlink - Unlink a range of IOVA space
>> + * @dev: DMA device
>> + * @state: IOVA state
>> + * @offset: offset into the IOVA state to unlink
>> + * @size: size of the buffer
>> + * @dir: DMA direction
>> + * @attrs: attributes of mapping properties
>> + *
>> + * Unlink a range of IOVA space for the given IOVA state.
>
> If I initially link a large range in one go, then unlink a small part of 
> it, what behaviour can I expect?

As in map say 128k and then unmap 4k?  It will just work, even if that
is not the intended use case, which is either map everything up front
and unmap everything together, or the HMM version of random constant
mapping and unmapping at page size granularity.


