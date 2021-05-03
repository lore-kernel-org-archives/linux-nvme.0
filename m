Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C23DC433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 17:15:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE8AD61139
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 17:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8AD61139
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0ZO1z7TVt1xV09Y7dVwwpKgAa8EGQE3NNjUmjnxwJsY=; b=mmDUeLP8dxZhWIzSUnS3Qn6Rr
	imLxC8FN+QE96U9Ex5QrrfgDiXllZqKANZx9UpTVtx+nlYPxR/Y48vG0RUBHgYokCW22zALXdQoSh
	fC+di5Oh8DEcMQxFkp5nvk0lkDJM2U37C8iT6O2b6nCfIEwj7EKjp2jpm6LM410DSDc2oodWZu+RS
	hXZaPgQUZpN3NxcS9uiv1k4L8XHZysdb5mhnMc9NvaerFOGB4kPy77FrMCgIuJd3yf9tvPpd0L4dU
	dvBPG/NNEIp0XrCLRN864sCj8d4aiMayckQEM6xTQ0BUDtL1nQVmiBWWj8K6vAc4pczJhuOPLkz33
	z7MrFGHjA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldcAS-00EUXt-T8; Mon, 03 May 2021 17:15:37 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldcAL-00EUXV-PN
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 17:15:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=/Q5g8C9jkIWWM3OWLSzMquUiscL+RFj92ybUcevP8nc=; b=3d74tZfPuPjxjRqQfMs5cCkm2D
 tDj6dWai/fHzgSuQvJ+28JTDF2sEDnMU3x+0kqQoRuArQlL1LiT+czeKoUojUV4OB/Q5+pOswz7ve
 HgnzQdVSZhxex9ZG4LjpXgDXD5UuJRG8E8OYH8ivf21ae2fC/D0yCZ6od0rUg9SCS8ddY7EiJPSv6
 TC/6sjf1L1aILZjnCX6im3NckFgZXeefq4ko+HZPd5c2VfXcEByPgRN2rkmK8q+x+qN5jIsAD9UXv
 51feE+KjQnrQXAf3FDAdf5khkM9sZmPkcv9aFDqM4l0j+qJHc0IGIjaP4JS+n7Vz/lYf8q3qAZ3oX
 3ERL0/MQ==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldcAI-003Kpv-Ho
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 17:15:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=/Q5g8C9jkIWWM3OWLSzMquUiscL+RFj92ybUcevP8nc=; b=BgMW37LpVUA/Vb1Ae2ZH6DSYZA
 RZN3oDLotj/Ofj6VlRt6iImh3Q8FFxK+Qz2P6Cz+eplJrws8aa7BtbTce8Axj7WFg+ZPShNb6e7fG
 bQFW8at/t5Aq2KPt6hT0kl8aBtkKUBNm3bZHtqXZP3iMkgMApZwVI/d7kBNL0yAXAuW+8ASnyw4ZB
 kMW9jSvrz8lE1XTCe6dramBWTLYY4MUbmKwFI2FuLAypD1uMxhiTmKUYEGwPRtWOY1+xqdgCn3Sux
 RKlFyaZm+IWzzyVyjy0lA1KvG50ZnVfJg4I4/aI0gYm3e2MM/+dJ7avE0O1mB/alREvUpN2a/g0lo
 vz3npu1g==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1ldcA2-00053o-JL; Mon, 03 May 2021 11:15:11 -0600
To: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-9-logang@deltatee.com>
 <e27d35f8-5c3a-39e3-9845-6d2bf15cc8b3@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <07f4c059-f4d6-0657-c31f-bb9187381889@deltatee.com>
Date: Mon, 3 May 2021 11:15:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <e27d35f8-5c3a-39e3-9845-6d2bf15cc8b3@nvidia.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jhubbard@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 08/16] PCI/P2PDMA: Introduce helpers for dma_map_sg
 implementations
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_101526_637804_53542A6E 
X-CRM114-Status: GOOD (  40.69  )
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



