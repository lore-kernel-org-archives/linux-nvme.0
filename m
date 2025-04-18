Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512FEC369D0
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 16:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sGSFKq2bjpcbVf5CrtQQJgdMX/Q300nWNnKAUsjWfHg=; b=cZmGfpF1z2l0EBGtxT/ok6gBk2
	0sREM5UgejjNWIMi8kPCnzzuVQxhiUVncQKszjQJ8FtDcnr399iGmfXmHD4R21VlXHxcZgLxmq6E7
	zPD01wxf29Jrm50xvTppWAAPbco/Nlfg+9SM6Gm5zN6FxPyPfRv0nRPbVMFpmYjIIRqMi/8zz1U3K
	xOPGDhA/DOp7dv7AbT9A7ySAZwECJftzrJ6+MmZIs+2pK02a+NWQkPY6ToRfucYII+g82oEUTCLpq
	GqaNSNHPRmUvHkFAgl4DuYmv5lHUGIPKZwkfB+zoqISRnDcnSd/Yf4U6+iF4LGojpF/W3R17H8PNh
	gk4TsHdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5ond-0000000H00k-3bYJ;
	Fri, 18 Apr 2025 16:42:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5fWk-0000000FJVb-2Ane
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 06:48:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 48B8D61137;
	Fri, 18 Apr 2025 06:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36D3C4CEE2;
	Fri, 18 Apr 2025 06:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744958921;
	bh=cqnRHSI3A0SPBMSXE0VihLmiV/XWEj+5iunBvjKyKeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U5Fc6xCkUVnudfp8hglXxiiE58xRlURonsSw8Qj3DhAU8RgP3b6Ih4dOzg7VaKUbh
	 +x/tDGWfx8VkqBhd+leYqYqZnyOafxgvNyjZ+Z8pdy54Bp01vwFeSVYUzppWu3RtBB
	 Ba7V3Lf/cvF5FoOqXFP0kiY5sPkqbb6xyjvQYenKhAKAmg98Jufg7cDMvmR4P+ZaTM
	 9m3f4HrwbMPD2uhTgyHAd0vY9N9vH54R1PwvgxIz2UjvDNMxbSTBbl8W4hDCXCUsRE
	 jEb6k0JH9oFIT9BrM+QShzhjwXvjzXbSvsjkIyl2LXz/soW450Lj3jz0htAYSmaw/6
	 xaovG4Mh87Atw==
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
Subject: [PATCH v8 11/24] mm/hmm: provide generic DMA managing logic
Date: Fri, 18 Apr 2025 09:47:41 +0300
Message-ID: <2a57edbcd266f58f1a4ac896352fb17b2e6d255c.1744825142.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744825142.git.leon@kernel.org>
References: <cover.1744825142.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Apr 2025 09:39:28 -0700
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

HMM callers use PFN list to populate range while calling
to hmm_range_fault(), the conversion from PFN to DMA address
is done by the callers with help of another DMA list. However,
it is wasteful on any modern platform and by doing the right
logic, that DMA list can be avoided.

Provide generic logic to manage these lists and gave an interface
to map/unmap PFNs to DMA addresses, without requiring from the callers
to be an experts in DMA core API.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/hmm-dma.h |  33 ++++++
 include/linux/hmm.h     |   4 +
 mm/hmm.c                | 215 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 251 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/hmm-dma.h

