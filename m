Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F84C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jan 2022 11:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zN5ussKdK8rGe+8Rg1RjZA3LfU+HxpiV6i9+iy1gYwI=; b=ngjs+fui2r/IAxbV6OFskZfMq0
	FFayeC806RU2odEEEABamWKA14N52E9bu7svaaJKw/2LaSsHedvkmmvolgEkv5k+78WedzSHPFure
	snyGdr73TXIQgNEwkk/B1O1GrykrkxHI8h1FRRL/GSCGxGTttV+4qiBfUUEJgw9GPYXoA75nDjLr1
	FY8f4PiZFPFuAwZA5wljt1eYA6lJXsnYR+tZTXqwpDZ1L+qJcIAxcCpX9GCgxNxr7t9VPfCEMWc81
	+E4dq0E/LE4ArzscwRg9egKzaNSRlkrDuP4z5KiyzP1Ebj6NL33ja01OBYsEhSiX4caEHFK85zWHs
	AWbnBavA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEV79-009BOe-Fc; Mon, 31 Jan 2022 11:44:55 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDF63-00HS65-6U
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 00:26:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=zN5ussKdK8rGe+8Rg1RjZA3LfU+HxpiV6i9+iy1gYwI=; b=JHb2sZwS3A32e7amabmVHJP6ni
 EM2MuyjnjcVSQi3Ge9tvmK/htrNqzw91M2/m3nQ0uHQFBdGqwMsaqy1XTX7hOwADCobDISD8T0BTE
 +szOJHzVtL+HbmFDfBo6ES1CO2C3zLlLAmQUEBwt9Falio9RLopO7N6kagpASGnrgOIxetUBWi2uv
 nEbAXrp0oh0PcFH/dXouma2mH5TjrxQNRCknYeHtTjRxuCSL9jxJxadFZn8w0rqWWiSg/WsnLamR/
 kjZehAIDKxxVooHSJdbvnCVGeRpNI1NeGV4OigtGuYn5lycJ1lwpQB4wE7WF7hnWqXmZiSosRjq0n
 Qagmgp5g==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1nDF5t-005Oca-AT; Thu, 27 Jan 2022 17:26:26 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1nDF5o-0001d1-IU; Thu, 27 Jan 2022 17:26:20 -0700
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
 Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Date: Thu, 27 Jan 2022 17:26:05 -0700
Message-Id: <20220128002614.6136-16-logang@deltatee.com>
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
 ckulkarnilinux@gmail.com, logang@deltatee.com, bhelgaas@google.com,
 jhubbard@nvidia.com, rcampbell@nvidia.com, jgg@nvidia.com,
 mgurtovoy@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v5 15/24] PCI/P2PDMA: Remove pci_p2pdma_[un]map_sg()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_162635_544238_6CF601F0 
X-CRM114-Status: GOOD (  13.74  )
X-Mailman-Approved-At: Mon, 31 Jan 2022 03:44:50 -0800
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

This interface is superseded by support in dma_map_sg() which now supports
heterogeneous scatterlists. There are no longer any users, so remove it.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/pci/p2pdma.c       | 66 --------------------------------------
 include/linux/pci-p2pdma.h | 27 ----------------
 2 files changed, 93 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 2b2cf00664e7..e66694cc9e14 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -879,72 +879,6 @@ enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
 	return type;
 }
 
-static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
-		struct device *dev, struct scatterlist *sg, int nents)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i) {
-		s->dma_address = sg_phys(s) + p2p_pgmap->bus_offset;
-		sg_dma_len(s) = s->length;
-	}
-
-	return nents;
-}
-
-/**
- * pci_p2pdma_map_sg_attrs - map a PCI peer-to-peer scatterlist for DMA
- * @dev: device doing the DMA request
- * @sg: scatter list to map
- * @nents: elements in the scatterlist
- * @dir: DMA direction
- * @attrs: DMA attributes passed to dma_map_sg() (if called)
- *
- * Scatterlists mapped with this function should be unmapped using
- * pci_p2pdma_unmap_sg_attrs().
- *
- * Returns the number of SG entries mapped or 0 on error.
- */
-int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	struct pci_p2pdma_pagemap *p2p_pgmap =
-		to_p2p_pgmap(sg_page(sg)->pgmap);
-
-	switch (pci_p2pdma_map_type(sg_page(sg)->pgmap, dev)) {
-	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
-		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
-	case PCI_P2PDMA_MAP_BUS_ADDR:
-		return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
-	default:
-		/* Mapping is not Supported */
-		return 0;
-	}
-}
-EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
-
-/**
- * pci_p2pdma_unmap_sg_attrs - unmap a PCI peer-to-peer scatterlist that was
- *	mapped with pci_p2pdma_map_sg()
- * @dev: device doing the DMA request
- * @sg: scatter list to map
- * @nents: number of elements returned by pci_p2pdma_map_sg()
- * @dir: DMA direction
- * @attrs: DMA attributes passed to dma_unmap_sg() (if called)
- */
-void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	enum pci_p2pdma_map_type map_type;
-
-	map_type = pci_p2pdma_map_type(sg_page(sg)->pgmap, dev);
-
-	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
-		dma_unmap_sg_attrs(dev, sg, nents, dir, attrs);
-}
-EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
-
 /**
  * pci_p2pdma_map_segment - map an sg segment determining the mapping type
  * @state: State structure that should be declared outside of the for_each_sg()
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 8318a97c9c61..2c07aa6b7665 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -30,10 +30,6 @@ struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
 					 unsigned int *nents, u32 length);
 void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
 void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
-int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs);
-void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs);
 int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
 			    bool *use_p2pdma);
 ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
@@ -83,17 +79,6 @@ static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
 static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 {
 }
-static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
-		struct scatterlist *sg, int nents, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	return 0;
-}
-static inline void pci_p2pdma_unmap_sg_attrs(struct device *dev,
-		struct scatterlist *sg, int nents, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-}
 static inline int pci_p2pdma_enable_store(const char *page,
 		struct pci_dev **p2p_dev, bool *use_p2pdma)
 {
@@ -119,16 +104,4 @@ static inline struct pci_dev *pci_p2pmem_find(struct device *client)
 	return pci_p2pmem_find_many(&client, 1);
 }
 
-static inline int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg,
-				    int nents, enum dma_data_direction dir)
-{
-	return pci_p2pdma_map_sg_attrs(dev, sg, nents, dir, 0);
-}
-
-static inline void pci_p2pdma_unmap_sg(struct device *dev,
-		struct scatterlist *sg, int nents, enum dma_data_direction dir)
-{
-	pci_p2pdma_unmap_sg_attrs(dev, sg, nents, dir, 0);
-}
-
 #endif /* _LINUX_PCI_P2P_H */
-- 
2.30.2