On 2021-05-02 6:50 p.m., John Hubbard wrote:
> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
>> Add pci_p2pdma_map_segment() as a helper for simple dma_map_sg()
>> implementations. It takes an scatterlist segment that must point to a
>> pci_p2pdma struct page and will map it if the mapping requires a bus
>> address.
>>
>> The return value indicates whether the mapping required a bus address
>> or whether the caller still needs to map the segment normally. If the
>> segment should not be mapped, -EREMOTEIO is returned.
>>
>> This helper uses a state structure to track the changes to the
>> pgmap across calls and avoid needing to lookup into the xarray for
>> every page.
>>
> 
> OK, coming back to this patch, after seeing how it is used later in
> the series...
> 
>> Also add pci_p2pdma_map_bus_segment() which is useful for IOMMU
>> dma_map_sg() implementations where the sg segment containing the page
>> differs from the sg segment containing the DMA address.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   drivers/pci/p2pdma.c       | 65 ++++++++++++++++++++++++++++++++++++++
>>   include/linux/pci-p2pdma.h | 21 ++++++++++++
>>   2 files changed, 86 insertions(+)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index 38c93f57a941..44ad7664e875 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -923,6 +923,71 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>>   }
>>   EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>>   
>> +/**
>> + * pci_p2pdma_map_segment - map an sg segment determining the mapping type
>> + * @state: State structure that should be declared on the stack outside of
>> + *	the for_each_sg() loop and initialized to zero.
> 
> Silly fine point for the docs here: it doesn't actually have to be on
> the stack, so I don't think you need to write that constraint in the
> documentation. It just has be be somehow allocated and zeroed.

Yeah, that's true, but there's really no reason it would ever not be
allocated on the stack.

> 
>> + * @dev: DMA device that's doing the mapping operation
>> + * @sg: scatterlist segment to map
>> + * @attrs: dma mapping attributes
>> + *
>> + * This is a helper to be used by non-iommu dma_map_sg() implementations where
>> + * the sg segment is the same for the page_link and the dma_address.
>> + *
>> + * Attempt to map a single segment in an SGL with the PCI bus address.
>> + * The segment must point to a PCI P2PDMA page and thus must be
>> + * wrapped in a is_pci_p2pdma_page(sg_page(sg)) check.
> 
> Should this be backed up with actual checks in the function, that
> the prerequisites are met?

I think that would be unnecessary. All callers are going to call this
inside an is_pci_p2pdma_page() check, otherwise it would slow down the
fast path.

>> + *
>> + * Returns 1 if the segment was mapped, 0 if the segment should be mapped
>> + * directly (or through the IOMMU) and -EREMOTEIO if the segment should not
>> + * be mapped at all.
>> + */
>> +int pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state,
>> +			   struct device *dev, struct scatterlist *sg,
>> +			   unsigned long dma_attrs)
>> +{
>> +	if (state->pgmap != sg_page(sg)->pgmap) {
>> +		state->pgmap = sg_page(sg)->pgmap;
>> +		state->map = pci_p2pdma_map_type(state->pgmap, dev, dma_attrs);
>> +		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
>> +	}
> 
> I'll quote myself from patch 9, because I had a comment there that actually
> was meant for this patch:
> 
> Is it worth putting this stuff on the caller's stack? I mean, is there a
> noticeable performance improvement from caching the state? Because if
> it's invisible, then simplicity is better. I suspect you're right, and
> that it *is* worth it, but it's good to know for real.

Yeah, I responded to this in another email.

> 
>> +
>> +	switch (state->map) {
>> +	case PCI_P2PDMA_MAP_BUS_ADDR:
>> +		sg->dma_address = sg_phys(sg) + state->bus_off;
>> +		sg_dma_len(sg) = sg->length;
>> +		sg_mark_pci_p2pdma(sg);
>> +		return 1;
>> +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>> +		return 0;
>> +	default:
>> +		return -EREMOTEIO;
>> +	}
>> +}
>> +
>> +/**
>> + * pci_p2pdma_map_bus_segment - map an sg segment pre determined to
>> + *	be mapped with PCI_P2PDMA_MAP_BUS_ADDR
> 
> Or:
> 
>   * pci_p2pdma_map_bus_segment - map an SG segment that is already known
>   * to be mapped with PCI_P2PDMA_MAP_BUS_ADDR
> 
> Also, should that prerequisite be backed up with checks in the function?

No, this function only really exists for the needs of iommu_dma_map_sg().

>> + * @pg_sg: scatterlist segment with the page to map
>> + * @dma_sg: scatterlist segment to assign a dma address to
>> + *
>> + * This is a helper for iommu dma_map_sg() implementations when the
>> + * segment for the dma address differs from the segment containing the
>> + * source page.
>> + *
>> + * pci_p2pdma_map_type() must have already been called on the pg_sg and
>> + * returned PCI_P2PDMA_MAP_BUS_ADDR.
> 
> Another prerequisite, so same question: do you think that the code should
> also check that this prerequisite is met?

Again, no, simply because it's this way because of what's required by
iommu_dma.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
