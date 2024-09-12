Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FC8EEB59D
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 12:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gGLs6QzmJOO36oeXATzigzPKHaISuQ3mIDTi96IgMDE=; b=CXy4/nc12inSNefdkht7uvr5hC
	SqMozupFycKQgCzUFp+lqzgCCB8DtWL2TTKlo0HQx3yIqn9HTyn9HyejeFMIw6q3OX1xvAaXIMClo
	QnJi8cWJBYSUd6RNpD7QjLMiWvRfa0ahg0oCs0z+6cXhDwaIOb1aEkxTw56nLuPLrB6BW0Az8c+pU
	QbzZMXK5iVaLR1uz9H2a/RqLfYlN+kLDNTV9SBq7IdVRdKgPlgdeof9r7gZOY7OrlbV4HTDNaJ31l
	i8jZ4Q9Bsm5OyU2iYFmYPU8yTgRu+txD6Mwc0B0imgeKob3C0sqVRmgyPkALQmEs8NEl9Svbt4sJl
	4mM3d5IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soiyP-0000000D2ID-3s4a;
	Thu, 12 Sep 2024 12:30:57 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohol-0000000CnqA-2CHU
	for linux-nvme@bombadil.infradead.org;
	Thu, 12 Sep 2024 11:16:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=gGLs6QzmJOO36oeXATzigzPKHaISuQ3mIDTi96IgMDE=; b=E+ffIZTEr4mXSeMYZiDwVhzo1T
	z7Oj/nLEz4ddPmpOtZ9pvwDQKsoYNiNsO6DRgHqvtqLxefsDg2936bTh/8b9sd8f55pdQXrfES/k6
	+4sNP7uVf7gecZWJY0WD9r5SyvKYSdtZqe457ox4nr5ma6z4uAZbSuZNfuLYC5YHFPbYoRpSgpwDA
	Qg6eq9Z6jWHatRY79OTlV4IQTNh2qID6LFgYkqhH0/coLLvmxxHwKRSadsa/pCkfRgFxXQfJXGLkY
	9FzmrYcZISs6HN7QAnnD8a/kbRXKyGaw1u3leKUMZ+9XgBpck28HV4WIDT/mvvduURbZiZQGLc6kt
	a2zSH37A==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sohoh-00000000RPP-1Y9S
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 11:16:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3B862A45276;
	Thu, 12 Sep 2024 11:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3784C4CEC3;
	Thu, 12 Sep 2024 11:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726139809;
	bh=spVFy3m3YsiOCt+eM/7kAiwbky1QV6tGttipLIv2zOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gxIRjDv2xSAwxfC7Pzv93fwrrIfQ9PwEmdy9PQY9kxiAaKE9zksC7l6BVJARsx/Su
	 1STWOMET2EijMQV/ogv3irEMdmIuZj3nnGt4KBmBcT6BEGtZX8cjNM1Pr20esfKwTf
	 J4gCuwNEqcuVTf4mIf24b0bSOAFHULKIEK1sxUpdhCWhDJud3jPtiwwQRwp14hntAr
	 VSglEmDWqgoCBkDlNN7vrfcRvvwdFx4IRR1eaFLfLtGEBfPB8gWc/Xet5lmJKcD4NA
	 zjaak/j/qqJF6x0ng9Y22CZ07xQLxhebgIlmpr7AwEEvH/7NVecTBsfEfiaTHT8btF
	 KIbgGEdSyuStA==
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
Subject: [RFC v2 12/21] RDMA/core: Separate DMA mapping to caching IOVA and page linkage
Date: Thu, 12 Sep 2024 14:15:47 +0300
Message-ID: <32e9e95b05e49d95079dc7cbfd458b00b47b1c81.1726138681.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726138681.git.leon@kernel.org>
References: <cover.1726138681.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_121651_729283_5229F2F9 
X-CRM114-Status: GOOD (  21.01  )
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

Reuse newly added DMA API to cache IOVA and only link/unlink pages
in fast path.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem_odp.c | 61 +++---------------------------
 drivers/infiniband/hw/mlx5/odp.c   |  7 +++-
 include/rdma/ib_umem_odp.h         |  8 +---
 kernel/dma/mapping.c               |  7 +---
 4 files changed, 14 insertions(+), 69 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 72885eca4181..7bfa1e54454c 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -81,19 +81,12 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 		if (!umem_odp->pfn_list)
 			return -ENOMEM;
 
