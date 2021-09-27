Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B1EC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 18:54:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F66D60527
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 18:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F66D60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=efpBvHuHi63t+T1KfbTMDF9IUbdtMQU7RXUCwWZGwR4=; b=JcDaUXKUv1KGIq
	C5NrG5/gxrnLD2IfKzcQufejHVqWvDE8JJCZdiW31EAEE5JTj0Xn1zrsZHsbksn77XRk3atBSNqZe
	y93WaxeuzDdZt4YVQcLqjES6YWKvpuFFSd7AnKaAwsbK5KAd1jBsxsQ+IU4VdpULJPsYRDVxsU4KU
	f5QpA0chmx/5VFNaFESHZIn2UUQfYw3x+9ojMXegVItAdfwVZZykceoQdcJNJbKi0NXuyZKRygtto
	aHIHLBuwY5vJmHn34JqLCUoLkivrzhpHJD71gcBE/FEkdZ3tJvq1SLa+1togUKxEU4+OkHeViuRmr
	GJ6qu9dnOJonZlUa64PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUvlC-003r5b-0z; Mon, 27 Sep 2021 18:53:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUvl8-003r3x-Cr
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 18:53:52 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9428960FD7;
 Mon, 27 Sep 2021 18:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632768830;
 bh=WQXS4Y5fxYTqqCk1J2d4JT7fGZFmk/5NLpzr/2vNoXg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=j+h82KEneKoIWmmfnU8bIarGfEsel7wnR0BgUFxYi+ROqggCWKJnSfSd4xp0oxArs
 4VZ3GUIs2qvJ7umsIGdOIUVhWigEcUG6BYJSlBElcymvcmm6xrYw7j5G4DYvOaXKVv
 6dsZLPWsl0rLoNrKwUAvPv0qEObRggFeNWlDYbFZcW5Fdh2/SXwRvmg2RelqMfK2xm
 3TxFsNqMUL6jRiFjOXsLJtYmZgIJGtPeY2plkKXC9gyiSASDMWeU3hsWDDsbttu6fx
 OydU71hNxH55bR/qjyo/saP9MWkZNX264D5M9bEfYe9wPiAMA0JBosJDzbsQP19KUC
 en1lkEz7/wQUg==
Date: Mon, 27 Sep 2021 13:53:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 04/20] PCI/P2PDMA: introduce helpers for dma_map_sg
 implementations
