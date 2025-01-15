Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2D9C02187
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 06:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2jBIHZ/hTbaSHFIMylTKG2eusxkqUBnhR1cwydJaFqA=; b=1nhIMMLHsASm5vBB15EkF+Npj+
	o2EpI7cLVmQaX/jTAl+rwpUwV5rkA7FEnjZGLzSXkU5fsd0hdoNX9Dqs+qF6IRmAiV+lK9yQkf7T7
	CAsCFEAdHlyTMLZh6Cgy+8HO87zrMI9lg6wYXxtVkEmIOQ8cxs27HGlf6DCwlv4ztI99PNwGcFEGK
	iNitanrW1uZSnLfmQik+dDHe6J+ZoT+vW2K2rRWCRFWZrw4xazA26RwKr9BO6a2XSbHxxVjHJ443L
	U3uHQUFDWzEBisIsqGOZCZAVAp+kxbSLTOJBGnAtwGX2T2oHOX7HnAoPMLTdSniKlk33f6NgB0S/v
	tk4UvdVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXwtQ-0000000Amvq-2d2T;
	Wed, 15 Jan 2025 06:28:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXwrK-0000000AmHp-1xnv
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 06:26:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A1F9068B05; Wed, 15 Jan 2025 07:26:28 +0100 (CET)
Date: Wed, 15 Jan 2025 07:26:28 +0100
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
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 07/17] dma-mapping: Implement link/unlink ranges API
Message-ID: <20250115062628.GA29782@lst.de>
References: <cover.1734436840.git.leon@kernel.org> <fa43307222f263e65ae0a84c303150def15e2c77.1734436840.git.leon@kernel.org> <ad2312e0-10d5-467a-be5e-75e80805b311@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad2312e0-10d5-467a-be5e-75e80805b311@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_222634_791819_00060C23 
X-CRM114-Status: GOOD (  30.10  )
X-Mailman-Approved-At: Tue, 14 Jan 2025 22:28:41 -0800
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
>>   EXPORT_SYMBOL_GPL(dma_iova_free);
>>   +static int __dma_iova_link(struct device *dev, dma_addr_t addr,
>> +		phys_addr_t phys, size_t size, enum dma_data_direction dir,
>> +		unsigned long attrs)
>> +{
>> +	bool coherent = dev_is_dma_coherent(dev);
>> +
>> +	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>> +		arch_sync_dma_for_device(phys, size, dir);
>
> Again, if we're going to pretend to support non-coherent devices, where are 
> the dma_sync_for_{device,cpu} calls that work for a dma_iova_state? It 
> can't be the existing dma_sync_single ops since that would require the user 
> to keep track of every mapping to sync them individually, and the whole 
> premise is to avoid doing that (not to mention dma-debug wouldn't like it). 
> Same for anything coherent but SWIOTLB-bounced.

That assumes you actually need to sync them.  Many DMA mapping if not
most dma mappings are one shots - map and unmap, no sync.  And these
will work fine here.

But I guess the documentation needs to spell that out.  While I don't
have a good non-coherent system to test, swiotlb has actually been
tested with nvme when I implemented this part.

>> +{
>> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>> +	struct iova_domain *iovad = &cookie->iovad;
>> +	size_t iova_start_pad = iova_offset(iovad, phys);
>> +	size_t iova_end_pad = iova_offset(iovad, phys + size);
>
> "end_pad" implies a length of padding from the unaligned end address to 
> reach the *next* granule boundary, but it seems this is actually the 
> unaligned tail length of the data itself. That's what confused me last 
> time, since in the map path that post-data padding region does matter in 
> its own right.

Yeah.  Do you have a suggestion for a better name?

>> +		phys_addr_t phys, size_t offset, size_t size,
>> +		enum dma_data_direction dir, unsigned long attrs)
>> +{
>> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>> +	struct iova_domain *iovad = &cookie->iovad;
>> +	size_t iova_start_pad = iova_offset(iovad, phys);
>> +
>> +	if (WARN_ON_ONCE(iova_start_pad && offset > 0))
>
> "iova_start_pad == 0" still doesn't guarantee that "phys" and "offset" are 
> appropriately aligned to each other.

>> +	if (dev_use_swiotlb(dev, size, dir) && iova_offset(iovad, phys | size))
>
> Again, why are we supporting non-granule-aligned mappings in the middle of 
> a range when the documentation explicitly says not to?

It's not trying to support that, but checking that this is guaranteed
to be the last one is harder than handling it like this.  If you have
a suggestion for better checks that would be very welcome.

>> +		if (!dev_is_dma_coherent(dev) &&
>> +		    !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>> +			arch_sync_dma_for_cpu(phys, len, dir);
>
> Hmm, how do attrs even work for a bulk unlink/destroy when the individual 
> mappings could have been linked with different values?

They shouldn't.  Just like randomly mixing flags doesn't work for the
existing APIs.

> (So no, irrespective of how conceptually horrid it is, clearly it's not 
> even functionally viable to open-code abuse of DMA_ATTR_SKIP_CPU_SYNC in 
> callers to attempt to work around P2P mappings...)

What do you mean with "work around"?  I guess Leon added it to the hmm
code based on previous feedback, but I still don't think any of our P2P
infrastructure works reliably with non-coherent devices as
iommu_dma_map_sg gets this wrong.  So despite the earlier comments I
suspect this should stick to the state of the art even if that is broken.


