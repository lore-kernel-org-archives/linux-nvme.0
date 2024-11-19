Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA30D62040
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 09:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ASOqfqo57q8TAqJHgVqYUCyiuGtomZMg9cwiPig5cWY=; b=GhoLVnFQIkuCIE2i3LLqoNyB5W
	vpBKvJwjO65OGuHHyosx0GBWy1HFwTxPP/KF4FhkID9iXC1XNCwoc95mT4U4H2OMUz/WlbtTMTz+Z
	ibGQeALSqq6+kEcVuK50i6pycc+oGO6ZZsZ1uzJdyFxaZVDO1oO2okb5Eazq3QM/aP91IGMqQ52aV
	neiaBaal68DYuLIdzSe5XCRUoSgjfFTxoWpuN1YA6BENcj0C2W68rroo5BaKwbh6Idp/FbNjnLHc9
	dAPwZV7Esu33xNo9Xd9HcqH4a/3U/bCe3n51TJHXIrr08vikdsUHjIqhSGTTpxJTwmV6L4NGF4Hu4
	GCpnGCOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDKAi-0000000Bpkc-3ZOa;
	Tue, 19 Nov 2024 09:05:20 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDKAg-0000000Bpjk-27ke
	for linux-nvme@lists.infradead.org;
	Tue, 19 Nov 2024 09:05:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id F02E8A42747;
	Tue, 19 Nov 2024 09:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DCDC4CECF;
	Tue, 19 Nov 2024 09:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732007116;
	bh=qslK9QNzD9RoFr7GVJ7I21Lqy9327g4qXpeTSoTD2Dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cv5uOTxSRP/Zlfyx8pwvQYettf0TzHwBftoQg8EWUdvGQSUrhYNTkJaHEMt90mnND
	 dL/Xxm06c7d2j9I8IymnJyGN9CGYF9PZAP+AG1HVBzf8AUcthPJhAd+k/qmq8hUeYV
	 2S4o5Gr48Y2AiD/EmI3wOWkLt4lpEWH0qz0kux7WL6fE8j+1ET//fwy1xbqVocSpXe
	 Ab5mRo9pg4yNjvuqxi0jb4bhYoSNsM4y2N6QC7+4YGcXRWzqXSt7GwZXmZewEqB/OX
	 /tdIXMaJ71vpUzz+qH2VBsIoFVA4QuLQubJhkLUBybYjH8dErW+BjxCo19oKKYayqc
	 wfHTbIuJlL9Jg==
Date: Tue, 19 Nov 2024 09:05:08 +0000
From: Will Deacon <will@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
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
Subject: Re: [PATCH v3 07/17] dma-mapping: Implement link/unlink ranges API
Message-ID: <20241119090507.GB28466@willie-the-truck>
References: <cover.1731244445.git.leon@kernel.org>
 <f8c7f160c9ae97fef4ccd355f9979727552c7374.1731244445.git.leon@kernel.org>
 <20241118145929.GB27795@willie-the-truck>
 <20241118185533.GA24154@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118185533.GA24154@unreal>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_010518_663748_F12471A5 
X-CRM114-Status: GOOD (  22.47  )
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

On Mon, Nov 18, 2024 at 08:55:33PM +0200, Leon Romanovsky wrote:
> On Mon, Nov 18, 2024 at 02:59:30PM +0000, Will Deacon wrote:
> > On Sun, Nov 10, 2024 at 03:46:54PM +0200, Leon Romanovsky wrote:
> > > +static void __iommu_dma_iova_unlink(struct device *dev,
> > > +		struct dma_iova_state *state, size_t offset, size_t size,
> > > +		enum dma_data_direction dir, unsigned long attrs,
> > > +		bool free_iova)
> > > +{
> > > +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> > > +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> > > +	struct iova_domain *iovad = &cookie->iovad;
> > > +	dma_addr_t addr = state->addr + offset;
> > > +	size_t iova_start_pad = iova_offset(iovad, addr);
> > > +	struct iommu_iotlb_gather iotlb_gather;
> > > +	size_t unmapped;
> > > +
> > > +	if ((state->__size & DMA_IOVA_USE_SWIOTLB) ||
> > > +	    (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)))
> > > +		iommu_dma_iova_unlink_range_slow(dev, addr, size, dir, attrs);
> > > +
> > > +	iommu_iotlb_gather_init(&iotlb_gather);
> > > +	iotlb_gather.queued = free_iova && READ_ONCE(cookie->fq_domain);
> > > +
> > > +	size = iova_align(iovad, size + iova_start_pad);
> > > +	addr -= iova_start_pad;
> > > +	unmapped = iommu_unmap_fast(domain, addr, size, &iotlb_gather);
> > > +	WARN_ON(unmapped != size);
> > 
> > Does the new API require that the 'size' passed to dma_iova_unlink()
> > exactly match the 'size' passed to the corresponding call to
> > dma_iova_link()? I ask because the IOMMU page-table code is built around
> > the assumption that partial unmap() operations never occur (i.e.
> > operations which could require splitting a huge mapping). We just
> > removed [1] that code from the Arm IO page-table implementations, so it
> > would be good to avoid adding it back for this.
> 
> dma_iova_link/dma_iova_unlink() don't have any assumptions in addition
> to already existing for dma_map_sg/dma_unmap_sg(). In reality, it means
> that all calls to unlink will have same size as for link.

Ok, great. Any chance you could call that out in the documentation patch,
please?

Will

