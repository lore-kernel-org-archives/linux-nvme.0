Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D44CE77178
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2024 14:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y42j5xQ8uuKkAImqJ1Sbr0phfQsqOqPqPxQXYkNnsPU=; b=kNofoIptGv+aJt3XHgWvl2yq1k
	B6+KiZbDH8mDWYSVcEC9sntzGzB/HjkI02oC+obBwbqdBlHret7lEtLFGtf+KYppnp/S0BqtXyYnE
	E/sjxDhZbfjB2AuQS1L479R2pq7eo6WzIxbYXzFYBg1jCmELI/YQ2HdpZbXzThoL7CUFC2mNwKUKp
	MBdF7eMnw+Su8t+k8P5gQ4Uo5wuH4wnX0r9VafZZcCZzcyTymEHQw9j5mqilc5cJjTBIz55oCfsiY
	0SNhBHulpHa/yIqN2BMzOuPkFw6kkrpi0Rjw4CRsr4omKnJRGEv6yt6XpZwQThwmLMvrgEJ0r3maq
	hVfb4GOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCr0-0000000GKdK-2wbn;
	Thu, 05 Dec 2024 14:29:18 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJBno-0000000G6iT-1RsT
	for linux-nvme@lists.infradead.org;
	Thu, 05 Dec 2024 13:21:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 83050A43827;
	Thu,  5 Dec 2024 13:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7146CC4CEDC;
	Thu,  5 Dec 2024 13:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733404915;
	bh=6vyLZ9mjLX8vy7gjsSTdc+TDPjgozca4sT5DOBvIDT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gEwcsWthUSAxIxjfrBqFOQiBldV+OvqF/KNda7RQCFCgJEElI1mMmtoN+OAS+1IpQ
	 EuWJ7VG//txuz2kWbME1w/2JZaKejgbJnHf6TLqiacZdDihn5BqEylAVe2qMs+NuVB
	 pWhJjLzknasZ9ihnmARhOaEOWIZGb5SVSvRnY60q3jBpRbezPmb7we5bRi2/dt13Ea
	 JLdquKywXFcp480ZZKdIODF68WfKZSw23kDSoPqazVFdm0fHCe5i0rXMKm+H5UbOjF
	 sfmG0PlOyozFrqQZHypeYrF7/l740hCK8my2FB1lNNDT+w8Tefa/D9M8qdoiBaYYXV
	 4GB38qMyF3oLQ==
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
	linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 07/18] iommu/dma: Factor out a iommu_dma_map_swiotlb helper
Date: Thu,  5 Dec 2024 15:21:06 +0200
Message-ID: <99fe6d72335764c3722d755be65e3802a1f6ce7e.1733398913.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733398913.git.leon@kernel.org>
References: <cover.1733398913.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_052156_512349_C49F250E 
X-CRM114-Status: GOOD (  18.24  )
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
2.47.0


