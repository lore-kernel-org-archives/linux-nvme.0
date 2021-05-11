Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A756BC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:11:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6BB61221
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6BB61221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/V7zi0C5mIU9hCS5vgVBOw5nJ+JVaGn6GiCO8CtnKu0=; b=phEZxlCoFodxi3awXJLUGNfV/
	bXIhB9sYvcAV5tGNgpVg1OgewE6khCF60p33KtmTfJ7W6fBp4tZ2Gd2nhaC847K5DyM+WuuPzbSys
	uLU30aGl8oLSf4i0SzSPzu2/uHeTs3djfkvbnaLUa21SK3OY62atsNvVUMtNn9isXVtaJYKqrzhiI
	dlDiVUN6F1FUKyUxBxH6fNOwtOj6Cv+GnG8KeTNpAeU0YUV8WhLVs4G66+tJM70fkRzBurvsNYHei
	wfJKrG790ZYVFmpC1oMOL6e37BXyjB5rbvtovbSSpfGi8wa3TM/p11UP3JkZKgoVF5ncIHTR0KvCn
	SXpxpzcMQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgUym-000gV3-Ir; Tue, 11 May 2021 16:11:29 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgUvD-000fil-JD
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 16:07:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=tMAIqc3ynAUjVNMmJZyA97GO/AXkgEpCMde9bMg3dSI=; b=doN+dm8v4zOVY/scH4ToPExzSI
 aiYRX+J1rWyPHWJ83rocg/viMS39Os9tgUIs/Z4n3tyHxL/HOcIDE7KFPYv6biLcmffvPLPpSYtJM
 LuX7iVT2pejgUfOlPqFXch2J2ZUBbqiCdEEd4+FoHKHuLyJWuDik2B2IbVZy742GrbkfI4tuj85/v
 DAUbOv9sxLKnRIUPWV1n3cEO2imAMLljKOE5Dj4nvrQMHwXzCtmq4pxTAoR7QUKbxLUOzsVgol8HF
 kw20ijUAFqtDmmEyYAfYe4hR8YywnM99yyKX+nkygenu6BKrXaSz+0b93LOVlHy51oVoANmpHkdzG
 qh8k10jQ==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgUvA-009k2S-O0
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 16:07:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620749263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tMAIqc3ynAUjVNMmJZyA97GO/AXkgEpCMde9bMg3dSI=;
 b=MDBF+iRVaWCFOFCj41522rJWBj4ArxI0z3fkIP3L1mDBX2lTotzCCU6HpsnqmfWgQIZfjA
 dqhfEfGCP6VoOtsuU1IWeR67CIljtBQD9eWjLqp1Hml7RMcSoO5tK6syoQ+1RINEz7ZAtm
 r+yEpi71LzvM5jFIXb5c4ljNbOoge+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-qB9XlPV8NbqOjRN04e3B5A-1; Tue, 11 May 2021 12:06:16 -0400
X-MC-Unique: qB9XlPV8NbqOjRN04e3B5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F7ED8C8640;
 Tue, 11 May 2021 16:06:12 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30ECA6E53E;
 Tue, 11 May 2021 16:06:08 +0000 (UTC)
