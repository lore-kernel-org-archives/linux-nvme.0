Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FABD6409B
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Nov 2024 15:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YwvThwxHYJJkKqaQNWxTxm91AL51oJoEpswNkB0je+M=; b=nmbCkbUxdgwoM2DQ9ho0d5/82P
	LVJNY25aPwjz9x5uSC3sWszS8LwgfhtVsZjQLqjUHk1XglY52gvCViwUOGRt5qLpIh3r+RU9g03Li
	Rjx1fACcFtbu0pz1oFBFKRlTY3odb6UkIh9VGt/y/6S2UGB9VamI4pn03mojQA1MaYIkwkfRw7bF4
	uvT4Uryh2i/ZdXBU6prql+r5C9rOf+Qdb6VZ8Bw5umqj20Eto3a6cztkvHNJ/0pm3hjVQQc6gafhZ
	a73oN7btX+XAs43huusJ7aC1kBrgMNlUuTIbZddkwmWdlRbJ52htNvQnYF2PB1mImu0UJyRPKBnMy
	JuqGb8DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tA9QE-0000000F4GY-3App;
	Sun, 10 Nov 2024 15:00:14 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tA8ID-0000000EwoO-2FXm
	for linux-nvme@lists.infradead.org;
	Sun, 10 Nov 2024 13:48:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1EDDCA40CFE;
	Sun, 10 Nov 2024 13:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CC6C4CED0;
	Sun, 10 Nov 2024 13:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731246472;
	bh=5m1d0+DTyGkZRlNmd/gGqpR64QjDJCq1VneMI9ozY3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JpQZxNP0/bC5tFyQm/Gazifc4568RD+Yg/FkE3Ofni8YbtijuQWSE5/BsL9I7TRIz
	 d/RXYEPyH8iP4wRDbG6DfLMSA6pPHJTkZz8ENUOag3L+0rObkmUTPhB7xpiELWr3Ff
	 PdmjPeQKogd9FHcx6LxoDC82pYQerSIIilLnnSyObsXYq1XCfW+DK33ZUw9Vl2lOHi
	 lE0hco768LIuDXY/sbzWTGLzhc9cqye91fohpaow/FYKQmoQ7EI73yVjhtxNzfk42g
	 KHLj29NkXl9zLUClqPvWsDxqezWz3ShXkOu2k085FuuJuKznb1m1ZHnJXshTfWxjxQ
	 AtsShAg/8wtvQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Leon Romanovsky <leonro@nvidia.com>,
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
Subject: [PATCH v3 04/17] dma-mapping: Add check if IOVA can be used
Date: Sun, 10 Nov 2024 15:46:51 +0200
Message-ID: <9515f330b9615de92a1864ab46acbd95e32634b6.1731244445.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731244445.git.leon@kernel.org>
References: <cover.1731244445.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_054754_113156_F70782CC 
X-CRM114-Status: GOOD (  13.97  )
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

From: Leon Romanovsky <leonro@nvidia.com>

This patch adds a check if IOVA can be used for the specific
transaction.

In the new API a DMA mapping transaction is identified by a
struct dma_iova_state, which holds some recomputed information
for the transaction which does not change for each page being
mapped.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/dma-mapping.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 1524da363734..6075e0708deb 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -76,6 +76,20 @@
 
 #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
 
+struct dma_iova_state {
+	size_t __size;
+};
+
+/*
+ * Use the high bit to mark if we used swiotlb for one or more ranges.
+ */
+#define DMA_IOVA_USE_SWIOTLB		(1ULL << 63)
+
+static inline size_t dma_iova_size(struct dma_iova_state *state)
+{
+	return state->__size & ~DMA_IOVA_USE_SWIOTLB;
+}
+
 #ifdef CONFIG_DMA_API_DEBUG
 void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
 void debug_dma_map_single(struct device *dev, const void *addr,
@@ -281,6 +295,25 @@ static inline int dma_mmap_noncontiguous(struct device *dev,
 }
 #endif /* CONFIG_HAS_DMA */
 
+#ifdef CONFIG_IOMMU_DMA
+/**
+ * dma_use_iova - check if the IOVA API is used for this state
+ * @state: IOVA state
+ *
+ * Return %true if the DMA transfers uses the dma_iova_*() calls or %false if
+ * they can't be used.
+ */
+static inline bool dma_use_iova(struct dma_iova_state *state)
+{
+	return state->__size != 0;
+}
+#else /* CONFIG_IOMMU_DMA */
+static inline bool dma_use_iova(struct dma_iova_state *state)
+{
+	return false;
+}
+#endif /* CONFIG_IOMMU_DMA */
+
 #if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
 void __dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir);
-- 
2.47.0