-		umem_odp->dma_list = kvcalloc(
-			ndmas, sizeof(*umem_odp->dma_list), GFP_KERNEL);
-		if (!umem_odp->dma_list) {
-			ret = -ENOMEM;
-			goto out_pfn_list;
-		}
 
 		dma_init_iova_state(&umem_odp->state, dev->dma_device,
 				    DMA_BIDIRECTIONAL);
 		ret = dma_alloc_iova(&umem_odp->state, end - start);
 		if (ret)
-			goto out_dma_list;
-
+			goto out_pfn_list;
 
 		ret = mmu_interval_notifier_insert(&umem_odp->notifier,
 						   umem_odp->umem.owning_mm,
@@ -106,8 +99,6 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 
 out_free_iova:
 	dma_free_iova(&umem_odp->state);
-out_dma_list:
-	kvfree(umem_odp->dma_list);
 out_pfn_list:
 	kvfree(umem_odp->pfn_list);
 	return ret;
@@ -285,7 +276,6 @@ void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
 		mutex_unlock(&umem_odp->umem_mutex);
 		mmu_interval_notifier_remove(&umem_odp->notifier);
 		dma_free_iova(&umem_odp->state);
-		kvfree(umem_odp->dma_list);
 		kvfree(umem_odp->pfn_list);
 	}
 	put_pid(umem_odp->tgid);
@@ -293,40 +283,10 @@ void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
 }
 EXPORT_SYMBOL(ib_umem_odp_release);
 
-/*
- * Map for DMA and insert a single page into the on-demand paging page tables.
- *
- * @umem: the umem to insert the page to.
- * @dma_index: index in the umem to add the dma to.
- * @page: the page struct to map and add.
- * @access_mask: access permissions needed for this page.
- *
- * The function returns -EFAULT if the DMA mapping operation fails.
- *
- */
-static int ib_umem_odp_map_dma_single_page(
-		struct ib_umem_odp *umem_odp,
-		unsigned int dma_index,
-		struct page *page)
-{
-	struct ib_device *dev = umem_odp->umem.ibdev;
-	dma_addr_t *dma_addr = &umem_odp->dma_list[dma_index];
-
-	*dma_addr = ib_dma_map_page(dev, page, 0, 1 << umem_odp->page_shift,
-				    DMA_BIDIRECTIONAL);
-	if (ib_dma_mapping_error(dev, *dma_addr)) {
-		*dma_addr = 0;
-		return -EFAULT;
-	}
-	umem_odp->npages++;
-	return 0;
-}
-
 /**
  * ib_umem_odp_map_dma_and_lock - DMA map userspace memory in an ODP MR and lock it.
  *
  * Maps the range passed in the argument to DMA addresses.
- * The DMA addresses of the mapped pages is updated in umem_odp->dma_list.
  * Upon success the ODP MR will be locked to let caller complete its device
  * page table update.
  *
@@ -434,15 +394,6 @@ int ib_umem_odp_map_dma_and_lock(struct ib_umem_odp *umem_odp, u64 user_virt,
 				  __func__, hmm_order, page_shift);
 			break;
 		}
-
-		ret = ib_umem_odp_map_dma_single_page(
-				umem_odp, dma_index, hmm_pfn_to_page(range.hmm_pfns[pfn_index]));
-		if (ret < 0) {
-			ibdev_dbg(umem_odp->umem.ibdev,
-				  "ib_umem_odp_map_dma_single_page failed with error %d\n", ret);
-			break;
-		}
-		range.hmm_pfns[pfn_index] |= HMM_PFN_DMA_MAPPED;
 	}
 	/* upon success lock should stay on hold for the callee */
 	if (!ret)
