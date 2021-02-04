Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F037BC433E6
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 22:12:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22B664F93
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 22:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22B664F93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3C7ug6PvqoT+1D0lXoMG0+V4iUQfw0CSEoGUv1K/d1E=; b=AFKg3Sbui1iF0Lqw5DhTbv7bt
	lXaK48aNpipztP4wl2cLmILJS9Hlql6c2BI5JR10R8dA9CB0PnXnRaBDV2rTsZo/8GH9V2uaKvmlD
	DEhEBXtg3fVi2pAGy2RV59ycm0PPIhyFeQjdujGpo3JpZ/0g1d67PYIrgcYYWoBUnorl10Lde+ODD
	rfShQxbXG3HP8sgY5v5zbNYC0w0Y7a+lTRRfuL6fKn5dN4cmkP90MI7ael+0DWDaPG0rsOmovtgDp
	r85VFtpAw7N4doplMN8dHqUYn1LBvAzwdFDENW16GG2a7S0mcVHHGch/4kWzCZ5U5m0Sg4QFzwCWP
	Xlo3uuRAg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7mrf-0000BG-Ff; Thu, 04 Feb 2021 22:12:39 +0000
Received: from foss.arm.com ([217.140.110.172])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7mrd-0000Am-8a
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 22:12:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55BF613A1;
 Thu,  4 Feb 2021 14:12:34 -0800 (PST)
Received: from [10.57.49.26] (unknown [10.57.49.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CD0F3F718;
 Thu,  4 Feb 2021 14:12:32 -0800 (PST)
Subject: Re: [PATCH 5/8] swiotlb: refactor swiotlb_tbl_map_single
To: Christoph Hellwig <hch@lst.de>, jxgao@google.com,
 gregkh@linuxfoundation.org
References: <20210204193035.2606838-1-hch@lst.de>
 <20210204193035.2606838-6-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f60ddc1b-94c3-32a1-06eb-b2187d56d797@arm.com>
Date: Thu, 4 Feb 2021 22:12:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210204193035.2606838-6-hch@lst.de>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_171237_650432_5A95ADB7 
X-CRM114-Status: GOOD (  23.74  )
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
Cc: saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 linux-nvme@lists.infradead.org, kbusch@kernel.org,
 iommu@lists.linux-foundation.org, erdemaktas@google.com,
 m.szyprowski@samsung.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021-02-04 19:30, Christoph Hellwig wrote:
> Split out a bunch of a self-contained helpers to make the function easier
> to follow.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/swiotlb.c | 177 +++++++++++++++++++++----------------------
>   1 file changed, 87 insertions(+), 90 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 79d5b236f25f10..e78615e3be2906 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -468,134 +468,131 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
>   	}
>   }
>   
> -phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
> -		size_t mapping_size, size_t alloc_size,
> -		enum dma_data_direction dir, unsigned long attrs)
> +/*
> + * Carefully handle integer overflow which can occur when boundary_mask == ~0UL.
> + */
> +static inline unsigned long get_max_slots(unsigned long boundary_mask)
>   {
> -	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(hwdev, io_tlb_start);
> -	unsigned long flags;
> -	phys_addr_t tlb_addr;
> -	unsigned int nslots, stride, index, wrap;
> -	int i;
> -	unsigned long mask;
> -	unsigned long offset_slots;
> -	unsigned long max_slots;
> -	unsigned long tmp_io_tlb_used;
> -
> -	if (no_iotlb_memory)
> -		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
> -
> -	if (mem_encrypt_active())
> -		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
> -
> -	if (mapping_size > alloc_size) {
> -		dev_warn_once(hwdev, "Invalid sizes (mapping: %zd bytes, alloc: %zd bytes)",
> -			      mapping_size, alloc_size);
> -		return (phys_addr_t)DMA_MAPPING_ERROR;
> -	}
> -
> -	mask = dma_get_seg_boundary(hwdev);
> +	if (boundary_mask + 1 == ~0UL)

Either "mask == ~0UL" or "mask + 1 == 0", surely?

> +		return 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
> +	return nr_slots(boundary_mask + 1);
> +}
>   
> -	tbl_dma_addr &= mask;
> +static unsigned int wrap_index(unsigned int index)
> +{
> +	if (index >= io_tlb_nslabs)
> +		return 0;
> +	return index;
> +}
>   
> -	offset_slots = nr_slots(tbl_dma_addr);
> +/*
> + * Find a suitable number of IO TLB entries size that will fit this request and
> + * allocate a buffer from that IO TLB pool.
> + */
> +static int find_slots(struct device *dev, size_t alloc_size,
> +		dma_addr_t tbl_dma_addr)
> +{
> +	unsigned int max_slots = get_max_slots(dma_get_seg_boundary(dev));
> +	unsigned int nslots = nr_slots(alloc_size), stride = 1;
> +	unsigned int index, wrap, count = 0, i;
> +	unsigned long flags;
>   
> -	/*
> -	 * Carefully handle integer overflow which can occur when mask == ~0UL.
> -	 */
> -	max_slots = mask + 1
> -		    ? nr_slots(mask + 1)
> -		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);

...since the condition here is effectively the latter.

Robin.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
