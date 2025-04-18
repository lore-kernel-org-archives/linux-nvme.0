Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AD6C369CA
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 16:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WG8lcd6o2n+dt2Qb+3KeVBaxZnHZiu15XEtc7tvNOUk=; b=A+hEzZVVEOS/GUonbW0W/PO6CL
	xrDH5FwbKZswMbTeuvsrEiBTqQI+fht/QKq6AbNWGBHltFc6cP/TOMD8cM5xX5tqVQRu3TR95YSJj
	TcurpXkT3n7jXauIfDkbmFR2REsnfbHTqG2mzYOHMcITfdQc1r/pYldGNAfvjb1cdGoRCYihcnFTn
	ACK9YAXTkGIj8mpYYmnv4JzXDnwQu888rtnj4KOsiMKxsFISIw2QIWNasf9o1l/bcnNtWw+Xz0Vvj
	QQHaIPoQ2VeyAYWkjcCTmXa8tKQKbJmct7FVIww/tX7DEsrk6vPO/bBNYp+43v2r1ZtCZoRBpnGCS
	cbZor0cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5onc-0000000Gzz1-3JJC;
	Fri, 18 Apr 2025 16:42:44 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5fWg-0000000FJSz-1vLS
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 06:48:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E53F844821;
	Fri, 18 Apr 2025 06:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6C6C4CEE2;
	Fri, 18 Apr 2025 06:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744958918;
	bh=bwZYS7t7aipTbZhzuM+nOmt9voRHtxEAZ2NbQn2AEac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PMzqbvZLVz6u0BLlY8BVSTF1Tzaj0IB6QlcytsBjcMXR0Vq5TqnLtjzxeMJFG6EZf
	 87EVNatEJsJ+MhBRMUMl/3smmRf84wLV/gcHBf+nM6UwLn/SM0zXin3XYVk8eNvmPd
	 IvHB/SR6YAL376Fx4EQ5AY8E8uil3Ks/7cDN4NdXi7X97Wsz6VzBpGjRylN9ItSia9
	 6nK6wF0YQV56//ML/sXgkFuHhqI0ej/GYQ68lOx4QO2x/Syr54x2LLs6AAQLNNe3cb
	 iGb2Rdu1nzTh48v7xaVqcanVC4DXs4yTpzwzguBV5fe+3IWAEHZ5oH15P5mM1MVDHX
	 CtLxdfiSNoQjw==
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
Subject: [PATCH v8 10/24] mm/hmm: let users to tag specific PFN with DMA mapped bit
Date: Fri, 18 Apr 2025 09:47:40 +0300
Message-ID: <4530281aa6f9846a54dd232ce5071f281cf0b570.1744825142.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744825142.git.leon@kernel.org>
References: <cover.1744825142.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_234838_552043_15FCBB4F 
X-CRM114-Status: GOOD (  21.23  )
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

Introduce new sticky flag (HMM_PFN_DMA_MAPPED), which isn't overwritten
by HMM range fault. Such flag allows users to tag specific PFNs with
information if this specific PFN was already DMA mapped.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/hmm.h | 17 +++++++++++++++
 mm/hmm.c            | 51 ++++++++++++++++++++++++++++-----------------
 2 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 126a36571667..a1ddbedc19c0 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -23,6 +23,8 @@ struct mmu_interval_notifier;
  * HMM_PFN_WRITE - if the page memory can be written to (requires HMM_PFN_VALID)
  * HMM_PFN_ERROR - accessing the pfn is impossible and the device should
  *                 fail. ie poisoned memory, special pages, no vma, etc
+ * HMM_PFN_DMA_MAPPED - Flag preserved on input-to-output transformation
+ *                      to mark that page is already DMA mapped
  *
  * On input:
  * 0                 - Return the current state of the page, do not fault it.
@@ -36,6 +38,13 @@ enum hmm_pfn_flags {
 	HMM_PFN_VALID = 1UL << (BITS_PER_LONG - 1),
 	HMM_PFN_WRITE = 1UL << (BITS_PER_LONG - 2),
 	HMM_PFN_ERROR = 1UL << (BITS_PER_LONG - 3),
+
+	/*
+	 * Sticky flags, carried from input to output,
+	 * don't forget to update HMM_PFN_INOUT_FLAGS
+	 */
+	HMM_PFN_DMA_MAPPED = 1UL << (BITS_PER_LONG - 7),
+
 	HMM_PFN_ORDER_SHIFT = (BITS_PER_LONG - 8),
 
 	/* Input flags */
@@ -57,6 +66,14 @@ static inline struct page *hmm_pfn_to_page(unsigned long hmm_pfn)
 	return pfn_to_page(hmm_pfn & ~HMM_PFN_FLAGS);
 }
 
