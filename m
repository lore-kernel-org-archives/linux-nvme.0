Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5EEC433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 07:05:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D618B208DB
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 07:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qchk/mvu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jqVQwXKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D618B208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DHLvuliqX0TpkbpvLY21ftlOHfKXfAbYQB/6PY7ReZY=; b=Qchk/mvuIJzLSzRSL25+YN1L6
	Xmn3VVTlBSa0SahLrK9K8YytdMDfwgmLBt+8d6Wkj2LdzGRY9lzE40No8QoqWPvU/5UANven4jdI9
	8TWldbhhQdgVPBuDl0vacZvDRfyl7b6NUItjhleqOlwhdk7jRFei9Diof46hR025sIkTGGd28Xvb8
	nRxl/K/uj4e6Dv8vvEItmxJmHkN7CxJGPLGsJRJwQ0QHwszM9Pa7gqWm9quXw7R3PHev5bw3sR5jH
	fTrQXDP0AdjdA2F7rc3e2SRFZDgTJr7NwY/2FL3ug+P4065EIp4TbqwrOD08ziliOpuiNMHKFAnRO
	qXY0LFq4A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8I9l-0000Sr-EM; Wed, 19 Aug 2020 07:05:09 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I1V-00056z-Lv; Wed, 19 Aug 2020 06:56:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=JBtww2AF0MKHgVJ2NsYCRS8RX5wJV/mnDYAumMky5+Q=; b=jqVQwXKaFpfaLermWlMeQOmiG2
 PlPtQdsPnRzZk9aVdDZYPr29069EriV/602dzGZwo5GfjgWPB1uaETIlQibnQxHFRhZwz6AQMzap1
 rZc3uQb5rpWNWX5Wajo6BoNAuXyX0+IRA2PL+dYxsTmFJPSrD+mdYTk6Hj5YekUT45kZnJY1dYaU8
 3x5Zpak+pYkzubqM2CSxEjr19RORB8nyR/wKOdN4C7LwZc4R34QaIrny+2VtnKH7T4W7BB448cc6n
 WX5R9KvfqG8Lp/Eg3w4h5AodbQCJs/HmqnLT6+15tDASXerOoVWfXkfJ9F/0rcFWryXLfaGekIoML
 rC3PGeoQ==;
Received: from [2001:4bb8:198:f3b2:86b6:2277:f429:37a1] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I1R-0008Qm-Og; Wed, 19 Aug 2020 06:56:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Pawel Osciak <pawel@osciak.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matt Porter <mporter@kernel.crashing.org>, iommu@lists.linux-foundation.org
Subject: [PATCH 17/28] dma-mapping: move dma_common_{mmap,
 get_sgtable} out of mapping.c
Date: Wed, 19 Aug 2020 08:55:44 +0200
Message-Id: <20200819065555.1802761-18-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819065555.1802761-1-hch@lst.de>
References: <20200819065555.1802761-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>, alsa-devel@alsa-project.org,
 linux-samsung-soc@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a new file that contains helpera for misc DMA ops, which is only
built when CONFIG_DMA_OPS is set.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/Makefile      |  1 +
 kernel/dma/mapping.c     | 47 +-----------------------------------
 kernel/dma/ops_helpers.c | 51 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 46 deletions(-)
 create mode 100644 kernel/dma/ops_helpers.c

diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
index 32c7c1942bbd6c..dc755ab68aabf9 100644
--- a/kernel/dma/Makefile
+++ b/kernel/dma/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_HAS_DMA)			+= mapping.o direct.o
+obj-$(CONFIG_DMA_OPS)			+= ops_helpers.o
 obj-$(CONFIG_DMA_OPS)			+= dummy.o
 obj-$(CONFIG_DMA_CMA)			+= contiguous.o
 obj-$(CONFIG_DMA_DECLARE_COHERENT)	+= coherent.o
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 0d129421e75fc8..848c95c27d79ff 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -8,7 +8,7 @@
 #include <linux/memblock.h> /* for max_pfn */
 #include <linux/acpi.h>
 #include <linux/dma-direct.h>
-#include <linux/dma-noncoherent.h>
+#include <linux/dma-mapping.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
 #include <linux/of_device.h>
@@ -295,22 +295,6 @@ void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 }
 EXPORT_SYMBOL(dma_sync_sg_for_device);
 
-/*
- * Create scatter-list for the already allocated DMA buffer.
- */
-int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
-		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		 unsigned long attrs)
-{
-	struct page *page = virt_to_page(cpu_addr);
-	int ret;
-
-	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
-	if (!ret)
-		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
-	return ret;
-}
-
 /*
  * The whole dma_get_sgtable() idea is fundamentally unsafe - it seems
  * that the intention is to allow exporting memory allocated via the
@@ -358,35 +342,6 @@ pgprot_t dma_pgprot(struct device *dev, pgprot_t prot, unsigned long attrs)
 }
 #endif /* CONFIG_MMU */
 
-/*
- * Create userspace mapping for the DMA-coherent memory.
- */
-int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
-		void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		unsigned long attrs)
-{
-#ifdef CONFIG_MMU
-	unsigned long user_count = vma_pages(vma);
-	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long off = vma->vm_pgoff;
-	int ret = -ENXIO;
-
-	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
-
-	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
-		return ret;
-
-	if (off >= count || user_count > count - off)
-		return -ENXIO;
-
-	return remap_pfn_range(vma, vma->vm_start,
-			page_to_pfn(virt_to_page(cpu_addr)) + vma->vm_pgoff,
-			user_count << PAGE_SHIFT, vma->vm_page_prot);
-#else
-	return -ENXIO;
-#endif /* CONFIG_MMU */
-}
-
 /**
  * dma_can_mmap - check if a given device supports dma_mmap_*
  * @dev: device to check
diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
new file mode 100644
index 00000000000000..e443c69be4299f
--- /dev/null
+++ b/kernel/dma/ops_helpers.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Helpers for DMA ops implementations.  These generally rely on the fact that
+ * the allocated memory contains normal pages in the direct kernel mapping.
+ */
+#include <linux/dma-noncoherent.h>
+
+/*
+ * Create scatter-list for the already allocated DMA buffer.
+ */
+int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
+		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		 unsigned long attrs)
+{
+	struct page *page = virt_to_page(cpu_addr);
+	int ret;
+
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (!ret)
+		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
+	return ret;
+}
+
+/*
+ * Create userspace mapping for the DMA-coherent memory.
+ */
+int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		unsigned long attrs)
+{
+#ifdef CONFIG_MMU
+	unsigned long user_count = vma_pages(vma);
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long off = vma->vm_pgoff;
+	int ret = -ENXIO;
+
+	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
+
+	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
+		return ret;
+
+	if (off >= count || user_count > count - off)
+		return -ENXIO;
+
+	return remap_pfn_range(vma, vma->vm_start,
+			page_to_pfn(virt_to_page(cpu_addr)) + vma->vm_pgoff,
+			user_count << PAGE_SHIFT, vma->vm_page_prot);
+#else
+	return -ENXIO;
+#endif /* CONFIG_MMU */
+}
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
