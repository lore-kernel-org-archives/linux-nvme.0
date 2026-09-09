Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AD4C79F8C
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 09:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zfo8YHC50Fl3ZDYN0nijYPMjYSxHIoKJMO4F8frAXnU=; b=L47XSjJCzqrk1GoDvDY0lT6gkM
	M56oJDKn65y/aRyn07zAbfQy1EfRGpkfzon/1JE/6uRhrhzJo+W7Okxwc7488VYgWOc+ht3/AlRme
	6P9NZZVLOdXBTJQLI5HHJcL1esEegEVx527yjiTeE1ml9jnPpXr4wjl97zP9/gbXzYmhjHvDfh432
	ZfLSn7nFXkXcC8PgT2i8KJ3zfq18FSxhz7hGmu87kpA4OH7aCwu5rnycbGw6asUXDAFMDQAN6ALLd
	1JIuipSK6EGOCpjd0cs4dK3eIYQoZ+TGe7pA9lxChJdp1RJWs4b7J/FmvHs2kGvKbGCk8ZEPZRcin
	5rnDLOHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4EgN-0000000BJCN-2sAb;
	Wed, 09 Sep 2026 09:33:31 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4EgM-0000000BJC0-2KIf
	for linux-nvme@bombadil.infradead.org;
	Wed, 09 Sep 2026 09:33:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=zfo8YHC50Fl3ZDYN0nijYPMjYSxHIoKJMO4F8frAXnU=; b=CnBfzado1thtLfl26B3JC3fx/T
	L+n8FH/NjISW1ROwrPYFGqzbzcAXbo6/ShxTBv/MzZQYJQLae1JrDNMFxiYov4+u/Vso9jaUVLoLS
	Fd8TNIDEMK2gM7DGH6kALjMf71WQ86piopXaLRyaGBqN6+tzCbZ3UokmdxwpqVuB/kfw1NvRUbRzX
	InKnEqvejF83KlNtgk8YbiVYvMhFHVvZ34j6FW94lZg/m8LBZgfxSAKAMdX3QGGbZv2lpX9bb32KB
	QWiDYQGI6vM5KzC7vUZIzKt1cUmT6KB8xGP294hhV2pEKVrlSONna9mvd4lWZ1SBZPcNXjp8BrzMA
	5Yr0aliA==;
Received: from [210.118.77.12] (helo=mailout2.w1.samsung.com)
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4EgJ-000000010Kx-25s7
	for linux-nvme@lists.infradead.org;
	Wed, 09 Sep 2026 09:33:29 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260909093317euoutp027863f44427fed99e2e5d4af7b22f920e~TnUUjOXpr1633116331euoutp02U
	for <linux-nvme@lists.infradead.org>; Wed,  9 Sep 2026 09:33:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260909093317euoutp027863f44427fed99e2e5d4af7b22f920e~TnUUjOXpr1633116331euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1788946397;
	bh=zfo8YHC50Fl3ZDYN0nijYPMjYSxHIoKJMO4F8frAXnU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=C/kV9M3WRkFTIiHUJ8QOf7pYfyOw1aBdcGtpVshU7iADJls+5G5Y/T0CnXV1edH1N
	 hctXOFL6mdtwRf0+dLYQJkrQapMtxjuEHvnqiKRWzNGvxCBsqWlbkpYyRu4Mt1ivjc
	 OeTpprLX7QLGy3VH+Y5XHvsyrM1OSac2eb0MvMoo=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260909093316eucas1p29c13790e88a78fc6dee44d78e1498080~TnUUAa8EZ0620106201eucas1p2j;
	Wed,  9 Sep 2026 09:33:16 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260909093315eusmtip27dce3e492bedeac71737c1cb92630b08~TnUSkSu-H2587025870eusmtip2v;
	Wed,  9 Sep 2026 09:33:15 +0000 (GMT)
