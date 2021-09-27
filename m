Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE961C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 18:47:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABDB160FD7
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 18:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ABDB160FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=jPUS5BKUtPH0Jv1wYfKsbPO+MddhI4X+MhUIBjn8x0s=; b=aNC7LU6baPxqtm
	R58BWPOZuMCcRqYa8WUBSUqNewA80RzF4TEW8pUNPC2+1FZE+b8yIX3LXsICum0fnZI/cgyDpfFGq
	prUm/b1ePqhYTdbrFa5aAaGE58fSMGYwXBX/dxjBd3lMHY9qK8FMfqJJe0UbdV7J6SA9NySuZEFwM
	rO9BK7Dx7VTbtOOthU1ch/6f0jU7jC+SacT8f37vYbRtNMiWzApP36I7UTYagig31OWruQ0zi5hEX
	8efAc5wTDZCAEyn/VWirMsV6Naiwvu2Rl0IUGS2knAl72XvwzwRVWPCuOJjNcU98wzyGz5FOAR9jJ
	uzxfCGYOO9HQhZbxqG1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUveQ-003pR1-Me; Mon, 27 Sep 2021 18:46:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUveN-003pQ2-KU
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 18:46:53 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 351AC60F70;
 Mon, 27 Sep 2021 18:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632768410;
 bh=aAUpJLAvxQ+tHaQKvkiHUoC8zvr3SDhJ8uiCDNoeqXs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=qzynkof5Gd1zNVPHo3jVrAnP115kuAFhtBukKFpONdjp87NprCm91HDbrE/owxdhZ
 xxo+KOoGVV8xi+r/xixAGATY/mdBwwFHbvwyMTntL/h4E9NIije4CwzKImO+Ft2TkT
 esRYtMPRx+sjIdI+yAhG+ZMuViJGWjFRbn/mUsDAUOmzw+aAGycJPSGKcxVsrEIzp8
 X0mn6JIfspomXpax77aqWhehi+1mnH/vQ4jhS6hEKe6Mz0SIuDNSMiJKjScDPZ41Nq
 qTUq0ayObtqPUirRQM9z42nmYatHl4UCiTIAydz4MMVW/EurQNGzuSW/wTRFFDwp+A
 k19lzCPqTmXVQ==
Date: Mon, 27 Sep 2021 13:46:48 -0500
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
Subject: Re: [PATCH v3 03/20] PCI/P2PDMA: make pci_p2pdma_map_type() non-static
Message-ID: <20210927184648.GA667259@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-4-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_114651_735531_21241BE0 
X-CRM114-Status: GOOD (  33.56  )
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

On Thu, Sep 16, 2021 at 05:40:43PM -0600, Logan Gunthorpe wrote:
> pci_p2pdma_map_type() will be needed by the dma-iommu map_sg
> implementation because it will need to determine the mapping type
> ahead of actually doing the mapping to create the actual iommu mapping.

I don't expect this to go via the PCI tree, but if it did I would
silently:

  s/PCI/P2PDMA: make pci_p2pdma_map_type() non-static/
    PCI/P2PDMA: Expose pci_p2pdma_map_type()/
  s/iommu/IOMMU/

and mention what this patch does in the commit log (in addition to the
subject) and fix a couple minor typos below.

> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/p2pdma.c       | 24 +++++++++++++---------
>  include/linux/pci-p2pdma.h | 41 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 1192c465ba6d..b656d8c801a7 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -20,13 +20,6 @@
>  #include <linux/seq_buf.h>
>  #include <linux/xarray.h>
>  
> -enum pci_p2pdma_map_type {
> -	PCI_P2PDMA_MAP_UNKNOWN = 0,
> -	PCI_P2PDMA_MAP_NOT_SUPPORTED,
> -	PCI_P2PDMA_MAP_BUS_ADDR,
> -	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
> -};
> -
>  struct pci_p2pdma {
>  	struct gen_pool *pool;
>  	bool p2pmem_published;
> @@ -841,8 +834,21 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
>  
> -static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
> -						    struct device *dev)
> +/**
> + * pci_p2pdma_map_type - return the type of mapping that should be used for
> + *	a given device and pgmap
> + * @pgmap: the pagemap of a page to determine the mapping type for
> + * @dev: device that is mapping the page
> + *
> + * Returns one of:
> + *	PCI_P2PDMA_MAP_NOT_SUPPORTED - The mapping should not be done
> + *	PCI_P2PDMA_MAP_BUS_ADDR - The mapping should use the PCI bus address
> + *	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE - The mapping should be done normally
> + *		using the CPU physical address (in dma-direct) or an IOVA
> + *		mapping for the IOMMU.
> + */
> +enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
> +					     struct device *dev)
>  {
>  	enum pci_p2pdma_map_type type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
>  	struct pci_dev *provider = to_p2p_pgmap(pgmap)->provider;
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index 8318a97c9c61..caac2d023f8f 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -16,6 +16,40 @@
>  struct block_device;
>  struct scatterlist;
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
> +	 * PCI_P2PDMA_MAP_NOT_SUPPORTED: Indicates the transaction will
> +	 * traverse the host bridge and the host bridge is not in the
> +	 * whitelist. DMA Mapping routines should return an error when
> +	 * this is returned.
> +	 */
> +	PCI_P2PDMA_MAP_NOT_SUPPORTED,
> +
> +	/*
> +	 * PCI_P2PDMA_BUS_ADDR: Indicates that two devices can talk to
> +	 * eachother directly through a PCI switch and the transaction will
> +	 * not traverse the host bridge. Such a mapping should program
> +	 * the DMA engine with PCI bus addresses.

s/eachother/each other/

> +	 */
> +	PCI_P2PDMA_MAP_BUS_ADDR,
> +
> +	/*
> +	 * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE: Indicates two devices can talk
> +	 * to eachother, but the transaction traverses a host bridge on the
> +	 * whitelist. In this case, a normal mapping either with CPU physical
> +	 * addresses (in the case of dma-direct) or IOVA addresses (in the
> +	 * case of IOMMUs) should be used to program the DMA engine.

s/eachother/each other/

> +	 */
> +	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
> +};
> +
>  #ifdef CONFIG_PCI_P2PDMA
>  int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  		u64 offset);
> @@ -30,6 +64,8 @@ struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
>  					 unsigned int *nents, u32 length);
>  void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
>  void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
> +enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
> +					     struct device *dev);
>  int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>  		int nents, enum dma_data_direction dir, unsigned long attrs);
>  void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
> @@ -83,6 +119,11 @@ static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
>  static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>  {
>  }
> +static inline enum pci_p2pdma_map_type
> +pci_p2pdma_map_type(struct dev_pagemap *pgmap, struct device *dev)
> +{
> +	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
> +}
>  static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
>  		struct scatterlist *sg, int nents, enum dma_data_direction dir,
>  		unsigned long attrs)
> -- 
> 2.30.2
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
