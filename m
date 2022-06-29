Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F393C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jun 2022 18:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VJ5giCnL9gW0Wv51Z6KrKnRSp+wk2wjV+WILMkU4Itc=; b=ji+6Tf3xL6Zhlsbwr5JIlVlfvy
	R6kKh4ZV0/Z4N6tZcwDvxSHPVO08Fh4pGptdpAEAVLAE2NXmk6sRv5uS1Tk1hAUGsIB36yZwsc3xn
	jzuynXhfGcyqbgjdJtud3T7KDDuq3Vb4f1BdfRbosMZv3qwjejslJmb2wls4fJOKr14lkgdTn15o+
	GvVNvrEhGkRrFUfH+aLGB9U5xEsZbk5/10Ty1KDxmMuGPCBufR2xjlfwolGdmJtPyqdiqhXFsFKXV
	kuTUOInELYgkRXJC1LBoBhWBbqzZsD/oBtzkiGBFTVRtet54afrTQaHPKQd4+DVh/X1V7A7H8QSsK
	WM8Iy5aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6c5N-00DNSA-Nm; Wed, 29 Jun 2022 18:06:45 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6c1W-00DLpG-Ut
	for linux-nvme@lists.infradead.org; Wed, 29 Jun 2022 18:02:50 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E21051480;
	Wed, 29 Jun 2022 11:02:42 -0700 (PDT)
