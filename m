Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1BDC369D5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9iJH05flBZYZade1Q4AdF0jFljOufYmw1jcj0Sa8j/E=; b=fYrCiAbVmljdR3Oc/niEqPpV/x
	UK8VgEbGAewDPUihPDESvBJWADiMyPvI1k7S1LuUZtJZwJDuoKQ0P4bQhsvFWwpNfLHyVVdqjiRyZ
	QLeXtmofCTLvGFaDVEoLeOCX5OgwZwDMBai6NAMdc+oYDI5wWqD05mUXTHfhZ7wpq3oFR58StKnKe
	oJPC1JmJznT/qZVtnG3a0FH7jFGzLljYCwKZMS99TEnnk9dmk3QLtBnuJOCfELa2k3M3RdNKrNZ9H
	0kxq7LaGrx6UvPsoSi6shs6MOyszq42Li7cd/yMAZWzSJXfPqVtXpO3+0eD3ZobULlmONqKwR1n7n
	b+W1P0jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9O9b-00000006JP4-35n5;
	Mon, 28 Apr 2025 13:04:11 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8oIa-00000002ao6-0nmk
	for linux-nvme@lists.infradead.org;
	Sat, 26 Apr 2025 22:47:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 879F460008;
	Sat, 26 Apr 2025 22:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CF1C4CEE2;
	Sat, 26 Apr 2025 22:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745707592;
	bh=it71BWM3Pceo9WRIYilwNRCMXHq8+IvGJApDek517BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKGaQruU+xGKGdoV3l0Vdfka/Y45JUZ628iUFoujF9GwWY3FxppXFkzRMUG35MpSg
	 EaiOBb12LBgx+b82Q725iKeAXZvDOQrTrYDbpjGsFJD/9JoTAfzclwS22FBORZc6ek
	 YrQeuCfAS9736Zz+L8ezEhzujNRGjLTWdfKLTu8z+Sj/Nf/KYu+5QuqEX0RYVcxQVu
	 iuNkpiXmoht3Sz9eAnub+4DM+HlcT4q+qLJWPn7TfVySmbrV5ShZFLhZN6chXawY7/
	 o0K1zUEdi2U8Gb27lMdTVWTZAdL8kVWJyUyes55gZ+Haf+mBp0qPllLRO9rYmNiAcI
	 bgflnweJDU5Mw==
Date: Sat, 26 Apr 2025 15:46:30 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
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
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 07/24] dma-mapping: Implement link/unlink ranges API
Message-ID: <aA1iRtCsPkuprI-X@bombadil.infradead.org>
References: <cover.1745394536.git.leon@kernel.org>
 <2d6ca43ef8d26177d7674b9e3bdf0fe62b55a7ed.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d6ca43ef8d26177d7674b9e3bdf0fe62b55a7ed.1745394536.git.leon@kernel.org>
X-Mailman-Approved-At: Mon, 28 Apr 2025 05:19:58 -0700
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

On Wed, Apr 23, 2025 at 11:12:58AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Introduce new DMA APIs to perform DMA linkage of buffers
> in layers higher than DMA.
> 
> In proposed API, the callers will perform the following steps.
> In map path:
> 	if (dma_can_use_iova(...))
> 	    dma_iova_alloc()
> 	    for (page in range)
> 	       dma_iova_link_next(...)
> 	    dma_iova_sync(...)
> 	else
> 	     /* Fallback to legacy map pages */
>              for (all pages)
> 	       dma_map_page(...)
> 
> In unmap path:
> 	if (dma_can_use_iova(...))
> 	     dma_iova_destroy()
> 	else
> 	     for (all pages)
> 		dma_unmap_page(...)
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/iommu/dma-iommu.c   | 261 ++++++++++++++++++++++++++++++++++++
>  include/linux/dma-mapping.h |  32 +++++
>  2 files changed, 293 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d2c298083e0a..2e014db5a244 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1818,6 +1818,267 @@ void dma_iova_free(struct device *dev, struct dma_iova_state *state)
>  }
>  EXPORT_SYMBOL_GPL(dma_iova_free);
>  
> +static int __dma_iova_link(struct device *dev, dma_addr_t addr,
> +		phys_addr_t phys, size_t size, enum dma_data_direction dir,
> +		unsigned long attrs)
> +{
> +	bool coherent = dev_is_dma_coherent(dev);
> +
> +	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		arch_sync_dma_for_device(phys, size, dir);

So arch_sync_dma_for_device() is a no-op on some architectures, notably x86.
So since you're doing this work and given the above pattern is common on
the non iova case, we could save ourselves 2 branches checks on x86 on
__dma_iova_link() and also generalize savings for the non-iova case as
well. For the non-iova case we have two use cases, one with the attrs on
initial mapping, and one without on subsequent sync ops. For the iova
case the attr is always consistently used.

So we could just have something like this:

#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE
static inline void arch_sync_dma_device(struct device *dev,
                                        phys_addr_t paddr, size_t size,
                                        enum dma_data_direction dir)
{
    if (!dev_is_dma_coherent(dev))
        arch_sync_dma_for_device(paddr, size, dir);
}

static inline void arch_sync_dma_device_attrs(struct device *dev,
                                              phys_addr_t paddr, size_t size,
                                              enum dma_data_direction dir,
                                              unsigned long attrs)
{
    if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
        arch_sync_dma_for_device(paddr, size, dir);
}
#else
static inline void arch_sync_dma_device(struct device *dev,
                                        phys_addr_t paddr, size_t size,
                                        enum dma_data_direction dir)
{
}

static inline void arch_sync_dma_device_attrs(struct device *dev,
                                              phys_addr_t paddr, size_t size,
                                              enum dma_data_direction dir,
                                              unsigned long attrs)
{
}
#endif

> +/**
> + * dma_iova_link - Link a range of IOVA space
> + * @dev: DMA device
> + * @state: IOVA state
> + * @phys: physical address to link
> + * @offset: offset into the IOVA state to map into
> + * @size: size of the buffer
> + * @dir: DMA direction
> + * @attrs: attributes of mapping properties
> + *
> + * Link a range of IOVA space for the given IOVA state without IOTLB sync.
> + * This function is used to link multiple physical addresses in contiguous
> + * IOVA space without performing costly IOTLB sync.
> + *
> + * The caller is responsible to call to dma_iova_sync() to sync IOTLB at
> + * the end of linkage.
> + */
> +int dma_iova_link(struct device *dev, struct dma_iova_state *state,
> +		phys_addr_t phys, size_t offset, size_t size,
> +		enum dma_data_direction dir, unsigned long attrs)
> +{
> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +	struct iova_domain *iovad = &cookie->iovad;
> +	size_t iova_start_pad = iova_offset(iovad, phys);
> +
> +	if (WARN_ON_ONCE(iova_start_pad && offset > 0))
> +		return -EIO;
> +
> +	if (dev_use_swiotlb(dev, size, dir) && iova_offset(iovad, phys | size))

There is already a similar check for the non-iova case for this on
iommu_dma_map_page() and a nice comment about what why this checked,
this seems to be just screaming for a helper:

/*                                                                       
 * Checks if a physical buffer has unaligned boundaries with respect to
 * the IOMMU granule. Returns non-zero if either the start or end
 * address is not aligned to the granule boundary.
*/
static inline size_t iova_unaligned(struct iova_domain *iovad,
                                    phys_addr_t phys,
				    size_t size)
{                                                                                
	return iova_offset(iovad, phys | size);
}  

Other than that, looks good.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

