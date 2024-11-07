Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9DCD43369
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 14:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Izi4mvBFeqgZhbS+lxZlKvs6PIp3z3YnyysPqg81y8A=; b=sGUOonXLPSwfmRg3/hb8kcs4Ro
	CoGzQb4E4JKqsjttTtdPQcn9KQ0kqjHVs04Q99H4wC4Jeu2n2yXm/mxZyXVNj6O5fySHlN7jgoHlI
	zsM4gqGcCeZWjmTmua7xR6mjYBLCJybVnLrk8zxT1Jb0/1wEpsenStNd4CzR6yLc4To6vnaeRgh4w
	eB8c6rhXrOXCnO0w2j8cRfGDKXB1viaMwgpcBVzHk8IoPpGfPKrJ4vKKJfcN849JEA2GoqaoCnMmK
	zOo/s85hUcVGVF3WF/rxbV0P2O190oqmauHJfBoxNopiufXOEGUhbBkngl+Etvjn//hJzhBno7c+o
	rmTH8U4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t93uN-00000007Lmg-01rG;
	Thu, 07 Nov 2024 14:54:51 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t93qM-00000007KsD-2XkO
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 14:50:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7A2C0A444AC;
	Thu,  7 Nov 2024 14:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FA6C4CECC;
	Thu,  7 Nov 2024 14:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730991041;
	bh=jRpyuqPS/RfPxFE82RRibgYz8lq1+WOk8OnAFcqr9HY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HrTTNVLGr0k6BbKW0dEb6ZIQo/RQQdIVrWJQhWAQa6JALjw5Uelh67HLaTrZXT/Je
	 mIj8OIN2KIw7OAdV8IRlUiwd1QctmZrFFKGXfzc0aWRWBVRkbHZd3v4Ma0JjAH5r4o
	 RllAPWRCzhb8AxRbCdK9JWFR5uvuvXaq57Bcp6JVx0/+/n0Vcd0FTwQpD0C13UseaK
	 zsbYe92XLKd6seRM8ug+RJKv9lk+J/tjBGwOyqeU8B+pQc9OZ32dNHSW1nTVwFmSDB
	 FF5TUjLYtNLjZJdK1mLn10lmaVO1g0mDZm3TMUsuhwXHoQmZjhgnckwVIp3naxiGmO
	 N7zfMcFtrOHMw==
Date: Thu, 7 Nov 2024 16:50:34 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 07/17] dma-mapping: Implement link/unlink ranges API
Message-ID: <20241107145034.GO5006@unreal>
References: <cover.1730298502.git.leon@kernel.org>
 <f8c7f160c9ae97fef4ccd355f9979727552c7374.1730298502.git.leon@kernel.org>
 <51c5a5d5-6f90-4c42-b0ef-b87791e00f20@arm.com>
 <20241104091048.GA25041@lst.de>
 <20241104121924.GC35848@ziepe.ca>
 <20241104125302.GA11168@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104125302.GA11168@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_065042_801183_C282566C 
X-CRM114-Status: GOOD (  32.88  )
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

On Mon, Nov 04, 2024 at 01:53:02PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 04, 2024 at 08:19:24AM -0400, Jason Gunthorpe wrote:
> > > That's a good point.  Only mapped through host bridge P2P can even
> > > end up here, so the address is a perfectly valid physical address
> > > in the host.  But I'm not sure if all arch_sync_dma_for_device
> > > implementations handle IOMMU memory fine.
> > 
> > I was told on x86 if you do a cache flush operation on MMIO there is a
> > chance it will MCE. Recently had some similar discussions about ARM
> > where it was asserted some platforms may have similar.
> 
> On x86 we never flush caches for DMA operations anyway, so x86 isn't
> really the concern here, but architectures that do cache incoherent DMA
> to PCIe devices.  Which isn't a whole lot as most SOCs try to avoid that
> for PCIe even if they lack DMA coherent for lesser peripherals, but I bet
> there are some on arm/arm64 and maybe riscv or mips.
> 
> > It would be safest to only call arch flushing calls on memory that is
> > mapped cachable. We can assume that a P2P target is never CPU
> > mapped cachable, regardless of how the DMA is routed.
> 
> Yes.  I.e. force DMA_ATTR_SKIP_CPU_SYNC for P2P.

What do you think?

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 38bcb3ecceeb..065bdace3344 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -559,14 +559,19 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
 {
 	enum dma_data_direction dir = rq_dma_dir(req);
 	unsigned int mapped = 0;
+	unsigned long attrs = 0;
 	int error = 0;
 
 	iter->addr = state->addr;
 	iter->len = dma_iova_size(state);
+	if (req->cmd_flags & REQ_P2PDMA) {
+		attrs |= DMA_ATTR_SKIP_CPU_SYNC;
+		req->cmd_flags &= ~REQ_P2PDMA;
+	}
 
 	do {
 		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
-				vec->len, dir, 0);
+				vec->len, dir, attrs);
 		if (error)
 			goto error_unmap;
 		mapped += vec->len;
@@ -578,7 +583,7 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
 
 	return true;
 error_unmap:
-	dma_iova_destroy(dma_dev, state, mapped, rq_dma_dir(req), 0);
+	dma_iova_destroy(dma_dev, state, mapped, rq_dma_dir(req), attrs);
 	iter->status = errno_to_blk_status(error);
 	return false;
 }
@@ -633,7 +638,6 @@ bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
 			 * P2P transfers through the host bridge are treated the
 			 * same as non-P2P transfers below and during unmap.
 			 */
