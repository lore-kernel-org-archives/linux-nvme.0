Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B13E77176
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2024 14:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=38nCuZVQhoZyNi2yPSNj6WGTyZv1iptpIUEMFvFc5qc=; b=c2ef6SMcXyZVkB2k4bzFRumfiG
	FFXwQMxsuxKQjbBCjLL3v/UDVblZ2HJc76rwBjjBuCXE9NdPcz7wnp6ZB8Kv9cFnopMpF3H6K4XyF
	EitSNhQDwnqF7ZBYuDFF7gg77zcXXGwi3EKW5WVf6AKjaQukYGLcp1hL9Kon8U9cPxPhZ5KgakV39
	W5PgWXfdDbMAIl/I+cUeboT5U5wvz+JbJ5pKu+u1StIjk6s3NyXI7QFRgai8oae2+o9vsl58d75jV
	AVX1EHBd4KKAfykWhthiMCGJx261Rgp5+zqsMSX/hZKB+zH5caePecrWNV+wlvx8L66YtR2NtN8lH
	5msvRrxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCqy-0000000GKa5-2kAR;
	Thu, 05 Dec 2024 14:29:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJBna-0000000G6cv-1yxk
	for linux-nvme@bombadil.infradead.org;
	Thu, 05 Dec 2024 13:21:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=38nCuZVQhoZyNi2yPSNj6WGTyZv1iptpIUEMFvFc5qc=; b=AwSwRB8lUKJ+vMrMdJdsUeW5Rk
	mfQRXq+TjZSkYJoMFKK81pLVwFMEe4jY+zAiKBJajiiyRa+tBsA635jTxfaotLe13uveFYLJ+h/nU
	oIL8CsS4Sp9cLXmh+fiA7Jbj/Z1a1pVhESh+n6KA4pNnUAd/fg3AWtr3F5tBgwIWi5w3HWH9KnMX6
	nGy4B1FkFYXC1pflojAQ0nPRPPGiUxHqPdlxxI4cpOtAdw/l3iDdGbuQ/FjP9RslSnYrrUwYCE7oa
	pJAN5YRa9sbrYOgKH8ynmhTXUm5GVLZBJTWaZx5MQpc0vSkkhSHyirTqjOLOhegmEiQl3FhPlecPe
	9TV6s+ZA==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJBnX-00000002u41-0KhJ
	for linux-nvme@lists.infradead.org;
	Thu, 05 Dec 2024 13:21:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EFA98A43841;
	Thu,  5 Dec 2024 13:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7D9C4CED1;
	Thu,  5 Dec 2024 13:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733404897;
	bh=E0jv1IHLKFRffsFQsSY/qzvzkcPyoS+otAu8oLaUFcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ejUF/tayGv26WWk7iHmiQVdJUgjBDHpZbXrunY7cFeVVUdBDx4cyT1I7zHi0s+TnY
	 kIqoj5OzfO2yX1mBJGEDvKoiGoLVIVtyyA10xoyVvosY6e9wd0SXjwoszkpf0nsSrX
	 3RYffObdMlZ/UDoiEgOmard2gzdBtNf91Tde0+dJsEDUraIKG6FLfTUxmS5mdWPAtR
	 VuGub4sh+aym4C7KgDC/VgEG4Lj+e0yNONveBi17J+ir5CtLMGayBTSNMbeEScu49/
	 IfRcHU26fgDZluVLW1tkVAJ7Y0PhX8wT297ybO/53BeHSHL1/4m0H49m93cmJgVRVN
	 JmceNdwM+nUQA==
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
Subject: [PATCH v4 01/18] PCI/P2PDMA: Refactor the p2pdma mapping helpers
Date: Thu,  5 Dec 2024 15:21:00 +0200
Message-ID: <e0dd9dff0f869d993afb599453bbfac8d59a956b.1733398913.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733398913.git.leon@kernel.org>
References: <cover.1733398913.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_132139_787369_BE116ACA 
X-CRM114-Status: GOOD (  31.13  )
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
index 2a9fa0c8cc00..5746ffaf0061 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1382,7 +1382,6 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 	struct scatterlist *s, *prev = NULL;
 	int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
 	struct pci_p2pdma_map_state p2pdma_state = {};
-	enum pci_p2pdma_map_type map;
 	dma_addr_t iova;
 	size_t iova_len = 0;
 	unsigned long mask = dma_get_seg_boundary(dev);
@@ -1412,28 +1411,30 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
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
index 7abd4f546d3c..82b6ed736f0f 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -995,40 +995,12 @@ static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
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
-	if (state->pgmap != sg_page(sg)->pgmap) {
-		state->pgmap = sg_page(sg)->pgmap;
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
+	state->pgmap = page->pgmap;
+	state->map = pci_p2pdma_map_type(state->pgmap, dev);
+	state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
 }
 
 /**
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index e172522cd936..63dd480e209b 100644
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
+		if (state->pgmap != page->pgmap)
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
index 5b4e6d3bf7bc..e289ad27d1b5 100644
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
2.47.0


