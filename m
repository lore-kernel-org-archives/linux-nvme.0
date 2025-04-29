Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B82C3ABAB
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 18:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BHPiN8dLKLCnD4pFx6tkd4ehR3fDU1kbq+ObibkBhpc=; b=Gtk0/MJLvgka8deIY0TmXF5eCh
	xBfxtC/ysCk+vewmyMHjrN+dl2wNBsNDSvhZQ68rEZ1ccZdUdstmWBVd2hUv5v3XanaYgHtkcL1IQ
	8X05LNr+GOqXeFAryTIGdQkvdzDnwJekHl9DtoiV1VzH8bWy+1ht5vkSJFWaNvPE+m+7S3s6mUuPK
	k831WvKHwBFlVH5UfbyskaXF//nLZCaT5RgquVM7+UrtRX/IjwkBnjoSa2kkcPO2aja7eT/pV1SAn
	9OwGvAM+3wwZpOBQ6+ls/iZOl++2aQ5uRjbV7HeT7PsufbfD9Y7jmT+Xxjc1JOXcx52OhGuiE11NM
	GAGPYUcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9pbg-0000000AWGG-3so6;
	Tue, 29 Apr 2025 18:23:00 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9d7E-00000008Ls8-0nJi
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 05:02:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745902964; x=1777438964;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yJHygitItCE7AjT4PE9hDK5eTwShgF8pqCV5bUS99tg=;
  b=U2HLKQPS0gvDlTbsgwSWgTwvCy/HLlNPw312TaeTxt2OAwDIZ3JfueKW
   zHL7dXy2sStKzuWGNSTood0YrO9maBkQ/v8t6PKpf5BYqHxCLP7lYZzOz
   qpVWaoYI+/aOgTjJir+whvQ7avtXFhkHrqPVWmk0nW0SGQQn/dKWDDFDb
   KKijkfW3vvJzqdwXPGJjmMf4glPT1naYFrD7QZ9Vo/AQtBlXEkZzgUmwq
   cEb9DFNgvqDEZs7Y+qVACOCQRO6E5mAThBkBWvxqk7ioR9gP5fQx1tXwQ
   xaOIF65uwnr4fTuwMB5bY7cSXYulcT+UCUDehjRPdx2IH/unKIYjxMw6M
   g==;
X-CSE-ConnectionGUID: 4G3fa7cQTxWuZDuLkNmDQw==
X-CSE-MsgGUID: X94ms4cuQm69g9x1DBBUhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="35121386"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="35121386"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 22:02:39 -0700
X-CSE-ConnectionGUID: a5E3m5JXQF+Vct9TFcNxPw==
X-CSE-MsgGUID: WNPv/oL5TCup2x/mZ3mf+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="138896368"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 22:02:30 -0700
Message-ID: <8416e94f-171e-4956-b8fe-246ed12a2314@linux.intel.com>
Date: Tue, 29 Apr 2025 12:58:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/24] iommu/dma: Factor out a iommu_dma_map_swiotlb
 helper
To: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Jake Edge <jake@lwn.net>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Chuck Lever <chuck.lever@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Dan Williams
 <dan.j.williams@intel.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
References: <cover.1745831017.git.leon@kernel.org>
 <f9a6a7874760a2919bea1f255bb3c81c6369ed1c.1745831017.git.leon@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <f9a6a7874760a2919bea1f255bb3c81c6369ed1c.1745831017.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_220244_240514_8EB6AEAB 
X-CRM114-Status: GOOD (  24.13  )
X-Mailman-Approved-At: Tue, 29 Apr 2025 11:22:51 -0700
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

On 4/28/25 17:22, Leon Romanovsky wrote:
> From: Christoph Hellwig<hch@lst.de>
> 
> Split the iommu logic from iommu_dma_map_page into a separate helper.
> This not only keeps the code neatly separated, but will also allow for
> reuse in another caller.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Tested-by: Jens Axboe<axboe@kernel.dk>
> Reviewed-by: Luis Chamberlain<mcgrof@kernel.org>
> Signed-off-by: Leon Romanovsky<leonro@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

with a nit below ...

> ---
>   drivers/iommu/dma-iommu.c | 73 ++++++++++++++++++++++-----------------
>   1 file changed, 41 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d3211a8d755e..d7684024c439 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1138,6 +1138,43 @@ void iommu_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
>   			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
>   }
>   
> +static phys_addr_t iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> +	struct iova_domain *iovad = &domain->iova_cookie->iovad;
> +
> +	if (!is_swiotlb_active(dev)) {
> +		dev_warn_once(dev, "DMA bounce buffers are inactive, unable to map unaligned transaction.\n");
> +		return (phys_addr_t)DMA_MAPPING_ERROR;
> +	}
> +
> +	trace_swiotlb_bounced(dev, phys, size);
> +
> +	phys = swiotlb_tbl_map_single(dev, phys, size, iova_mask(iovad), dir,
> +			attrs);
> +
> +	/*
> +	 * Untrusted devices should not see padding areas with random leftover
> +	 * kernel data, so zero the pre- and post-padding.
> +	 * swiotlb_tbl_map_single() has initialized the bounce buffer proper to
> +	 * the contents of the original memory buffer.
> +	 */
> +	if (phys != (phys_addr_t)DMA_MAPPING_ERROR && dev_is_untrusted(dev)) {
> +		size_t start, virt = (size_t)phys_to_virt(phys);
> +
> +		/* Pre-padding */
> +		start = iova_align_down(iovad, virt);
> +		memset((void *)start, 0, virt - start);
> +
> +		/* Post-padding */
> +		start = virt + size;
> +		memset((void *)start, 0, iova_align(iovad, start) - start);
> +	}
> +
> +	return phys;
> +}
> +
>   dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   	      unsigned long offset, size_t size, enum dma_data_direction dir,
>   	      unsigned long attrs)
> @@ -1151,42 +1188,14 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   	dma_addr_t iova, dma_mask = dma_get_mask(dev);
>   
>   	/*
> -	 * If both the physical buffer start address and size are
> -	 * page aligned, we don't need to use a bounce page.
> +	 * If both the physical buffer start address and size are page aligned,
> +	 * we don't need to use a bounce page.
>   	 */
>   	if (dev_use_swiotlb(dev, size, dir) &&
>   	    iova_offset(iovad, phys | size)) {
> -		if (!is_swiotlb_active(dev)) {

... Is it better to move this check into the helper? Simply no-op if a
bounce page is not needed:

	if (!dev_use_swiotlb(dev, size, dir) ||
	    !iova_offset(iovad, phys | size))
		return phys;

Thanks,
baolu

