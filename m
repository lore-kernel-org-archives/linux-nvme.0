Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E45C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 15:52:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD7D64FFB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 15:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD7D64FFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=q4SQMzVK/q2C3C4kC1bwmQu/VQj27rJ7zjkwx/mLfEM=; b=nvk4VlR54FTCq7Jleav87vLfa
	RigYBwQ42JX0CIvawHLtupiz+nWnWnSrmH1CwHmPA53NT74JMsT9lsCeRhzvoyJQN5fAxuudwarw4
	dL277fqtZuO0hfvPaL8+OmYr57E8Nv9+7qcPVox0BB3/zBo3u+enN90JymzC4MidOSjmCTTTQ4LVH
	ezx6N+2PCjsOq3VIKQDS3/6mlG7Y1fk0lp7VdLUWlLt7xj/Yauvc+2VzYjO16cIwjfsyGwJcIJCqd
	Nri9srcW4sIvxDEpyHXuDUrNSWJfYnEqEIettM5+FfyNRz1Hn/pYZELv7EWT8iVKF6At7SVr02ViB
	fznwjOGnQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKk5H-00BsC5-5m; Fri, 12 Mar 2021 15:52:15 +0000
Received: from foss.arm.com ([217.140.110.172])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lKk5B-00BsAi-3q
 for linux-nvme@lists.infradead.org; Fri, 12 Mar 2021 15:52:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8D0211B3;
 Fri, 12 Mar 2021 07:52:07 -0800 (PST)
Received: from [10.57.52.136] (unknown [10.57.52.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DA3A3F7D7;
 Fri, 12 Mar 2021 07:52:04 -0800 (PST)
Subject: Re: [RFC PATCH v2 06/11] dma-direct: Support PCI P2PDMA pages in
 dma-direct map_sg
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Ira Weiny <iweiny@intel.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jason Ekstrand <jason@jlekstrand.net>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates
 <sbates@raithlin.com>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Christoph Hellwig <hch@lst.de>, Xiong Jianxin <jianxin.xiong@intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-7-logang@deltatee.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <215e1472-5294-d20a-a43a-ff6dfe8cd66e@arm.com>
Date: Fri, 12 Mar 2021 15:52:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311233142.7900-7-logang@deltatee.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210312_155209_804417_27858108 
X-CRM114-Status: GOOD (  27.39  )
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

On 2021-03-11 23:31, Logan Gunthorpe wrote:
> Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
> PCI P2PDMA pages directly without a hack in the callers. This allows
> for heterogeneous SGLs that contain both P2PDMA and regular pages.
> 
> SGL segments that contain PCI bus addresses are marked with
> sg_mark_pci_p2pdma() and are ignored when unmapped.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   kernel/dma/direct.c  | 35 ++++++++++++++++++++++++++++++++---
>   kernel/dma/mapping.c | 13 ++++++++++---
>   2 files changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 002268262c9a..f326d32062dd 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -13,6 +13,7 @@
>   #include <linux/vmalloc.h>
>   #include <linux/set_memory.h>
>   #include <linux/slab.h>
> +#include <linux/pci-p2pdma.h>
>   #include "direct.h"
>   
>   /*
> @@ -387,19 +388,47 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>   	struct scatterlist *sg;
>   	int i;
>   
> -	for_each_sg(sgl, sg, nents, i)
> +	for_each_sg(sgl, sg, nents, i) {
> +		if (sg_is_pci_p2pdma(sg))
> +			continue;
> +
>   		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
>   			     attrs);
> +	}
>   }
>   #endif
>   
>   int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>   		enum dma_data_direction dir, unsigned long attrs)
>   {
> -	int i;
> +	struct dev_pagemap *pgmap = NULL;
> +	int i, map = -1, ret = 0;
>   	struct scatterlist *sg;
> +	u64 bus_off;
>   
>   	for_each_sg(sgl, sg, nents, i) {
> +		if (is_pci_p2pdma_page(sg_page(sg))) {
> +			if (sg_page(sg)->pgmap != pgmap) {
> +				pgmap = sg_page(sg)->pgmap;
> +				map = pci_p2pdma_dma_map_type(dev, pgmap);
> +				bus_off = pci_p2pdma_bus_offset(sg_page(sg));
> +			}
> +
> +			if (map < 0) {
> +				sg->dma_address = DMA_MAPPING_ERROR;
> +				ret = -EREMOTEIO;
> +				goto out_unmap;
> +			}
> +
> +			if (map) {
> +				sg->dma_address = sg_phys(sg) + sg->offset -
> +					bus_off;
> +				sg_dma_len(sg) = sg->length;
> +				sg_mark_pci_p2pdma(sg);
> +				continue;
> +			}
> +		}
> +
>   		sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
>   				sg->offset, sg->length, dir, attrs);
>   		if (sg->dma_address == DMA_MAPPING_ERROR)
> @@ -411,7 +440,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>   
>   out_unmap:
>   	dma_direct_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
> -	return 0;
> +	return ret;
>   }
>   
>   dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index b6a633679933..adc1a83950be 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -178,8 +178,15 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
>   EXPORT_SYMBOL(dma_unmap_page_attrs);
>   
>   /*
> - * dma_maps_sg_attrs returns 0 on error and > 0 on success.
> - * It should never return a value < 0.
> + * dma_maps_sg_attrs returns 0 on any resource error and > 0 on success.
> + *
> + * If 0 is returned, the mapping can be retried and will succeed once
> + * sufficient resources are available.

That's not a guarantee we can uphold. Retrying forever in the vain hope 
that a device might evolve some extra address bits, or a bounce buffer 
might magically grow big enough for a gigantic mapping, isn't 
necessarily the best idea.

> + *
> + * If there are P2PDMA pages in the scatterlist then this function may
> + * return -EREMOTEIO to indicate that the pages are not mappable by the
> + * device. In this case, an error should be returned for the IO as it
> + * will never be successfully retried.
>    */
>   int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>   		enum dma_data_direction dir, unsigned long attrs)
> @@ -197,7 +204,7 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>   		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
>   	else
>   		ents = ops->map_sg(dev, sg, nents, dir, attrs);
> -	BUG_ON(ents < 0);
> +

This scares me - I hesitate to imagine the amount of driver/subsystem 
code out there that will see nonzero and merrily set off iterating a 
negative number of segments, if we open the floodgates of allowing 
implementations to return error codes here.

Robin.

>   	debug_dma_map_sg(dev, sg, nents, ents, dir);
>   
>   	return ents;
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
