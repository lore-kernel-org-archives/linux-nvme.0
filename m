Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44DEC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:39:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C1F610EA
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C1F610EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6WKfCS6bQDoaci4p2yQ6bA4taUXBydG1DmjjJzQMBps=; b=Ewh0DP6Ot6Ugrx
	ybV056JjV9VAN4DE6VEe9syNzBQo/rNbsl55SxYPBlKOr9mP9yU9TmpJlCv5u1Qwm9QycFmPdZmC9
	iDb7+7QuDRHWEmhUCWrZ8xfxksEKbzus28Ou3+NjNwYaTt02SVT1JRMMXalOe5I7JybX0wHmQJF8/
	SVr3NMGcB7d03Mym4JuM4sy9QUNjOZygGC3l/iWEIO9t2yMa09aIc4a1wJpfwFus0NzrkMk0JEq17
	Hgk5/ZDGQeUgWxVC6sSmu1jS3uajoOwLXUe06Qb49yfwRy1S6pPaJxH7Vxp/975rv+QF2lFbIAkwR
	QIxechbNr/iir2e5VS/A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhJzY-006Zaw-6s; Thu, 13 May 2021 22:39:40 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsX-006YdX-ME
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 22:32:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=6u9ILVRKlmqudAt9Un+7r9dFNUtTIxAGQYUmPLCOvYA=; b=XUUiO1yr7PrXrro6d4ZtD2BR+t
 U1Zv06TBxtqv6Nwm9gnqDB613tLcfMGfCFmXxHn06iLLzGVDVMEjPMyMTmKsoDJsA8s8OlPePlDhl
 ARD81tRfyEgwZ5l1Bjovm0xkpGy4n4Q68/dyBsHlI3BA9AV6+fk8n9pG8swfdzezTnxQQfUfCo7ja
 eV4sx5USpBeh6Z8tQR9E4N48HTxaD9Eq4UxCfMu7hhxjNKiLoIWSq6cBOyw6JbvvPnjU1sx5RTIGV
 bfgXegVMlAQ/v4LUYCIiH32QggrkU6Y0jbP9BtxeUXLmb9fIH/O+soF7AJkGevsqiBT/YUW2WNcJs
 On3y+uxg==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsU-00BZCv-R0
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 22:32:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=6u9ILVRKlmqudAt9Un+7r9dFNUtTIxAGQYUmPLCOvYA=; b=pe5Fdee9kavi5iFg2CLlP1bXFi
 HU3RX2gpRFQZ9fmvX22kRlQ9tmoW1IQw9r+DGQ3T3QdxtHl3b/VIO94fKdjopL37vqgg7Zzjftxmp
 jHgPUcB0KTR9a9MvX0FNQxNUzwfyTStes45pWzv97i1orQZqpuIMdSY+cOI6Ig8VJvZCOv6tDm5LD
 hMZXY0cQDmv3jkeOuUICge6tIqsC7jCs6gsGnrMMIXgbb/n5ct/WAVE6Ir4yPw5uO8qGdXCrNaoi6
 BDfCh+SFrIw/vLTFiSiOBO9e0V4S9GH47DCSSlWyDULHacflmdBU43SvbEookKvEvFgmAg6wIqjMD
 1AWe8ueg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsT-0000nF-8J; Thu, 13 May 2021 16:32:22 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsH-0001T8-PQ; Thu, 13 May 2021 16:32:09 -0600
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
Date: Thu, 13 May 2021 16:31:55 -0600
Message-Id: <20210513223203.5542-15-logang@deltatee.com>
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
Subject: [PATCH v2 14/22] PCI/P2PDMA: Introduce helpers for dma_map_sg
 implementations
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_153222_937476_FFFE9504 
X-CRM114-Status: GOOD (  18.05  )
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

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c       | 59 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci-p2pdma.h | 21 ++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 0568604fd8b4..b0d779aeade9 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -938,6 +938,65 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
 
+/**
+ * pci_p2pdma_map_segment - map an sg segment determining the mapping type
+ * @state: State structure that should be declared outside of the for_each_sg()
+ *	loop and initialized to zero.
+ * @dev: DMA device that's doing the mapping operation
+ * @sg: scatterlist segment to map
+ *
+ * This is a helper to be used by non-iommu dma_map_sg() implementations where
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
+		sg_dma_mark_pci_p2pdma(sg);
+	}
+
+	return state->map;
+}
+
+/**
+ * pci_p2pdma_map_bus_segment - map an sg segment pre determined to
+ *	be mapped with PCI_P2PDMA_MAP_BUS_ADDR
+ * @pg_sg: scatterlist segment with the page to map
+ * @dma_sg: scatterlist segment to assign a dma address to
+ *
+ * This is a helper for iommu dma_map_sg() implementations when the
+ * segment for the dma address differs from the segment containing the
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
+	sg_dma_mark_pci_p2pdma(dma_sg);
+}
+
 /**
  * pci_p2pdma_enable_store - parse a configfs/sysfs attribute store
  *		to enable p2pdma
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index caac2d023f8f..e5a8d5bc0f51 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -13,6 +13,12 @@
 
 #include <linux/pci.h>
 
+struct pci_p2pdma_map_state {
+	struct dev_pagemap *pgmap;
+	int map;
+	u64 bus_off;
+};
+
 struct block_device;
 struct scatterlist;
 
@@ -70,6 +76,11 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs);
 void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs);
+enum pci_p2pdma_map_type
+pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
+		       struct scatterlist *sg);
+void pci_p2pdma_map_bus_segment(struct scatterlist *pg_sg,
+				struct scatterlist *dma_sg);
 int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
 			    bool *use_p2pdma);
 ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
@@ -135,6 +146,16 @@ static inline void pci_p2pdma_unmap_sg_attrs(struct device *dev,
 		unsigned long attrs)
 {
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
 static inline int pci_p2pdma_enable_store(const char *page,
 		struct pci_dev **p2p_dev, bool *use_p2pdma)
 {
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
