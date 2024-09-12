Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D483EEB593
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 11:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0W2KxFG10TKBSKgDyfiWAc4x58BJsldPcALBb7K1X/4=; b=M9tIYz889FYN+EZs4QU72sByyR
	SxvS7sLb+Rr7coICshxxBkD9IMysJzp7GB3WnBn8tlUy00IIqdsXRyvPodtzJhsvEEwBMgfU5tMJa
	LHkNS6vO6jEnDYizvzuk0/clM9eyep/1oB1YDNiAemUjnMFP4nI0XEPu3xzpCoSfXBFvEG5t4xzhy
	lIRu/2x3g/6/3gwPtkhuT8hQVl0LvewsFQpSf9R4eS/6Rc2dIay3YvYDqLedYKVbkQcUJd9B3XQtP
	k3EdDbIrwkRhj0mtG7PP7GAQhaxUEMFV1zFhUsxPg5FkF0EzY9a+Lvwob0rir0aviB2aZtUB4FgOi
	2dvo8AtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohoU-0000000Cnbg-1pic;
	Thu, 12 Sep 2024 11:16:38 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohoM-0000000CnUj-2wmq
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 11:16:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 21E78A45269;
	Thu, 12 Sep 2024 11:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AE0C4CECC;
	Thu, 12 Sep 2024 11:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726139789;
	bh=YbYR1B9oX34Xv+Cehx9/tYc07da7ONVOmPeGXmHRn1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fMCA+j/uOJoozgNYTkAQZ9i5owgnrutNMDDvBGalOj/zk/VYWCdYuZ4BwEUgbo+Ee
	 8IK3/oKPT7MWMTtxPtDL2tX4K+v6ORqHmqpoXabXDx37Z0XKm5aVZRF6/WCoJ9ITzO
	 y2gg2RxijzVwlXxmRZdMVaHnbiANFg06GCTCeNRhNlUjPZ4StdmFz7Mfcxa8G1XV1K
	 slWv9Nbw6MJs1cRNGwbW5Pi2YtCX+5q7wtccX+oU6he+cAY4vrHTPY4NBWkdGZdWz5
	 rmSAiwxnbgN6fVd3O1RZFGWZ5pQ/Skqfv2XfNFsGj0rdVOoX/QhfA/JxO+QYtRiKMd
	 e8hcOh4m/hvyg==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC v2 07/21] dma-mapping: implement link range API
Date: Thu, 12 Sep 2024 14:15:42 +0300
Message-ID: <bf1ad045f27a8dfac9e9dafd09869ac9a6be0b51.1726138681.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726138681.git.leon@kernel.org>
References: <cover.1726138681.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_041631_079847_A9A73E71 
X-CRM114-Status: GOOD (  13.01  )
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

Introduce new DMA APIs to perform DMA linkage of buffers
in layers higher than DMA.

In proposed API, the callers will perform the following steps:
dma_alloc_iova()
if (dma_can_use_iova(...))
  dma_start_range(...)
  for (page in range)
     dma_link_range(...)
  dma_end_range(...)
else
  /* Fallback to legacy map pages */
  dma_map_page(...)

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/dma-mapping.h | 26 ++++++++++++++++
 kernel/dma/mapping.c        | 60 +++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2c74e68b0567..bb541f8944e5 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -11,6 +11,7 @@
 #include <linux/scatterlist.h>
 #include <linux/bug.h>
 #include <linux/mem_encrypt.h>
