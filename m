Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAE6C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jun 2022 19:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wtEVZJzV27xvlwsGQZCUhLA3H94kzjzmpSCjqNJAWJk=; b=4tRr4KTdZptoxrZEcFltgLoZta
	sPU2i/f8a76ZAgSW9+8pga92qP/veCHR2puFZs0TD0jkbhyIRSkN+OgR3rGDhXc0O6M0q1PLnSuqL
	/rmN24sofkGA0wPoKS0mCgtHG4kscz/hhrrtEUm67XxpYaPFb6FkTfooeTgA2jYRkmLDCcHUxE/S4
	Ff8ccpVftJVVddhT/0qrwoq4FApCrymf1yUy1H/zf7GfqZHG4kgwklUU1aDidGAODDxlZI1HHbhky
	OX0YGJSUdB4+w5u03QHBojXY1pAmpBJ4toEl+mpNQoAuRpBS4xFd96mBw0lSV6JJ9C2aNgjl7mEoc
	G1NwbIeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6d9k-00Ditz-OE; Wed, 29 Jun 2022 19:15:20 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6d9f-00Diq0-Ml
	for linux-nvme@lists.infradead.org; Wed, 29 Jun 2022 19:15:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 123D21480;
	Wed, 29 Jun 2022 12:15:14 -0700 (PDT)
