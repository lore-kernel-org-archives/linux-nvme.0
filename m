Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1BCC369D1
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 16:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y91156ZVUxKoGxa2sobCRwO1aYL+34PC7aNefbDxF+w=; b=AfpE79CUwTnPTWLv3W9xo61ONE
	ImGll9bcVP0QHwY2iu1YXBzH8w1Zdavax3/Tl75VI8vFr2hROzWNu90Arpu0Nl0R3u+5apuvBdKk3
	nkt+IMPmfb0Wq6Z4ZqW0RYyGxTdCljGB/7xjecYN7Zt4WzdhlyJsGowrNb0tIsItWWYLNLqnVFeTo
	JQnRaL2g8+ECRQe+OZYuWl1+muu0Xeh7yEe2cr7fhxxaUOSWvx5gQEElnTlB0i+kb5b4q3zhfb6af
	UCGCW9hPxuz9nfxzWrOAqABxfuj3UPrPBAj00TjbN1gNWvPSlEBhY/0UxakLZvfrgVmAW/kQmBSNi
	yaDmGzMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5onY-0000000GzuM-0Iwf;
	Fri, 18 Apr 2025 16:42:40 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5fWS-0000000FJJM-031s
	for linux-nvme@bombadil.infradead.org;
	Fri, 18 Apr 2025 06:48:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=y91156ZVUxKoGxa2sobCRwO1aYL+34PC7aNefbDxF+w=; b=K0LlTWo6O5EWkFYWpvXH+BjPA+
	qWDg+9rRqMkXh1ubq2IP5nM9AwHylHm+nqURt2F4SZ+OpiaJ+y2J3VmdNHJj80yMISa6+66bfZZHf
	BlXvg4ty8Lckhmw4o9jNSPUQ8mFPg2xfdlXST7ohyDwXmoFS5HJBAfbYPS24lET0dXXK8WIDS1/0K
	VU3dEndYqr2OJodTsUoBM5D0Qp/QY6KQxSDXR0xWUNLnnqIXu6xKVQ/kh7AocgYjtJuKipM6mZoAo
	wNw8svxVXhnH/T2vbj3Y/lpGMOd3BQSwVmbcGcrH/osZaVr+NkXUhOciYhnn9klTvt0XtWSSgpx9E
	GKLXIEew==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u5fWO-0000000AUAI-1sFl
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 06:48:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D496E5C59A6;
	Fri, 18 Apr 2025 06:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40E9C4CEE2;
	Fri, 18 Apr 2025 06:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744958892;
	bh=1w8orYYRjktaG4+9PyX9jjVAlLyeJePSPLmHpjw9D9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sXE5leQLsudq7SQg22i6/SqtqWqTlyyHAQIVWH9bAO2MPQDxZa/toNj/b/aLdj1pt
	 eJUWdsewIeS6EZkoThfFVFTy5m8l0mxx5sdQ+vBF9/SXZTcg2hsnqwgb3oNxahbY9Q
	 oxuGoQH4WN3xjQONhDH8oS73auA1V/uQTo9nHZ/cx/E3sT0mtK+BoCLPUYd0owEJYd
	 fjKBOzgpvUHxtDEkUtJvp5kHHi1mVDpQO/AdiuKd+z8ggrWsUkBFWGoXfUcdgeVwhr
	 w43naidPPhLQuz6IIctO1psEPnQRXpIg3+Lpw0HqEUNsBrYGLlhV9OMeJWV08Myuy1
	 6a1cHGyG90F5w==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Cc: Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH v8 01/24] PCI/P2PDMA: Refactor the p2pdma mapping helpers
Date: Fri, 18 Apr 2025 09:47:31 +0300
Message-ID: <cdcd9792a4f3f0d59b482c90121fe9b7a8e947e9.1744825142.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744825142.git.leon@kernel.org>
References: <cover.1744825142.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_074820_977649_E1B7A8A2 
X-CRM114-Status: GOOD (  31.69  )
X-Mailman-Approved-At: Fri, 18 Apr 2025 09:39:28 -0700
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

The current scheme with a single helper to determine the P2P status
and map a scatterlist segment force users to always use the map_sg
helper to DMA map, which we're trying to get away from because they
are very cache inefficient.

Refactor the code so that there is a single helper that checks the P2P
state for a page, including the result that it is not a P2P page to
simplify the callers, and a second one to perform the address translation
for a bus mapped P2P transfer that does not depend on the scatterlist
structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/dma-iommu.c   | 47 +++++++++++++++++-----------------
 drivers/pci/p2pdma.c        | 38 ++++-----------------------
 include/linux/dma-map-ops.h | 51 +++++++++++++++++++++++++++++--------
 kernel/dma/direct.c         | 43 +++++++++++++++----------------
 4 files changed, 91 insertions(+), 88 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index cb7e29dcac15..a8f9fd93e150 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1359,7 +1359,6 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 	struct scatterlist *s, *prev = NULL;
 	int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
 	struct pci_p2pdma_map_state p2pdma_state = {};
