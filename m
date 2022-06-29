Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D78CC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jun 2022 22:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yVJkquctrxAoNz8gXWxalQPFR+kficMZVVuKxSIBo/w=; b=m+gC4K9i6sJL46
	ArJ49ZwTf3ALO7kXyag9H8L6QAc4iTlYrp0v9M6Ep6mTJPV6lKpMnMnZ5+Flh3Fe7d/Xt21qw+Bp7
	V+8ZVol6g1ChLIBgsojql+jDy1UQ8iexCfKNu7yVKjaYVVQk+NmmKd9SL0pCOgW43gDnc9GUopwLx
	z0SaJB3EsHUJERhMexR96gyNIuIBeswiZUubqQiqi/zWog511dfegYWwrRLFjpAuQ6zumCHquQNxm
	FdjfUPrK8KUvY9361yuoyilWnulxMB1AZQuAHTS7IcjHiuotgC7jUA7s2GIRWds3qzm4Dz+8tSZfz
	ed/NZNBO0FYfOfDVzyjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6gNg-00EHd0-G2; Wed, 29 Jun 2022 22:41:56 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6gNd-00EHbf-NU
	for linux-nvme@lists.infradead.org; Wed, 29 Jun 2022 22:41:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=yVJkquctrxAoNz8gXWxalQPFR+kficMZVVuKxSIBo/w=; b=cX1QqveBfo+xPu7dGHmrnO0J7K
	qJxZ/4a3qviR2YsYxAl441tnDslX7UZLKVNl7dECkLbDJBrODx24Z1FZZ2YR0gfK4Qx5bFxKsdnV+
	ayp9miFGsznMYxLuJT8qz8m4U8lbLvb0m6Ihhj5N+dY9xmE7ZIBt8+8ePCpdzZ/dd2H7pg8bVqEIL
	vOvuRL9kWAgEKZ7udv7uSElDfsGN0ygRfue2iteXV1Evx26BlZvoCj9t2OzZA3JRHuGstDkn2hrBY
	PycWefQB0v5JZG34eFp4p3I7HwaoFTdQBv3Qpo6sU7xpIDA51IeoXpZk0+KoB2vKszKIczOjopgNy
	fM05bfoA==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1o6gNZ-002ZYA-Ie; Wed, 29 Jun 2022 16:41:50 -0600
Message-ID: <626de61d-e85e-bc9f-9e3d-836a408c859f@deltatee.com>
Date: Wed, 29 Jun 2022 16:41:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
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
 <7f0673e1-433b-65fb-1d2b-c3e4adeebf87@arm.com>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <7f0673e1-433b-65fb-1d2b-c3e4adeebf87@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, dave.b.minturn@intel.com, martin.oliveira@eideticom.com, rcampbell@nvidia.com, jgg@nvidia.com, jhubbard@nvidia.com, dave.hansen@linux.intel.com, willy@infradead.org, christian.koenig@amd.com, jgg@ziepe.ca, ckulkarnilinux@gmail.com, jason@jlekstrand.net, daniel.vetter@ffwll.ch, helgaas@kernel.org, dan.j.williams@intel.com, sbates@raithlin.com, ira.weiny@intel.com, hch@lst.de, jianxin.xiong@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 08/21] iommu/dma: support PCI P2PDMA pages in dma-iommu
 map_sg
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_154153_842058_1E4C6D41 
X-CRM114-Status: GOOD (  41.26  )
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



