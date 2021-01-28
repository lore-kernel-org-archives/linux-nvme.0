Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CBAC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 18:16:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B3A64DD6
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 18:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B3A64DD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/xbQWCZD5taWJ/0Mkq9KThpYOkYCPSA36YyTZZBjX3o=; b=uPoJz40jGpbV67VwMISfxWrG6
	jQZYbYE16G239CmJwTaP2iKlP7uwLnV9S4soAkEHO3v2xp3qmai/UJgVV8JvZH0Gnal8u1hd/Jp2D
	ZJKNVHK3hE9uuRH9QYfxsBJxpCumiQaG7YNhoVPd4vk8ax01RG/8WhaBKR15Mpyb5+sHLFDHs7X0Y
	wloCiFzPc+v7w+LJAN8qPLm2nY02OnC5aB+EadmX8O/1s+6uzwrgl3qJJWFliftRKFxxWH58nL8M8
	NFTKtjFQoX3y5KeF7P4yhV5k/I+QqTSO9rOAMRJY6hXDO3MBuLbX90uJerRc8P/rNEd7Vh7sN1np+
	UrQMEzPnw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5BqM-0000B7-A2; Thu, 28 Jan 2021 18:16:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5BqJ-0000AK-IJ
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 18:16:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 45B0F68B05; Thu, 28 Jan 2021 19:16:28 +0100 (CET)
Date: Thu, 28 Jan 2021 19:16:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jianxiong Gao <jxgao@google.com>
Subject: Re: [PATCH 2/3] Add swiotlb offset preserving mapping when
 dma_dma_parameters->page_offset_mask is non zero.
Message-ID: <20210128181627.GB11790@lst.de>
References: <20210128003829.1892018-1-jxgao@google.com>
 <20210128003829.1892018-3-jxgao@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210128003829.1892018-3-jxgao@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_131631_859608_E40946F2 
X-CRM114-Status: GOOD (  21.49  )
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
Cc: axboe@fb.com, heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, bgolaszewski@baylibre.com, iommu@lists.linux-foundation.org,
 jroedel@suse.de, erdemaktas@google.com, dan.j.williams@intel.com,
 andriy.shevchenko@linux.intel.com, robin.murphy@arm.com, hch@lst.de,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 27, 2021 at 04:38:28PM -0800, Jianxiong Gao wrote:
> For devices that need to preserve address offset on mapping through
> swiotlb, this patch adds offset preserving based on page_offset_mask
> and keeps the offset if the mask is non zero. This is needed for
> device drivers like NVMe.
> 
> Signed-off-by: Jianxiong Gao <jxgao@google.com>
> ---
>  kernel/dma/swiotlb.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 7c42df6e6100..4cab35f2c9bc 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -468,7 +468,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
>  	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(hwdev, io_tlb_start);
>  	unsigned long flags;
>  	phys_addr_t tlb_addr;
> -	unsigned int nslots, stride, index, wrap;
> +	unsigned int nslots, stride, index, wrap, page_offset_mask, page_offset;
>  	int i;
>  	unsigned long mask;
>  	unsigned long offset_slots;
> @@ -500,12 +500,16 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
>  		    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
>  		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
>  
> +	page_offset_mask = dma_get_page_offset_mask(hwdev);
> +	page_offset = orig_addr & page_offset_mask;
> +	alloc_size += page_offset;
> +
>  	/*
>  	 * For mappings greater than or equal to a page, we limit the stride
>  	 * (and hence alignment) to a page size.
>  	 */
>  	nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
> -	if (alloc_size >= PAGE_SIZE)
> +	if ((alloc_size >= PAGE_SIZE) || (page_offset_mask > (1 << IO_TLB_SHIFT)))
>  		stride = (1 << (PAGE_SHIFT - IO_TLB_SHIFT));
>  	else
>  		stride = 1;
> @@ -583,6 +587,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
>  	 */
>  	for (i = 0; i < nslots; i++)
>  		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
> +	/*
> +	 * When keeping the offset of the original data, we need to advance
> +	 * the tlb_addr by the offset of orig_addr.
> +	 */
> +	tlb_addr += page_offset;
>  	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>  	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
>  		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
> @@ -598,7 +607,9 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
>  			      enum dma_data_direction dir, unsigned long attrs)
>  {
>  	unsigned long flags;
> -	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
> +	unsigned int num_page_offset_slabs, page_offset_mask = dma_get_page_offset_mask(hwdev);

Yikes, please avoid these crazy long lines.

> +	num_page_offset_slabs =  (tlb_addr & page_offset_mask) / (1 << IO_TLB_SHIFT);

also a double whitespace here.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
