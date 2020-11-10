Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA28BC4742C
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 23:25:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C4A20781
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 23:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qdOQcAUZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPV32dPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C4A20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:Subject:To:From:
	Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	 bh=Go3R695DHX/TQoeXilW3mPtBS+kIGDdxi+oTdTDCl4c=; b=qdOQcAUZyGKocZQSwePtYr/01
	jJw9MRln6oeLKAm83lVCSnxNWXMW07GkrTjZOzrYmhZMP5v53PdFZoLSA+1eHT+pVGjVurzuP+RH1
	1AUKsfXpBznBVQ+SKnL9PZlqtuLfvq29Qmk8ryWW5l3xsqxwuWD/2buT26dYlh9kOJZ5NNTuPCKqE
	h4n7fcpQLzTYqz+dJhEn4UIPefPrsR8rbFoPTxwgb6IuOVistNsmS7pA4TJXKjpS6LgEFwYOJRMsg
	xZG5Ju41G15R43+Kl37IoOopnvD4OmlHH64Yr1tKFnDgU0yn6K4mleujrX6g2sCbvI2J3FEixtj/h
	TT/BpEkfA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcd0q-0008Gm-SM; Tue, 10 Nov 2020 23:25:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcd0n-0008FC-Jn
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 23:25:18 +0000
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BC9BC20781;
 Tue, 10 Nov 2020 23:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605050715;
 bh=o6lMTu5xFOzYsPde49ClXFU1xXCgPh17zPTl4Yx9dys=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=dPV32dPJxAhqlhllWUsMt1gC7dOq85ACuyi2fnWL+r9/kPB0YaAY/q+UhWjLeQo7V
 ZDoeayJFbRzQ9/aW39itkyKKH8s+us5oMd9a8UfsuIgKpGjmBDN1DXk5OlpCVC2zRi
 xPJXtoRNKmQs4fail2G1MnvjO16Ve1HVNwPMHkTo=
Date: Tue, 10 Nov 2020 17:25:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 03/15] PCI/P2PDMA: Introduce
 pci_p2pdma_should_map_bus() and pci_p2pdma_bus_offset()
Message-ID: <20201110232513.GA705726@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201106170036.18713-4-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201110_182517_820565_BD15051C 
X-CRM114-Status: GOOD (  27.51  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ira Weiny <iweiny@intel.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Don Dutile <ddutile@redhat.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 06, 2020 at 10:00:24AM -0700, Logan Gunthorpe wrote:
> Introduce pci_p2pdma_should_map_bus() which is meant to be called by
> dma map functions to determine how to map a given p2pdma page.

s/dma/DMA/ for consistency (also below in function comment)

> pci_p2pdma_bus_offset() is also added to allow callers to get the bus
> offset if they need to map the bus address.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/p2pdma.c       | 46 ++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-p2pdma.h | 11 +++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index ea8472278b11..9961e779f430 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -930,6 +930,52 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>  
> +/**
> + * pci_p2pdma_bus_offset - returns the bus offset for a given page
> + * @page: page to get the offset for
> + *
> + * Must be passed a pci p2pdma page.

s/pci/PCI/

> + */
> +u64 pci_p2pdma_bus_offset(struct page *page)
> +{
> +	struct pci_p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(page->pgmap);
> +
> +	WARN_ON(!is_pci_p2pdma_page(page));
> +
> +	return p2p_pgmap->bus_offset;
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pdma_bus_offset);
> +
> +/**
> + * pci_p2pdma_should_map_bus - determine if a dma mapping should use the
> + *	bus address
> + * @dev: device doing the DMA request
> + * @pgmap: dev_pagemap structure for the mapping
> + *
> + * Returns 1 if the page should be mapped with a bus address, 0 otherwise
> + * and -1 the device should not be mapping P2PDMA pages.

I think this is missing a word.

I'm not really sure how to interpret the "should" in
pci_p2pdma_should_map_bus().  If this returns -1, does that mean the
patches *cannot* be mapped?  They *could* be mapped, but you really
*shouldn't*?  Something else?

1 means page should be mapped with bus address.  0 means ... what,
exactly?  It should be mapped with some different address?

Sorry these are naive questions because I don't know how all this
works.

> + */
> +int pci_p2pdma_should_map_bus(struct device *dev, struct dev_pagemap *pgmap)
> +{
> +	struct pci_p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(pgmap);
> +	struct pci_dev *client;
> +
> +	if (!dev_is_pci(dev))
> +		return -1;
> +
> +	client = to_pci_dev(dev);
> +
> +	switch (pci_p2pdma_map_type(p2p_pgmap->provider, client)) {
> +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +		return 0;
> +	case PCI_P2PDMA_MAP_BUS_ADDR:
> +		return 1;
> +	default:
> +		return -1;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pdma_should_map_bus);
> +
>  /**
>   * pci_p2pdma_enable_store - parse a configfs/sysfs attribute store
>   *		to enable p2pdma
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index 8318a97c9c61..fc5de47eeac4 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -34,6 +34,8 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>  		int nents, enum dma_data_direction dir, unsigned long attrs);
>  void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>  		int nents, enum dma_data_direction dir, unsigned long attrs);
> +u64 pci_p2pdma_bus_offset(struct page *page);
> +int pci_p2pdma_should_map_bus(struct device *dev, struct dev_pagemap *pgmap);
>  int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
>  			    bool *use_p2pdma);
>  ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
> @@ -83,6 +85,15 @@ static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
>  static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>  {
>  }
> +static inline u64 pci_p2pdma_bus_offset(struct page *page)
> +{
> +	return -1;
> +}
> +static inline int pci_p2pdma_should_map_bus(struct device *dev,
> +					    struct dev_pagemap *pgmap)
> +{
> +	return -1;
> +}
>  static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
>  		struct scatterlist *sg, int nents, enum dma_data_direction dir,
>  		unsigned long attrs)
> -- 
> 2.20.1
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