Received: from [10.57.85.71] (unknown [10.57.85.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6188D3F792;
	Wed, 29 Jun 2022 12:15:10 -0700 (PDT)
Message-ID: <7f0673e1-433b-65fb-1d2b-c3e4adeebf87@arm.com>
Date: Wed, 29 Jun 2022 20:15:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 08/21] iommu/dma: support PCI P2PDMA pages in dma-iommu
 map_sg
Content-Language: en-GB
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Chaitanya Kulkarni
 <ckulkarnilinux@gmail.com>, Jason Ekstrand <jason@jlekstrand.net>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Bjorn Helgaas <helgaas@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates
 <sbates@raithlin.com>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>, Xiong Jianxin <jianxin.xiong@intel.com>
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-9-logang@deltatee.com>
 <feecc6fe-a16e-11f2-33c8-3de7c96b9ad5@arm.com>
 <f56181fb-7035-a775-22b1-77f97d6ec52c@deltatee.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <f56181fb-7035-a775-22b1-77f97d6ec52c@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_121515_869070_C8BEE3FE 
X-CRM114-Status: GOOD (  47.84  )
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

On 2022-06-29 16:57, Logan Gunthorpe wrote:
> 
> 
> 
> On 2022-06-29 06:07, Robin Murphy wrote:
>> On 2022-06-15 17:12, Logan Gunthorpe wrote:
>>> When a PCI P2PDMA page is seen, set the IOVA length of the segment
>>> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
>>> apply the appropriate bus address to the segment. The IOVA is not
>>> created if the scatterlist only consists of P2PDMA pages.
>>>
>>> A P2PDMA page may have three possible outcomes when being mapped:
>>>     1) If the data path between the two devices doesn't go through
>>>        the root port, then it should be mapped with a PCI bus address
>>>     2) If the data path goes through the host bridge, it should be mapped
>>>        normally with an IOMMU IOVA.
>>>     3) It is not possible for the two devices to communicate and thus
>>>        the mapping operation should fail (and it will return -EREMOTEIO).
>>>
>>> Similar to dma-direct, the sg_dma_mark_pci_p2pdma() flag is used to
>>> indicate bus address segments. On unmap, P2PDMA segments are skipped
>>> over when determining the start and end IOVA addresses.
>>>
>>> With this change, the flags variable in the dma_map_ops is set to
>>> DMA_F_PCI_P2PDMA_SUPPORTED to indicate support for P2PDMA pages.
>>>
>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>> ---
>>>    drivers/iommu/dma-iommu.c | 68 +++++++++++++++++++++++++++++++++++----
>>>    1 file changed, 61 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index f90251572a5d..b01ca0c6a7ab 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -21,6 +21,7 @@
>>>    #include <linux/iova.h>
>>>    #include <linux/irq.h>
>>>    #include <linux/list_sort.h>
>>> +#include <linux/memremap.h>
>>>    #include <linux/mm.h>
>>>    #include <linux/mutex.h>
>>>    #include <linux/pci.h>
>>> @@ -1062,6 +1063,16 @@ static int __finalise_sg(struct device *dev,
>>> struct scatterlist *sg, int nents,
>>>            sg_dma_address(s) = DMA_MAPPING_ERROR;
>>>            sg_dma_len(s) = 0;
>>>    +        if (is_pci_p2pdma_page(sg_page(s)) && !s_iova_len) {
>>
>> Logically, should we not be able to use sg_is_dma_bus_address() here? I
>> think it should be feasible, and simpler, to prepare the p2p segments
>> up-front, such that at this point all we need to do is restore the
>> original length (if even that, see below).
> 
> Per my previous email, no, because sg_is_dma_bus_address() is not set
> yet and not meant to tell you something about the page. That flag will
> be set below by pci_p2pdma_map_bus_segment() and then checkd in
> iommu_dma_unmap_sg() to determine if the dma_address in the segment
> needs to be unmapped.

I know it's not set yet as-is; I'm suggesting things should be 
restructured so that it *would be*. In the logical design of this code, 
the DMA addresses are effectively determined in iommu_dma_map_sg(), and 
__finalise_sg() merely converts them from a relative to an absolute form 
(along with undoing the other trickery). Thus the call to 
pci_p2pdma_map_bus_segment() absolutely belongs in the main 
iommu_map_sg() loop.

>>> +            if (i > 0)
>>> +                cur = sg_next(cur);
>>> +
>>> +            pci_p2pdma_map_bus_segment(s, cur);
>>> +            count++;
>>> +            cur_len = 0;
>>> +            continue;
>>> +        }
>>> +
>>>            /*
>>>             * Now fill in the real DMA data. If...
>>>             * - there is a valid output segment to append to
>>> @@ -1158,6 +1169,8 @@ static int iommu_dma_map_sg(struct device *dev,
>>> struct scatterlist *sg,
>>>        struct iova_domain *iovad = &cookie->iovad;
>>>        struct scatterlist *s, *prev = NULL;
>>>        int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
>>> +    struct dev_pagemap *pgmap = NULL;
>>> +    enum pci_p2pdma_map_type map_type;
>>>        dma_addr_t iova;
>>>        size_t iova_len = 0;
>>>        unsigned long mask = dma_get_seg_boundary(dev);
>>> @@ -1193,6 +1206,35 @@ static int iommu_dma_map_sg(struct device *dev,
>>> struct scatterlist *sg,
>>>            s_length = iova_align(iovad, s_length + s_iova_off);
>>>            s->length = s_length;
>>>    +        if (is_pci_p2pdma_page(sg_page(s))) {
>>> +            if (sg_page(s)->pgmap != pgmap) {
>>> +                pgmap = sg_page(s)->pgmap;
>>> +                map_type = pci_p2pdma_map_type(pgmap, dev);
>>> +            }
>>
>> There's a definite code smell here, but per above and below I think we
>> *should* actually call the new helper instead of copy-pasting half of it.
> 
> 
>>
>>> +
>>> +            switch (map_type) {
>>> +            case PCI_P2PDMA_MAP_BUS_ADDR:
>>> +                /*
>>> +                 * A zero length will be ignored by
>>> +                 * iommu_map_sg() and then can be detected
>>
>> If that is required behaviour then it needs an explicit check in
>> iommu_map_sg() to guarantee (and document) it. It's only by chance that
>> __iommu_map() happens to return success for size == 0 *if* all the other
>> arguments still line up, which is a far cry from a safe no-op.
> 
> What should such a check look like? I could certainly add some comments
> to iommu_map_sg(), but I don't see what the code would need to check for...

I'd say a check for zero-length segments would look like "if (sg->length 
== 0)", most likely with a "continue;" on the following line.

>> However, rather than play yet more silly tricks, I think it would make
>> even more sense to make iommu_map_sg() properly aware and able to skip
>> direct p2p segments on its own. Once it becomes normal to pass mixed
>> scatterlists around, it's only a matter of time until one ends up being
>> handed to a driver which manages its own IOMMU domain, and then what?
> 
> I suppose we can add another call to is_pci_p2pdma_page() inside
> iommu_map_sg() if you think that is cleaner. Seems like more work on the
> fast path to me, but I'm not opposed to it.

I was thinking more of sg_is_dma_bus_address() but admittedly under my 
initial misapprehension of that. I suppose there's still a tenuous 
argument that even though we're not actually consuming sg_dma_address() 
at that point, if a segment *has* been earmarked for direct p2p, then 
skipping it rather than mapping it at the root complex TA that's 
probably never going to see those transactions might seem the more 
logical choice.

However it's all a bit hypothetical, and not significantly cleaner than 
a zero-size special case, so I'm not particularly tied to the idea either.

>>> +                 * in __finalise_sg() to actually map the
>>> +                 * bus address.
>>> +                 */
>>> +                s->length = 0;
>>> +                continue;
>>> +            case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>>> +                /*
>>> +                 * Mapping through host bridge should be
>>> +                 * mapped with regular IOVAs, thus we
>>> +                 * do nothing here and continue below.
>>> +                 */
>>> +                break;
>>> +            default:
>>> +                ret = -EREMOTEIO;
>>> +                goto out_restore_sg;
>>> +            }
>>> +        }
>>> +
>>>            /*
>>>             * Due to the alignment of our single IOVA allocation, we can
>>>             * depend on these assumptions about the segment boundary mask:
>>> @@ -1215,6 +1257,9 @@ static int iommu_dma_map_sg(struct device *dev,
>>> struct scatterlist *sg,
>>>            prev = s;
>>>        }
>>>    +    if (!iova_len)
>>> +        return __finalise_sg(dev, sg, nents, 0);
>>> +
>>>        iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev),
>>> dev);
>>>        if (!iova) {
>>>            ret = -ENOMEM;
>>> @@ -1236,7 +1281,7 @@ static int iommu_dma_map_sg(struct device *dev,
>>> struct scatterlist *sg,
>>>    out_restore_sg:
>>>        __invalidate_sg(sg, nents);
>>>    out:
>>> -    if (ret != -ENOMEM)
>>> +    if (ret != -ENOMEM && ret != -EREMOTEIO)
>>>            return -EINVAL;
>>>        return ret;
>>>    }
>>> @@ -1244,7 +1289,7 @@ static int iommu_dma_map_sg(struct device *dev,
>>> struct scatterlist *sg,
>>>    static void iommu_dma_unmap_sg(struct device *dev, struct
>>> scatterlist *sg,
>>>            int nents, enum dma_data_direction dir, unsigned long attrs)
>>>    {
>>> -    dma_addr_t start, end;
>>> +    dma_addr_t end, start = DMA_MAPPING_ERROR;
>>
>> There are several things I don't like about this logic, I'd rather have
>> "end = 0" here...
> 
> Ok, I think that should work.
> 
>>>        struct scatterlist *tmp;
>>>        int i;
>>>    @@ -1260,14 +1305,22 @@ static void iommu_dma_unmap_sg(struct device
>>> *dev, struct scatterlist *sg,
>>>         * The scatterlist segments are mapped into a single
>>>         * contiguous IOVA allocation, so this is incredibly easy.
>>>         */
>>
>> [ This comment rather stops being true :( ]
> 
> Not exactly. Sure there are some segments in the SGL that have bus
> addresses, but all the regular IOVAs still have a single contiguous
> allocation and only require one call to  __iommu_dma_unmap(). The only
> trick issues is finding the first and last actual IOVA SG to get the range.

"The scatterlist segments" means all of them, including any p2p ones 
which are demonstrably not mapped into anything. The extra logic 
required to skip non-mapped p2p segments goes beyond "incredibly easy". 
If there's one thing I *do* definitely understand, it's my own comments ;)

Thanks,
Robin.

> 
>>
>>> -    start = sg_dma_address(sg);
>>> -    for_each_sg(sg_next(sg), tmp, nents - 1, i) {
>>
>> ...then generalise the first-element special case here into a dedicated
>> "walk to the first non-p2p element" loop...
> 
> Ok, I'll see what I can do for that.
> 
> Logan

