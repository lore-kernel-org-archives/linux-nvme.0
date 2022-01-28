Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9248C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 00:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9y7uxxCijIQhRgYYWdLYi/EHC9No4LME+9YvR+dIhu0=; b=DnlHXck7XiS8IKkip0DyKihWQ5
	QhjuvY7KGVFxd+wXsuXNhUNnEfXxTwflPO3a4+4KvNHnQPm9vZgZnTCnxe54CPSaupJnsoqSllbW8
	tCfE9SkNFvSK2AVQdmzaW/SbjkSxWNK4itVBl15avBb73/qvBto6RpUDrIrKuk80SRjpdujl1Zlgt
	SVTjJcHsWPYqU7B4zlhSG1ReoIJckfRxnkKsZ7BfDRxXd9Ul4swdgoy7o/aVqNZqwjG03NMo/5liv
	jevetGTViknnwYF4O458TBs71IRHPYRea5jw73Lj4VlbnDHyt67vw0eo4559VMAJD+BCjK21ECxzn
	72CXccfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDFGk-00HVRU-EW; Fri, 28 Jan 2022 00:37:38 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDF62-00HS5u-SP
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 00:26:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=9y7uxxCijIQhRgYYWdLYi/EHC9No4LME+9YvR+dIhu0=; b=l4d3EpTtcxL3EaodXSNshKzMis
 1/jQH/RITkY0nTE3stsu/LrD8K8tHp5sBnCU4mUgyGT2sccFE9pG+vOSGhS2KQPG9z4RWATIO//8o
 7Wii1JtGU5ngbOHFd+Ug+xwKAa767JeAdM9RRtkkBgdq5Qp1nsV4zhTumRTg+ZmuDXJFqi7VAU8ge
 0M4tD1wbs1NmBbQ4Y5wufnnmwq7NwOABY7OOiKuVwr2f8JFg1Y0Zt2GyhZouLVvYzcaEHa8YIFQ8g
 HBJp1H7DxAZwwhQ9WbP6mDyRl30Jkciv8xdaY6XSsOozDBMNYVVORQRpeptIiUeDHoVy0GM40wX8z
 ZWJkcFhg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1nDF5v-005OcY-KP; Thu, 27 Jan 2022 17:26:28 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1nDF5m-0001cR-UW; Thu, 27 Jan 2022 17:26:18 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Ralph Campbell <rcampbell@nvidia.com>,
 Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 27 Jan 2022 17:25:56 -0700
Message-Id: <20220128002614.6136-7-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128002614.6136-1-logang@deltatee.com>
References: <20220128002614.6136-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com,
 willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net,
 dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com,
 andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com,
 ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com,
 ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
 logang@deltatee.com, bhelgaas@google.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v5 06/24] PCI/P2PDMA: Introduce helpers for dma_map_sg
 implementations
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_162635_075515_142C7AAA 
X-CRM114-Status: GOOD (  19.72  )
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

Add pci_p2pdma_map_segment() as a helper for simple dma_map_sg()
implementations. It takes an scatterlist segment that must point to a
pci_p2pdma struct page and will map it if the mapping requires a bus
address.

The return value indicates whether the mapping required a bus address
or whether the caller still needs to map the segment normally. If the
segment should not be mapped, -EREMOTEIO is returned.

This helper uses a state structure to track the changes to the
pgmap across calls and avoid needing to lookup into the xarray for
every page.

Also add pci_p2pdma_map_bus_segment() which is useful for IOMMU
dma_map_sg() implementations where the sg segment containing the page
differs from the sg segment containing the DMA address.

Prototypes for these helpers are added to dma-map-ops.h as they are only
useful to dma map implementations and don't need to pollute the public
pci-p2pdma header.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/p2pdma.c        | 59 +++++++++++++++++++++++++++++++++++++
 include/linux/dma-map-ops.h | 21 +++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 751d682e66ae..2b2cf00664e7 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -945,6 +945,65 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
 
