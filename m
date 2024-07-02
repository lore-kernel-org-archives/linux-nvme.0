Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86D0C41513
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 09:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9l3RqBQ3wmhiS4Devu11UR9cNpL8lZMERvC1jOBPYeU=; b=Oki1DFvOovvLdk5tEj3d9uHwkh
	QywUCbzH6gYk/dCGowCG1JMbPRM4yzgzEwqvUTbVTpNnXWL8TwmaHjAm9VVUwwHRHhhz01cQvi0Qt
	w/cq9blU/oaRInTCTaI+tIar9GrdHv5lU/sFS2xyK4vxVYKkujz2tQeOtyZf55whVnamr+HxiZ8zW
	x1ykwzmMn7UKjnw7DV4cpllRvR/0B46PApem7Eg8UTHHgLO62sT+q6XiUgOxNv6Pufq9G1t+uelEH
	ZWaKddoN0jfDZ0+9kc2YGv53oPweqsyXIIsLY3iUKUMXrCojxCg+oR+D2k0r+eQbyx+7g8f2SC1ZR
	pWGnHdig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOZWp-000000065MM-0WFq;
	Tue, 02 Jul 2024 09:10:23 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOZWl-000000065Ic-0rQM
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 09:10:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1FC19CE1CF5;
	Tue,  2 Jul 2024 09:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E09C4AF0E;
	Tue,  2 Jul 2024 09:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719911416;
	bh=r8LbBOjlbH4F69KVmFsNaHjJ/rODIFYYIWRpcAsJOVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DERWykstv7XxGRlK5d+9zV0EQM0MK52hTvvioFtFjlLgY6y7WByKUa78ayxSb4kv4
	 I+xUVII03CJetjfBvTMv9CMMhQJfzVzLz89kaGypwXqqSFHhbw4Gb2EbFJGDnfX17l
	 0aC4Byhh+gWLSP7xqntoErbx/0yPnHiKuF5CB/Xs9/iSM9GN7ebAkO6YOTDfK+Sr8y
	 dJtkIzyXzi0gzX+IoPLVGBHI3F2b9pwZ+KO31UXjhbL9I3Iuq75SeGIsrKaVl1FT3q
	 sHBmNAh3u7+dpLJB9+kZkDVxWvxbuHf4tfrlHP2fR8bQCt2MPqKJJkSIF05sdFYODC
	 r+/wFzkIKdacg==
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
Subject: [RFC PATCH v1 05/18] mm/hmm: let users to tag specific PFN with DMA mapped bit
Date: Tue,  2 Jul 2024 12:09:35 +0300
Message-ID: <769b6266d5e8638322f25550dd01a85515bf9d08.1719909395.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719909395.git.leon@kernel.org>
References: <cover.1719909395.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_021019_652636_DF5F4593 
X-CRM114-Status: GOOD (  16.64  )
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
by HMM range fault. Such flag allows users to tag specific PFNs with information
if this specific PFN was already DMA mapped.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/hmm.h |  4 ++++
 mm/hmm.c            | 34 +++++++++++++++++++++-------------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 126a36571667..2999697db83a 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -23,6 +23,8 @@ struct mmu_interval_notifier;
  * HMM_PFN_WRITE - if the page memory can be written to (requires HMM_PFN_VALID)
  * HMM_PFN_ERROR - accessing the pfn is impossible and the device should
  *                 fail. ie poisoned memory, special pages, no vma, etc
+ * HMM_PFN_DMA_MAPPED - Flag preserved on input-to-output transformation
+ * 			to mark that page is already DMA mapped
  *
  * On input:
  * 0                 - Return the current state of the page, do not fault it.
