Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20B0C30658
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g9SErVqLGwmT74XKztdMcaMW7Z/xOj3VfCtyRrAV9cY=; b=iYj53WpUn8RtgC7wgoc70JPe8E
	UBLgzkJWH2OZoVLWkpYv5cuSjxleGmF1yd7dVwiEBD/lMeDGLa2D48f4wmD8yCHu2yXnnel9t+2eS
	lDrLXu7KTsaZFJh9A25W0/Pomjy4QD2yPSkIiOWVQ/0Js/4ebjcRmc3Vq31YzPK6w51Im42pUg8lc
	5zeI13X0C0hXfk/tWn4c6KptgmOfJ6TDlwOMslDBkdMyF+1hiVLuxEcy/auBXQrZo/LZEp+o2TF4m
	mPGxlm8S0t1ykjgn3iYfwmARbroQTIGfGHyXejkiE4zAEh3VxXZT/qSd9WPT/Dr1y6Di5tcU8MHMK
	LBAfxMng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOZWg-000000065EK-0GIT;
	Tue, 02 Jul 2024 09:10:14 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOZWc-000000065B8-36aC
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 09:10:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C12ACCE1CFA;
	Tue,  2 Jul 2024 09:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCD7C4AF0C;
	Tue,  2 Jul 2024 09:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719911408;
	bh=I7mD3dENF4HZBNBumoLyPjANfOtz0e/DAq7U9sRqLk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PqzjMLOjXeye9zq/mHzTj6Cl4RxSudqszFKsPx54AmE/tJ+OHgWu5ivCnN1LbBRUN
	 1Yv5vxJ4cXclv2ETPV3ZWWpK913fTcXr7yVC/nJo7AtJ6rnu3SJBTnF9+JY89SOEvd
	 TYkrX534Vg7HQIcEHujxARKgvk/nUOly8dQEFeqHVLZriAax5EaH09H4nUGZ/y8Loi
	 vDIjzYbeVRyYivHIMQkPD/nstZnUBJhmQWQx2JPLSSZymUewhzPZooZ7yJC7ufM6es
	 ONXggsrnv88nbqTGWDYThjoAZxFxhMpavbb+IIZpeIVu2VNBfqxKFRLDEd3u7X+sYd
	 zohrHgWstJ+9w==
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
Cc: Leon Romanvosky <leonro@nvidia.com>,
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
Subject: [RFC PATCH v1 03/18] dma-mapping: check if IOVA can be used
Date: Tue,  2 Jul 2024 12:09:33 +0300
Message-ID: <4c479ac482c3bd123a5f999fdff46454a7faa905.1719909395.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719909395.git.leon@kernel.org>
References: <cover.1719909395.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_021011_161538_278CB8E8 
X-CRM114-Status: GOOD (  20.18  )
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

From: Leon Romanvosky <leonro@nvidia.com>

Provide a way to the callers to see if IOVA can be used for specific
DMA memory type.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/dma-iommu.c   | 13 -------------
 drivers/pci/p2pdma.c        |  4 ++--
 include/linux/dma-map-ops.h | 21 +++++++++++++++++++++
 include/linux/dma-mapping.h | 10 ++++++++++
 kernel/dma/mapping.c        | 32 ++++++++++++++++++++++++++++++++
 5 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 43520e7275cc..89e34503e0bb 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -597,19 +597,6 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	return ret;
 }
 
-static bool dev_is_untrusted(struct device *dev)
-{
-	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
-}
-
-static bool dev_use_swiotlb(struct device *dev, size_t size,
-			    enum dma_data_direction dir)
-{
-	return IS_ENABLED(CONFIG_SWIOTLB) &&
-		(dev_is_untrusted(dev) ||
-		 dma_kmalloc_needs_bounce(dev, size, dir));
-}
-
 static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *sg,
 			       int nents, enum dma_data_direction dir)
 {
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
index 23e5e2f63a1c..b52e9c8db241 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -9,6 +9,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/pgtable.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
 
 struct cma;
 struct iommu_ops;
@@ -348,6 +349,19 @@ static inline bool dma_kmalloc_needs_bounce(struct device *dev, size_t size,
 	return !dma_kmalloc_safe(dev, dir) && !dma_kmalloc_size_aligned(size);
 }
 
+static inline bool dev_is_untrusted(struct device *dev)
+{
+	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
+}
+
+static inline bool dev_use_swiotlb(struct device *dev, size_t size,
+				   enum dma_data_direction dir)
+{
+	return IS_ENABLED(CONFIG_SWIOTLB) &&
+	       (dev_is_untrusted(dev) ||
+		dma_kmalloc_needs_bounce(dev, size, dir));
+}
+
 void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
@@ -514,6 +528,8 @@ struct pci_p2pdma_map_state {
 enum pci_p2pdma_map_type
 pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
 		       struct scatterlist *sg);
+enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
+					     struct device *dev);
 #else /* CONFIG_PCI_P2PDMA */
 static inline enum pci_p2pdma_map_type
 pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
@@ -521,6 +537,11 @@ pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
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
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 673ddcf140ff..9d1e020869a6 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -100,6 +100,11 @@ struct dma_iova_attrs {
 	unsigned long attrs;
 };
 
+struct dma_iova_state {
+	struct dma_iova_attrs *iova;
+	struct dma_memory_type *type;
+};
+
 #ifdef CONFIG_DMA_API_DEBUG
 void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
 void debug_dma_map_single(struct device *dev, const void *addr,
@@ -178,6 +183,7 @@ int dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
 		size_t size, struct sg_table *sgt);
 
 void dma_get_memory_type(struct page *page, struct dma_memory_type *type);
+bool dma_can_use_iova(struct dma_iova_state *state, size_t size);
 #else /* CONFIG_HAS_DMA */
 static inline int dma_alloc_iova(struct dma_iova_attrs *iova)
 {
@@ -319,6 +325,10 @@ static inline void dma_get_memory_type(struct page *page,
 				       struct dma_memory_type *type)
 {
 }
+static inline bool dma_can_use_iova(struct dma_iova_state *state, size_t size)
+{
+	return false;
+}
 #endif /* CONFIG_HAS_DMA */
 
 #if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 0c8f51010d08..9044ee525fdb 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -968,3 +968,35 @@ void dma_free_iova(struct dma_iova_attrs *iova)
 	ops->free_iova(dev, iova->addr, iova->size);
 }
 EXPORT_SYMBOL_GPL(dma_free_iova);
+
+/**
+ * dma_can_use_iova - check if the device type is valid
+ *                    and won't take SWIOTLB path
+ * @state: IOVA state
+ * @size: size of the buffer
+ *
+ * Return %true if the device should use swiotlb for the given buffer, else
+ * %false.
+ */
+bool dma_can_use_iova(struct dma_iova_state *state, size_t size)
+{
+	struct device *dev = state->iova->dev;
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+	struct dma_memory_type *type = state->type;
+	enum pci_p2pdma_map_type map;
+
+	if (is_swiotlb_force_bounce(dev) ||
+	    dev_use_swiotlb(dev, size, state->iova->dir))
+		return false;
+
+	if (dma_map_direct(dev, ops) || !ops->alloc_iova)
+		return false;
+
+	if (type->type == DMA_MEMORY_TYPE_P2P) {
+		map = pci_p2pdma_map_type(type->p2p_pgmap, dev);
+		return map == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
+	}
+
+	return type->type == DMA_MEMORY_TYPE_NORMAL;
+}
+EXPORT_SYMBOL_GPL(dma_can_use_iova);
-- 
2.45.2