diff --git a/include/linux/hmm-dma.h b/include/linux/hmm-dma.h
new file mode 100644
index 000000000000..f58b9fc71999
--- /dev/null
+++ b/include/linux/hmm-dma.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
+#ifndef LINUX_HMM_DMA_H
+#define LINUX_HMM_DMA_H
+
+#include <linux/dma-mapping.h>
+
+struct dma_iova_state;
+struct pci_p2pdma_map_state;
+
+/*
+ * struct hmm_dma_map - array of PFNs and DMA addresses
+ *
+ * @state: DMA IOVA state
+ * @pfns: array of PFNs
+ * @dma_list: array of DMA addresses
+ * @dma_entry_size: size of each DMA entry in the array
+ */
+struct hmm_dma_map {
+	struct dma_iova_state state;
+	unsigned long *pfn_list;
+	dma_addr_t *dma_list;
+	size_t dma_entry_size;
+};
+
+int hmm_dma_map_alloc(struct device *dev, struct hmm_dma_map *map,
+		      size_t nr_entries, size_t dma_entry_size);
+void hmm_dma_map_free(struct device *dev, struct hmm_dma_map *map);
+dma_addr_t hmm_dma_map_pfn(struct device *dev, struct hmm_dma_map *map,
+			   size_t idx,
+			   struct pci_p2pdma_map_state *p2pdma_state);
+bool hmm_dma_unmap_pfn(struct device *dev, struct hmm_dma_map *map, size_t idx);
+#endif /* LINUX_HMM_DMA_H */
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index a1ddbedc19c0..1bc33e4c20ea 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -23,6 +23,8 @@ struct mmu_interval_notifier;
  * HMM_PFN_WRITE - if the page memory can be written to (requires HMM_PFN_VALID)
  * HMM_PFN_ERROR - accessing the pfn is impossible and the device should
  *                 fail. ie poisoned memory, special pages, no vma, etc
+ * HMM_PFN_P2PDMA - P2P page
+ * HMM_PFN_P2PDMA_BUS - Bus mapped P2P transfer
  * HMM_PFN_DMA_MAPPED - Flag preserved on input-to-output transformation
  *                      to mark that page is already DMA mapped
  *
