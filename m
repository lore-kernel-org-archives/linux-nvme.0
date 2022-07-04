Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173C4C43334
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jul 2022 15:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gzMIizqjvcjUqAnb5IAJ862AQ/s/fxwCGoKaF18Q1o0=; b=oTZveqBS2i4GoZgiuaCWWyN4Db
	/OMlzIi5HsoLhsbnOY6g2akRfCpugMiRc9LaGxY/FCuPZFtWVCi+uY/khR5VDPIRDxq6js5T6oULE
	IVU5d9KjvPymT2vlQMSyyEQrbwdURgpap5NLtSb3t0WzmIc28bMZl9dpcKvAksbzjT9vbIPTBy+24
	8QaU1EfqwP+nqd0lCeeYxPcewLGXfZ6O5w9ZKSRTVgXGiuRSrN6i5iGlfZq7PmJAB1I68gvF5+Ro+
	Zp07do1glqt/Aimx59wTYtYYHhK8t7aLaO88RnTe+qipiwdMjHjoifOWiJqdQxN/NrP1cDGED5jn/
	5FO0juyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8Ngv-009cHP-L2; Mon, 04 Jul 2022 15:08:49 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8Ngt-009cGP-AB
	for linux-nvme@lists.infradead.org; Mon, 04 Jul 2022 15:08:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03A6F23A;
	Mon,  4 Jul 2022 08:08:46 -0700 (PDT)
Received: from [10.57.86.91] (unknown [10.57.86.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9C583F792;
	Mon,  4 Jul 2022 08:08:41 -0700 (PDT)
Message-ID: <2be62742-4737-bb3c-5467-011a26edfcea@arm.com>
Date: Mon, 4 Jul 2022 16:08:37 +0100
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
X-CRM114-CacheID: sfid-20220704_080847_489906_5F6ABB0F 
X-CRM114-Status: GOOD (  32.88  )
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

Another thought that's hit me slightly late; depending on CONFIG_64BIT 
also means that we've got a whole 4 bytes of padding in struct 
scatterlist to play with, so at that point maybe it's worth considering 
carrying new extra DMA mapping properties in their own field(s). For 
instance it would also be really helpful to flag whether a segment is 
bounce-buffered or not.

Robin.

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
> +
>   /**
>    * sg_phys - Return physical address of an sg entry
>    * @sg:	     SG entry

