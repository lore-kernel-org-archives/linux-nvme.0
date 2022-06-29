Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0B1C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jun 2022 09:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e/AX9LcU4en+nJewDe5gXnjNunwfU9eHtMHBKdj4UCI=; b=Thape3LjWQImoGcsLD+tg1vHg+
	I7JrxaODnelLOC7B0ZV3vWIr6BaQCsd5gxCKuYjHicuhhbMtWKvl+dfnCy+qy1cEJNtbO1oghfU8f
	i6eDEFkOuWjB3Gjvkq9yQ7VkMEQMXOoVeSEG+49fipx7HszTFVjOuaO6YHNr8F8Cepz2FTnFmKm3K
	MANjTBipAlMuoLIMH7l+3cxyWDOpywbeR+5RBABZdynVC5TwqNCaRJ890qJoONijIKf/abl90mTxW
	VfICT+sSnEzfrLhw7htXjp1Fj+eDyCoXeKqqQFThLrdpFkcPINbJxAn0p7eIt6bITeCBmDkJb62fY
	kaExCVOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6Te3-00AZq7-Bc; Wed, 29 Jun 2022 09:05:59 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6Tdx-00AZlW-JX
	for linux-nvme@lists.infradead.org; Wed, 29 Jun 2022 09:05:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B53E41477;
	Wed, 29 Jun 2022 02:05:50 -0700 (PDT)
Received: from [10.57.85.71] (unknown [10.57.85.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA2B53F792;
	Wed, 29 Jun 2022 02:05:45 -0700 (PDT)
Message-ID: <b56d9b93-c59f-5764-e599-d9718edb42d3@arm.com>
Date: Wed, 29 Jun 2022 10:05:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 01/21] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
Content-Language: en-GB
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-2-logang@deltatee.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220615161233.17527-2-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_020553_820262_31BFF59D 
X-CRM114-Status: GOOD (  36.97  )
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

On 2022-06-15 17:12, Logan Gunthorpe wrote:
> Make use of the third free LSB in scatterlist's page_link on 64bit systems.
> 
> The extra bit will be used by dma_[un]map_sg_p2pdma() to determine when a
> given SGL segments dma_address points to a PCI bus address.
> dma_unmap_sg_p2pdma() will need to perform different cleanup when a
> segment is marked as a bus address.
> 
> The new bit will only be used when CONFIG_PCI_P2PDMA is set; this means
> PCI P2PDMA will require CONFIG_64BIT. This should be acceptable as the
> majority of P2PDMA use cases are restricted to newer root complexes and
> roughly require the extra address space for memory BARs used in the
> transactions.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/pci/Kconfig         |  5 +++++
>   include/linux/scatterlist.h | 44 ++++++++++++++++++++++++++++++++++++-
>   2 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 133c73207782..5cc7cba1941f 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -164,6 +164,11 @@ config PCI_PASID
>   config PCI_P2PDMA
>   	bool "PCI peer-to-peer transfer support"
>   	depends on ZONE_DEVICE
> +	#
> +	# The need for the scatterlist DMA bus address flag means PCI P2PDMA
> +	# requires 64bit
> +	#
> +	depends on 64BIT
>   	select GENERIC_ALLOCATOR
>   	help
>   	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 7ff9d6386c12..6561ca8aead8 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -64,12 +64,24 @@ struct sg_append_table {
>   #define SG_CHAIN	0x01UL
>   #define SG_END		0x02UL
>   
> +/*
> + * bit 2 is the third free bit in the page_link on 64bit systems which
> + * is used by dma_unmap_sg() to determine if the dma_address is a
> + * bus address when doing P2PDMA.
> + */
> +#ifdef CONFIG_PCI_P2PDMA
> +#define SG_DMA_BUS_ADDRESS	0x04UL
> +static_assert(__alignof__(struct page) >= 8);
> +#else
> +#define SG_DMA_BUS_ADDRESS	0x00UL
> +#endif
> +
>   /*
>    * We overload the LSB of the page pointer to indicate whether it's
>    * a valid sg entry, or whether it points to the start of a new scatterlist.
>    * Those low bits are there for everyone! (thanks mason :-)
>    */
> -#define SG_PAGE_LINK_MASK (SG_CHAIN | SG_END)
> +#define SG_PAGE_LINK_MASK (SG_CHAIN | SG_END | SG_DMA_BUS_ADDRESS)
>   
>   static inline unsigned int __sg_flags(struct scatterlist *sg)
>   {
> @@ -91,6 +103,11 @@ static inline bool sg_is_last(struct scatterlist *sg)
>   	return __sg_flags(sg) & SG_END;
>   }
>   
> +static inline bool sg_is_dma_bus_address(struct scatterlist *sg)
> +{
> +	return __sg_flags(sg) & SG_DMA_BUS_ADDRESS;
> +}
> +
>   /**
>    * sg_assign_page - Assign a given page to an SG entry
>    * @sg:		    SG entry
> @@ -245,6 +262,31 @@ static inline void sg_unmark_end(struct scatterlist *sg)
>   	sg->page_link &= ~SG_END;
>   }
>   
> +/**
> + * sg_dma_mark_bus address - Mark the scatterlist entry as a bus address
> + * @sg:		 SG entryScatterlist

entryScatterlist?

> + *
> + * Description:
> + *   Marks the passed in sg entry to indicate that the dma_address is
> + *   a bus address and doesn't need to be unmapped.
> + **/
> +static inline void sg_dma_mark_bus_address(struct scatterlist *sg)
> +{
> +	sg->page_link |= SG_DMA_BUS_ADDRESS;
> +}
> +
> +/**
> + * sg_unmark_pci_p2pdma - Unmark the scatterlist entry as a bus address
> + * @sg:		 SG entryScatterlist
> + *
> + * Description:
> + *   Clears the bus address mark.
> + **/
> +static inline void sg_dma_unmark_bus_address(struct scatterlist *sg)
> +{
> +	sg->page_link &= ~SG_DMA_BUS_ADDRESS;
> +}

Does this serve any useful purpose? If a page is determined to be device 
memory, it's not going to suddenly stop being device memory, and if the 
underlying sg is recycled to point elsewhere then sg_assign_page() will 
still (correctly) clear this flag anyway. Trying to reason about this 
beyond superficial API symmetry - i.e. why exactly would a caller need 
to call it, and what would the implications be of failing to do so - 
seems to lead straight to confusion.

In fact I'd be inclined to have sg_assign_page() be responsible for 
setting the flag automatically as well, and thus not need 
sg_dma_mark_bus_address() either, however I can see the argument for 
doing it this way round to not entangle the APIs too much, so I don't 
have any great objection to that.

Thanks,
Robin.

> +
>   /**
>    * sg_phys - Return physical address of an sg entry
>    * @sg:	     SG entry

