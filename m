Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5794C369DC
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rAT6htFJwU9YS9ucogc9yQY/N+MgxUHZ3sqr7Ovxx10=; b=2M4VzO3xok1Qkun11mipUtkjne
	3qLQX4fZ3V2uxFQ50e2cAUpbTjthh02lUH5Ju4R+27EKUI3hlgCpUKCIgaHDyNBYrbpwMhQt4CTfN
	6kulxLs2SB4W08bX1s+AaUPZMGZSr2qo+qSF35buxhOaiRoFn23c7jw389FW5wFQSLNFb5zsuFKH4
	ITp2JNxg/Sl9qWoyqOVdVbHtcEH5gzGd2wTrhATyufRM5QrbdOVf+4pGjNqs+csGWBdjWTbpPc8nS
	jRnz/Dt8oXuuSvCEojHvwdIWF4E2PEdmz4zgK/aEwLF7UYfbDvTnW4jhWnB8Mgv3hIWyn2BMVNiRw
	YIiTifHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9O9r-00000006JnM-01uc;
	Mon, 28 Apr 2025 13:04:27 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Khs-00000005aTw-2KcD
	for linux-nvme@bombadil.infradead.org;
	Mon, 28 Apr 2025 09:23:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=rAT6htFJwU9YS9ucogc9yQY/N+MgxUHZ3sqr7Ovxx10=; b=cw3Dfdcj2DOhgJTYZ44lC/TJik
	+bVdQTmi3BJ5HefgBBaiRmTgnERRq1L2jdJ2phYYSmmNxr4YJ6XUQSmzQ7UE45PE+41DSCl8fzxG7
	qjEJYgN1cQdraRUP1okHWrjgeiWXVl26zEK4EGKOvMvFc47dHrIhtw+ABBMc8i/g5h1/06SbY5LPn
	sRpOgSZ6lEyyWUdUiWtx7ULpDg5+1L4ey04z/BUqTuNAwxYSM7QoMe12ZqoM3+SeSJkdp5WjhXP7E
	dt44bjDZYrdCLwzL5I+X91K0CPchBppWQD28FZgdq1fEzkmEeaXZgrQ2Tt34la5eZe15lpkV3WtkI
	tOysfrQg==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u9Kho-0000000Cd5C-3THj
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 09:23:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4F9465C4823;
	Mon, 28 Apr 2025 09:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793B3C4CEF0;
	Mon, 28 Apr 2025 09:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745832195;
	bh=7JZyUOUgfxHnGGG2HNKQMfblPgeeA2+t6VQ5mlFxHys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GfCwVVwdyFZmy+bRtQCIHsemKrBs8wbIR2UqsztY5GMF0OIm6MavtPECFiD+SMVDI
	 +a1etzFYrSBq/hrx15Z7WCLjK2G9v22HGYTe8UdZ3YqH/HDl+rz3uDoylfAlaZwt2u
	 2YY3mUvm1+pvHmj8SEsNj9VVcNA8rvqSDjaWnOkYBdGB7UdEf7U92TRCOmt7Lwp+Bn
	 M989LV/ZRjL+WWCZwb5dI+P4iU/d2OGxVUfpkp0gPNylAN0RBbXVeewsgljmoc+1Ex
	 XZPoE/bywuEsRDcl36Jn1nkR2Ws743Ze2Qn4zXZvtW2lGFPAPZrqEjsCHzhWFmhkZu
	 F0KhMRfOO3NFw==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v10 05/24] dma-mapping: Provide an interface to allow allocate IOVA
Date: Mon, 28 Apr 2025 12:22:11 +0300
Message-ID: <30f0601d400711b3859deeb8fef3090f5b2020a4.1745831017.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745831017.git.leon@kernel.org>
References: <cover.1745831017.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_102317_295395_915C2373 
X-CRM114-Status: GOOD (  24.87  )
X-Mailman-Approved-At: Mon, 28 Apr 2025 05:19:59 -0700
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

The existing .map_page() callback provides both allocating of IOVA
and linking DMA pages. That combination works great for most of the
callers who use it in control paths, but is less effective in fast
paths where there may be multiple calls to map_page().

These advanced callers already manage their data in some sort of
database and can perform IOVA allocation in advance, leaving range
linkage operation to be in fast path.

Provide an interface to allocate/deallocate IOVA and next patch
link/unlink DMA ranges to that specific IOVA.

In the new API a DMA mapping transaction is identified by a
struct dma_iova_state, which holds some recomputed information
for the transaction which does not change for each page being
mapped, so add a check if IOVA can be used for the specific
transaction.

The API is exported from dma-iommu as it is the only implementation
supported, the namespace is clearly different from iommu_* functions
which are not allowed to be used. This code layout allows us to save
function call per API call used in datapath as well as a lot of boilerplate
code.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/dma-iommu.c   | 86 +++++++++++++++++++++++++++++++++++++
 include/linux/dma-mapping.h | 48 +++++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9ba8d8bc0ce9..d3211a8d755e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1723,6 +1723,92 @@ size_t iommu_dma_max_mapping_size(struct device *dev)
 	return SIZE_MAX;
 }
 