+/**
+ * pci_p2pdma_map_segment - map an sg segment determining the mapping type
+ * @state: State structure that should be declared outside of the for_each_sg()
+ *	loop and initialized to zero.
+ * @dev: DMA device that's doing the mapping operation
+ * @sg: scatterlist segment to map
+ *
+ * This is a helper to be used by non-IOMMU dma_map_sg() implementations where
+ * the sg segment is the same for the page_link and the dma_address.
+ *
+ * Attempt to map a single segment in an SGL with the PCI bus address.
+ * The segment must point to a PCI P2PDMA page and thus must be
+ * wrapped in a is_pci_p2pdma_page(sg_page(sg)) check.
+ *
+ * Returns the type of mapping used and maps the page if the type is
+ * PCI_P2PDMA_MAP_BUS_ADDR.
+ */
+enum pci_p2pdma_map_type
+pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
+		       struct scatterlist *sg)
+{
+	if (state->pgmap != sg_page(sg)->pgmap) {
+		state->pgmap = sg_page(sg)->pgmap;
+		state->map = pci_p2pdma_map_type(state->pgmap, dev);
+		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
+	}
+
+	if (state->map == PCI_P2PDMA_MAP_BUS_ADDR) {
+		sg->dma_address = sg_phys(sg) + state->bus_off;
+		sg_dma_len(sg) = sg->length;
+		sg_dma_mark_bus_address(sg);
+	}
+
+	return state->map;
+}
+
+/**
+ * pci_p2pdma_map_bus_segment - map an sg segment pre determined to
+ *	be mapped with PCI_P2PDMA_MAP_BUS_ADDR
+ * @pg_sg: scatterlist segment with the page to map
+ * @dma_sg: scatterlist segment to assign a DMA address to
+ *
+ * This is a helper for iommu dma_map_sg() implementations when the
+ * segment for the DMA address differs from the segment containing the
+ * source page.
+ *
+ * pci_p2pdma_map_type() must have already been called on the pg_sg and
+ * returned PCI_P2PDMA_MAP_BUS_ADDR.
+ */
+void pci_p2pdma_map_bus_segment(struct scatterlist *pg_sg,
+				struct scatterlist *dma_sg)
+{
+	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(sg_page(pg_sg)->pgmap);
+
+	dma_sg->dma_address = sg_phys(pg_sg) + pgmap->bus_offset;
+	sg_dma_len(dma_sg) = pg_sg->length;
+	sg_dma_mark_bus_address(dma_sg);
+}
+
 /**
  * pci_p2pdma_enable_store - parse a configfs/sysfs attribute store
  *		to enable p2pdma
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index d693a0e33bac..752f91e5eb5d 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -413,15 +413,36 @@ enum pci_p2pdma_map_type {
 	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
 };
 
+struct pci_p2pdma_map_state {
+	struct dev_pagemap *pgmap;
+	int map;
+	u64 bus_off;
+};
+
 #ifdef CONFIG_PCI_P2PDMA
 enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
 					     struct device *dev);
+enum pci_p2pdma_map_type
+pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
+		       struct scatterlist *sg);
+void pci_p2pdma_map_bus_segment(struct scatterlist *pg_sg,
+				struct scatterlist *dma_sg);
 #else /* CONFIG_PCI_P2PDMA */
 static inline enum pci_p2pdma_map_type
 pci_p2pdma_map_type(struct dev_pagemap *pgmap, struct device *dev)
 {
 	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
 }
+static inline enum pci_p2pdma_map_type
+pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
+		       struct scatterlist *sg)
+{
+	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
+}
+static inline void pci_p2pdma_map_bus_segment(struct scatterlist *pg_sg,
+					      struct scatterlist *dma_sg)
+{
+}
 #endif /* CONFIG_PCI_P2PDMA */
 
 #endif /* _LINUX_DMA_MAP_OPS_H */
-- 
2.30.2