+/*
+ * hmm_pfn_to_phys() - return physical address pointed to by a device entry
+ */
+static inline phys_addr_t hmm_pfn_to_phys(unsigned long hmm_pfn)
+{
+	return __pfn_to_phys(hmm_pfn & ~HMM_PFN_FLAGS);
+}
+
 /*
  * hmm_pfn_to_map_order() - return the CPU mapping size order
  *
diff --git a/mm/hmm.c b/mm/hmm.c
index 082f7b7c0b9e..51fe8b011cc7 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -39,13 +39,20 @@ enum {
 	HMM_NEED_ALL_BITS = HMM_NEED_FAULT | HMM_NEED_WRITE_FAULT,
 };
 
+enum {
+	/* These flags are carried from input-to-output */
+	HMM_PFN_INOUT_FLAGS = HMM_PFN_DMA_MAPPED,
+};
+
 static int hmm_pfns_fill(unsigned long addr, unsigned long end,
 			 struct hmm_range *range, unsigned long cpu_flags)
 {
 	unsigned long i = (addr - range->start) >> PAGE_SHIFT;
 
-	for (; addr < end; addr += PAGE_SIZE, i++)
-		range->hmm_pfns[i] = cpu_flags;
+	for (; addr < end; addr += PAGE_SIZE, i++) {
+		range->hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
+		range->hmm_pfns[i] |= cpu_flags;
+	}
 	return 0;
 }
 
@@ -202,8 +209,10 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 		return hmm_vma_fault(addr, end, required_fault, walk);
 
 	pfn = pmd_pfn(pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++)
-		hmm_pfns[i] = pfn | cpu_flags;
+	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
+		hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
+		hmm_pfns[i] |= pfn | cpu_flags;
+	}
 	return 0;
 }
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
@@ -230,14 +239,14 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	unsigned long cpu_flags;
 	pte_t pte = ptep_get(ptep);
 	uint64_t pfn_req_flags = *hmm_pfn;
+	uint64_t new_pfn_flags = 0;
 
 	if (pte_none_mostly(pte)) {
 		required_fault =
 			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
 		if (required_fault)
 			goto fault;
-		*hmm_pfn = 0;
-		return 0;
+		goto out;
 	}
 
 	if (!pte_present(pte)) {
@@ -253,16 +262,14 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 			cpu_flags = HMM_PFN_VALID;
 			if (is_writable_device_private_entry(entry))
 				cpu_flags |= HMM_PFN_WRITE;
-			*hmm_pfn = swp_offset_pfn(entry) | cpu_flags;
-			return 0;
+			new_pfn_flags = swp_offset_pfn(entry) | cpu_flags;
+			goto out;
 		}
 
 		required_fault =
 			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
-		if (!required_fault) {
-			*hmm_pfn = 0;
-			return 0;
-		}
+		if (!required_fault)
+			goto out;
 
 		if (!non_swap_entry(entry))
 			goto fault;
@@ -304,11 +311,13 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 			pte_unmap(ptep);
 			return -EFAULT;
 		}
-		*hmm_pfn = HMM_PFN_ERROR;
-		return 0;
+		new_pfn_flags = HMM_PFN_ERROR;
+		goto out;
 	}
 
-	*hmm_pfn = pte_pfn(pte) | cpu_flags;
+	new_pfn_flags = pte_pfn(pte) | cpu_flags;
+out:
+	*hmm_pfn = (*hmm_pfn & HMM_PFN_INOUT_FLAGS) | new_pfn_flags;
 	return 0;
 
 fault:
@@ -448,8 +457,10 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 		}
 
 		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-		for (i = 0; i < npages; ++i, ++pfn)
-			hmm_pfns[i] = pfn | cpu_flags;
+		for (i = 0; i < npages; ++i, ++pfn) {
+			hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
+			hmm_pfns[i] |= pfn | cpu_flags;
+		}
 		goto out_unlock;
 	}
 
@@ -507,8 +518,10 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	}
 
 	pfn = pte_pfn(entry) + ((start & ~hmask) >> PAGE_SHIFT);
-	for (; addr < end; addr += PAGE_SIZE, i++, pfn++)
-		range->hmm_pfns[i] = pfn | cpu_flags;
+	for (; addr < end; addr += PAGE_SIZE, i++, pfn++) {
+		range->hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
+		range->hmm_pfns[i] |= pfn | cpu_flags;
+	}
 
 	spin_unlock(ptl);
 	return 0;
-- 
2.49.0


