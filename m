Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1537C71136
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 18:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eo36Awb51Q0RV63PDdElEhRn7Tjl7dlRvWvgcpemBWc=; b=bukZRszz9AY7Z1
	uCGFO2Y8MF89CldvSU2v3omTxBb4XAkOJp4aAlfGGnIxqZ650CeyZNp8k8MWTJOhkPxGTQoLd/naM
	Sog/Zqr3ZXd3tRuvPB3xLxvueztyAsqt5cpPpGZ8GRW4PUeYreug40HB4aA8f60dooDE5HOPVuLPr
	18vDkk2L5ZdQMSuT5dkcWx/npH7gqD7eW/ErPiupRfVQB5wEJGnoW8OR6LoqFdAhPcxXMwNdVrJZz
	atOFImHnWU6VrYQNJ4P/8sorvzto/JGaqj0boGqxsDCYRWKmwyVrKkLN04IeTwkQK6E9jR9sKAVvi
	H++mU/wSihB+E0QeJ1Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPPkk-0000000Anfv-44BK;
	Wed, 11 Jun 2025 18:00:46 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPMCk-0000000A4Bb-1Jyb
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 14:13:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B6D4B43E8B;
	Wed, 11 Jun 2025 14:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECDFC4CEE3;
	Wed, 11 Jun 2025 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749651205;
	bh=g9ZqoAzVAgYCqLKjo26Nv7HuA3LavIx+D1Zfdwx4AmQ=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fh4PB6DN00JmQKz/lac6hrUrtZvhOUXWR0/9zvjFFBk5Vay8mUnwEKugj2zz5MPUz
	 0j/TfGkirXtWz3g0N+uzhYETUi4rws5JtQGh8qcpfQ6r/3sxabxi7PMQIzIS9ONH7L
	 HoXdnW/5+6G68HsWb1DDx1Yyihyhm8cc2pUjqfdNuDSqkCKwawVkqSH2hSS+6FohjJ
	 jeiIRLxt+M4Yl3eIdj4boSsdOW6eJeYqelMVsv4IHkuQm7ZUBFooqf5gdbyTJD9RXY
	 QlR0Wn1ymn3XzOuWNefG9a9yBBLQ8miEQKN74OpNc2TKmbh5gGXgIRAAbrwTaAdz+B
	 8hASRyk58J6hQ==
Message-ID: <4bdeb522-42d4-460c-8812-7e0d8602cf8f@kernel.org>
Date: Wed, 11 Jun 2025 16:13:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-8-hch@lst.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250610050713.2046316-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_071326_394931_11D0FEFB 
X-CRM114-Status: GOOD (  26.30  )
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
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/06/2025 07.06, Christoph Hellwig wrote:
> Use the blk_rq_dma_map API to DMA map requests instead of scatterlists.
> This removes the need to allocate a scatterlist covering every segment,
> and thus the overall transfer length limit based on the scatterlist
> allocation.
> 
> Instead the DMA mapping is done by iterating the bio_vec chain in the
> request directly.  The unmap is handled differently depending on how
> we mapped:
> 
>  - when using an IOMMU only a single IOVA is used, and it is stored in
>    iova_state
>  - for direct mappings that don't use swiotlb and are cache coherent no
>    unmap is needed at all
>  - for direct mappings that are not cache coherent or use swiotlb, the
>    physical addresses are rebuild from the PRPs or SGL segments
> 
> The latter unfortunately adds a fair amount of code to the driver, but
> it is code not used in the fast path.
> 
> The conversion only covers the data mapping path, and still uses a
> scatterlist for the multi-segment metadata case.  I plan to convert that
> as soon as we have good test coverage for the multi-segment metadata
> path.
> 
> Thanks to Chaitanya Kulkarni for an initial attempt at a new DMA API
> conversion for nvme-pci, Kanchan Joshi for bringing back the single
> segment optimization, Leon Romanovsky for shepherding this through a
> gazillion rebases and Nitesh Shetty for various improvements.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 388 +++++++++++++++++++++++++---------------
>  1 file changed, 242 insertions(+), 146 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 04461efb6d27..2d3573293d0c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
...
> @@ -2908,26 +3018,14 @@ static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
>  static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)

Since this pool is now used exclusively for metadata, it makes sense to update
the function name accordingly:

static int nvme_pci_alloc_iod_meta_mempool(struct nvme_dev *dev)

>  {
>  	size_t meta_size = sizeof(struct scatterlist) * (NVME_MAX_META_SEGS + 1);
> -	size_t alloc_size = sizeof(struct scatterlist) * NVME_MAX_SEGS;
> -
> -	dev->iod_mempool = mempool_create_node(1,
> -			mempool_kmalloc, mempool_kfree,
> -			(void *)alloc_size, GFP_KERNEL,
> -			dev_to_node(dev->dev));
> -	if (!dev->iod_mempool)
> -		return -ENOMEM;
>  
>  	dev->iod_meta_mempool = mempool_create_node(1,
>  			mempool_kmalloc, mempool_kfree,
>  			(void *)meta_size, GFP_KERNEL,
>  			dev_to_node(dev->dev));
>  	if (!dev->iod_meta_mempool)
> -		goto free;
> -
> +		return -ENOMEM;
>  	return 0;
> -free:
> -	mempool_destroy(dev->iod_mempool);
> -	return -ENOMEM;
>  }
>  
>  static void nvme_free_tagset(struct nvme_dev *dev)