Message-ID: <565dcd03-4787-4e0f-a37b-9d04a9296b78@samsung.com>
Date: Wed, 9 Sep 2026 11:33:14 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-mapping: rename dma_opt_mapping_size()
To: John Garry <john.g.garry@oracle.com>, robin.murphy@arm.com,
	joro@8bytes.org, will@kernel.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, James.Bottomley@HansenPartnership.com, mkp@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, John Garry <john.garry@linux.dev>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260831093620.3481337-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260909093316eucas1p29c13790e88a78fc6dee44d78e1498080
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260831093715eucas1p296758c633e8ab3c48b3070ae4f5e2f1f
X-EPHeader: CA
X-CMS-RootMailID: 20260831093715eucas1p296758c633e8ab3c48b3070ae4f5e2f1f
References: <CGME20260831093715eucas1p296758c633e8ab3c48b3070ae4f5e2f1f@eucas1p2.samsung.com>
	<20260831093620.3481337-1-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_103327_738586_098C4DDA 
X-CRM114-Status: GOOD (  23.24  )
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

On 31.08.2026 11:36, John Garry wrote:
> From: John Garry <john.garry@linux.dev>
>
> Function dma_opt_mapping_size() implies from its name that it returns a
> target or sweet spot DMA mapping size. However, it is just an upper limit
> optimal DMA mapping size. Above this size, DMA mapping performance may
> significantly degrade.
>
> Rename to dma_max_opt_mapping_size() to reflect the real behaviour. Also
> rename the internal DMA mapping symbols to align with this.
>
> The DMA API documentation already described this behaviour properly (so
> there is nothing to update).
>
> Signed-off-by: John Garry <john.garry@linux.dev>
Applied to dma-mapping-for-next, thanks!
> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
> index ba23a472f7948..69d4ebe4f96db 100644
> --- a/Documentation/core-api/dma-api.rst
> +++ b/Documentation/core-api/dma-api.rst
> @@ -154,7 +154,7 @@ others should not be larger than the returned value.
>  ::
>  
>  	size_t
> -	dma_opt_mapping_size(struct device *dev);
> +	dma_max_opt_mapping_size(struct device *dev);
>  
>  Returns the maximum optimal size of a mapping for the device.
>  
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 58c624513cd43..1b26c9ce4aabe 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1762,7 +1762,7 @@ unsigned long iommu_dma_get_merge_boundary(struct device *dev)
>  	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
>  }
>  
> -size_t iommu_dma_opt_mapping_size(void)
> +size_t iommu_dma_max_opt_mapping_size(void)
>  {
>  	return iova_rcache_range();
>  }
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index da93b505d2394..d87d268037d81 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3747,7 +3747,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
>  	 */
>  	dev->ctrl.max_hw_sectors = min_t(u32,
>  			NVME_MAX_BYTES >> SECTOR_SHIFT,
> -			dma_opt_mapping_size(&pdev->dev) >> 9);
> +			dma_max_opt_mapping_size(&pdev->dev) >> SECTOR_SHIFT);
>  	dev->ctrl.max_segments = NVME_MAX_SEGS;
>  	dev->ctrl.max_integrity_segments = 1;
>  	return dev;
> diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
> index d689b9ed08a6c..aaa47552a215c 100644
> --- a/drivers/scsi/scsi_transport_sas.c
> +++ b/drivers/scsi/scsi_transport_sas.c
> @@ -223,8 +223,8 @@ static int sas_bsg_initialize(struct Scsi_Host *shost, struct sas_rphy *rphy)
>  
>  /*
>   * Set shost->opt_sectors from the DMA optimal mapping size, but only
> - * when dma_opt_mapping_size() is strictly less than dma_max_mapping_size(),
> - * indicating a genuine optimization hint from an IOMMU or DMA backend.
> + * when dma_max_opt_mapping_size() is strictly less than
> + * dma_max_mapping_size(), indicating a genuine optimization hint.
>   * When the two are equal (e.g. IOMMU disabled / passthrough), no real
>   * hint exists, so leave opt_sectors at 0 to avoid bogus optimal_io_size
>   * values that break filesystem geometry (e.g. mkfs.xfs stripe alignment).
> @@ -232,16 +232,16 @@ static int sas_bsg_initialize(struct Scsi_Host *shost, struct sas_rphy *rphy)
>  static void sas_dma_setup_opt_sectors(struct Scsi_Host *shost)
>  {
>  	struct device *dma_dev = shost->dma_dev;
> -	size_t opt = dma_opt_mapping_size(dma_dev);
> +	size_t max_opt = dma_max_opt_mapping_size(dma_dev);
>  	size_t max = dma_max_mapping_size(dma_dev);
>  	unsigned int opt_sectors;
>  
> -	/* opt >= max means no real hint was provided by the DMA layer */
> -	if (opt >= max)
> +	/* max_opt >= max means no real hint was provided by the DMA layer */
> +	if (max_opt >= max)
>  		return;
>  
>  	/* Clamp to max_sectors to avoid overflow in sector arithmetic */
> -	opt_sectors = min_t(unsigned int, opt >> SECTOR_SHIFT,
> +	opt_sectors = min_t(unsigned int, max_opt >> SECTOR_SHIFT,
>  			    shost->max_sectors);
>  
>  	/* Guard against zero before rounddown_pow_of_two() */
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 8fae2b7deb20d..eee6de5188c76 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -60,7 +60,7 @@ struct dma_map_ops {
>  	int (*dma_supported)(struct device *dev, u64 mask);
>  	u64 (*get_required_mask)(struct device *dev);
>  	size_t (*max_mapping_size)(struct device *dev);
> -	size_t (*opt_mapping_size)(void);
> +	size_t (*max_opt_mapping_size)(void);
>  	unsigned long (*get_merge_boundary)(struct device *dev);
>  };
>  
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index a3e880649fa41..efde0e5a58dc2 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -207,7 +207,7 @@ int dma_set_coherent_mask(struct device *dev, u64 mask);
>  u64 dma_get_required_mask(struct device *dev);
>  bool dma_addressing_limited(struct device *dev);
>  size_t dma_max_mapping_size(struct device *dev);
> -size_t dma_opt_mapping_size(struct device *dev);
> +size_t dma_max_opt_mapping_size(struct device *dev);
>  unsigned long dma_get_merge_boundary(struct device *dev);
>  struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
>  		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs);
> @@ -326,7 +326,7 @@ static inline size_t dma_max_mapping_size(struct device *dev)
>  {
>  	return 0;
>  }
> -static inline size_t dma_opt_mapping_size(struct device *dev)
> +static inline size_t dma_max_opt_mapping_size(struct device *dev)
>  {
>  	return 0;
>  }
> diff --git a/include/linux/iommu-dma.h b/include/linux/iommu-dma.h
> index 060f6e23ab3c8..fae5d50e4f277 100644
> --- a/include/linux/iommu-dma.h
> +++ b/include/linux/iommu-dma.h
> @@ -39,7 +39,7 @@ int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
>  		void *cpu_addr, dma_addr_t dma_addr, size_t size,
>  		unsigned long attrs);
>  unsigned long iommu_dma_get_merge_boundary(struct device *dev);
> -size_t iommu_dma_opt_mapping_size(void);
> +size_t iommu_dma_max_opt_mapping_size(void);
>  size_t iommu_dma_max_mapping_size(struct device *dev);
>  void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
>  		dma_addr_t handle, unsigned long attrs);
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index bf2651a70b7c2..82e701648d604 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -1012,19 +1012,19 @@ size_t dma_max_mapping_size(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dma_max_mapping_size);
>  
> -size_t dma_opt_mapping_size(struct device *dev)
> +size_t dma_max_opt_mapping_size(struct device *dev)
>  {
>  	const struct dma_map_ops *ops = get_dma_ops(dev);
>  	size_t size = SIZE_MAX;
>  
>  	if (use_dma_iommu(dev))
> -		size = iommu_dma_opt_mapping_size();
> -	else if (ops && ops->opt_mapping_size)
> -		size = ops->opt_mapping_size();
> +		size = iommu_dma_max_opt_mapping_size();
> +	else if (ops && ops->max_opt_mapping_size)
> +		size = ops->max_opt_mapping_size();
>  
>  	return min(dma_max_mapping_size(dev), size);
>  }
> -EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
> +EXPORT_SYMBOL_GPL(dma_max_opt_mapping_size);
>  
>  unsigned long dma_get_merge_boundary(struct device *dev)
>  {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


