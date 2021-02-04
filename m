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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256ECC433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 22:09:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7675964FA1
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 22:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7675964FA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0pphU5PD8VYkp1CqNdKTYbnFgsKCcC3BtcgL/LDuBRg=; b=ppfY+v99h4NbreBH8gH72ktAe
	bPUPwr3x3cLZYpb6LaFM//SRmOAV9ee4iN/kAFjoBBVWIGHOugzffO+dc2PNx5tioTvGubLajCaUH
	ah8hdVe6csMfSATs0NQscL2G/2xjA1BtoNmmwbHS/M31Xg7le69W1hcyaBBWzXSPaY9YDfkX3H0jC
	AXGbjdxIM/EHNe23kaBHVxvYy5aMX70Zr35Wsu8Vqk1xGND4zZ1XxBEF5ZHbKcrTpqiVIZNFl5UHm
	YZMbD8C/nulQzbBWpNI9N9w2GpXZvxJZTNo8GZfCe9MuWlECPC5fe3pnnuDDJCgfe1qVFWsJvpkYs
	Sg0glqVXQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7moJ-0008Mw-VN; Thu, 04 Feb 2021 22:09:12 +0000
Received: from foss.arm.com ([217.140.110.172])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7moF-0008MN-Ri
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 22:09:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27B9A13A1;
 Thu,  4 Feb 2021 14:09:06 -0800 (PST)
Received: from [10.57.49.26] (unknown [10.57.49.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65AC73F718;
 Thu,  4 Feb 2021 14:09:04 -0800 (PST)
Subject: Re: [PATCH 3/8] swiotlb: factor out a nr_slots helper
To: Christoph Hellwig <hch@lst.de>, jxgao@google.com,
 gregkh@linuxfoundation.org
References: <20210204193035.2606838-1-hch@lst.de>
 <20210204193035.2606838-4-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ae995e9d-4476-cea2-a4d7-9e9cbab5aafd@arm.com>
Date: Thu, 4 Feb 2021 22:09:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210204193035.2606838-4-hch@lst.de>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_170907_959156_44170566 
X-CRM114-Status: GOOD (  21.37  )
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
> Factor out a helper to find the number of slots for a given size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/swiotlb.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 838dbad10ab916..0c0b81799edbdb 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -194,6 +194,11 @@ static inline unsigned long io_tlb_offset(unsigned long val)
>   	return val & (IO_TLB_SEGSIZE - 1);
>   }
>   
> +static unsigned long nr_slots(u64 val)
> +{
> +	return ALIGN(val, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;

Would DIV_ROUND_UP(val, 1 << IOTLB_SHIFT) be even clearer?

Robin.

> +}
> +
>   /*
>    * Early SWIOTLB allocation may be too early to allow an architecture to
>    * perform the desired operations.  This function allows the architecture to
> @@ -493,20 +498,20 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
>   
>   	tbl_dma_addr &= mask;
>   
> -	offset_slots = ALIGN(tbl_dma_addr, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
> +	offset_slots = nr_slots(tbl_dma_addr);
>   
>   	/*
>   	 * Carefully handle integer overflow which can occur when mask == ~0UL.
>   	 */
>   	max_slots = mask + 1
> -		    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
> +		    ? nr_slots(mask + 1)
>   		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
>   
>   	/*
>   	 * For mappings greater than or equal to a page, we limit the stride
>   	 * (and hence alignment) to a page size.
>   	 */
> -	nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
> +	nslots = nr_slots(alloc_size);
>   	if (alloc_size >= PAGE_SIZE)
>   		stride = (1 << (PAGE_SHIFT - IO_TLB_SHIFT));
>   	else
> @@ -602,7 +607,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
>   			      enum dma_data_direction dir, unsigned long attrs)
>   {
>   	unsigned long flags;
> -	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
> +	int i, count, nslots = nr_slots(alloc_size);
>   	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
>   	phys_addr_t orig_addr = io_tlb_orig_addr[index];
>   
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