Received: from [10.57.85.71] (unknown [10.57.85.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 050C53F5A1;
	Wed, 29 Jun 2022 11:02:37 -0700 (PDT)
Message-ID: <d84a0498-3b7f-3d38-2bfd-9a175db4002a@arm.com>
Date: Wed, 29 Jun 2022 19:02:33 +0100
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
 <b56d9b93-c59f-5764-e599-d9718edb42d3@arm.com>
 <c42b5ee3-5d4f-7e44-8885-26b8417208ae@deltatee.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <c42b5ee3-5d4f-7e44-8885-26b8417208ae@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_110247_216923_30BFD033 
X-CRM114-Status: GOOD (  38.31  )
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

On 2022-06-29 16:39, Logan Gunthorpe wrote:
> 
> 
> 
> On 2022-06-29 03:05, Robin Murphy wrote:
>> On 2022-06-15 17:12, Logan Gunthorpe wrote:
>>> Make use of the third free LSB in scatterlist's page_link on 64bit
>>> systems.
>>>
>>> The extra bit will be used by dma_[un]map_sg_p2pdma() to determine when a
>>> given SGL segments dma_address points to a PCI bus address.
>>> dma_unmap_sg_p2pdma() will need to perform different cleanup when a
>>> segment is marked as a bus address.
>>>
>>> The new bit will only be used when CONFIG_PCI_P2PDMA is set; this means
>>> PCI P2PDMA will require CONFIG_64BIT. This should be acceptable as the
>>> majority of P2PDMA use cases are restricted to newer root complexes and
>>> roughly require the extra address space for memory BARs used in the
>>> transactions.
>>>
>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>>> ---
>>>    drivers/pci/Kconfig         |  5 +++++
>>>    include/linux/scatterlist.h | 44 ++++++++++++++++++++++++++++++++++++-
>>>    2 files changed, 48 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>>> index 133c73207782..5cc7cba1941f 100644
>>> --- a/drivers/pci/Kconfig
>>> +++ b/drivers/pci/Kconfig
>>> @@ -164,6 +164,11 @@ config PCI_PASID
>>>    config PCI_P2PDMA
>>>        bool "PCI peer-to-peer transfer support"
>>>        depends on ZONE_DEVICE
>>> +    #
>>> +    # The need for the scatterlist DMA bus address flag means PCI P2PDMA
>>> +    # requires 64bit
>>> +    #
>>> +    depends on 64BIT
>>>        select GENERIC_ALLOCATOR
>>>        help
>>>          Enableѕ drivers to do PCI peer-to-peer transactions to and from
>>> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
>>> index 7ff9d6386c12..6561ca8aead8 100644
>>> --- a/include/linux/scatterlist.h
>>> +++ b/include/linux/scatterlist.h
>>> @@ -64,12 +64,24 @@ struct sg_append_table {
>>>    #define SG_CHAIN    0x01UL
>>>    #define SG_END        0x02UL
>>>    +/*
>>> + * bit 2 is the third free bit in the page_link on 64bit systems which
>>> + * is used by dma_unmap_sg() to determine if the dma_address is a
>>> + * bus address when doing P2PDMA.
>>> + */
>>> +#ifdef CONFIG_PCI_P2PDMA
>>> +#define SG_DMA_BUS_ADDRESS    0x04UL
>>> +static_assert(__alignof__(struct page) >= 8);
>>> +#else
>>> +#define SG_DMA_BUS_ADDRESS    0x00UL
>>> +#endif
>>> +
>>>    /*
>>>     * We overload the LSB of the page pointer to indicate whether it's
>>>     * a valid sg entry, or whether it points to the start of a new
>>> scatterlist.
>>>     * Those low bits are there for everyone! (thanks mason :-)
>>>     */
>>> -#define SG_PAGE_LINK_MASK (SG_CHAIN | SG_END)
>>> +#define SG_PAGE_LINK_MASK (SG_CHAIN | SG_END | SG_DMA_BUS_ADDRESS)
>>>      static inline unsigned int __sg_flags(struct scatterlist *sg)
>>>    {
>>> @@ -91,6 +103,11 @@ static inline bool sg_is_last(struct scatterlist *sg)
>>>        return __sg_flags(sg) & SG_END;
>>>    }
>>>    +static inline bool sg_is_dma_bus_address(struct scatterlist *sg)
>>> +{
>>> +    return __sg_flags(sg) & SG_DMA_BUS_ADDRESS;
>>> +}
>>> +
>>>    /**
>>>     * sg_assign_page - Assign a given page to an SG entry
>>>     * @sg:            SG entry
>>> @@ -245,6 +262,31 @@ static inline void sg_unmark_end(struct
>>> scatterlist *sg)
>>>        sg->page_link &= ~SG_END;
>>>    }
>>>    +/**
>>> + * sg_dma_mark_bus address - Mark the scatterlist entry as a bus address
>>> + * @sg:         SG entryScatterlist
>>
>> entryScatterlist?
>>
>>> + *
>>> + * Description:
>>> + *   Marks the passed in sg entry to indicate that the dma_address is
>>> + *   a bus address and doesn't need to be unmapped.
>>> + **/
>>> +static inline void sg_dma_mark_bus_address(struct scatterlist *sg)
>>> +{
>>> +    sg->page_link |= SG_DMA_BUS_ADDRESS;
>>> +}
>>> +
>>> +/**
>>> + * sg_unmark_pci_p2pdma - Unmark the scatterlist entry as a bus address
>>> + * @sg:         SG entryScatterlist
>>> + *
>>> + * Description:
>>> + *   Clears the bus address mark.
>>> + **/
>>> +static inline void sg_dma_unmark_bus_address(struct scatterlist *sg)
>>> +{
>>> +    sg->page_link &= ~SG_DMA_BUS_ADDRESS;
>>> +}
>>
>> Does this serve any useful purpose? If a page is determined to be device
>> memory, it's not going to suddenly stop being device memory, and if the
>> underlying sg is recycled to point elsewhere then sg_assign_page() will
>> still (correctly) clear this flag anyway. Trying to reason about this
>> beyond superficial API symmetry - i.e. why exactly would a caller need
>> to call it, and what would the implications be of failing to do so -
>> seems to lead straight to confusion.
>>
>> In fact I'd be inclined to have sg_assign_page() be responsible for
>> setting the flag automatically as well, and thus not need
>> sg_dma_mark_bus_address() either, however I can see the argument for
>> doing it this way round to not entangle the APIs too much, so I don't
>> have any great objection to that.
> 
> Yes, I think you misunderstand what this is for. The SG_DMA_BUS_ADDDRESS
> flag doesn't mark the segment for the page, but for the dma address. It
> cannot be set in sg_assign_page() seeing it's not a property of the page
> but a property of the dma_address in the sgl.
> 
> It's not meant for use by regular SG users, it's only meant for use
> inside DMA mapping implementations. The purpose is to know whether a
> given dma_address in the SGL is a bus address or regular memory because
> the two different types must be unmapped differently. We can't rely on
> the page because, as you know, many dma_map_sg() the dma_address entry
> in the sgl does not map to the same memory as the page. Or to put it
> another way: is_pci_p2pdma_page(sg->page) does not imply that
> sg->dma_address points to a bus address.
> 
> Does that make sense?

Ah, you're quite right, in trying to take in the whole series at once 
first thing in the morning I did fail to properly grasp that detail, so 
indeed the sg_assign_page() thing couldn't possibly work, but as I said 
that's fine anyway. I still think the lifecycle management is a bit off 
though - equivalently, a bus address doesn't stop being a bus address, 
so it would seem appropriate to update this flag appropriately whenever 
sg_dma_address() is assigned to, and not when it isn't.

Thanks,
Robin.

