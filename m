Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5058C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:43:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1851B613C2
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1851B613C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4k7hkdy2gVgo/Gh9ngJ2CzI2gskIIfOdiwNggZO1ysg=; b=O/6nrfz+L7GBc7
	guo+lF7vqdq3+UYtbovs6fWMVL1uzkGt679dk0JI3qdKlB1hsDNihHpBosRU3Hs9Nu+Op+kEJ0TXs
	O3wurLMm+kx8lz/gpby1gqbXGIYy20f4VuVYCioBG4WNbbZjKiBjgWcMLSJVfR9VeCvifQ1hoj22Q
	XnTPqPHN4GFTP8myKSRTP9mzu/kvDOwXc545kos3S3N1rpS7qdUCMkhcsfhiG6bSTevSpT8oBfwGq
	D6z9l3tkjO+t2r/Eq0Z3iRUGwsFTcpGApH8sgvjaje8frBEL5QLfQl6mec8iYYLXSNE8OpzttzLJr
	bE/UKcZd4EDWlUf/uZJw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhK2w-006ZwA-WB; Thu, 13 May 2021 22:43:11 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsY-006Ydd-Sj
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 22:32:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=7MS0bSfJ2mnnZCWPWhVUT6MgbCmIqN5H2BCwYErUm2c=; b=vNbKzDrtW9lJEzsGefXpCBjuIA
 xDO+NjWMihYyrbIIrB6BMERLRQpvH7YIJK0IChYUQ2hXyNym/5+3GxxCLBign2ru7q+cPMvLllwzR
 R39qMRQUsU8VdwXn/3J0YveLS2VsFBc2aEArQWK9ZEsqtLr2f8T23kazJOkr/uZ4Ya736djgZDj3h
 XWRCpAnMa/Evz/ZuHAKwg7dxyCtLWl4w/peymdWVCMetN0tIi1+1hNtL5eNZtPaGA06kiBkMNR7vc
 jN0QYexz8grvLr9qfzlcLXhAM6s48vCB9LDraEvnNIMJCLjg5Y+ViE1/SmirAV0pL6aN/gVaDXF5i
 TLYah9Ew==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsW-00BZDS-1Y
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 22:32:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=7MS0bSfJ2mnnZCWPWhVUT6MgbCmIqN5H2BCwYErUm2c=; b=qlIMb+pONiemsW9qXadsAq7a33
 Byr1d16fcLJrH5kbqBkw0+/dVdwZEi5l+K0vvJT2Y/e4bMTQN2jYpaRYn2VGw0tC/wgzsKHxZC71e
 xTrzjDcFRK5+I+XJnfPhDfguu5Ia0MatZQjzgi1Nz/6Dm2bOGplsHLJh3My+nEmODzCVuocQv3xRo
 1RhjFVIEymTMMIpTFKB+wYxoTbJqhIOOBMv9bW1h8BYjVERE54HV/BBbD9a7Hqxs0qpYp6DgdbJO4
 P8nx0uBq1LHOkwceVho1S5BqWP9kNABaVaeErTeKdwdjoWZ3eYqsdblTdQeJXG5MdyTJTphDncJlJ
 mjQZxRew==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsT-0000nB-8p; Thu, 13 May 2021 16:32:23 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsH-0001T5-KZ; Thu, 13 May 2021 16:32:09 -0600
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
 Robin Murphy <robin.murphy@arm.com>, Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 13 May 2021 16:31:54 -0600
Message-Id: <20210513223203.5542-14-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210513223203.5542-1-logang@deltatee.com>
References: <20210513223203.5542-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org,
 dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com,
 jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 13/22] PCI/P2PDMA: Make pci_p2pdma_map_type() non-static
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_153224_107860_02C31CE1 
X-CRM114-Status: GOOD (  20.76  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

pci_p2pdma_map_type() will be needed by the dma-iommu map_sg
implementation because it will need to determine the mapping type
ahead of actually doing the mapping to create the actual iommu mapping.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c       | 24 +++++++++++++---------
 include/linux/pci-p2pdma.h | 41 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 6c2057cd3f37..0568604fd8b4 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -20,13 +20,6 @@
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
@@ -844,8 +837,21 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
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
 	struct pci_dev *provider = to_p2p_pgmap(pgmap)->provider;
 	enum pci_p2pdma_map_type ret;
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 8318a97c9c61..caac2d023f8f 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -16,6 +16,40 @@
 struct block_device;
 struct scatterlist;
 
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
+	 * whitelist. DMA Mapping routines should return an error when
+	 * this is returned.
+	 */
+	PCI_P2PDMA_MAP_NOT_SUPPORTED,
+
+	/*
+	 * PCI_P2PDMA_BUS_ADDR: Indicates that two devices can talk to
+	 * eachother directly through a PCI switch and the transaction will
+	 * not traverse the host bridge. Such a mapping should program
+	 * the DMA engine with PCI bus addresses.
+	 */
+	PCI_P2PDMA_MAP_BUS_ADDR,
+
+	/*
+	 * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE: Indicates two devices can talk
+	 * to eachother, but the transaction traverses a host bridge on the
+	 * whitelist. In this case, a normal mapping either with CPU physical
+	 * addresses (in the case of dma-direct) or IOVA addresses (in the
+	 * case of IOMMUs) should be used to program the DMA engine.
+	 */
+	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
+};
+
 #ifdef CONFIG_PCI_P2PDMA
 int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 		u64 offset);
@@ -30,6 +64,8 @@ struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
 					 unsigned int *nents, u32 length);
 void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
 void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
+enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
+					     struct device *dev);
 int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs);
 void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
@@ -83,6 +119,11 @@ static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
 static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 {
 }
+static inline enum pci_p2pdma_map_type
+pci_p2pdma_map_type(struct dev_pagemap *pgmap, struct device *dev)
+{
+	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
+}
 static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
 		struct scatterlist *sg, int nents, enum dma_data_direction dir,
 		unsigned long attrs)
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
