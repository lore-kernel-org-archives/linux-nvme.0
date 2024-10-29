Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82ABD3A66C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 15:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=q/ppnKPqjq1ZOWgFdXtmo78cQBjKVN58gXA7eOZBfs4=; b=GQFwtxj1sb5dNZ
	znTcPAO/O7TqH64dQyzhHsA+EzGsbVYRyBegMExwBf34R8hiz720S2Dxz2glLkBvkAqctphuzErM+
	ogKR6uuTiJYS9XBjAxZxqbw4E2tR0ODUFEZrJ3NoREWbpQXWVtj1aI3iUc+OgP81Z48cDNgcyyLdO
	lhM/A/hKsyLu1zKWSDIjytouPnLVsaGGnKTbZah4AazR5WK/alXwm4hst+bTFh4xusi5rDSin/S4F
	/RXjOQ5Y3YPY1kJryt4P8nDv1TWq9Jcv4DF0vaxlu8TuWFyPJvte23eCCDsHoyCBD3YaE8F0iGKqU
	b0A30NgCi9L77c8d6eEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5nv8-0000000ErJy-43QS;
	Tue, 29 Oct 2024 15:14:10 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5nsC-0000000EqVJ-03Ap
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 15:11:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id ED0DBA42F75;
	Tue, 29 Oct 2024 15:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518F5C4CEE5;
	Tue, 29 Oct 2024 15:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730214665;
	bh=SQQchx1vtsZlKAa985I87v+ow+U4p33UlUeg+FERc0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LyBQOUO2cEsu+Tni0G/a2shPNK+3v0pcWANBtQ3I2TpwqpZtXMDurKkmJNCB2oohh
	 FDq6iFWCCGs1KozCEG39c2+UBJ4oZAul+Fh/hrzx93pik7koNtaiystZtJXr9nHeci
	 OVwi2t8duMu/ih5zjJmkGrY1Z7RUHbWslWh8nCjnILiVUmGdP96opvDh6vYyZzJkDL
	 iqTq3OInuyi1xereyTOtUDDWIjp64Dk1bkhfTokQgnE7hOvGaX6nT86WvQCFXPs9aA
	 8JqhSVbH+n/fg2UKLL9y5lDCFyFvtph8fNrcQaCSJLpiFtY+LSFpMwaLG+EvyuCA64
	 9EBM45hwMqjQg==
Date: Tue, 29 Oct 2024 10:11:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
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
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 02/18] dma-mapping: move the PCI P2PDMA mapping helpers
 to pci-p2pdma.h
Message-ID: <20241029151104.GA1156518@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27698e7cc55f6ca5371c3d86c50fd3afce9afddd.1730037276.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_081108_299134_604C7049 
X-CRM114-Status: GOOD (  37.00  )
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

