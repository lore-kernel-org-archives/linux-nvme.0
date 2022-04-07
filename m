Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5E0C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 16:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZOsyiabOyxecdEuYc3kJmut49yeuPwIWNC6/tcRPR9U=; b=OBn0a///UhhyneY8ZrRqX8SQon
	rcDl3QqLwpmkUHFPnZl8mr8Vf1TBXXcAeGX7Ki2toCQRx3DEhTyEwq9QlGo5f/ncKdtFQZTbemVls
	/NouA8AuLTjCVR2EolK0AnflczzrATM99W672rMO2EqD7OBg2s2rd9nO3efObO3XdVh+u9d3tql6Y
	ZR1zVIgX5xneDEZA8MMVjXXfxrECSNg03KK3eAYv+ocCWYF+6oY/dDzoSuaeKml9MeVr+vofxq2dN
	s+bNTJdhP9BYK+o/bVbqprXQoydTxh+cEz8KEGRacjMG71hlCvy5kGKVFCfQJPNhze2v1A/HivMmt
	EhzkozlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncVFK-00DAgu-EC; Thu, 07 Apr 2022 16:44:34 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncUMO-00CnvK-Lm
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 15:47:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=ZOsyiabOyxecdEuYc3kJmut49yeuPwIWNC6/tcRPR9U=; b=mGO/cGmneP/dZW/WsfodTl7Ogz
 PEIgQwvjqGOvP7HfvYwFaT5lZ8aiSS2eZytzyjxCYimAQmmbhaa1XR3DHQEzrXgYBYFHa9y/aDKte
 KBkPf5kd0p8cByNnJoSO8kvewiiTQkzGyCyZu6v/sHFK1gxwE5YqTXMRzT5xGU7IzKQ2r3RKXDMZj
 PodJrYUo+VDNunK+R/AUaAezTvlwUo2DqO4n5ScdgFWcOKAfGAOioZEhI77wVtDxIERDGGRALxYi/
 z08rJQMeWbD/I5CD4FzVjnAf+70lUu4R5y5IpAH+TB4u7hSmRxUk2GFkQSih31bgB28vH6hEiIhVA
 x5tOBmYQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1ncUMH-002BBh-KX; Thu, 07 Apr 2022 09:47:43 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1ncUMB-00021N-Kh; Thu, 07 Apr 2022 09:47:35 -0600
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
 Jason Gunthorpe <jgg@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>
Date: Thu,  7 Apr 2022 09:46:59 -0600
Message-Id: <20220407154717.7695-4-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407154717.7695-1-logang@deltatee.com>
References: <20220407154717.7695-1-logang@deltatee.com>
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
 jhubbard@nvidia.com, rcampbell@nvidia.com, jgg@nvidia.com, kch@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v6 03/21] PCI/P2PDMA: Expose pci_p2pdma_map_type()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_084748_917739_83A2F5DE 
X-CRM114-Status: GOOD (  21.61  )
X-Mailman-Approved-At: Thu, 07 Apr 2022 09:37:58 -0700
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

pci_p2pdma_map_type() will be needed by the dma-iommu map_sg
implementation because it will need to determine the mapping type
ahead of actually doing the mapping to create the actual IOMMU mapping.

Prototypes for this helper are added to dma-map-ops.h as they are only
useful to dma map implementations and don't need to pollute the public
pci-p2pdma header

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/pci/p2pdma.c        | 25 +++++++++++++--------
 include/linux/dma-map-ops.h | 45 +++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index c3a68e82cf36..8573bf9d651a 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) "pci-p2pdma: " fmt
 #include <linux/ctype.h>
+#include <linux/dma-map-ops.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -20,13 +21,6 @@
 #include <linux/seq_buf.h>
 #include <linux/xarray.h>
 
-enum pci_p2pdma_map_type {
-	PCI_P2PDMA_MAP_UNKNOWN = 0,
-	PCI_P2PDMA_MAP_NOT_SUPPORTED,
-	PCI_P2PDMA_MAP_BUS_ADDR,
-	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
-};
-
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
@@ -842,8 +836,21 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 }
 EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
 
-static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
-						    struct device *dev)
+/**
+ * pci_p2pdma_map_type - return the type of mapping that should be used for
+ *	a given device and pgmap
+ * @pgmap: the pagemap of a page to determine the mapping type for
+ * @dev: device that is mapping the page
+ *
+ * Returns one of:
+ *	PCI_P2PDMA_MAP_NOT_SUPPORTED - The mapping should not be done
+ *	PCI_P2PDMA_MAP_BUS_ADDR - The mapping should use the PCI bus address
+ *	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE - The mapping should be done normally
+ *		using the CPU physical address (in dma-direct) or an IOVA
+ *		mapping for the IOMMU.
+ */
+enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
+					     struct device *dev)
 {
 	enum pci_p2pdma_map_type type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
 	struct pci_dev *provider = to_p2p_pgmap(pgmap)->provider;
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 0d5b06b3a4a6..d693a0e33bac 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -379,4 +379,49 @@ static inline void debug_dma_dump_mappings(struct device *dev)
 
 extern const struct dma_map_ops dma_dummy_ops;
 
+enum pci_p2pdma_map_type {
+	/*
+	 * PCI_P2PDMA_MAP_UNKNOWN: Used internally for indicating the mapping
+	 * type hasn't been calculated yet. Functions that return this enum
+	 * never return this value.
+	 */
+	PCI_P2PDMA_MAP_UNKNOWN = 0,
+
+	/*
+	 * PCI_P2PDMA_MAP_NOT_SUPPORTED: Indicates the transaction will
+	 * traverse the host bridge and the host bridge is not in the
+	 * allowlist. DMA Mapping routines should return an error when
+	 * this is returned.
+	 */
+	PCI_P2PDMA_MAP_NOT_SUPPORTED,
+
+	/*
+	 * PCI_P2PDMA_BUS_ADDR: Indicates that two devices can talk to
+	 * each other directly through a PCI switch and the transaction will
+	 * not traverse the host bridge. Such a mapping should program
+	 * the DMA engine with PCI bus addresses.
+	 */
+	PCI_P2PDMA_MAP_BUS_ADDR,
+
+	/*
+	 * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE: Indicates two devices can talk
+	 * to each other, but the transaction traverses a host bridge on the
+	 * allowlist. In this case, a normal mapping either with CPU physical
+	 * addresses (in the case of dma-direct) or IOVA addresses (in the
+	 * case of IOMMUs) should be used to program the DMA engine.
+	 */
+	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
+};
+
+#ifdef CONFIG_PCI_P2PDMA
+enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
+					     struct device *dev);
+#else /* CONFIG_PCI_P2PDMA */
+static inline enum pci_p2pdma_map_type
+pci_p2pdma_map_type(struct dev_pagemap *pgmap, struct device *dev)
+{
+	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
+}
+#endif /* CONFIG_PCI_P2PDMA */
+
 #endif /* _LINUX_DMA_MAP_OPS_H */
-- 
2.30.2


