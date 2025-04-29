Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E7EC369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 18:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SFgrjIY+SQtCPii0hJBqyXHSTgDlXLalpbQltj/vhsU=; b=gc46+x2xr5GPkL7OA/dL2hrFr3
	p69ALPchEUmYvoh24w24YHLseFXnyeIp4NK7nYvYJ8RUPjHDrseRhePiS0Cu9wj4uR4UHQA0ET+7W
	NjdK6Ut3+P0J7jlyXqaHvEI1JtZ58vLR5MD77viYDTD7TiE5gbngpLeUcpVcymY4DeVhzrGwbwaZM
	uYgj19xKUgsZHuwchEG/t09hfsYXy8CNHR4e/yuqrCuQmYXwfZ0AcPcs+qawd+Vm8Dw8vVxEgtIj7
	fFb6wPPEVcqDkFqcbjZDofrDPaLMh243EcV3/1K3IRsACDHB2TqU4sso6sWL1FxkNI85ubc6n1gjX
	pgGmGNuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9pbh-0000000AWHX-3I6l;
	Tue, 29 Apr 2025 18:23:01 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9dnF-00000008QO1-0mnI
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 05:46:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 65190A4B7A4;
	Tue, 29 Apr 2025 05:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF06C4CEE3;
	Tue, 29 Apr 2025 05:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745905567;
	bh=ZlzjgR8ZCmhh7ln3bWsTRkN7njOkthtsCcGhOVJD370=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OPIJHlt8bTW2SZgZvCQl0TtC/C7oWnwza0G162u6trNqiDyxNtzHYyjIBFxHIMyHP
	 kNYqu6Gd4ME2eiPecfo02OZnUJNpPqZ11ior8m1BTlK5ogMz8NZw8SNe7GhZl9kwTJ
	 AE9Uu94aifbn/PGHOYs6Xv+jxIIqUi/Vde5glUd+VZ5LXI9CAkEAbHZUqkqCHxgTf8
	 5FlvFRf8qZr6a1Vlk2E6XTcc/QgHu16QEmaS6D/ZS8tOk76ZJl2EWdi8dagzkXZD/z
	 cAVfMvTVwCBZimzwv4w3tYH/7v26KFBOlhohXUM8B1HoNMgXXtnUSEr5ZpJvKIxX2N
	 MhsioMleKoeXg==
Date: Tue, 29 Apr 2025 08:46:02 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v10 05/24] dma-mapping: Provide an interface to allow
 allocate IOVA
Message-ID: <20250429054602.GI5848@unreal>
References: <cover.1745831017.git.leon@kernel.org>
 <30f0601d400711b3859deeb8fef3090f5b2020a4.1745831017.git.leon@kernel.org>
 <0086302d-1cb3-43dd-a989-e4b1995a0d22@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0086302d-1cb3-43dd-a989-e4b1995a0d22@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_224609_352772_59DF3FCB 
X-CRM114-Status: GOOD (  40.96  )
X-Mailman-Approved-At: Tue, 29 Apr 2025 11:22:51 -0700
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

On Tue, Apr 29, 2025 at 11:10:54AM +0800, Baolu Lu wrote:
> On 4/28/25 17:22, Leon Romanovsky wrote:
> > From: Leon Romanovsky<leonro@nvidia.com>
> > 
> > The existing .map_page() callback provides both allocating of IOVA
> 
> .map_pages()

Changed, thanks

