Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4815FC2D0A3
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 18:06:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0686206FA
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 18:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tvS2/fYd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="BHzl7brW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0686206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IRoKbtkbH8PRdRo/8bx7Sw4DUJOK3ynTCHze3uMGdnQ=; b=tvS2/fYdVnwUVE+GSFKCXVe2+
	/eLsjRz4qEyhCl1TohZZ08eP+/trPykok6eWx8swu4PVfNgVFW5eygp8xdyhcouVQxrspUugUBPzn
	p7KCEqHAyuvrKxW0gWG0VYeYjJ/H+BEnNSiO9JR4V2b0PxN9c25r1rTXZ9elr3BBp+5vJqJqoYsw+
	jFuYyZi6NgE2jUT23LdIvlpOWjxqRNjTZrEIsQf0POjz5wf2xTg3ERAazmfr43FSR6Pj7G3netgdO
	sWja9D8NZuaebm7vV+Z6oqQg3GFptnoXuTEeveN5NMIEcgb4DCO6UIzgTdqzKzPdZXw5+Yj7KNxTK
	jXahYd7IA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb67o-0003qg-0T; Fri, 06 Nov 2020 18:06:12 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb56r-000113-6S
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 17:01:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SXfy4s8hoEPUTYM9kHHNonZmUe909URW6TTsyKH/U90=; b=BHzl7brWOE/xtPuLFhRTe7TuHr
 CCuWDnC47LTjBL2g1BoQKbHUoik8thlIDKyGFVrzXe/dGQN/+q/AWwhzkDSG6NdRqMWTmAk7orOgm
 KZqZo4YCrM1c5gq6KJoBazV729nnyG74Kar8Gv8V0vLg66n2prPHvabelgflf6qaiTIOa9nfeH69h
 ftQrsd9dF9OF9hUH3f7nuXp5nYN33gwIU7KdPW/+hieD4Z1ZUvgHpBdGlk2kU5ZtnPCHRdTHe98Ai
 4V4Av/tH/K18dDGBupBS5yz0N4oKJW3RHAb9dz2rzhTisd+rpgJpzqbgkHksBZ2JSO2NF4fo9vQ3a
 9Yf47kmw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kb56k-0002Pa-Ak; Fri, 06 Nov 2020 10:01:05 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kb56U-0004t2-LB; Fri, 06 Nov 2020 10:00:46 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Fri,  6 Nov 2020 10:00:26 -0700
Message-Id: <20201106170036.18713-6-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106170036.18713-1-logang@deltatee.com>
References: <20201106170036.18713-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, dan.j.williams@intel.com,
 iweiny@intel.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org,
 daniel.vetter@ffwll.ch, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [RFC PATCH 05/15] dma-direct: Support PCI P2PDMA pages in dma-direct
 map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_120109_753287_92AD5C45 
X-CRM114-Status: GOOD (  20.56  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: John Hubbard <jhubbard@nvidia.com>, Ira Weiny <iweiny@intel.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Don Dutile <ddutile@redhat.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
PCI P2PDMA pages directly without a hack in the callers. This allows
for heterogeneous SGLs that contain both P2PDMA and regular pages.

The DMA_ATTR_P2PDMA flag is added to allow callers to indicate support
for P2PDMA pages. In order for a caller to support P2PDMA pages they
must ensure no segment is greater than 2GB such that the high bit
of the dma length can be used as a flag to indicate a P2PDMA segment.
Such code must then ensure to use sg_dma_p2pdma_len() instead of
sg_dma_len() to filter out the flag.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/dma-mapping.h | 11 +++++++++++
 kernel/dma/direct.c         | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 956151052d45..8d028e15b531 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -61,6 +61,17 @@
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
 
+/*
+ * DMA_ATTR_P2PDMA: specifies that dma_map_sg() may return p2pdma
+ * bus addresses. Code that specifies this must ensure to
+ * use sg_dma_p2pdma_len() instead of sg_dma_len() as the high
+ * bit of the length will indicate a P2PDMA bus address.
+ *
+ * If this attribute is not set and P2PDMA pages are encountered,
+ * dma_map_sg() will return an error.
+ */
+#define DMA_ATTR_P2PDMA			(1UL << 10)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 06c111544f61..2fcb31789436 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -13,6 +13,7 @@
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
 #include <linux/slab.h>
+#include <linux/pci-p2pdma.h>
 #include "direct.h"
 
 /*
@@ -387,19 +388,47 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 	struct scatterlist *sg;
 	int i;
 
-	for_each_sg(sgl, sg, nents, i)
+	for_each_sg(sgl, sg, nents, i) {
+		if (attrs & DMA_ATTR_P2PDMA && sg_dma_is_p2pdma(sg)) {
+			sg_dma_len(sg) &= ~SG_P2PDMA_FLAG;
+			continue;
+		}
+
 		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
 			     attrs);
+	}
 }
 #endif
 
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-	int i;
+	struct dev_pagemap *pgmap = NULL;
+	int i, map = -1;
 	struct scatterlist *sg;
+	u64 bus_off;
 
 	for_each_sg(sgl, sg, nents, i) {
+		if (is_pci_p2pdma_page(sg_page(sg))) {
+			if (sg_page(sg)->pgmap != pgmap) {
+				pgmap = sg_page(sg)->pgmap;
+				map = pci_p2pdma_should_map_bus(dev, pgmap);
+				bus_off = pci_p2pdma_bus_offset(sg_page(sg));
+			}
+
+			if (map < 0 || !(attrs & DMA_ATTR_P2PDMA)) {
+				sg->dma_address = DMA_MAPPING_ERROR;
+				goto out_unmap;
+			}
+
+			if (map) {
+				sg->dma_address = sg_phys(sg) + sg->offset -
+					bus_off;
+				sg_dma_len(sg) = sg->length | SG_P2PDMA_FLAG;
+				continue;
+			}
+		}
+
 		sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
 				sg->offset, sg->length, dir, attrs);
 		if (sg->dma_address == DMA_MAPPING_ERROR)
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