-	enum pci_p2pdma_map_type map;
 	dma_addr_t iova;
 	size_t iova_len = 0;
 	unsigned long mask = dma_get_seg_boundary(dev);
@@ -1389,28 +1388,30 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		size_t s_length = s->length;
 		size_t pad_len = (mask - iova_len + 1) & mask;
 
-		if (is_pci_p2pdma_page(sg_page(s))) {
-			map = pci_p2pdma_map_segment(&p2pdma_state, dev, s);
-			switch (map) {
-			case PCI_P2PDMA_MAP_BUS_ADDR:
-				/*
-				 * iommu_map_sg() will skip this segment as
-				 * it is marked as a bus address,
-				 * __finalise_sg() will copy the dma address
-				 * into the output segment.
-				 */
-				continue;
-			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
-				/*
-				 * Mapping through host bridge should be
-				 * mapped with regular IOVAs, thus we
-				 * do nothing here and continue below.
-				 */
-				break;
-			default:
-				ret = -EREMOTEIO;
-				goto out_restore_sg;
-			}
+		switch (pci_p2pdma_state(&p2pdma_state, dev, sg_page(s))) {
+		case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+			/*
+			 * Mapping through host bridge should be mapped with
+			 * regular IOVAs, thus we do nothing here and continue
+			 * below.
+			 */
+			break;
+		case PCI_P2PDMA_MAP_NONE:
+			break;
+		case PCI_P2PDMA_MAP_BUS_ADDR:
+			/*
+			 * iommu_map_sg() will skip this segment as it is marked
+			 * as a bus address, __finalise_sg() will copy the dma
+			 * address into the output segment.
+			 */
+			s->dma_address = pci_p2pdma_bus_addr_map(&p2pdma_state,
+						sg_phys(s));
+			sg_dma_len(s) = sg->length;
+			sg_dma_mark_bus_address(s);
+			continue;
+		default:
+			ret = -EREMOTEIO;
+			goto out_restore_sg;
 		}
 
 		sg_dma_address(s) = s_iova_off;
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 19214ec81fbb..8d955c25aed3 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -1004,40 +1004,12 @@ static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
 	return type;
 }
 
-/**
- * pci_p2pdma_map_segment - map an sg segment determining the mapping type
- * @state: State structure that should be declared outside of the for_each_sg()
- *	loop and initialized to zero.
- * @dev: DMA device that's doing the mapping operation
- * @sg: scatterlist segment to map
- *
- * This is a helper to be used by non-IOMMU dma_map_sg() implementations where
- * the sg segment is the same for the page_link and the dma_address.
- *
- * Attempt to map a single segment in an SGL with the PCI bus address.
- * The segment must point to a PCI P2PDMA page and thus must be
- * wrapped in a is_pci_p2pdma_page(sg_page(sg)) check.
- *
- * Returns the type of mapping used and maps the page if the type is
- * PCI_P2PDMA_MAP_BUS_ADDR.
- */
-enum pci_p2pdma_map_type
-pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
-		       struct scatterlist *sg)
+void __pci_p2pdma_update_state(struct pci_p2pdma_map_state *state,
+		struct device *dev, struct page *page)
 {
-	if (state->pgmap != page_pgmap(sg_page(sg))) {
-		state->pgmap = page_pgmap(sg_page(sg));
-		state->map = pci_p2pdma_map_type(state->pgmap, dev);
-		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
-	}
-
-	if (state->map == PCI_P2PDMA_MAP_BUS_ADDR) {
-		sg->dma_address = sg_phys(sg) + state->bus_off;
-		sg_dma_len(sg) = sg->length;
-		sg_dma_mark_bus_address(sg);
-	}
-
-	return state->map;
+	state->pgmap = page_pgmap(page);
+	state->map = pci_p2pdma_map_type(state->pgmap, dev);
+	state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
 }
 
 /**
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index e172522cd936..a6b09e61f1a1 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -443,6 +443,11 @@ enum pci_p2pdma_map_type {
 	 */
 	PCI_P2PDMA_MAP_UNKNOWN = 0,
 
