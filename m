Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B36C02199
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2025 14:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FCvKJduO115Hwr3m8euFET908wS6PQ2RwDpc3mnAlyc=; b=ry7/coI/oRD27FXBR4ohzufY2h
	S4phsIq4FO0T0SHUlYq7mQK7uxwwgzA8+oLmG+dxSQZXpB9hi39Txs8X8ATCU3ebavJnFFW/hu+6v
	W1XjqLTXglt1FMgJJpX8NyUcDmoO97lLR1Lq8zluYLJp9Sq05TIeKaEC5EjEwy/no4uIatuPGIDJo
	NYEUZpnBIfeqIe/x4PkHUV65B+hCyk0CZaPHWpRBMbXUWUxCRqQMuYi2LZT2fA9dnADCqTMym4Hun
	SSxPCOfpbs+2Es7hvUyMC9iNTrENumDy1gDTHZd7VvOZjTbH5+Z19eC0OeQsQ3QdL5+ubwceRVqPi
	DZotSAlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfgcF-00000003aSw-04a0;
	Wed, 05 Feb 2025 14:42:59 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfgah-00000003Zj7-1hRC
	for linux-nvme@lists.infradead.org;
	Wed, 05 Feb 2025 14:41:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7CF0CA436BC;
	Wed,  5 Feb 2025 14:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0BCC4CEDD;
	Wed,  5 Feb 2025 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738766482;
	bh=h/yBzjhoClTiKMl8LmMlOxeyuG0iINYdLuYFXO+3beM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQyxrQTbpGC5ELIJR6leSqpKifyAyAeb8I25BfLUz1ZlNtPRHHXvoAx88ZmrkyhEj
	 oiWitEtgqYTOWTpFkQbSoNIgY697J6MH3fgUibpLubW6kyqypRIhWVHQGweM5VjovX
	 Y1kC2pXK7i3BJenUde3znE6Y9+xI1LxPrSgIzVCpeRFAFE2Mk+Y2KOQSzJRqpjmsik
	 lZLP6NauWc5PCH6knOGMgYGQ2xZ4Jq10wd5UPj6rUnemzBirIatwxYpFvbihAfjv4l
	 iAoBLOEQbRc5Y/oScO3iFxYYMiLToSeN6xqr8mVzjSijcHqG6FQdSWfyW/ezi5a2FL
	 0IJKIrd4mwf4A==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
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
Subject: [PATCH v7 08/17] dma-mapping: add a dma_need_unmap helper
Date: Wed,  5 Feb 2025 16:40:28 +0200
Message-ID: <6c134d9e273433c52ca406de30112ecbc13f3b88.1738765879.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738765879.git.leonro@nvidia.com>
References: <cover.1738765879.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250205_064123_577928_6447129F 
X-CRM114-Status: GOOD (  14.77  )
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

Add helper that allows a driver to skip calling dma_unmap_*
if the DMA layer can guarantee that they are no-nops.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/dma-mapping.h |  5 +++++
 kernel/dma/mapping.c        | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index a71e110f1e9d..d2f358c5a25d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -406,6 +406,7 @@ static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 {
 	return dma_dev_need_sync(dev) ? __dma_need_sync(dev, dma_addr) : false;
 }
+bool dma_need_unmap(struct device *dev);
 #else /* !CONFIG_HAS_DMA || !CONFIG_DMA_NEED_SYNC */
 static inline bool dma_dev_need_sync(const struct device *dev)
 {
@@ -431,6 +432,10 @@ static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 {
 	return false;
 }
+static inline bool dma_need_unmap(struct device *dev)
+{
+	return false;
+}
 #endif /* !CONFIG_HAS_DMA || !CONFIG_DMA_NEED_SYNC */
 
 struct page *dma_alloc_pages(struct device *dev, size_t size,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index cda127027e48..3c3204ad2839 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -443,6 +443,24 @@ bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 }
 EXPORT_SYMBOL_GPL(__dma_need_sync);
 
+/**
+ * dma_need_unmap - does this device need dma_unmap_* operations
+ * @dev: device to check
+ *
+ * If this function returns %false, drivers can skip calling dma_unmap_* after
+ * finishing an I/O.  This function must be called after all mappings that might
+ * need to be unmapped have been performed.
+ */
+bool dma_need_unmap(struct device *dev)
+{
+	if (!dma_map_direct(dev, get_dma_ops(dev)))
+		return true;
+	if (!dev->dma_skip_sync)
+		return true;
+	return IS_ENABLED(CONFIG_DMA_API_DEBUG);
+}
+EXPORT_SYMBOL_GPL(dma_need_unmap);
+
 static void dma_setup_need_sync(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-- 
2.48.1


