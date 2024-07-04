Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864A2C30653
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jul 2024 15:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u+aHfEX8o0rhywophaRE/rYg5Icyqncq4KrEqzyoFgE=; b=ghmvj/K5DvmDfGphNKF5xhMLzk
	TSmihLgqtm/2R1CjUJPIxlLVV5YngTjQ1xh7faEKEsHxDi+liJoMM0LwOVXWTY3cxaNuU+dCDNCjz
	brTRnkqo6CoHUq8tVdVtjCrK4bFAd5jNUS8i8gwll8Um/J7zHk7LjxnJeWD9u/wT5+ignGvPDB0hz
	BUX1fuZVMkFkavc+zW8koRZCjNmUm6MT4tb9ReHnakiBmCsygLaydXFFUcfgzGQ0CMs0D64kgCr7z
	sTXDDV603+9vye7iCaUurvFfLeueET40y8kyRO+QPQ9iHv+BVwtroLrsZJ7WEXMFU5u3amIKcr5Oa
	BgZS+E/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPOJW-0000000Dgju-0xhe;
	Thu, 04 Jul 2024 15:24:02 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPOJP-0000000Dggk-2Pps
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jul 2024 15:23:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA206367;
	Thu,  4 Jul 2024 08:24:18 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E2F73F766;
	Thu,  4 Jul 2024 08:23:50 -0700 (PDT)
Message-ID: <249ec228-4ffd-4121-bd51-f4a19275fee1@arm.com>
Date: Thu, 4 Jul 2024 16:23:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 18/18] nvme-pci: use new dma API
To: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, "Zeng, Oak" <oak.zeng@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <cover.1719909395.git.leon@kernel.org>
 <47eb0510b0a6aa52d9f5665d75fa7093dd6af53f.1719909395.git.leon@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <47eb0510b0a6aa52d9f5665d75fa7093dd6af53f.1719909395.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_082355_701477_3A1C9A12 
X-CRM114-Status: GOOD (  10.29  )
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

On 02/07/2024 10:09 am, Leon Romanovsky wrote:
[...]
> +static inline dma_addr_t nvme_dma_link_page(struct page *page,
> +					   unsigned int poffset,
> +					   unsigned int len,
> +					   struct nvme_iod *iod)
>   {
> -	int i;
> -	struct scatterlist *sg;
> +	struct dma_iova_attrs *iova = &iod->dma_map->iova;
> +	struct dma_iova_state *state = &iod->dma_map->state;
> +	dma_addr_t dma_addr;
> +	int ret;
> +
> +	if (iod->dma_map->use_iova) {
> +		phys_addr_t phys = page_to_phys(page) + poffset;

Yeah, there's no way this can possibly work. You can't do the 
dev_use_swiotlb() check up-front based on some overall DMA operation 
size, but then build that operation out of arbitrarily small fragments 
of different physical pages that *could* individually need bouncing to 
not break coherency.

Thanks,
Robin.

> +
> +		dma_addr = state->iova->addr + state->range_size;
> +		ret = dma_link_range(&iod->dma_map->state, phys, len);
> +		if (ret)
> +			return DMA_MAPPING_ERROR;
> +	} else {
> +		dma_addr = dma_map_page_attrs(iova->dev, page, poffset, len,
> +					      iova->dir, iova->attrs);
> +	}
> +	return dma_addr;
> +}

