Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3AED591AC
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 18:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D2akyTStHphlevLO8TuttvWyh3SNkfVhmMVdiV5tVXM=; b=hf6RufZSK9rb4HB7OT/4CmJytB
	jQ05ylo7JQbUXkEZbSPDRbKu7+CnSEc6dHMPEaJcLTCijYSLccVEFlXBrwJcYRmj/X0SKKgtF09co
	OS8KZnyTCYnYzYM9MnMmP44ehbOL9tBe1FY8grKrdFYwcCmFD8bny42AzaNBQH4xEopkF2saBUYTq
	yLkhMPy/mKEVVeK8Hemh4SZwxwcDQomxMEI0qsCy/GMgrcUWPZwzfu/hppVrTqMZ/nHGtS3XEJe6E
	pkhm2OBuGkQj/JX9QRCDPi2ArMINGce9MmB7mUClDIEaAGPxqAAYoeoDWIBv/+5nCZEbO2Oj2/tKW
	7Qvd2qhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tD6uV-0000000AOrf-0koX;
	Mon, 18 Nov 2024 18:55:43 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tD6uS-0000000AOqk-1oe8
	for linux-nvme@lists.infradead.org;
	Mon, 18 Nov 2024 18:55:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A6B1DA41ABB;
	Mon, 18 Nov 2024 18:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CA9C4CECC;
	Mon, 18 Nov 2024 18:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731956138;
	bh=/gmHJa/TBxEDstIIvnX3KmYFWImvFtyFP0gjXaeuHFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P67NkgKpagD5QPwkoLn48IDjtjZ7XiI7hB74ktXAOzTjzFx25SdPGIQTsJPn3c/+1
	 7mKXhe/08HVsqBRSEOx0tOKdadCpjOBrUyOGIzap4a8CF3tcQQzVYOpA4KCKlbL9eG
	 FZDNA127wqunzK1pyu+ixL9pn3cpHGQTiZ/HklwS4zlyqRfWpfZR7WpwvZo4s6XE1b
	 33uAWW/5I0UcpudrKi/56u1/L85PdWYLjkcUUGZXni1xcq/PN0bKJ29dpyNBUK3NkQ
	 hg7XGXtOx8q1P8cuRCDFQtSWlcXwLibDCDFZaRJ8t0FlQaoTBba1d1kPOW8eXaQxfI
	 AghFYrjiJkifw==
Date: Mon, 18 Nov 2024 20:55:33 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Will Deacon <will@kernel.org>
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
Message-ID: <20241118185533.GA24154@unreal>
References: <cover.1731244445.git.leon@kernel.org>
 <f8c7f160c9ae97fef4ccd355f9979727552c7374.1731244445.git.leon@kernel.org>
 <20241118145929.GB27795@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118145929.GB27795@willie-the-truck>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_105540_594999_660ED2B4 
X-CRM114-Status: GOOD (  24.64  )
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

On Mon, Nov 18, 2024 at 02:59:30PM +0000, Will Deacon wrote:
> On Sun, Nov 10, 2024 at 03:46:54PM +0200, Leon Romanovsky wrote:
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
> >              for (all pages)
> > 	       dma_map_page(...)
> > 
> > In unmap path:
> > 	if (dma_can_use_iova(...))
> > 	     dma_iova_destroy()
> > 	else
> > 	     for (all pages)
> > 		dma_unmap_page(...)
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/iommu/dma-iommu.c   | 259 ++++++++++++++++++++++++++++++++++++
> >  include/linux/dma-mapping.h |  32 +++++
> >  2 files changed, 291 insertions(+)
> 

<...>

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
> > +
> > +	size = iova_align(iovad, size + iova_start_pad);
> > +	addr -= iova_start_pad;
> > +	unmapped = iommu_unmap_fast(domain, addr, size, &iotlb_gather);
> > +	WARN_ON(unmapped != size);
> 
> Does the new API require that the 'size' passed to dma_iova_unlink()
> exactly match the 'size' passed to the corresponding call to
> dma_iova_link()? I ask because the IOMMU page-table code is built around
> the assumption that partial unmap() operations never occur (i.e.
> operations which could require splitting a huge mapping). We just
> removed [1] that code from the Arm IO page-table implementations, so it
> would be good to avoid adding it back for this.

dma_iova_link/dma_iova_unlink() don't have any assumptions in addition
to already existing for dma_map_sg/dma_unmap_sg(). In reality, it means
that all calls to unlink will have same size as for link.

Thanks

> 
> Will
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git/commit/?h=arm/smmu&id=33729a5fc0caf7a97d20507acbeee6b012e7e519