On Sun, Oct 27, 2024 at 04:21:02PM +0200, Leon Romanovsky wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> To support the upcoming non-scatterlist mapping helpers, we need to go
> back to have them called outside of the DMA API.  Thus move them out of
> dma-map-ops.h, which is only for DMA API implementations to pci-p2pdma.h,
> which is for driver use.
> 
> Note that the core helper is still not exported as the mapping is
> expected to be done only by very highlevel subsystem code at least for
> now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/iommu/dma-iommu.c   |  1 +
>  include/linux/dma-map-ops.h | 84 -------------------------------------
>  include/linux/pci-p2pdma.h  | 84 +++++++++++++++++++++++++++++++++++++
>  kernel/dma/direct.c         |  1 +
>  4 files changed, 86 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 6e50023c8112..c422e36c0d66 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -26,6 +26,7 @@
>  #include <linux/mutex.h>
>  #include <linux/of_iommu.h>
>  #include <linux/pci.h>
> +#include <linux/pci-p2pdma.h>
>  #include <linux/scatterlist.h>
>  #include <linux/spinlock.h>
>  #include <linux/swiotlb.h>
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 49edcbda19d1..6ee626e50708 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -435,88 +435,4 @@ static inline void debug_dma_dump_mappings(struct device *dev)
>  
>  extern const struct dma_map_ops dma_dummy_ops;
>  
> -enum pci_p2pdma_map_type {
> -	/*
> -	 * PCI_P2PDMA_MAP_UNKNOWN: Used internally for indicating the mapping
> -	 * type hasn't been calculated yet. Functions that return this enum
> -	 * never return this value.
> -	 */
> -	PCI_P2PDMA_MAP_UNKNOWN = 0,
> -
> -	/*
> -	 * Not a PCI P2PDMA transfer.
> -	 */
> -	PCI_P2PDMA_MAP_NONE,
> -
> -	/*
> -	 * PCI_P2PDMA_MAP_NOT_SUPPORTED: Indicates the transaction will
> -	 * traverse the host bridge and the host bridge is not in the
> -	 * allowlist. DMA Mapping routines should return an error when
> -	 * this is returned.
> -	 */
> -	PCI_P2PDMA_MAP_NOT_SUPPORTED,
> -
> -	/*
> -	 * PCI_P2PDMA_BUS_ADDR: Indicates that two devices can talk to
> -	 * each other directly through a PCI switch and the transaction will
> -	 * not traverse the host bridge. Such a mapping should program
> -	 * the DMA engine with PCI bus addresses.
> -	 */
> -	PCI_P2PDMA_MAP_BUS_ADDR,
> -
> -	/*
> -	 * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE: Indicates two devices can talk
> -	 * to each other, but the transaction traverses a host bridge on the
> -	 * allowlist. In this case, a normal mapping either with CPU physical
> -	 * addresses (in the case of dma-direct) or IOVA addresses (in the
> -	 * case of IOMMUs) should be used to program the DMA engine.
> -	 */
> -	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
> -};
> -
> -struct pci_p2pdma_map_state {
> -	struct dev_pagemap *pgmap;
> -	enum pci_p2pdma_map_type map;
> -	u64 bus_off;
> -};
> -
> -/* helper for pci_p2pdma_state(), do not use directly */
> -void __pci_p2pdma_update_state(struct pci_p2pdma_map_state *state,
> -		struct device *dev, struct page *page);
> -
> -/**
> - * pci_p2pdma_state - check the P2P transfer state of a page
> - * @state: 	P2P state structure
> - * @dev:	device to transfer to/from
> - * @page:	page to map
> - *
> - * Check if @page is a PCI P2PDMA page, and if yes of what kind.  Returns the
> - * map type, and updates @state with all information needed for a P2P transfer.
> - */
> -static inline enum pci_p2pdma_map_type
> -pci_p2pdma_state(struct pci_p2pdma_map_state *state, struct device *dev,
> -		struct page *page)
> -{
> -	if (IS_ENABLED(CONFIG_PCI_P2PDMA) && is_pci_p2pdma_page(page)) {
> -		if (state->pgmap != page->pgmap)
> -			__pci_p2pdma_update_state(state, dev, page);
> -		return state->map;
> -	}
> -	return PCI_P2PDMA_MAP_NONE;
> -}
> -
> -/**
> - * pci_p2pdma_bus_addr_map - map a PCI_P2PDMA_MAP_BUS_ADDR P2P transfer
> - * @state: 	P2P state structure
> - * @paddr:	physical address to map
> - *
> - * Map a physically contigous PCI_P2PDMA_MAP_BUS_ADDR transfer.
> - */
> -static inline dma_addr_t
> -pci_p2pdma_bus_addr_map(struct pci_p2pdma_map_state *state, phys_addr_t paddr)
> -{
> -	WARN_ON_ONCE(state->map != PCI_P2PDMA_MAP_BUS_ADDR);
> -	return paddr + state->bus_off;
> -}
> -
>  #endif /* _LINUX_DMA_MAP_OPS_H */
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index 2c07aa6b7665..66b71f60a811 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -104,4 +104,88 @@ static inline struct pci_dev *pci_p2pmem_find(struct device *client)
>  	return pci_p2pmem_find_many(&client, 1);
>  }
>  
> +enum pci_p2pdma_map_type {
> +	/*
> +	 * PCI_P2PDMA_MAP_UNKNOWN: Used internally for indicating the mapping
> +	 * type hasn't been calculated yet. Functions that return this enum
> +	 * never return this value.
> +	 */
> +	PCI_P2PDMA_MAP_UNKNOWN = 0,
> +
> +	/*
> +	 * Not a PCI P2PDMA transfer.
> +	 */
> +	PCI_P2PDMA_MAP_NONE,
> +
> +	/*
> +	 * PCI_P2PDMA_MAP_NOT_SUPPORTED: Indicates the transaction will
> +	 * traverse the host bridge and the host bridge is not in the
> +	 * allowlist. DMA Mapping routines should return an error when
> +	 * this is returned.
> +	 */
> +	PCI_P2PDMA_MAP_NOT_SUPPORTED,
> +
> +	/*
> +	 * PCI_P2PDMA_BUS_ADDR: Indicates that two devices can talk to
> +	 * each other directly through a PCI switch and the transaction will
> +	 * not traverse the host bridge. Such a mapping should program
> +	 * the DMA engine with PCI bus addresses.
> +	 */
> +	PCI_P2PDMA_MAP_BUS_ADDR,
> +
> +	/*
> +	 * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE: Indicates two devices can talk
> +	 * to each other, but the transaction traverses a host bridge on the
> +	 * allowlist. In this case, a normal mapping either with CPU physical
> +	 * addresses (in the case of dma-direct) or IOVA addresses (in the
> +	 * case of IOMMUs) should be used to program the DMA engine.
> +	 */
> +	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
> +};
> +
> +struct pci_p2pdma_map_state {
> +	struct dev_pagemap *pgmap;
> +	enum pci_p2pdma_map_type map;
> +	u64 bus_off;
> +};
> +
> +/* helper for pci_p2pdma_state(), do not use directly */
> +void __pci_p2pdma_update_state(struct pci_p2pdma_map_state *state,
> +		struct device *dev, struct page *page);
> +
> +/**
> + * pci_p2pdma_state - check the P2P transfer state of a page
> + * @state: 	P2P state structure
> + * @dev:	device to transfer to/from
> + * @page:	page to map
> + *
> + * Check if @page is a PCI P2PDMA page, and if yes of what kind.  Returns the
> + * map type, and updates @state with all information needed for a P2P transfer.
> + */
> +static inline enum pci_p2pdma_map_type
> +pci_p2pdma_state(struct pci_p2pdma_map_state *state, struct device *dev,
> +		struct page *page)
> +{
> +	if (IS_ENABLED(CONFIG_PCI_P2PDMA) && is_pci_p2pdma_page(page)) {
> +		if (state->pgmap != page->pgmap)
> +			__pci_p2pdma_update_state(state, dev, page);
> +		return state->map;
> +	}
> +	return PCI_P2PDMA_MAP_NONE;
> +}
> +
> +/**
> + * pci_p2pdma_bus_addr_map - map a PCI_P2PDMA_MAP_BUS_ADDR P2P transfer
> + * @state: 	P2P state structure
> + * @paddr:	physical address to map
> + *
> + * Map a physically contigous PCI_P2PDMA_MAP_BUS_ADDR transfer.
> + */
> +static inline dma_addr_t
> +pci_p2pdma_bus_addr_map(struct pci_p2pdma_map_state *state, phys_addr_t paddr)
> +{
> +	WARN_ON_ONCE(state->map != PCI_P2PDMA_MAP_BUS_ADDR);
> +	return paddr + state->bus_off;
> +}
> +
>  #endif /* _LINUX_PCI_P2P_H */
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index a793400161c2..47e124561fff 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -13,6 +13,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/set_memory.h>
>  #include <linux/slab.h>
> +#include <linux/pci-p2pdma.h>
>  #include "direct.h"
>  
>  /*
> -- 
> 2.46.2
> 