@@ -43,6 +45,8 @@ enum hmm_pfn_flags {
 	 * Sticky flags, carried from input to output,
 	 * don't forget to update HMM_PFN_INOUT_FLAGS
 	 */
+	HMM_PFN_P2PDMA     = 1UL << (BITS_PER_LONG - 5),
+	HMM_PFN_P2PDMA_BUS = 1UL << (BITS_PER_LONG - 6),
 	HMM_PFN_DMA_MAPPED = 1UL << (BITS_PER_LONG - 7),
 
 	HMM_PFN_ORDER_SHIFT = (BITS_PER_LONG - 8),
diff --git a/mm/hmm.c b/mm/hmm.c
index 51fe8b011cc7..e23ab4ee3994 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -10,6 +10,7 @@
  */
 #include <linux/pagewalk.h>
 #include <linux/hmm.h>
+#include <linux/hmm-dma.h>
 #include <linux/init.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
@@ -23,6 +24,7 @@
 #include <linux/sched/mm.h>
 #include <linux/jump_label.h>
 #include <linux/dma-mapping.h>
+#include <linux/pci-p2pdma.h>
 #include <linux/mmu_notifier.h>
 #include <linux/memory_hotplug.h>
 
@@ -41,7 +43,8 @@ enum {
 
 enum {
 	/* These flags are carried from input-to-output */
-	HMM_PFN_INOUT_FLAGS = HMM_PFN_DMA_MAPPED,
+	HMM_PFN_INOUT_FLAGS = HMM_PFN_DMA_MAPPED | HMM_PFN_P2PDMA |
+			      HMM_PFN_P2PDMA_BUS,
 };
 
 static int hmm_pfns_fill(unsigned long addr, unsigned long end,
@@ -620,3 +623,213 @@ int hmm_range_fault(struct hmm_range *range)
 	return ret;
 }
 EXPORT_SYMBOL(hmm_range_fault);
+
+/**
+ * hmm_dma_map_alloc - Allocate HMM map structure
+ * @dev: device to allocate structure for
+ * @map: HMM map to allocate
+ * @nr_entries: number of entries in the map
+ * @dma_entry_size: size of the DMA entry in the map
+ *
+ * Allocate the HMM map structure and all the lists it contains.
+ * Return 0 on success, -ENOMEM on failure.
+ */
+int hmm_dma_map_alloc(struct device *dev, struct hmm_dma_map *map,
+		      size_t nr_entries, size_t dma_entry_size)
+{
+	bool dma_need_sync = false;
+	bool use_iova;
+
+	if (!(nr_entries * PAGE_SIZE / dma_entry_size))
+		return -EINVAL;
+
+	/*
+	 * The HMM API violates our normal DMA buffer ownership rules and can't
+	 * transfer buffer ownership.  The dma_addressing_limited() check is a
+	 * best approximation to ensure no swiotlb buffering happens.
+	 */
+#ifdef CONFIG_DMA_NEED_SYNC
+	dma_need_sync = !dev->dma_skip_sync;
+#endif /* CONFIG_DMA_NEED_SYNC */
+	if (dma_need_sync || dma_addressing_limited(dev))
+		return -EOPNOTSUPP;
+
+	map->dma_entry_size = dma_entry_size;
+	map->pfn_list =
+		kvcalloc(nr_entries, sizeof(*map->pfn_list), GFP_KERNEL);
+	if (!map->pfn_list)
+		return -ENOMEM;
+
+	use_iova = dma_iova_try_alloc(dev, &map->state, 0,
+			nr_entries * PAGE_SIZE);
+	if (!use_iova && dma_need_unmap(dev)) {
+		map->dma_list = kvcalloc(nr_entries, sizeof(*map->dma_list),
+					 GFP_KERNEL);
+		if (!map->dma_list)
+			goto err_dma;
+	}
+	return 0;
+
+err_dma:
+	kvfree(map->pfn_list);
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(hmm_dma_map_alloc);
+
+/**
+ * hmm_dma_map_free - iFree HMM map structure
+ * @dev: device to free structure from
+ * @map: HMM map containing the various lists and state
+ *
+ * Free the HMM map structure and all the lists it contains.
+ */
+void hmm_dma_map_free(struct device *dev, struct hmm_dma_map *map)
+{
+	if (dma_use_iova(&map->state))
+		dma_iova_free(dev, &map->state);
+	kvfree(map->pfn_list);
+	kvfree(map->dma_list);
+}
+EXPORT_SYMBOL_GPL(hmm_dma_map_free);
+
+/**
+ * hmm_dma_map_pfn - Map a physical HMM page to DMA address
+ * @dev: Device to map the page for
+ * @map: HMM map
+ * @idx: Index into the PFN and dma address arrays
+ * @p2pdma_state: PCI P2P state.
+ *
+ * dma_alloc_iova() allocates IOVA based on the size specified by their use in
+ * iova->size. Call this function after IOVA allocation to link whole @page
+ * to get the DMA address. Note that very first call to this function
+ * will have @offset set to 0 in the IOVA space allocated from
+ * dma_alloc_iova(). For subsequent calls to this function on same @iova,
+ * @offset needs to be advanced by the caller with the size of previous
+ * page that was linked + DMA address returned for the previous page that was
+ * linked by this function.
+ */
+dma_addr_t hmm_dma_map_pfn(struct device *dev, struct hmm_dma_map *map,
+			   size_t idx,
+			   struct pci_p2pdma_map_state *p2pdma_state)
+{
+	struct dma_iova_state *state = &map->state;
+	dma_addr_t *dma_addrs = map->dma_list;
+	unsigned long *pfns = map->pfn_list;
+	struct page *page = hmm_pfn_to_page(pfns[idx]);
+	phys_addr_t paddr = hmm_pfn_to_phys(pfns[idx]);
+	size_t offset = idx * map->dma_entry_size;
+	unsigned long attrs = 0;
+	dma_addr_t dma_addr;
+	int ret;
+
+	if ((pfns[idx] & HMM_PFN_DMA_MAPPED) &&
+	    !(pfns[idx] & HMM_PFN_P2PDMA_BUS)) {
+		/*
+		 * We are in this flow when there is a need to resync flags,
+		 * for example when page was already linked in prefetch call
+		 * with READ flag and now we need to add WRITE flag
+		 *
+		 * This page was already programmed to HW and we don't want/need
+		 * to unlink and link it again just to resync flags.
+		 */
+		if (dma_use_iova(state))
+			return state->addr + offset;
+
+		/*
+		 * Without dma_need_unmap, the dma_addrs array is NULL, thus we
+		 * need to regenerate the address below even if there already
+		 * was a mapping. But !dma_need_unmap implies that the
+		 * mapping stateless, so this is fine.
+		 */
+		if (dma_need_unmap(dev))
+			return dma_addrs[idx];
+
+		/* Continue to remapping */
+	}
+
+	switch (pci_p2pdma_state(p2pdma_state, dev, page)) {
+	case PCI_P2PDMA_MAP_NONE:
+		break;
+	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+		attrs |= DMA_ATTR_SKIP_CPU_SYNC;
+		pfns[idx] |= HMM_PFN_P2PDMA;
+		break;
+	case PCI_P2PDMA_MAP_BUS_ADDR:
+		pfns[idx] |= HMM_PFN_P2PDMA_BUS | HMM_PFN_DMA_MAPPED;
+		return pci_p2pdma_bus_addr_map(p2pdma_state, paddr);
+	default:
+		return DMA_MAPPING_ERROR;
+	}
+
+	if (dma_use_iova(state)) {
+		ret = dma_iova_link(dev, state, paddr, offset,
+				    map->dma_entry_size, DMA_BIDIRECTIONAL,
+				    attrs);
+		if (ret)
+			goto error;
+
+		ret = dma_iova_sync(dev, state, offset, map->dma_entry_size);
+		if (ret) {
+			dma_iova_unlink(dev, state, offset, map->dma_entry_size,
+					DMA_BIDIRECTIONAL, attrs);
+			goto error;
+		}
+
+		dma_addr = state->addr + offset;
+	} else {
+		if (WARN_ON_ONCE(dma_need_unmap(dev) && !dma_addrs))
+			goto error;
+
+		dma_addr = dma_map_page(dev, page, 0, map->dma_entry_size,
+					DMA_BIDIRECTIONAL);
+		if (dma_mapping_error(dev, dma_addr))
+			goto error;
+
+		if (dma_need_unmap(dev))
+			dma_addrs[idx] = dma_addr;
+	}
+	pfns[idx] |= HMM_PFN_DMA_MAPPED;
+	return dma_addr;
+error:
+	pfns[idx] &= ~HMM_PFN_P2PDMA;
+	return DMA_MAPPING_ERROR;
+
+}
+EXPORT_SYMBOL_GPL(hmm_dma_map_pfn);
+
+/**
+ * hmm_dma_unmap_pfn - Unmap a physical HMM page from DMA address
+ * @dev: Device to unmap the page from
+ * @map: HMM map
+ * @idx: Index of the PFN to unmap
+ *
+ * Returns true if the PFN was mapped and has been unmapped, false otherwise.
+ */
+bool hmm_dma_unmap_pfn(struct device *dev, struct hmm_dma_map *map, size_t idx)
+{
+	struct dma_iova_state *state = &map->state;
+	dma_addr_t *dma_addrs = map->dma_list;
+	unsigned long *pfns = map->pfn_list;
+	unsigned long attrs = 0;
+
+#define HMM_PFN_VALID_DMA (HMM_PFN_VALID | HMM_PFN_DMA_MAPPED)
+	if ((pfns[idx] & HMM_PFN_VALID_DMA) != HMM_PFN_VALID_DMA)
+		return false;
+#undef HMM_PFN_VALID_DMA
+
+	if (pfns[idx] & HMM_PFN_P2PDMA_BUS)
+		; /* no need to unmap bus address P2P mappings */
+	else if (dma_use_iova(state)) {
+		if (pfns[idx] & HMM_PFN_P2PDMA)
+			attrs |= DMA_ATTR_SKIP_CPU_SYNC;
+		dma_iova_unlink(dev, state, idx * map->dma_entry_size,
+				map->dma_entry_size, DMA_BIDIRECTIONAL, attrs);
+	} else if (dma_need_unmap(dev))
+		dma_unmap_page(dev, dma_addrs[idx], map->dma_entry_size,
+			       DMA_BIDIRECTIONAL);
+
+	pfns[idx] &=
+		~(HMM_PFN_DMA_MAPPED | HMM_PFN_P2PDMA | HMM_PFN_P2PDMA_BUS);
+	return true;
+}
+EXPORT_SYMBOL_GPL(hmm_dma_unmap_pfn);
-- 
2.49.0