On 2022-06-29 13:15, Robin Murphy wrote:
> On 2022-06-29 16:57, Logan Gunthorpe wrote:
>>
>>
>>
>> On 2022-06-29 06:07, Robin Murphy wrote:
>>> On 2022-06-15 17:12, Logan Gunthorpe wrote:
>>>> When a PCI P2PDMA page is seen, set the IOVA length of the segment
>>>> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
>>>> apply the appropriate bus address to the segment. The IOVA is not
>>>> created if the scatterlist only consists of P2PDMA pages.
>>>>
>>>> A P2PDMA page may have three possible outcomes when being mapped:
>>>>     1) If the data path between the two devices doesn't go through
>>>>        the root port, then it should be mapped with a PCI bus address
>>>>     2) If the data path goes through the host bridge, it should be
>>>> mapped
>>>>        normally with an IOMMU IOVA.
>>>>     3) It is not possible for the two devices to communicate and thus
>>>>        the mapping operation should fail (and it will return
>>>> -EREMOTEIO).
>>>>
>>>> Similar to dma-direct, the sg_dma_mark_pci_p2pdma() flag is used to
>>>> indicate bus address segments. On unmap, P2PDMA segments are skipped
>>>> over when determining the start and end IOVA addresses.
>>>>
>>>> With this change, the flags variable in the dma_map_ops is set to
>>>> DMA_F_PCI_P2PDMA_SUPPORTED to indicate support for P2PDMA pages.
>>>>
>>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>>> ---
>>>>    drivers/iommu/dma-iommu.c | 68
>>>> +++++++++++++++++++++++++++++++++++----
>>>>    1 file changed, 61 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>>> index f90251572a5d..b01ca0c6a7ab 100644
>>>> --- a/drivers/iommu/dma-iommu.c
>>>> +++ b/drivers/iommu/dma-iommu.c
>>>> @@ -21,6 +21,7 @@
>>>>    #include <linux/iova.h>
>>>>    #include <linux/irq.h>
>>>>    #include <linux/list_sort.h>
>>>> +#include <linux/memremap.h>
>>>>    #include <linux/mm.h>
>>>>    #include <linux/mutex.h>
>>>>    #include <linux/pci.h>
>>>> @@ -1062,6 +1063,16 @@ static int __finalise_sg(struct device *dev,
>>>> struct scatterlist *sg, int nents,
>>>>            sg_dma_address(s) = DMA_MAPPING_ERROR;
>>>>            sg_dma_len(s) = 0;
>>>>    +        if (is_pci_p2pdma_page(sg_page(s)) && !s_iova_len) {
>>>
>>> Logically, should we not be able to use sg_is_dma_bus_address() here? I
>>> think it should be feasible, and simpler, to prepare the p2p segments
>>> up-front, such that at this point all we need to do is restore the
>>> original length (if even that, see below).
>>
>> Per my previous email, no, because sg_is_dma_bus_address() is not set
>> yet and not meant to tell you something about the page. That flag will
>> be set below by pci_p2pdma_map_bus_segment() and then checkd in
>> iommu_dma_unmap_sg() to determine if the dma_address in the segment
>> needs to be unmapped.
> 
> I know it's not set yet as-is; I'm suggesting things should be
> restructured so that it *would be*. In the logical design of this code,
> the DMA addresses are effectively determined in iommu_dma_map_sg(), and
> __finalise_sg() merely converts them from a relative to an absolute form
> (along with undoing the other trickery). Thus the call to
> pci_p2pdma_map_bus_segment() absolutely belongs in the main
> iommu_map_sg() loop.

I don't see how that can work: __finalise_sg() does more than convert
them from relative to absolute, it also figures out which SG entry will
contain which dma_address segment. Which segment a P2PDMA address needs
to be programmed into depends on the how 'cur' is calculated which in
turn depends on things like seg_mask and max_len. This calculation is
not done in iommu_dma_map_sg() so I don't see how there's any hope of
assigning the bus address for the P2P segments in that function.

If there's a way to restructure things so that's possible that I'm not
seeing, I'm open to it but it's certainly not immediately obvious.

>>>> +
>>>> +            switch (map_type) {
>>>> +            case PCI_P2PDMA_MAP_BUS_ADDR:
>>>> +                /*
>>>> +                 * A zero length will be ignored by
>>>> +                 * iommu_map_sg() and then can be detected
>>>
>>> If that is required behaviour then it needs an explicit check in
>>> iommu_map_sg() to guarantee (and document) it. It's only by chance that
>>> __iommu_map() happens to return success for size == 0 *if* all the other
>>> arguments still line up, which is a far cry from a safe no-op.
>>
>> What should such a check look like? I could certainly add some comments
>> to iommu_map_sg(), but I don't see what the code would need to check
>> for...
> 
> I'd say a check for zero-length segments would look like "if (sg->length
> == 0)", most likely with a "continue;" on the following line.

Oh, that's pretty simple to add. Will change.

>>> However, rather than play yet more silly tricks, I think it would make
>>> even more sense to make iommu_map_sg() properly aware and able to skip
>>> direct p2p segments on its own. Once it becomes normal to pass mixed
>>> scatterlists around, it's only a matter of time until one ends up being
>>> handed to a driver which manages its own IOMMU domain, and then what?
>>
>> I suppose we can add another call to is_pci_p2pdma_page() inside
>> iommu_map_sg() if you think that is cleaner. Seems like more work on the
>> fast path to me, but I'm not opposed to it.
> 
> I was thinking more of sg_is_dma_bus_address() but admittedly under my
> initial misapprehension of that. I suppose there's still a tenuous
> argument that even though we're not actually consuming sg_dma_address()
> at that point, if a segment *has* been earmarked for direct p2p, then
> skipping it rather than mapping it at the root complex TA that's
> probably never going to see those transactions might seem the more
> logical choice.
> 
> However it's all a bit hypothetical, and not significantly cleaner than
> a zero-size special case, so I'm not particularly tied to the idea either.

Yeah, looking at it closer, I can't see how to get rid of the zero size
special case without doing the whole pci_p2pdma_map_type() calculation
twice which we really want to avoid.

Logan