Message-ID: <20210927185348.GA668256@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-5-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_115350_538957_A5437117 
X-CRM114-Status: GOOD (  28.66  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 16, 2021 at 05:40:44PM -0600, Logan Gunthorpe wrote:
> Add pci_p2pdma_map_segment() as a helper for simple dma_map_sg()
> implementations. It takes an scatterlist segment that must point to a
> pci_p2pdma struct page and will map it if the mapping requires a bus
> address.
> 
> The return value indicates whether the mapping required a bus address
> or whether the caller still needs to map the segment normally. If the
> segment should not be mapped, -EREMOTEIO is returned.
> 
> This helper uses a state structure to track the changes to the
> pgmap across calls and avoid needing to lookup into the xarray for
> every page.
> 
> Also add pci_p2pdma_map_bus_segment() which is useful for IOMMU
> dma_map_sg() implementations where the sg segment containing the page
> differs from the sg segment containing the DMA address.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Ditto.

> ---
>  drivers/pci/p2pdma.c       | 59 ++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-p2pdma.h | 21 ++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index b656d8c801a7..58c34f1f1473 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -943,6 +943,65 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>  
> +/**
> + * pci_p2pdma_map_segment - map an sg segment determining the mapping type
> + * @state: State structure that should be declared outside of the for_each_sg()
> + *	loop and initialized to zero.
> + * @dev: DMA device that's doing the mapping operation
> + * @sg: scatterlist segment to map
> + *
> + * This is a helper to be used by non-iommu dma_map_sg() implementations where
> + * the sg segment is the same for the page_link and the dma_address.

s/non-iommu/non-IOMMU/

> + *
> + * Attempt to map a single segment in an SGL with the PCI bus address.
> + * The segment must point to a PCI P2PDMA page and thus must be
> + * wrapped in a is_pci_p2pdma_page(sg_page(sg)) check.
> + *
> + * Returns the type of mapping used and maps the page if the type is
> + * PCI_P2PDMA_MAP_BUS_ADDR.
> + */
> +enum pci_p2pdma_map_type
> +pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
> +		       struct scatterlist *sg)
> +{
> +	if (state->pgmap != sg_page(sg)->pgmap) {
> +		state->pgmap = sg_page(sg)->pgmap;
> +		state->map = pci_p2pdma_map_type(state->pgmap, dev);
> +		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
> +	}
> +
> +	if (state->map == PCI_P2PDMA_MAP_BUS_ADDR) {
> +		sg->dma_address = sg_phys(sg) + state->bus_off;
> +		sg_dma_len(sg) = sg->length;
> +		sg_dma_mark_pci_p2pdma(sg);
> +	}
> +
> +	return state->map;
> +}
> +
> +/**
> + * pci_p2pdma_map_bus_segment - map an sg segment pre determined to
> + *	be mapped with PCI_P2PDMA_MAP_BUS_ADDR
> + * @pg_sg: scatterlist segment with the page to map
> + * @dma_sg: scatterlist segment to assign a dma address to

s/dma address/DMA address/, also below

> + *
> + * This is a helper for iommu dma_map_sg() implementations when the
> + * segment for the dma address differs from the segment containing the
> + * source page.
> + *
> + * pci_p2pdma_map_type() must have already been called on the pg_sg and
> + * returned PCI_P2PDMA_MAP_BUS_ADDR.
> + */
> +void pci_p2pdma_map_bus_segment(struct scatterlist *pg_sg,
> +				struct scatterlist *dma_sg)
> +{
> +	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(sg_page(pg_sg)->pgmap);
> +
> +	dma_sg->dma_address = sg_phys(pg_sg) + pgmap->bus_offset;
> +	sg_dma_len(dma_sg) = pg_sg->length;
> +	sg_dma_mark_pci_p2pdma(dma_sg);
> +}
> +
>  /**
>   * pci_p2pdma_enable_store - parse a configfs/sysfs attribute store
>   *		to enable p2pdma
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index caac2d023f8f..e5a8d5bc0f51 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -13,6 +13,12 @@
>  
>  #include <linux/pci.h>
>  
> +struct pci_p2pdma_map_state {
> +	struct dev_pagemap *pgmap;
> +	int map;
> +	u64 bus_off;
> +};
> +
>  struct block_device;
>  struct scatterlist;
>  
> @@ -70,6 +76,11 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>  		int nents, enum dma_data_direction dir, unsigned long attrs);
>  void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>  		int nents, enum dma_data_direction dir, unsigned long attrs);
> +enum pci_p2pdma_map_type
> +pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
> +		       struct scatterlist *sg);
> +void pci_p2pdma_map_bus_segment(struct scatterlist *pg_sg,
> +				struct scatterlist *dma_sg);
>  int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
>  			    bool *use_p2pdma);
>  ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
> @@ -135,6 +146,16 @@ static inline void pci_p2pdma_unmap_sg_attrs(struct device *dev,
>  		unsigned long attrs)
>  {
>  }
> +static inline enum pci_p2pdma_map_type
> +pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
> +		       struct scatterlist *sg)
> +{
> +	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
> +}
> +static inline void pci_p2pdma_map_bus_segment(struct scatterlist *pg_sg,
> +					      struct scatterlist *dma_sg)
> +{
> +}
>  static inline int pci_p2pdma_enable_store(const char *page,
>  		struct pci_dev **p2p_dev, bool *use_p2pdma)
>  {
> -- 
> 2.30.2
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