Subject: Re: [PATCH 07/16] PCI/P2PDMA: Make pci_p2pdma_map_type() non-static
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-8-logang@deltatee.com>
From: Don Dutile <ddutile@redhat.com>
Message-ID: <a2da7566-7e0d-6a3a-055d-4d324deba4af@redhat.com>
Date: Tue, 11 May 2021 12:06:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-8-logang@deltatee.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_090744_976831_9F4218DA 
X-CRM114-Status: GOOD (  32.47  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/8/21 1:01 PM, Logan Gunthorpe wrote:
> pci_p2pdma_map_type() will be needed by the dma-iommu map_sg
> implementation because it will need to determine the mapping type
> ahead of actually doing the mapping to create the actual iommu mapping.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/pci/p2pdma.c       | 34 +++++++++++++++++++++++-----------
>   include/linux/pci-p2pdma.h | 15 +++++++++++++++
>   2 files changed, 38 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index bcb1a6d6119d..38c93f57a941 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -20,13 +20,6 @@
>   #include <linux/seq_buf.h>
>   #include <linux/xarray.h>
>   
> -enum pci_p2pdma_map_type {
> -	PCI_P2PDMA_MAP_UNKNOWN = 0,
> -	PCI_P2PDMA_MAP_NOT_SUPPORTED,
> -	PCI_P2PDMA_MAP_BUS_ADDR,
> -	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
> -};
> -
>   struct pci_p2pdma {
>   	struct gen_pool *pool;
>   	bool p2pmem_published;
> @@ -822,13 +815,30 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>   }
>   EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
>   
> -static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
> -						    struct device *dev)
> +/**
> + * pci_p2pdma_map_type - return the type of mapping that should be used for
> + *	a given device and pgmap
> + * @pgmap: the pagemap of a page to determine the mapping type for
> + * @dev: device that is mapping the page
> + * @dma_attrs: the attributes passed to the dma_map operation --
> + *	this is so they can be checked to ensure P2PDMA pages were not
> + *	introduced into an incorrect interface (like dma_map_sg). *
> + *
> + * Returns one of:
> + *	PCI_P2PDMA_MAP_NOT_SUPPORTED - The mapping should not be done
> + *	PCI_P2PDMA_MAP_BUS_ADDR - The mapping should use the PCI bus address
> + *	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE - The mapping should be done directly
> + */
I'd recommend putting these descriptions in the enum's in pci-p2pdma.h .
Also, can you use a better description for THRU_HOST_BRIDGE -- it leaves the reader wondering what 'done directly' means.

Thanks.
-dd

> +enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
> +		struct device *dev, unsigned long dma_attrs)
>   {
>   	struct pci_dev *provider = to_p2p_pgmap(pgmap)->provider;
>   	enum pci_p2pdma_map_type ret;
>   	struct pci_dev *client;
>   
> +	WARN_ONCE(!(dma_attrs & __DMA_ATTR_PCI_P2PDMA),
> +		  "PCI P2PDMA pages were mapped with dma_map_sg!");
> +
>   	if (!provider->p2pdma)
>   		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
>   
> @@ -879,7 +889,8 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>   	struct pci_p2pdma_pagemap *p2p_pgmap =
>   		to_p2p_pgmap(sg_page(sg)->pgmap);
>   
> -	switch (pci_p2pdma_map_type(sg_page(sg)->pgmap, dev)) {
> +	switch (pci_p2pdma_map_type(sg_page(sg)->pgmap, dev,
> +				    __DMA_ATTR_PCI_P2PDMA)) {
>   	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>   		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
>   	case PCI_P2PDMA_MAP_BUS_ADDR:
> @@ -904,7 +915,8 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>   {
>   	enum pci_p2pdma_map_type map_type;
>   
> -	map_type = pci_p2pdma_map_type(sg_page(sg)->pgmap, dev);
> +	map_type = pci_p2pdma_map_type(sg_page(sg)->pgmap, dev,
> +				       __DMA_ATTR_PCI_P2PDMA);
>   
>   	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
>   		dma_unmap_sg_attrs(dev, sg, nents, dir, attrs);
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index 8318a97c9c61..a06072ac3a52 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -16,6 +16,13 @@
>   struct block_device;
>   struct scatterlist;
>   
> +enum pci_p2pdma_map_type {
> +	PCI_P2PDMA_MAP_UNKNOWN = 0,
> +	PCI_P2PDMA_MAP_NOT_SUPPORTED,
> +	PCI_P2PDMA_MAP_BUS_ADDR,
> +	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
> +};
> +
>   #ifdef CONFIG_PCI_P2PDMA
>   int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>   		u64 offset);
> @@ -30,6 +37,8 @@ struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
>   					 unsigned int *nents, u32 length);
>   void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
>   void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
> +enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
> +		struct device *dev, unsigned long dma_attrs);
>   int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>   		int nents, enum dma_data_direction dir, unsigned long attrs);
>   void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
> @@ -83,6 +92,12 @@ static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
>   static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>   {
>   }
> +static inline enum pci_p2pdma_map_type pci_p2pdma_map_type(
> +		struct dev_pagemap *pgmap, struct device *dev,
> +		unsigned long dma_attrs)
> +{
> +	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
> +}
>   static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
>   		struct scatterlist *sg, int nents, enum dma_data_direction dir,
>   		unsigned long attrs)


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
