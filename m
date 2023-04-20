Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D140CC77B73
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Apr 2023 15:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kgM0JHzPCNvKr+9cp/L0boL52jHq5xNEmgbL15g1x5o=; b=AGAGtvrzuHxPW7vRz9sYbDIoAM
	ESbESNykFrnJeMCCP/ciMJCehBJLReGqz+pedPMqPMk8SThiwCNXmA+sQnmOrZXVyZ3GMfLGzVZGL
	BvHWXdt0T515rXgpE2oce6FxnbCmv6U/DxAB+mm7kotP/yHGKoEJLsGdWWCyIyITYIYPlfSlvzpu1
	zvkVdxY/q+ptQ99k8xh4GF8eRYRCN75SVmLAMZ7Ve9FSRWCeLWbs0sNG9NWu3SugxcuO2n4kBcAUZ
	oI9Ve2qMcHUceUcxad0uVZ4DORiDAUviwswX4Ds0pFaf6EODaWuHTr7uraVuhC6pkjArYNyyOqQP2
	+/7YxRPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppWEA-008PUM-0t;
	Thu, 20 Apr 2023 15:29:42 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppWE6-008PSi-2K
	for linux-nvme@lists.infradead.org;
	Thu, 20 Apr 2023 15:29:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D400060A3B;
	Thu, 20 Apr 2023 15:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE642C433D2;
	Thu, 20 Apr 2023 15:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682004573;
	bh=MAxNLEi9Laz6Rtk0cSTWmnXgzP9ZBF70aoAIMpyib2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEnFQ1MT4Bx7GdsJ7zJ7/xMQNfCHn/ZPrWdbglAtfT1j1zhh2WMvDSpbOyvPrtuXY
	 ra87ivs+pxFFPdqDoSJQAFfnXMSquQwd0jG+fxOxGfSeORKfZM4b3iziBYtM3CXM1/
	 PaexFbMbnsusfE/Qc7F6ipQ0FiG6gSujQG96PfKIp4R3Jd5LY3H1hr4zPCZ0E0hV6S
	 cdsyDBxsuBipFp8D5YQWqogrphq1bEkUJlDDkpbjug5JzObRjj/+J6N7SeugNjyTZR
	 ZK2SRmLJ8VMxOn/zDy+08TYoGW5ttZ4TtKsaovwGYnUZUdLtJQm67GZpXijRdZgCRR
	 6Yd1kqMJySmcw==
Date: Thu, 20 Apr 2023 09:29:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	iommu@lists.linux.dev, Jiwei Sun <sunjw10@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH] nvme: clamp max_hw_sectors based on DMA optimized
 limitation
Message-ID: <ZEFaWnF+b87i91o/@kbusch-mbp.dhcp.thefacebook.com>
References: <20230420130155.19281-1-adrianhuang0701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420130155.19281-1-adrianhuang0701@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_082938_863402_F1AD7608 
X-CRM114-Status: GOOD (  22.74  )
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

On Thu, Apr 20, 2023 at 09:01:55PM +0800, Adrian Huang wrote:
> To fix the lock contention issue, clamp max_hw_sectors based on
> DMA optimized limitation in order to leverage scalable IOVA mechanism.
> 
> Note: The issue does not happen with another NVME disk (mdts = 5
> and max_hw_sectors_kb = 128)

Thanks for the patch. I think this makes sense.
 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 53ef028596c6..c0d1ea889b4d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1819,11 +1819,16 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
>  	bool vwc = ctrl->vwc & NVME_CTRL_VWC_PRESENT;
>  
>  	if (ctrl->max_hw_sectors) {
> -		u32 max_segments =
> -			(ctrl->max_hw_sectors / (NVME_CTRL_PAGE_SIZE >> 9)) + 1;
> +		u32 opt_sectors, max_sectors; /* optimized/max sectors */
> +		u32 max_segments;
> +
> +		opt_sectors = dma_opt_mapping_size(ctrl->dev) >> SECTOR_SHIFT;
> +		max_sectors = min_not_zero(ctrl->max_hw_sectors, opt_sectors);
> +
> +		max_segments = (max_sectors / (NVME_CTRL_PAGE_SIZE >> 9)) + 1;
>  
>  		max_segments = min_not_zero(max_segments, ctrl->max_segments);
> -		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
> +		blk_queue_max_hw_sectors(q, max_sectors);
>  		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
>  	}
>  	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);

Taking into account what Linus mentioned on a similiar patch[1], I think it may
make more sense for the lower level driver code to have already capped
ctrl->max_hw_sectors prior to calling this function. Something like the patch
below.

[1] https://lore.kernel.org/all/CAHk-=whogEk1UJfU3E7aW18PDYRbdAzXta5J0ECg=CB5=sCe7g@mail.gmail.com/

Side note, I think he's incorrect about using the max_segment_size limit since
the dma code will collapse physically contiguous segments, so splitting bvecs
for that limit won't really help.

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 282d808400c5b..8505fbeaa2d2f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2914,6 +2914,12 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	struct nvme_dev *dev;
 	int ret = -ENOMEM;
 
+	/*
+	 * Limit the max command size to prevent iod->sg allocations going
+	 * over a single page.
+	 */
+	size_t max_bytes = NVME_MAX_KB_SZ;
+
 	if (node == NUMA_NO_NODE)
 		set_dev_node(&pdev->dev, first_memory_node);
 
@@ -2955,12 +2961,9 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
 	dma_set_max_seg_size(&pdev->dev, 0xffffffff);
 
-	/*
-	 * Limit the max command size to prevent iod->sg allocations going
-	 * over a single page.
-	 */
-	dev->ctrl.max_hw_sectors = min_t(u32,
-		NVME_MAX_KB_SZ << 1, dma_max_mapping_size(&pdev->dev) >> 9);
+	max_bytes = min(max_bytes, dma_max_mapping_size(&pdev->dev));
+	max_bytes = min_not_zero(max_bytes, dma_opt_mapping_size(&pdev->dev));
+	dev->ctrl.max_hw_sectors = max_bytes >> 9;
 	dev->ctrl.max_segments = NVME_MAX_SEGS;
 
 	/*
--

