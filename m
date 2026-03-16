Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3D7F013FA
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Mar 2026 21:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yfkM3PPHPu0YkcTV5+iO+zYIAo8OkU2BN/FF4q1YWkc=; b=Xw8qCwjJQ0u4q1lXaZbLwDBZsN
	zlmhKWoSynmCY2g9CB/zxoSYS9Gr6hlerLQYWhouCXgwSg8sAZ0pipEEXtLPhZTXL7m6xiIz5TSx9
	2HYaGDgA2er1GbDyB+nNFTbrJ1HtHIs80GdbyWm4BmLl7yO/q3iXNQ0nx4iMVjAQf1MXM5jk+HPrV
	dD4YJbd9NRWiylUnZSvDtygNDwZ6TLDNXLUwOICvYiQC0VA1sdr7tHGpcif58/RFpTG5iIMIAU5mM
	KtsJ1Kj+q5NXfZcBeGLjdFSSgo7SXpDEIMr8w7XDhJORSRkvJFFOWtE90LphdV0i1VQX+9Yju9do2
	jUL9cugg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2FNQ-00000004vrN-1udP;
	Mon, 16 Mar 2026 21:21:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2FNH-00000004vk8-2Hxe
	for linux-nvme@lists.infradead.org;
	Mon, 16 Mar 2026 21:21:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A04F560018;
	Mon, 16 Mar 2026 21:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45E4C19421;
	Mon, 16 Mar 2026 21:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773696078;
	bh=7hQsD6OV/+I6l6ywpcTkVvu09Wp5p0rXdGylP/BtJkk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MwTDFJWbT4QMhFuhoZ4RP78E7/Z69d5atjmG6hr0fVP91fAm02eHYwcAfq4MiLlHQ
	 ndutEwlj7xMxtEQhYIaJQYit4HPfI5hi1OB1OaSPn6exVmKc3DtmdFQfaw1hVRfCut
	 DMpGXOCl0T66mIHSwkMHUoyO5mCkuQ7a2j0BqLhHxgGRpXSzv0TOI9oVg99W7BPr5s
	 mbaZShe/s4Ui2nKhFsCG/IOlSLqfAiMS8VAyuj69bIwKeKcs/zuuzCvbH/a8yIxen0
	 dBm8zEuZuLLV4E+jJDe9vIiGy1lbatQczb7oH/FQm5xA5x20gAZGrMtZj093hTK8TN
	 GHyGhm6JPbWvw==
Message-ID: <bf63044a-5c5d-496c-be6d-43f310068bbe@kernel.org>
Date: Tue, 17 Mar 2026 06:21:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] nvme-pci: handle dma_opt_mapping_size() returning
 0
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
 m.szyprowski@samsung.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me
Cc: robin.murphy@arm.com, martin.petersen@oracle.com,
 damien.lemoal@opensource.wdc.com, john.g.garry@oracle.com,
 ahuang12@lenovo.com, iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, ionut_n2001@yahoo.com,
 sunlightlinux@gmail.com
References: <20260316203956.64515-1-ionut.nechita@windriver.com>
 <20260316203956.64515-3-ionut.nechita@windriver.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260316203956.64515-3-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 3/17/26 05:39, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> After the previous commit, dma_opt_mapping_size() returns 0 when no DMA
> backend provides an optimal mapping size hint (e.g. IOMMU in passthrough
> mode with no ops->opt_mapping_size callback).
> 
> The NVMe PCI driver used min_t(u32, NVME_MAX_BYTES >> SECTOR_SHIFT,
> dma_opt_mapping_size() >> 9) to cap max_hw_sectors.  With a 0 return
> value this would set max_hw_sectors to 0, which is invalid.
> 
> Guard the min_t so that max_hw_sectors is only capped when
> dma_opt_mapping_size() provides a real hint.  When it returns 0, fall
> back to the existing NVME_MAX_BYTES >> SECTOR_SHIFT default.
> 
> Fixes: 3710e2b056cb ("nvme-pci: clamp max_hw_sectors based on DMA optimized limitation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
>  drivers/nvme/host/pci.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b78ba239c8ea8..dc148fb6eff28 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3640,6 +3640,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
>  {
>  	unsigned long quirks = id->driver_data;
>  	int node = dev_to_node(&pdev->dev);
> +	size_t dma_opt;
>  	struct nvme_dev *dev;
>  	struct quirk_entry *qentry;
>  	int ret = -ENOMEM;
> @@ -3691,12 +3692,16 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
>  	dma_set_max_seg_size(&pdev->dev, 0xffffffff);
>  
>  	/*
> -	 * Limit the max command size to prevent iod->sg allocations going
> -	 * over a single page.
> +	 * Limit the max command size to prevent iod->sg allocations
> +	 * going over a single page.  Only apply the DMA optimal mapping
> +	 * size limit when the DMA layer actually provides one (non-zero
> +	 * return from dma_opt_mapping_size()).
>  	 */
> -	dev->ctrl.max_hw_sectors = min_t(u32,
> -			NVME_MAX_BYTES >> SECTOR_SHIFT,
> -			dma_opt_mapping_size(&pdev->dev) >> 9);

Why not simply change this to min_not_zero() ? That would do the same. Are you
maybe getting a warning without the u32 cast ?

> +	dev->ctrl.max_hw_sectors = NVME_MAX_BYTES >> SECTOR_SHIFT;
> +	dma_opt = dma_opt_mapping_size(&pdev->dev);
> +	if (dma_opt)
> +		dev->ctrl.max_hw_sectors =
> +			min_t(u32, dev->ctrl.max_hw_sectors, dma_opt >> 9);
>  	dev->ctrl.max_segments = NVME_MAX_SEGS;
>  	dev->ctrl.max_integrity_segments = 1;
>  	return dev;


-- 
Damien Le Moal
Western Digital Research

