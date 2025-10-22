Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DEACCD1BE
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 06:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=42uwMQFCrtxhvkpJkrGIOWVw+pmhbUOVzNAD2uGqFb4=; b=4FHI5WM1eh9gLv3QDfVoOU8YK9
	VTOeNfjlDsSXgFiNaNIs47zN5s5bRTzi5uXM7WjWykEJjpgEXcxfG9ZheBNe8OCTdqdcune1xaXwx
	0ziItEvlAwyrTuZguVFPDecBQwncdMWrlaL4vmF6mkTGTwR/9DTJc4Bf/qvWiH6ykSwpBcb53+plG
	XMUz9ZahvCgbjztfuN4AUzeZj+BuQ7c8kYlm2HoSfiBVJHkHEAKEVkUk0aZvc67t6RCBYrtacKmaA
	/eeLXcBeh1hUYEZJYOQWchbcs0HFYMqsUV9TmL1FT72oYt8qbXfquSYscGxx9joUlcni13bR2vdbz
	m44SxgfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSEF-00000001e0i-18kp;
	Wed, 22 Oct 2025 06:21:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSE9-00000001dzK-232M
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 06:21:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E62DB227A88; Wed, 22 Oct 2025 08:21:35 +0200 (CEST)
Date: Wed, 22 Oct 2025 08:21:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 2/2] block-dma: properly take MMIO path
Message-ID: <20251022062135.GD4317@lst.de>
References: <20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com> <20251020-block-with-mmio-v2-2-147e9f93d8d4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-block-with-mmio-v2-2-147e9f93d8d4@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_232143_034886_3A88A2EE 
X-CRM114-Status: GOOD (  23.57  )
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

On Mon, Oct 20, 2025 at 08:00:21PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> In commit eadaa8b255f3 ("dma-mapping: introduce new DMA attribute to
> indicate MMIO memory"), DMA_ATTR_MMIO attribute was added to describe
> MMIO addresses, which require to avoid any memory cache flushing, as
> an outcome of the discussion pointed in Link tag below.
> 
> In case of PCI_P2PDMA_MAP_THRU_HOST_BRIDGE transfer, blk-mq-dm logic
> treated this as regular page and relied on "struct page" DMA flow.
> That flow performs CPU cache flushing, which shouldn't be done here,
> and doesn't set IOMMU_MMIO flag in DMA-IOMMU case.
> 
> Link: https://lore.kernel.org/all/f912c446-1ae9-4390-9c11-00dce7bf0fd3@arm.com/
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  block/blk-mq-dma.c            |  6 ++++--
>  drivers/nvme/host/pci.c       | 23 +++++++++++++++++++++--
>  include/linux/blk-integrity.h |  7 ++++---
>  include/linux/blk-mq-dma.h    | 11 +++++++----
>  4 files changed, 36 insertions(+), 11 deletions(-)
> 
> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> index 4ba7b0323da4..3ede8022b41c 100644
> --- a/block/blk-mq-dma.c
> +++ b/block/blk-mq-dma.c
> @@ -94,7 +94,7 @@ static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
>  		struct blk_dma_iter *iter, struct phys_vec *vec)
>  {
>  	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
> -			rq_dma_dir(req), 0);
> +			rq_dma_dir(req), iter->attrs);
>  	if (dma_mapping_error(dma_dev, iter->addr)) {
>  		iter->status = BLK_STS_RESOURCE;
>  		return false;
> @@ -116,7 +116,7 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
>  
>  	do {
>  		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
> -				vec->len, dir, 0);
> +				vec->len, dir, iter->attrs);
>  		if (error)
>  			break;
>  		mapped += vec->len;
> @@ -184,6 +184,8 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
>  		 * P2P transfers through the host bridge are treated the
>  		 * same as non-P2P transfers below and during unmap.
>  		 */
> +		iter->attrs |= DMA_ATTR_MMIO;

DMA_ATTR_MMIO is the only flags in iter->attrs, and I can't see any other
DMA mapping flag that would fit here.  So I'd rather store the
enum pci_p2pdma_map_type here, which also removes the need for REQ_P2PDMA 
and BIP_P2P_DMA when propagating that to nvme.