@@ -462,10 +413,8 @@ EXPORT_SYMBOL(ib_umem_odp_map_dma_and_lock);
 void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 virt,
 				 u64 bound)
 {
-	dma_addr_t dma;
 	int idx;
 	u64 addr;
-	struct ib_device *dev = umem_odp->umem.ibdev;
 
 	lockdep_assert_held(&umem_odp->umem_mutex);
 
@@ -473,19 +422,19 @@ void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 virt,
 	bound = min_t(u64, bound, ib_umem_end(umem_odp));
 	for (addr = virt; addr < bound; addr += BIT(umem_odp->page_shift)) {
 		unsigned long pfn_idx = (addr - ib_umem_start(umem_odp)) >> PAGE_SHIFT;
-		struct page *page = hmm_pfn_to_page(umem_odp->pfn_list[pfn_idx]);
 
 		idx = (addr - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
-		dma = umem_odp->dma_list[idx];
 
 		if (!(umem_odp->pfn_list[pfn_idx] & HMM_PFN_VALID))
 			continue;
 		if (!(umem_odp->pfn_list[pfn_idx] & HMM_PFN_DMA_MAPPED))
 			continue;
 
-		ib_dma_unmap_page(dev, dma, BIT(umem_odp->page_shift),
-				  DMA_BIDIRECTIONAL);
+		dma_hmm_unlink_page(&umem_odp->state,
+				    &umem_odp->pfn_list[pfn_idx],
+				    idx * (1 << umem_odp->page_shift));
 		if (umem_odp->pfn_list[pfn_idx] & HMM_PFN_WRITE) {
+			struct page *page = hmm_pfn_to_page(umem_odp->pfn_list[pfn_idx]);
 			struct page *head_page = compound_head(page);
 			/*
 			 * set_page_dirty prefers being called with
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 4bf691fb266f..f1fe2b941bb4 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -149,6 +149,7 @@ static void populate_mtt(__be64 *pas, size_t idx, size_t nentries,
 {
 	struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);
 	bool downgrade = flags & MLX5_IB_UPD_XLT_DOWNGRADE;
+	struct ib_device *dev = odp->umem.ibdev;
 	unsigned long pfn;
 	dma_addr_t pa;
 	size_t i;
@@ -162,12 +163,16 @@ static void populate_mtt(__be64 *pas, size_t idx, size_t nentries,
 			/* Initial ODP init */
 			continue;
 
-		pa = odp->dma_list[idx + i];
+		pa = dma_hmm_link_page(&odp->state, &odp->pfn_list[idx + i],
+				       (idx + i) * (1 << odp->page_shift));
+		WARN_ON_ONCE(ib_dma_mapping_error(dev, pa));
+
 		pa |= MLX5_IB_MTT_READ;
 		if ((pfn & HMM_PFN_WRITE) && !downgrade)
 			pa |= MLX5_IB_MTT_WRITE;
 
 		pas[i] = cpu_to_be64(pa);
+		odp->npages++;
 	}
 }
 
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index f99911b478c4..cb081c69fd1a 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -18,15 +18,9 @@ struct ib_umem_odp {
 	/* An array of the pfns included in the on-demand paging umem. */
 	unsigned long *pfn_list;
 
-	/*
-	 * An array with DMA addresses mapped for pfns in pfn_list.
-	 * The lower two bits designate access permissions.
-	 * See ODP_READ_ALLOWED_BIT and ODP_WRITE_ALLOWED_BIT.
-	 */
-	dma_addr_t		*dma_list;
 	struct dma_iova_state state;
 	/*
-	 * The umem_mutex protects the page_list and dma_list fields of an ODP
+	 * The umem_mutex protects the page_list field of an ODP
 	 * umem, allowing only a single thread to map/unmap pages. The mutex
 	 * also protects access to the mmu notifier counters.
 	 */
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 5354ddc3ac03..38d7b3239dbb 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -1108,7 +1108,7 @@ dma_addr_t dma_hmm_link_page(struct dma_iova_state *state, unsigned long *pfn,
 	struct page *page = hmm_pfn_to_page(*pfn);
 	phys_addr_t phys = page_to_phys(page);
 	bool coherent = dev_is_dma_coherent(dev);
-	dma_addr_t addr;
+	dma_addr_t addr = phys_to_dma(dev, phys);
 	int ret;
 
 	if (*pfn & HMM_PFN_DMA_MAPPED)
@@ -1123,8 +1123,7 @@ dma_addr_t dma_hmm_link_page(struct dma_iova_state *state, unsigned long *pfn,
 		 * The DMA address calculation below is based on the fact that
 		 * HMM doesn't work with swiotlb.
 		 */
-		return (state->addr) ? state->addr + dma_offset :
-				       phys_to_dma(dev, phys);
+		return (state->addr) ? state->addr + dma_offset : addr;
 
 	state->range_size = dma_offset;
 
@@ -1136,8 +1135,6 @@ dma_addr_t dma_hmm_link_page(struct dma_iova_state *state, unsigned long *pfn,
 	if (!use_dma_iommu(dev)) {
 		if (!coherent)
 			arch_sync_dma_for_device(phys, PAGE_SIZE, state->dir);
-
-		addr = phys_to_dma(dev, phys);
 		goto done;
 	}
 
-- 
2.46.0


