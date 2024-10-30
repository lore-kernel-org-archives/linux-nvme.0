Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D14CD5CCB8
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 15:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x88jTcq6GLouiEokwKqr1ClmMP8uqV/wSbdaC6q3fFg=; b=JXrAf0M/PVtZQUQPbOozztCqkP
	k6fL6okywZ2Y7Vka/MOL4ZZElDcWrIyVJmgjkQcylYhljnuKBGpWfL8OD8qKKGeBZlLIVXZ/0nL8z
	NsykXvEH0cdNqNatuS8AvDNwMQ63yN2PAGWUdaU2zD9P2pOY/LSN745sS1DnsntrpEeNIbcrT7GHG
	wPxn7lKyKJ3kDpRTShm9kuF2m9BeB12henErtJpqIews7ORkmkz9pmzJXWuadkGWctip+p7ww+1nz
	srOqrLmtu/b8k43edJSJOnaHU/1IJAOpovfwAd4oX6Z3lfok0/q7L4tu0is+A72vsXbksGAX+yb17
	aJ/M1xUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6AOK-00000000nRe-3C5g;
	Wed, 30 Oct 2024 15:13:48 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6AOC-00000000nKg-3fcs
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 15:13:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4BEECA4255F;
	Wed, 30 Oct 2024 15:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13913C4CECE;
	Wed, 30 Oct 2024 15:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730301219;
	bh=XGQ1NR355bwszo+JrznVV1hbHviA7CQrxv/BERy+y90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LmPDkamqTEpX+kwqmBANPlqtlaFChfErvXzZhGcch88a2LmIU2YivyLFbxjH/hzDZ
	 UNXh/XXgTFkZfi9o/NrVNl/D2NwKGhCbDbxrukedWRjZezPUNgu3cjHDkBmHwB1ipi
	 ToolLhizyQGeQxxr9bWcbopr2T3qyqnWcemFq8LORVDrrnGTOu7T2CVKojWMqU0aQy
	 +EYFhYN45wrl8n2fh86UD+fmcagGwz4cCmHXzXzOmvR9DGTd+10cF2ZIGLyWyxQLVv
	 N2MVluX7uYAEpW4yfHdfhNE3yxm+LfwU2OgZ2tF67RMlGpA+rFfIfD9Nx5spoyzjvo
	 M+eW1/GKIlmtg==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1 06/17] iommu/dma: Factor out a iommu_dma_map_swiotlb helper
Date: Wed, 30 Oct 2024 17:12:52 +0200
Message-ID: <38bd0f07e18f4c74f2ab77f268e9d0424569f69f.1730298502.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1730298502.git.leon@kernel.org>
References: <cover.1730298502.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_081341_142383_E9DC8813 
X-CRM114-Status: GOOD (  18.44  )
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

From: Christoph Hellwig <hch@lst.de>

Split the iommu logic from iommu_dma_map_page into a separate helper.
This not only keeps the code neatly separated, but will also allow for
reuse in another caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 73 ++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 127150f63c95..e1eaad500d27 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1161,6 +1161,43 @@ void iommu_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
 			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
 }
 
+static phys_addr_t iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iova_domain *iovad = &domain->iova_cookie->iovad;
+
+	if (!is_swiotlb_active(dev)) {
+		dev_warn_once(dev, "DMA bounce buffers are inactive, unable to map unaligned transaction.\n");
+		return DMA_MAPPING_ERROR;
+	}
+
+	trace_swiotlb_bounced(dev, phys, size);
+
+	phys = swiotlb_tbl_map_single(dev, phys, size, iova_mask(iovad), dir,
+			attrs);
+
+	/*
+	 * Untrusted devices should not see padding areas with random leftover
+	 * kernel data, so zero the pre- and post-padding.
+	 * swiotlb_tbl_map_single() has initialized the bounce buffer proper to
+	 * the contents of the original memory buffer.
+	 */
+	if (phys != DMA_MAPPING_ERROR && dev_is_untrusted(dev)) {
+		size_t start, virt = (size_t)phys_to_virt(phys);
+
+		/* Pre-padding */
+		start = iova_align_down(iovad, virt);
+		memset((void *)start, 0, virt - start);
+
+		/* Post-padding */
+		start = virt + size;
+		memset((void *)start, 0, iova_align(iovad, start) - start);
+	}
+
+	return phys;
+}
+
 dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	      unsigned long offset, size_t size, enum dma_data_direction dir,
 	      unsigned long attrs)
@@ -1174,42 +1211,14 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	dma_addr_t iova, dma_mask = dma_get_mask(dev);
 
 	/*
-	 * If both the physical buffer start address and size are
-	 * page aligned, we don't need to use a bounce page.
+	 * If both the physical buffer start address and size are page aligned,
+	 * we don't need to use a bounce page.
 	 */
 	if (dev_use_swiotlb(dev, size, dir) &&
 	    iova_offset(iovad, phys | size)) {
-		if (!is_swiotlb_active(dev)) {
-			dev_warn_once(dev, "DMA bounce buffers are inactive, unable to map unaligned transaction.\n");
-			return DMA_MAPPING_ERROR;
-		}
-
-		trace_swiotlb_bounced(dev, phys, size);
-
-		phys = swiotlb_tbl_map_single(dev, phys, size,
-					      iova_mask(iovad), dir, attrs);
-
+		phys = iommu_dma_map_swiotlb(dev, phys, size, dir, attrs);
 		if (phys == DMA_MAPPING_ERROR)
-			return DMA_MAPPING_ERROR;
-
-		/*
-		 * Untrusted devices should not see padding areas with random
-		 * leftover kernel data, so zero the pre- and post-padding.
-		 * swiotlb_tbl_map_single() has initialized the bounce buffer
-		 * proper to the contents of the original memory buffer.
-		 */
-		if (dev_is_untrusted(dev)) {
-			size_t start, virt = (size_t)phys_to_virt(phys);
-
-			/* Pre-padding */
-			start = iova_align_down(iovad, virt);
-			memset((void *)start, 0, virt - start);
-
-			/* Post-padding */
-			start = virt + size;
-			memset((void *)start, 0,
-			       iova_align(iovad, start) - start);
-		}
+			return phys;
 	}
 
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-- 
2.46.2


