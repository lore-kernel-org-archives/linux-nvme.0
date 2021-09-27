Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7462DC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 18:51:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3619B60462
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 18:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3619B60462
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=aaIhco28M1qHrg3GFtSqo4m77kgXMKKVmMuBRNqg+tk=; b=KqGNbNthUf4WYm
	1SqF1mAXaAAidI+eDEK1Q6hq6ZVvfuImOhjEAJNhfIeKDZLW5V1SvjFHpuVFmHgELgMJaeAqkXDJB
	G3Z6kdiHsKVGeQOCTyd5m9S3Q2tzDAJftJJJo9idRp9qj/ldbGVyxHJ9Px86EqhouK161NZlRI81n
	Go/CRluzcFa3DCOrE3Q0eXQhV6WsS5jwWC+5Yhr9KkK9a1GaR8oVmzTbAS3NjFJFLenAjjcJ+jG74
	F+huXDzsr3YKF77lED4zfmiUsk2vzzAGEJAa9t4L3/3sDf+ZgHFg4am7R1f9eWZdSClKW2Wc6PoLV
	7aC6cMw6yGPcWyKLD2qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUviS-003qP5-Eb; Mon, 27 Sep 2021 18:51:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUviP-003qNc-B2
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 18:51:02 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9932A60FF2;
 Mon, 27 Sep 2021 18:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632768661;
 bh=k2U75S9hycwPlp5+wID80zDHl//3Y8/paTLDMvAioQM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=UiGsmazF0pWnH4PJv++Pc3qoV57uOH08K5QJJNjGF1YcGUP4WV8kgU0kScvdNul0f
 wsFexhiQ+OrXnOMHfhTBDaEwOebbHwizs+TDglY/05m9tFSdRkfw2BPGq5S9irGr4v
 xKCycfmgSfp44hpQbD3NpX0spcoShILfvx6pxDN+hdnBFxmd1nG6YKflsKrINUqr/i
 mODOdQCoSyl+//BrlyHw4aFcrOIfom6oGDPjKUzjmt/OsJt3cocks7xy3gDpYABdqM
 VSiASBD1dlEDX2AtBOYNl4ixAWKOPhe5JI9ce00vwSDeE2hNqp8o8xg5e/lLNSUdSA
 JgnAJe9AfYHlA==
Date: Mon, 27 Sep 2021 13:50:59 -0500
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
Subject: Re: [PATCH v3 13/20] PCI/P2PDMA: remove pci_p2pdma_[un]map_sg()
Message-ID: <20210927185059.GA668202@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-14-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_115101_443719_00BC903B 
X-CRM114-Status: GOOD (  20.90  )
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

On Thu, Sep 16, 2021 at 05:40:53PM -0600, Logan Gunthorpe wrote:
> This interface is superseded by support in dma_map_sg() which now supports
> heterogeneous scatterlists. There are no longer any users, so remove it.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Ditto.

> ---
>  drivers/pci/p2pdma.c       | 65 --------------------------------------
>  include/linux/pci-p2pdma.h | 27 ----------------
>  2 files changed, 92 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 58c34f1f1473..4478633346bd 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -878,71 +878,6 @@ enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
>  	return type;
>  }
>  
> -static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
> -		struct device *dev, struct scatterlist *sg, int nents)
> -{
> -	struct scatterlist *s;
> -	int i;
> -
> -	for_each_sg(sg, s, nents, i) {
> -		s->dma_address = sg_phys(s) - p2p_pgmap->bus_offset;
> -		sg_dma_len(s) = s->length;
> -	}
> -
> -	return nents;
> -}
> -
> -/**
> - * pci_p2pdma_map_sg_attrs - map a PCI peer-to-peer scatterlist for DMA
> - * @dev: device doing the DMA request
> - * @sg: scatter list to map
> - * @nents: elements in the scatterlist
> - * @dir: DMA direction
> - * @attrs: DMA attributes passed to dma_map_sg() (if called)
> - *
> - * Scatterlists mapped with this function should be unmapped using
> - * pci_p2pdma_unmap_sg_attrs().
> - *
> - * Returns the number of SG entries mapped or 0 on error.
> - */
> -int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
> -		int nents, enum dma_data_direction dir, unsigned long attrs)
> -{
> -	struct pci_p2pdma_pagemap *p2p_pgmap =
> -		to_p2p_pgmap(sg_page(sg)->pgmap);
> -
> -	switch (pci_p2pdma_map_type(sg_page(sg)->pgmap, dev)) {
> -	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> -		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
> -	case PCI_P2PDMA_MAP_BUS_ADDR:
> -		return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
> -	default:
> -		return 0;
> -	}
> -}
> -EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
> -
> -/**
> - * pci_p2pdma_unmap_sg_attrs - unmap a PCI peer-to-peer scatterlist that was
> - *	mapped with pci_p2pdma_map_sg()
> - * @dev: device doing the DMA request
> - * @sg: scatter list to map
> - * @nents: number of elements returned by pci_p2pdma_map_sg()
> - * @dir: DMA direction
> - * @attrs: DMA attributes passed to dma_unmap_sg() (if called)
> - */
> -void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
> -		int nents, enum dma_data_direction dir, unsigned long attrs)
> -{
> -	enum pci_p2pdma_map_type map_type;
> -
> -	map_type = pci_p2pdma_map_type(sg_page(sg)->pgmap, dev);
> -
> -	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
> -		dma_unmap_sg_attrs(dev, sg, nents, dir, attrs);
> -}
> -EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
> -
>  /**
>   * pci_p2pdma_map_segment - map an sg segment determining the mapping type
>   * @state: State structure that should be declared outside of the for_each_sg()
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index e5a8d5bc0f51..0c33a40a86e7 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -72,10 +72,6 @@ void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
>  void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
>  enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
>  					     struct device *dev);
> -int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
> -		int nents, enum dma_data_direction dir, unsigned long attrs);
> -void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
> -		int nents, enum dma_data_direction dir, unsigned long attrs);
>  enum pci_p2pdma_map_type
>  pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
>  		       struct scatterlist *sg);
> @@ -135,17 +131,6 @@ pci_p2pdma_map_type(struct dev_pagemap *pgmap, struct device *dev)
>  {
>  	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
>  }
> -static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
> -		struct scatterlist *sg, int nents, enum dma_data_direction dir,
> -		unsigned long attrs)
> -{
> -	return 0;
> -}
> -static inline void pci_p2pdma_unmap_sg_attrs(struct device *dev,
> -		struct scatterlist *sg, int nents, enum dma_data_direction dir,
> -		unsigned long attrs)
> -{
> -}
>  static inline enum pci_p2pdma_map_type
>  pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
>  		       struct scatterlist *sg)
> @@ -181,16 +166,4 @@ static inline struct pci_dev *pci_p2pmem_find(struct device *client)
>  	return pci_p2pmem_find_many(&client, 1);
>  }
>  
> -static inline int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg,
> -				    int nents, enum dma_data_direction dir)
> -{
> -	return pci_p2pdma_map_sg_attrs(dev, sg, nents, dir, 0);
> -}
> -
> -static inline void pci_p2pdma_unmap_sg(struct device *dev,
> -		struct scatterlist *sg, int nents, enum dma_data_direction dir)
> -{
> -	pci_p2pdma_unmap_sg_attrs(dev, sg, nents, dir, 0);
> -}
> -
>  #endif /* _LINUX_PCI_P2P_H */
> -- 
> 2.30.2
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
