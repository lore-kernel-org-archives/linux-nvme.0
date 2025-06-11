Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD30C71133
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 15:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zzowbOVNmXnOCcXoC7Sl4ONUsWy/IHKnV5hJzurmIOo=; b=SXxMBrIqkEI4D+
	8nWMABDcVUY0Oeas49EeK+ojC8GrX0q/nTtIqGBHFAIQWk/KcPlFPSyIFHWaJYg04cW82O6wvSbzK
	KP7Ok29zCvZrR8E59fEUCMiv8Zq/O/X7ATW53SBZUDlfgp4hX2l6EQ+ifySbOHESvBGRDfA1adUc+
	lYXSD+U87Y9GYu3wp8N2PC17cAhzcAX5K8JAqoUTV5smRxJGKmVft1b5ExvjnWZ47aoCkft8xGdG6
	eUgNRBYL6+C5Pv6gWZKdgZo0PG2H5BoRywXK1fk+BYa4Gw90jv9Ag6FPDJQE4nyyRMygHOWFTK48q
	7KqQg8QQ2QLkep7+vaKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPNL9-0000000ANpO-1lMA;
	Wed, 11 Jun 2025 15:26:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPKMM-00000009pDa-3Rdg
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 12:15:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A3A8C5C57F7;
	Wed, 11 Jun 2025 12:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0A3C4CEEE;
	Wed, 11 Jun 2025 12:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749644114;
	bh=zK3mQC0Jkck96l1GMcCAp8W9FUpL+mkHpHxAzpC5Qi4=;
	h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
	b=KN11kb6+nrjF2QKf1wbs0T2MFYQuV1hjJ2xlHdBcU0eYeYBzqO0x32J/s9Df40sxM
	 fNOif8tExR1viPxI/6EDIwNVRjdv+ae6nC4bMtbqoUgWUwwTrpUDmb7suBwGvOW8IK
	 D9U5Zrnhq2ur7nSgpSnijdc5D5o3aYIwwyexCYf902cFku1y1IljdTdJind9Mcx3vs
	 oISMZj8+OrB8UxmnWDlfeNnROWIrSehOnqlwasHTiqYKHZZisJuE8b2Y7Jnl6jjVfo
	 P//9yg8Y/wqMX+OXg6KRYi195jP1WtSeFQXxZwzrFjyJEv97l/T8/hdbElumpypaFy
	 RcJ+gSzh2y6pA==
Message-ID: <5c4f1a7f-b56f-4a97-a32e-fa2ded52922a@kernel.org>
Date: Wed, 11 Jun 2025 14:15:10 +0200
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
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_051514_942727_B555A8AB 
X-CRM114-Status: GOOD (  25.22  )
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
> @@ -7,7 +7,7 @@
>  #include <linux/acpi.h>
>  #include <linux/async.h>
>  #include <linux/blkdev.h>
> -#include <linux/blk-mq.h>
> +#include <linux/blk-mq-dma.h>
>  #include <linux/blk-integrity.h>
>  #include <linux/dmi.h>
>  #include <linux/init.h>
> @@ -27,7 +27,6 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/io-64-nonatomic-hi-lo.h>
>  #include <linux/sed-opal.h>
> -#include <linux/pci-p2pdma.h>
>  
>  #include "trace.h"
>  #include "nvme.h"
> @@ -46,13 +45,11 @@
>  #define NVME_MAX_NR_DESCRIPTORS	5
>  
>  /*
> - * For data SGLs we support a single descriptors worth of SGL entries, but for
> - * now we also limit it to avoid an allocation larger than PAGE_SIZE for the
> - * scatterlist.
> + * For data SGLs we support a single descriptors worth of SGL entries.
> + * For PRPs, segments don't matter at all.
>   */
>  #define NVME_MAX_SEGS \
> -	min(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc), \
> -	    (PAGE_SIZE / sizeof(struct scatterlist)))
> +	(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc))

The 8 MiB max transfer size is only reachable if host segments are at least 32k.
But I think this limitation is only on the SGL side, right? Adding support to
multiple SGL segments should allow us to increase this limit 256 -> 2048.

Is this correct?