> 
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
> > In the new API a DMA mapping transaction is identified by a
> > struct dma_iova_state, which holds some recomputed information
> > for the transaction which does not change for each page being
> > mapped, so add a check if IOVA can be used for the specific
> > transaction.
> > 
> > The API is exported from dma-iommu as it is the only implementation
> > supported, the namespace is clearly different from iommu_* functions
> > which are not allowed to be used. This code layout allows us to save
> > function call per API call used in datapath as well as a lot of boilerplate
> > code.
> > 
> > Reviewed-by: Christoph Hellwig<hch@lst.de>
> > Tested-by: Jens Axboe<axboe@kernel.dk>
> > Reviewed-by: Luis Chamberlain<mcgrof@kernel.org>
> > Signed-off-by: Leon Romanovsky<leonro@nvidia.com>
> > ---
> >   drivers/iommu/dma-iommu.c   | 86 +++++++++++++++++++++++++++++++++++++
> >   include/linux/dma-mapping.h | 48 +++++++++++++++++++++
> >   2 files changed, 134 insertions(+)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 9ba8d8bc0ce9..d3211a8d755e 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -1723,6 +1723,92 @@ size_t iommu_dma_max_mapping_size(struct device *dev)
> >   	return SIZE_MAX;
> >   }
> > +/**
> > + * dma_iova_try_alloc - Try to allocate an IOVA space
> > + * @dev: Device to allocate the IOVA space for
> > + * @state: IOVA state
> > + * @phys: physical address
> > + * @size: IOVA size
> > + *
> > + * Check if @dev supports the IOVA-based DMA API, and if yes allocate IOVA space
> > + * for the given base address and size.
> > + *
> > + * Note: @phys is only used to calculate the IOVA alignment. Callers that always
> > + * do PAGE_SIZE aligned transfers can safely pass 0 here.
> 
> Have you considered adding a direct alignment parameter to
> dma_iova_try_alloc()? '0' simply means the default PAGE_SIZE alignment.
> 
> I'm imagining that some devices might have particular alignment needs
> for better performance, especially for the ATS cache efficiency. This
> would allow those device drivers to express the requirements directly
> during iova allocation.

This is actually what is happening now, take a look in
blk_rq_dma_map_iter_start() implementation, which uses custom alignment.

> 
> > + *
> > + * Returns %true if the IOVA-based DMA API can be used and IOVA space has been
> > + * allocated, or %false if the regular DMA API should be used.
> > + */
> > +bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
> > +		phys_addr_t phys, size_t size)
> > +{
> > +	struct iommu_dma_cookie *cookie;
> > +	struct iommu_domain *domain;
> > +	struct iova_domain *iovad;
> > +	size_t iova_off;
> > +	dma_addr_t addr;
> > +
> > +	memset(state, 0, sizeof(*state));
> > +	if (!use_dma_iommu(dev))
> > +		return false;
> > +
> > +	domain = iommu_get_dma_domain(dev);
> > +	cookie = domain->iova_cookie;
> > +	iovad = &cookie->iovad;
> > +	iova_off = iova_offset(iovad, phys);
> > +
> > +	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
> > +	    iommu_deferred_attach(dev, iommu_get_domain_for_dev(dev)))
> > +		return false;
> > +
> > +	if (WARN_ON_ONCE(!size))
> > +		return false;
> > +
> > +	/*
> > +	 * DMA_IOVA_USE_SWIOTLB is flag which is set by dma-iommu
> > +	 * internals, make sure that caller didn't set it and/or
> > +	 * didn't use this interface to map SIZE_MAX.
> > +	 */
> > +	if (WARN_ON_ONCE((u64)size & DMA_IOVA_USE_SWIOTLB))
> 
> I'm a little concerned that device drivers might inadvertently misuse
> the state->__size by forgetting about the high bit being used for
> DMA_IOVA_USE_SWIOTLB. Perhaps adding a separate flag within struct
> dma_iova_state to prevent such issues?

Device drivers are not supposed to use this DMA API interface and the
vision that subsystems will provide specific to them wrappers. See HMM,
and block changes as an example. VFIO mlx5 implementation is a temporary
measure till we convert another VFIO LM driver to get understanding what
type of abstraction we will need.

The high bit is used to save memory.

> 
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
> > +EXPORT_SYMBOL_GPL(dma_iova_try_alloc);
> 
> Thanks,
> baolu
> 