+#include <linux/iommu.h>
 
 /**
  * List of possible attributes associated with a DMA mapping. The semantics
@@ -82,6 +83,7 @@ struct dma_iova_state {
 	size_t size;
 	enum dma_data_direction dir;
 	u8 use_iova : 1;
+	size_t range_size;
 };
 
 static inline void dma_init_iova_state(struct dma_iova_state *state,
@@ -173,6 +175,11 @@ int dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
 void dma_set_iova_state(struct dma_iova_state *state, struct page *page,
 			size_t size);
 bool dma_can_use_iova(struct dma_iova_state *state);
+int dma_start_range(struct dma_iova_state *state);
+void dma_end_range(struct dma_iova_state *state);
+dma_addr_t dma_link_range_attrs(struct dma_iova_state *state, phys_addr_t phys,
+				size_t size, unsigned long attrs);
+void dma_unlink_range_attrs(struct dma_iova_state *state, unsigned long attrs);
 #else /* CONFIG_HAS_DMA */
 static inline int dma_alloc_iova_unaligned(struct dma_iova_state *state,
 					   phys_addr_t phys, size_t size)
@@ -319,6 +326,23 @@ static inline bool dma_can_use_iova(struct dma_iova_state *state)
 {
 	return false;
 }
+static inline int dma_start_range(struct dma_iova_state *state)
+{
+	return -EOPNOTSUPP;
+}
+static inline void dma_end_range(struct dma_iova_state *state)
+{
+}
+static inline dma_addr_t dma_link_range_attrs(struct dma_iova_state *state,
+					      phys_addr_t phys, size_t size,
+					      unsigned long attrs)
+{
+	return DMA_MAPPING_ERROR;
+}
+static inline void dma_unlink_range_attrs(struct dma_iova_state *state,
+					  unsigned long attrs)
+{
+}
 #endif /* CONFIG_HAS_DMA */
 
 #if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
@@ -513,6 +537,8 @@ static inline void dma_sync_sgtable_for_device(struct device *dev,
 #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
 #define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, 0)
 #define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, 0)
+#define dma_link_range(d, p, o) dma_link_range_attrs(d, p, o, 0)
+#define dma_unlink_range(d) dma_unlink_range_attrs(d, 0)
 
 bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size);
 
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 16cb03d5d87d..39fac8c21643 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -1024,3 +1024,63 @@ bool dma_can_use_iova(struct dma_iova_state *state)
 	return state->use_iova;
 }
 EXPORT_SYMBOL_GPL(dma_can_use_iova);
+
+/**
+ * dma_start_range - Start a range of IOVA space
+ * @state: IOVA state
+ *
+ * Start a range of IOVA space for the given IOVA state.
+ */
+int dma_start_range(struct dma_iova_state *state)
+{
+	if (!state->use_iova)
+		return 0;
+
+	return iommu_dma_start_range(state->dev);
+}
+EXPORT_SYMBOL_GPL(dma_start_range);
+
+/**
+ * dma_end_range - End a range of IOVA space
+ * @state: IOVA state
+ *
+ * End a range of IOVA space for the given IOVA state.
+ */
+void dma_end_range(struct dma_iova_state *state)
+{
+	if (!state->use_iova)
+		return;
+
+	iommu_dma_end_range(state->dev);
+}
+EXPORT_SYMBOL_GPL(dma_end_range);
+
+/**
+ * dma_link_range_attrs - Link a range of IOVA space
+ * @state: IOVA state
+ * @phys: physical address to link
+ * @size: size of the buffer
+ * @attrs: attributes of mapping properties
+ *
+ * Link a range of IOVA space for the given IOVA state.
+ */
+dma_addr_t dma_link_range_attrs(struct dma_iova_state *state, phys_addr_t phys,
+				size_t size, unsigned long attrs)
+{
+	return iommu_dma_link_range(state, phys, size, attrs);
+}
+EXPORT_SYMBOL_GPL(dma_link_range_attrs);
+
+/**
+ * dma_unlink_range_attrs - Unlink a range of IOVA space
+ * @state: IOVA state
+ * @attrs: attributes of mapping properties
+ *
+ * Unlink a range of IOVA space for the given IOVA state.
+ */
+void dma_unlink_range_attrs(struct dma_iova_state *state, unsigned long attrs)
+{
+	iommu_dma_unlink_range(state->dev, state->addr, state->range_size,
+			       state->dir, attrs);
+}
+EXPORT_SYMBOL_GPL(dma_unlink_range_attrs);
-- 
2.46.0


