Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F82ED12D41
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Nov 2024 15:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PCo17FAGoI0N36z1xhgr+jZX1coQaBkOx2Lfp0sQCQA=; b=fGhTXSyEkEoOHK465pz8Dm27QI
	5XQSMmuYHEs1G09q/nG0KtqmMUmVxXWxnk8DfBOKx+RCIDCknmUKFYmA0gIImF7cwspIp1VZumMTO
	yKEtq9qWfltE/8i1rJAoEFJvXM1+nw3cudaF6J+o+siv4c3p9bFdgyVjdyLucpYCd+cUc/KmZq7ak
	jDZzlekmypW490Rw0V1T5v1X/2BwfPlw8BwM+s5bsvSbrnSqrByj8Nxq5gLkVLkKMGkEuvQXrEvx9
	IQsGs90TkKU37f4xOOclW9Nq75HI8QTp+UArozBDBj+S6ZZ1j2sW06D9UZ3fMf83J6kOLwtleUOLg
	bI2el7Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tA9ZD-0000000F5s5-0rUD;
	Sun, 10 Nov 2024 15:09:31 +0000
Received: from out-173.mta1.migadu.com ([2001:41d0:203:375::ad])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tA9Z8-0000000F5qS-41Kk
	for linux-nvme@lists.infradead.org;
	Sun, 10 Nov 2024 15:09:29 +0000
Message-ID: <5ea594b3-7451-4553-92c1-2590c8baef20@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731251359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PCo17FAGoI0N36z1xhgr+jZX1coQaBkOx2Lfp0sQCQA=;
	b=Kwl2ylu4VPdk87+OR+b1SUGCOqDGZ8sXihB72SCRVQi9i6kYT1ztmGzGjEKIgaTkzqz7O7
	gUdz5mo8gHkrYMkATcROHwm+OWPXtUwFXI2ChCzpDr7jZTQAnz47D+n7DFqKijh6+E8P9T
	rOxWb9K9BcpUIQd4Xi7vpR/Dwmt+txs=
Date: Sun, 10 Nov 2024 16:09:11 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1 04/17] dma-mapping: Add check if IOVA can be used
To: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Leon Romanovsky <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <cover.1730298502.git.leon@kernel.org>
 <9515f330b9615de92a1864ab46acbd95e32634b6.1730298502.git.leon@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <9515f330b9615de92a1864ab46acbd95e32634b6.1730298502.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_070927_796550_7D5D57D1 
X-CRM114-Status: GOOD (  22.14  )
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

在 2024/10/30 16:12, Leon Romanovsky 写道:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> This patch adds a check if IOVA can be used for the specific
> transaction.
> 
> In the new API a DMA mapping transaction is identified by a
> struct dma_iova_state, which holds some recomputed information
> for the transaction which does not change for each page being
> mapped.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   include/linux/dma-mapping.h | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 1524da363734..6075e0708deb 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -76,6 +76,20 @@
>   
>   #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
>   
> +struct dma_iova_state {
> +	size_t __size;
> +};
> +
> +/*
> + * Use the high bit to mark if we used swiotlb for one or more ranges.
> + */
> +#define DMA_IOVA_USE_SWIOTLB		(1ULL << 63)

A trivial problem.
In the above macro, using BIT_ULL(63) is better?

Zhu Yanjun

> +
> +static inline size_t dma_iova_size(struct dma_iova_state *state)
> +{
> +	return state->__size & ~DMA_IOVA_USE_SWIOTLB;
> +}
> +
>   #ifdef CONFIG_DMA_API_DEBUG
>   void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
>   void debug_dma_map_single(struct device *dev, const void *addr,
> @@ -281,6 +295,25 @@ static inline int dma_mmap_noncontiguous(struct device *dev,
>   }
>   #endif /* CONFIG_HAS_DMA */
>   
> +#ifdef CONFIG_IOMMU_DMA
> +/**
> + * dma_use_iova - check if the IOVA API is used for this state
> + * @state: IOVA state
> + *
> + * Return %true if the DMA transfers uses the dma_iova_*() calls or %false if
> + * they can't be used.
> + */
> +static inline bool dma_use_iova(struct dma_iova_state *state)
> +{
> +	return state->__size != 0;
> +}
> +#else /* CONFIG_IOMMU_DMA */
> +static inline bool dma_use_iova(struct dma_iova_state *state)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_IOMMU_DMA */
> +
>   #if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
>   void __dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
>   		enum dma_data_direction dir);