-			req->cmd_flags &= ~REQ_P2PDMA;
 			break;
 		default:
 			iter->status = BLK_STS_INVAL;
@@ -644,6 +648,8 @@ bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
 	if (blk_can_dma_map_iova(req, dma_dev) &&
 	    dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len))
 		return blk_rq_dma_map_iova(req, dma_dev, state, iter, &vec);
+
+	req->cmd_flags &= ~REQ_P2PDMA;
 	return blk_dma_map_direct(req, dma_dev, iter, &vec);
 }
 EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 62980ca8f3c5..5fe30fbc42b0 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -23,6 +23,7 @@ struct mmu_interval_notifier;
  * HMM_PFN_WRITE - if the page memory can be written to (requires HMM_PFN_VALID)
  * HMM_PFN_ERROR - accessing the pfn is impossible and the device should
  *                 fail. ie poisoned memory, special pages, no vma, etc
+ * HMM_PFN_P2PDMA - P@P page, not bus mapped
  * HMM_PFN_P2PDMA_BUS - Bus mapped P2P transfer
  * HMM_PFN_DMA_MAPPED - Flag preserved on input-to-output transformation
  *                      to mark that page is already DMA mapped
@@ -41,6 +42,7 @@ enum hmm_pfn_flags {
 	HMM_PFN_ERROR = 1UL << (BITS_PER_LONG - 3),
 
 	/* Sticky flag, carried from Input to Output */
+	HMM_PFN_P2PDMA     = 1UL << (BITS_PER_LONG - 5),
 	HMM_PFN_P2PDMA_BUS = 1UL << (BITS_PER_LONG - 6),
 	HMM_PFN_DMA_MAPPED = 1UL << (BITS_PER_LONG - 7),
 
diff --git a/mm/hmm.c b/mm/hmm.c
index 4ef2b3815212..b2ec199c2ea8 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -710,6 +710,7 @@ dma_addr_t hmm_dma_map_pfn(struct device *dev, struct hmm_dma_map *map,
 	struct page *page = hmm_pfn_to_page(pfns[idx]);
 	phys_addr_t paddr = hmm_pfn_to_phys(pfns[idx]);
 	size_t offset = idx * map->dma_entry_size;
+	unsigned long attrs = 0;
 	dma_addr_t dma_addr;
 	int ret;
 
@@ -740,6 +741,9 @@ dma_addr_t hmm_dma_map_pfn(struct device *dev, struct hmm_dma_map *map,
 
 	switch (pci_p2pdma_state(p2pdma_state, dev, page)) {
 	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+		attrs |= DMA_ATTR_SKIP_CPU_SYNC;
+		pfns[idx] |= HMM_PFN_P2PDMA;
+		fallthrough;
 	case PCI_P2PDMA_MAP_NONE:
 		break;
 	case PCI_P2PDMA_MAP_BUS_ADDR:
@@ -752,7 +756,8 @@ dma_addr_t hmm_dma_map_pfn(struct device *dev, struct hmm_dma_map *map,
 
 	if (dma_use_iova(state)) {
 		ret = dma_iova_link(dev, state, paddr, offset,
-				    map->dma_entry_size, DMA_BIDIRECTIONAL, 0);
+				    map->dma_entry_size, DMA_BIDIRECTIONAL,
+				    attrs);
 		if (ret)
 			return DMA_MAPPING_ERROR;
 
@@ -793,6 +798,7 @@ bool hmm_dma_unmap_pfn(struct device *dev, struct hmm_dma_map *map, size_t idx)
 	struct dma_iova_state *state = &map->state;
 	dma_addr_t *dma_addrs = map->dma_list;
 	unsigned long *pfns = map->pfn_list;
+	unsigned long attrs = 0;
 
 #define HMM_PFN_VALID_DMA (HMM_PFN_VALID | HMM_PFN_DMA_MAPPED)
 	if ((pfns[idx] & HMM_PFN_VALID_DMA) != HMM_PFN_VALID_DMA)
@@ -801,14 +807,16 @@ bool hmm_dma_unmap_pfn(struct device *dev, struct hmm_dma_map *map, size_t idx)
 
 	if (pfns[idx] & HMM_PFN_P2PDMA_BUS)
 		; /* no need to unmap bus address P2P mappings */
-	else if (dma_use_iova(state))
+	else if (dma_use_iova(state)) {
+		if (pfns[idx] & HMM_PFN_P2PDMA)
+			attrs |= DMA_ATTR_SKIP_CPU_SYNC;
 		dma_iova_unlink(dev, state, idx * map->dma_entry_size,
-				map->dma_entry_size, DMA_BIDIRECTIONAL, 0);
-	else if (dma_need_unmap(dev))
+				map->dma_entry_size, DMA_BIDIRECTIONAL, attrs);
+	} else if (dma_need_unmap(dev))
 		dma_unmap_page(dev, dma_addrs[idx], map->dma_entry_size,
 			       DMA_BIDIRECTIONAL);
 
-	pfns[idx] &= ~(HMM_PFN_DMA_MAPPED | HMM_PFN_P2PDMA_BUS);
+	pfns[idx] &= ~(HMM_PFN_DMA_MAPPED | HMM_PFN_P2PDMA | HMM_PFN_P2PDMA_BUS);
 	return true;
 }
 EXPORT_SYMBOL_GPL(hmm_dma_unmap_pfn);