@@ -36,6 +38,8 @@ enum hmm_pfn_flags {
 	HMM_PFN_VALID = 1UL << (BITS_PER_LONG - 1),
 	HMM_PFN_WRITE = 1UL << (BITS_PER_LONG - 2),
 	HMM_PFN_ERROR = 1UL << (BITS_PER_LONG - 3),
+	/* Sticky lag, carried from Input to Output */
+	HMM_PFN_DMA_MAPPED = 1UL << (BITS_PER_LONG - 7),
 	HMM_PFN_ORDER_SHIFT = (BITS_PER_LONG - 8),
 
 	/* Input flags */
diff --git a/mm/hmm.c b/mm/hmm.c
index 93aebd9cc130..03aeb9929d9e 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -44,8 +44,10 @@ static int hmm_pfns_fill(unsigned long addr, unsigned long end,
 {
 	unsigned long i = (addr - range->start) >> PAGE_SHIFT;
 
-	for (; addr < end; addr += PAGE_SIZE, i++)
-		range->hmm_pfns[i] = cpu_flags;
+	for (; addr < end; addr += PAGE_SIZE, i++) {
+		range->hmm_pfns[i] &= HMM_PFN_DMA_MAPPED;
+		range->hmm_pfns[i] |= cpu_flags;
+	}
 	return 0;
 }
 
@@ -202,8 +204,10 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 		return hmm_vma_fault(addr, end, required_fault, walk);
 
 	pfn = pmd_pfn(pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++)
-		hmm_pfns[i] = pfn | cpu_flags;
+	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
+		hmm_pfns[i] &= HMM_PFN_DMA_MAPPED;
+		hmm_pfns[i] |= pfn | cpu_flags;
+	}
 	return 0;
 }
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
@@ -236,7 +240,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
 		if (required_fault)
 			goto fault;
-		*hmm_pfn = 0;
+		*hmm_pfn = *hmm_pfn & HMM_PFN_DMA_MAPPED;
 		return 0;
 	}
 
@@ -253,14 +257,14 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 			cpu_flags = HMM_PFN_VALID;
 			if (is_writable_device_private_entry(entry))
 				cpu_flags |= HMM_PFN_WRITE;
-			*hmm_pfn = swp_offset_pfn(entry) | cpu_flags;
+			*hmm_pfn = (*hmm_pfn & HMM_PFN_DMA_MAPPED) | swp_offset_pfn(entry) | cpu_flags;
 			return 0;
 		}
 
 		required_fault =
 			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
 		if (!required_fault) {
-			*hmm_pfn = 0;
+			*hmm_pfn = *hmm_pfn & HMM_PFN_DMA_MAPPED;
 			return 0;
 		}
 
@@ -304,11 +308,11 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 			pte_unmap(ptep);
 			return -EFAULT;
 		}
-		*hmm_pfn = HMM_PFN_ERROR;
+		*hmm_pfn = (*hmm_pfn & HMM_PFN_DMA_MAPPED) | HMM_PFN_ERROR;
 		return 0;
 	}
 
-	*hmm_pfn = pte_pfn(pte) | cpu_flags;
+	*hmm_pfn = (*hmm_pfn & HMM_PFN_DMA_MAPPED) | pte_pfn(pte) | cpu_flags;
 	return 0;
 
 fault:
@@ -448,8 +452,10 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 		}
 
 		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-		for (i = 0; i < npages; ++i, ++pfn)
-			hmm_pfns[i] = pfn | cpu_flags;
+		for (i = 0; i < npages; ++i, ++pfn) {
+			hmm_pfns[i] &= HMM_PFN_DMA_MAPPED;
+			hmm_pfns[i] |= pfn | cpu_flags;
+		}
 		goto out_unlock;
 	}
 
@@ -507,8 +513,10 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	}
 
 	pfn = pte_pfn(entry) + ((start & ~hmask) >> PAGE_SHIFT);
-	for (; addr < end; addr += PAGE_SIZE, i++, pfn++)
-		range->hmm_pfns[i] = pfn | cpu_flags;
+	for (; addr < end; addr += PAGE_SIZE, i++, pfn++) {
+		range->hmm_pfns[i] &= HMM_PFN_DMA_MAPPED;
+		range->hmm_pfns[i] |= pfn | cpu_flags;
+	}
 
 	spin_unlock(ptl);
 	return 0;
-- 
2.45.2