+	/*
+	 * Not a PCI P2PDMA transfer.
+	 */
+	PCI_P2PDMA_MAP_NONE,
+
 	/*
 	 * PCI_P2PDMA_MAP_NOT_SUPPORTED: Indicates the transaction will
 	 * traverse the host bridge and the host bridge is not in the
@@ -471,21 +476,47 @@ enum pci_p2pdma_map_type {
 
 struct pci_p2pdma_map_state {
 	struct dev_pagemap *pgmap;
-	int map;
+	enum pci_p2pdma_map_type map;
 	u64 bus_off;
 };
 
-#ifdef CONFIG_PCI_P2PDMA
-enum pci_p2pdma_map_type
-pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
-		       struct scatterlist *sg);
-#else /* CONFIG_PCI_P2PDMA */
+/* helper for pci_p2pdma_state(), do not use directly */
+void __pci_p2pdma_update_state(struct pci_p2pdma_map_state *state,
+		struct device *dev, struct page *page);
+
+/**
+ * pci_p2pdma_state - check the P2P transfer state of a page
+ * @state:	P2P state structure
+ * @dev:	device to transfer to/from
+ * @page:	page to map
+ *
+ * Check if @page is a PCI P2PDMA page, and if yes of what kind.  Returns the
+ * map type, and updates @state with all information needed for a P2P transfer.
+ */
 static inline enum pci_p2pdma_map_type
-pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
-		       struct scatterlist *sg)
+pci_p2pdma_state(struct pci_p2pdma_map_state *state, struct device *dev,
+		struct page *page)
+{
+	if (IS_ENABLED(CONFIG_PCI_P2PDMA) && is_pci_p2pdma_page(page)) {
+		if (state->pgmap != page_pgmap(page))
+			__pci_p2pdma_update_state(state, dev, page);
+		return state->map;
+	}
+	return PCI_P2PDMA_MAP_NONE;
+}
+
+/**
+ * pci_p2pdma_bus_addr_map - map a PCI_P2PDMA_MAP_BUS_ADDR P2P transfer
+ * @state:	P2P state structure
+ * @paddr:	physical address to map
+ *
+ * Map a physically contigous PCI_P2PDMA_MAP_BUS_ADDR transfer.
+ */
+static inline dma_addr_t
+pci_p2pdma_bus_addr_map(struct pci_p2pdma_map_state *state, phys_addr_t paddr)
 {
-	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
+	WARN_ON_ONCE(state->map != PCI_P2PDMA_MAP_BUS_ADDR);
+	return paddr + state->bus_off;
 }
-#endif /* CONFIG_PCI_P2PDMA */
 
 #endif /* _LINUX_DMA_MAP_OPS_H */
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index b8fe0b3d0ffb..cec43cd5ed62 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -462,34 +462,33 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs)
 {
 	struct pci_p2pdma_map_state p2pdma_state = {};
-	enum pci_p2pdma_map_type map;
 	struct scatterlist *sg;
 	int i, ret;
 
 	for_each_sg(sgl, sg, nents, i) {
-		if (is_pci_p2pdma_page(sg_page(sg))) {
-			map = pci_p2pdma_map_segment(&p2pdma_state, dev, sg);
-			switch (map) {
-			case PCI_P2PDMA_MAP_BUS_ADDR:
-				continue;
-			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
-				/*
-				 * Any P2P mapping that traverses the PCI
-				 * host bridge must be mapped with CPU physical
-				 * address and not PCI bus addresses. This is
-				 * done with dma_direct_map_page() below.
-				 */
-				break;
-			default:
-				ret = -EREMOTEIO;
+		switch (pci_p2pdma_state(&p2pdma_state, dev, sg_page(sg))) {
+		case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+			/*
+			 * Any P2P mapping that traverses the PCI host bridge
+			 * must be mapped with CPU physical address and not PCI
+			 * bus addresses.
+			 */
+			break;
+		case PCI_P2PDMA_MAP_NONE:
+			sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
+					sg->offset, sg->length, dir, attrs);
+			if (sg->dma_address == DMA_MAPPING_ERROR) {
+				ret = -EIO;
 				goto out_unmap;
 			}
-		}
-
-		sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
-				sg->offset, sg->length, dir, attrs);
-		if (sg->dma_address == DMA_MAPPING_ERROR) {
-			ret = -EIO;
+			break;
+		case PCI_P2PDMA_MAP_BUS_ADDR:
+			sg->dma_address = pci_p2pdma_bus_addr_map(&p2pdma_state,
+					sg_phys(sg));
+			sg_dma_mark_bus_address(sg);
+			continue;
+		default:
+			ret = -EREMOTEIO;
 			goto out_unmap;
 		}
 		sg_dma_len(sg) = sg->length;
-- 
2.49.0


