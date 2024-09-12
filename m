Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A4DEEB59D
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 12:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a8A9ch32OnCK6zlVv+ChhoMntSAAJjv1Y1wVJxAAmWs=; b=1N7HitYwd4EHi6L8enqM9aHInk
	pIeI9myzPGU29wcBJJCIsGbtUDDPR5kZ4QCRkkRdngYlXpU3L9Os/SLjyJ66ppTLqz7LrmSnec9dP
	XSl4DcY5osfdT2Zw9k2D3zgoIRP6fRoX5Uj4iEE8ce4geHyqgGVlcLXTcc94vUmKjvaAq+0vVpNDR
	YUNmD8SA6lTg8hYly/JnQPTqTiWwhoAYIOXQn0VyPRR0rvAMmuE/vgR5/ReRTW1bbVkqVqCZquVgF
	df8S1rQqg0yyJiKU7pI19fRm/uC8Mo5OWWNN04vYJpGSsQkdiWPvJsu68U/k8GVExwvM2N96qVOc4
	n5XgZpuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soiyO-0000000D2Ht-26T7;
	Thu, 12 Sep 2024 12:30:56 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohoQ-0000000CnYf-3HiW
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 11:16:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 33B8AA45274;
	Thu, 12 Sep 2024 11:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8814DC4CECC;
	Thu, 12 Sep 2024 11:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726139793;
	bh=UdWHtN/ksXEH4oEZ6oLMvfaCKk3WWuTK2xFlFpaVROQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JaEIJPQlXW2dDMP6p7hqTalr5/nZfzPDNjt31Ao+a/Z+6Qd6aR11344w2a+DiulS6
	 iMiK8gTB/L8nSXItJGUYe9cwRmL2GgnozYUV8QmwIPwxlHyW9aemlOw4kUFJ274pAA
	 PN0d31Risc4/iSKKWebUhSD66kfvH9LIyEwYMS4hOAKbYQxJRBmddM3wevSD+t9Lab
	 3P9ksYF1WRRS9QQhDgWjrPfCaOyxagFMoWzGFxcyzomruL7xcQnhG0yOGfbzjF3fR/
	 bCmDiQ+O2/NGR32Y9Ac9Uqzw207ZTfmgI/uaIsUSGZlxOlUgCp8lIc5BJSywScgOIC
	 JJAYki7oZADlw==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC v2 03/21] iommu/dma: Add check if IOVA can be used
Date: Thu, 12 Sep 2024 14:15:38 +0300
Message-ID: <cac154df7131984929a1cf73948bc5986af5ef85.1726138681.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726138681.git.leon@kernel.org>
References: <cover.1726138681.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_041635_277197_A121A427 
X-CRM114-Status: GOOD (  17.27  )
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

From: Leon Romanovsky <leonro@nvidia.com>

This patch adds a check if IOVA can be used for the page and size.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/dma-iommu.c   | 21 +++++++++++++++++++++
 drivers/pci/p2pdma.c        |  4 ++--
 include/linux/dma-map-ops.h |  7 +++++++
 include/linux/iommu-dma.h   |  7 +++++++
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 72763f76b712..3e2e382bb502 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -11,6 +11,7 @@
 #include <linux/acpi_iort.h>
 #include <linux/atomic.h>
 #include <linux/crash_dump.h>
+#include <linux/cc_platform.h>
 #include <linux/device.h>
 #include <linux/dma-direct.h>
 #include <linux/dma-map-ops.h>
@@ -1829,6 +1830,26 @@ void iommu_dma_unlink_range(struct device *dev, dma_addr_t start, size_t size,
 		iommu_iotlb_sync(domain, &iotlb_gather);
 }
 
+bool iommu_can_use_iova(struct device *dev, struct page *page, size_t size,
+			enum dma_data_direction dir)
+{
+	enum pci_p2pdma_map_type map;
+
+	if (is_swiotlb_force_bounce(dev) || dev_use_swiotlb(dev, size, dir))
+		return false;
+
+	/* TODO: Rewrite this check to rely on specific struct page flags */
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		return false;
+
+	if (page && is_pci_p2pdma_page(page)) {
+		map = pci_p2pdma_map_type(page->pgmap, dev);
+		return map == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
+	}
+
+	return true;
+}
+
 void iommu_setup_dma_ops(struct device *dev)
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4f47a13cb500..6ceea32bb041 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -964,8 +964,8 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 }
 EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
 
-static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
-						    struct device *dev)
+enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
+					     struct device *dev)
 {
 	enum pci_p2pdma_map_type type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
 	struct pci_dev *provider = to_p2p_pgmap(pgmap)->provider;
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 103d9c66c445..936e822e9f40 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -516,6 +516,8 @@ struct pci_p2pdma_map_state {
 enum pci_p2pdma_map_type
 pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
 		       struct scatterlist *sg);
+enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
+					     struct device *dev);
 #else /* CONFIG_PCI_P2PDMA */
 static inline enum pci_p2pdma_map_type
 pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
@@ -523,6 +525,11 @@ pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
 {
 	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
 }
+static inline enum pci_p2pdma_map_type
+pci_p2pdma_map_type(struct dev_pagemap *pgmap, struct device *dev)
+{
+	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
+}
 #endif /* CONFIG_PCI_P2PDMA */
 
 #endif /* _LINUX_DMA_MAP_OPS_H */
diff --git a/include/linux/iommu-dma.h b/include/linux/iommu-dma.h
index 21b0341f52b8..561d81b12d9c 100644
--- a/include/linux/iommu-dma.h
+++ b/include/linux/iommu-dma.h
@@ -66,6 +66,8 @@ dma_addr_t iommu_dma_link_range(struct dma_iova_state *state, phys_addr_t phys,
 				size_t size, unsigned long attrs);
 void iommu_dma_unlink_range(struct device *dev, dma_addr_t start, size_t size,
 			    enum dma_data_direction dir, unsigned long attrs);
+bool iommu_can_use_iova(struct device *dev, struct page *page, size_t size,
+			enum dma_data_direction dir);
 #else
 static inline bool use_dma_iommu(struct device *dev)
 {
@@ -209,5 +211,10 @@ static inline void iommu_dma_unlink_range(struct device *dev, dma_addr_t start,
 					  unsigned long attrs)
 {
 }
+static inline bool iommu_can_use_iova(struct device *dev, struct page *page,
+				      size_t size, enum dma_data_direction dir)
+{
+	return false;
+}
 #endif /* CONFIG_IOMMU_DMA */
 #endif /* _LINUX_IOMMU_DMA_H */
-- 
2.46.0