+/**
+ * dma_iova_try_alloc - Try to allocate an IOVA space
+ * @dev: Device to allocate the IOVA space for
+ * @state: IOVA state
+ * @phys: physical address
+ * @size: IOVA size
+ *
+ * Check if @dev supports the IOVA-based DMA API, and if yes allocate IOVA space
+ * for the given base address and size.
+ *
+ * Note: @phys is only used to calculate the IOVA alignment. Callers that always
+ * do PAGE_SIZE aligned transfers can safely pass 0 here.
+ *
+ * Returns %true if the IOVA-based DMA API can be used and IOVA space has been
+ * allocated, or %false if the regular DMA API should be used.
+ */
+bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
+		phys_addr_t phys, size_t size)
+{
+	struct iommu_dma_cookie *cookie;
+	struct iommu_domain *domain;
+	struct iova_domain *iovad;
+	size_t iova_off;
+	dma_addr_t addr;
+
+	memset(state, 0, sizeof(*state));
+	if (!use_dma_iommu(dev))
+		return false;
+
+	domain = iommu_get_dma_domain(dev);
+	cookie = domain->iova_cookie;
+	iovad = &cookie->iovad;
+	iova_off = iova_offset(iovad, phys);
+
+	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
+	    iommu_deferred_attach(dev, iommu_get_domain_for_dev(dev)))
+		return false;
+
+	if (WARN_ON_ONCE(!size))
+		return false;
+
+	/*
+	 * DMA_IOVA_USE_SWIOTLB is flag which is set by dma-iommu
+	 * internals, make sure that caller didn't set it and/or
+	 * didn't use this interface to map SIZE_MAX.
+	 */
+	if (WARN_ON_ONCE((u64)size & DMA_IOVA_USE_SWIOTLB))
+		return false;
+
+	addr = iommu_dma_alloc_iova(domain,
+			iova_align(iovad, size + iova_off),
+			dma_get_mask(dev), dev);
+	if (!addr)
+		return false;
+
+	state->addr = addr + iova_off;
+	state->__size = size;
+	return true;
+}
+EXPORT_SYMBOL_GPL(dma_iova_try_alloc);
+
+/**
+ * dma_iova_free - Free an IOVA space
+ * @dev: Device to free the IOVA space for
+ * @state: IOVA state
+ *
+ * Undoes a successful dma_try_iova_alloc().
+ *
+ * Note that all dma_iova_link() calls need to be undone first.  For callers
+ * that never call dma_iova_unlink(), dma_iova_destroy() can be used instead
+ * which unlinks all ranges and frees the IOVA space in a single efficient
+ * operation.
+ */
+void dma_iova_free(struct device *dev, struct dma_iova_state *state)
+{
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	size_t iova_start_pad = iova_offset(iovad, state->addr);
+	size_t size = dma_iova_size(state);
+
+	iommu_dma_free_iova(domain, state->addr - iova_start_pad,
+			iova_align(iovad, size + iova_start_pad), NULL);
+}
+EXPORT_SYMBOL_GPL(dma_iova_free);
+
 void iommu_setup_dma_ops(struct device *dev)
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index b79925b1c433..de7f73810d54 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -72,6 +72,22 @@
 
 #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
 
+struct dma_iova_state {
+	dma_addr_t addr;
+	u64 __size;
+};
+
+/*
+ * Use the high bit to mark if we used swiotlb for one or more ranges.
+ */
+#define DMA_IOVA_USE_SWIOTLB		(1ULL << 63)
+
+static inline size_t dma_iova_size(struct dma_iova_state *state)
+{
+	/* Casting is needed for 32-bits systems */
+	return (size_t)(state->__size & ~DMA_IOVA_USE_SWIOTLB);
+}
+
 #ifdef CONFIG_DMA_API_DEBUG
 void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
 void debug_dma_map_single(struct device *dev, const void *addr,
@@ -277,6 +293,38 @@ static inline int dma_mmap_noncontiguous(struct device *dev,
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
+
+bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
+		phys_addr_t phys, size_t size);
+void dma_iova_free(struct device *dev, struct dma_iova_state *state);
+#else /* CONFIG_IOMMU_DMA */
+static inline bool dma_use_iova(struct dma_iova_state *state)
+{
+	return false;
+}
+static inline bool dma_iova_try_alloc(struct device *dev,
+		struct dma_iova_state *state, phys_addr_t phys, size_t size)
+{
+	return false;
+}
+static inline void dma_iova_free(struct device *dev,
+		struct dma_iova_state *state)
+{
+}
+#endif /* CONFIG_IOMMU_DMA */
+
 #if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
 void __dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir);
-- 
2.49.0


