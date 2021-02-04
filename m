Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7E6C433E6
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 19:31:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F8564D9D
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 19:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F8564D9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sz6xdIOdHXLOa6hGE25UYOFjpfvGg/6MkxMO7XMbbHw=; b=mhxBskUz7irprXh1udz0X7foi
	Zn+tvsSI7gt1FZ2f9mK+x5Y55f1cazr85A2OIaGBcJK6m2q3FjaLdeCRVbGPelK6RNYPsnNghouIv
	Q9y7DGXBSs9amt1ovoXJ/Y+6O5n3eVCRyqfh0x7VgMeuh5Q2LTr/6H3EzUZa/nerVbCTlPJ8zM2bf
	tEL71e9wAijs5aNv6kDlVHsFcQaPWtBQI6JayT1CT9KmTm7gB0Yr0yFyk+ot8jxqJdYFvEyRUdbw+
	CZR4lJqs4LLRptKV2DvT108AiVmHXO/ffW/kkDV+vzg9EJs2F6WJXpf2r/zu4NWoAwcsLonpCkN5c
	JrCKF+ELQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7kLR-0008Fu-Gl; Thu, 04 Feb 2021 19:31:13 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7kLA-00086x-Mz
 for linux-nvme@merlin.infradead.org; Thu, 04 Feb 2021 19:30:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=CIo5VDs2ltYoLrA8GdNf3ix/BoMo8kLdErBtNjgO7kY=; b=a1F4fOX29uswkceMTlQg3TIMyW
 UTDyEcuzYuB7bOoaUQy41O3JtYHHDB/eLqJzk1AItu2pMDrNT1IQHfgszgZm5s/F4A+vjJNyjgzqz
 90dpl+lgv74Bc1DYiLqn3oASoa4rFjROeJnUJ+GvA0M0Q6XCyqBN6uOKKVd1UPDUW9o59yQF6CiEV
 g7EMTGOtespvnAqNZHe+7XujJXsnPltPHFoxh5DgD8YDDzBOfCDmWqfNxgA8DMYI8wCP4unHWvApg
 Hi9KSUJ2XpWHqE2mnNDp7g+eL5g74FCmYIn1b4IcFDKGcx75xHEDTW9E6ZkmKHVoYG8pi4F2YgzgN
 Bnocmx0Q==;
Received: from [2001:4bb8:184:7d04:e998:f47:b9fb:7611] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l7kL8-001JjP-J7; Thu, 04 Feb 2021 19:30:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: jxgao@google.com,
	gregkh@linuxfoundation.org
Subject: [PATCH 7/8] swiotlb: respect min_align_mask
Date: Thu,  4 Feb 2021 20:30:34 +0100
Message-Id: <20210204193035.2606838-8-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210204193035.2606838-1-hch@lst.de>
References: <20210204193035.2606838-1-hch@lst.de>
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
Cc: saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 linux-nvme@lists.infradead.org, kbusch@kernel.org,
 iommu@lists.linux-foundation.org, erdemaktas@google.com, robin.murphy@arm.com,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Respect the min_align_mask in struct device_dma_parameters in swiotlb.

There are two parts to it:
 1) for the lower bits of the alignment inside the io tlb slot, just
    extent the size of the allocation and leave the start of the slot
     empty
 2) for the high bits ensure we find a slot that matches the high bits
    of the alignment to avoid wasting too much memory

Based on an earlier patch from Jianxiong Gao <jxgao@google.com>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 49 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 6a2439826a1ba4..ab3192142b9906 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -468,6 +468,18 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
 	}
 }
 
+/*
+ * Return the offset into a iotlb slot required to keep the device happy.
+ */
+static unsigned int swiotlb_align_offset(struct device *dev, u64 addr)
+{
+	unsigned min_align_mask = dma_get_min_align_mask(dev);
+
+	if (!min_align_mask)
+		return 0;
+	return addr & min_align_mask & ((1 << IO_TLB_SHIFT) - 1);
+}
+
 /*
  * Carefully handle integer overflow which can occur when boundary_mask == ~0UL.
  */
@@ -478,6 +490,16 @@ static inline unsigned long get_max_slots(unsigned long boundary_mask)
 	return nr_slots(boundary_mask + 1);
 }
 
+static inline bool check_alignment(phys_addr_t orig_addr,
+		dma_addr_t tbl_dma_addr, unsigned int index,
+		unsigned int min_align_mask)
+{
+	if (!min_align_mask)
+		return true;
+	return ((tbl_dma_addr + (index << IO_TLB_SHIFT)) & min_align_mask) ==
+		(orig_addr & min_align_mask);
+}
+
 static unsigned int wrap_index(unsigned int index)
 {
 	if (index >= io_tlb_nslabs)
@@ -489,9 +511,11 @@ static unsigned int wrap_index(unsigned int index)
  * Find a suitable number of IO TLB entries size that will fit this request and
  * allocate a buffer from that IO TLB pool.
  */
-static int find_slots(struct device *dev, size_t alloc_size,
-		dma_addr_t tbl_dma_addr)
+static int find_slots(struct device *dev, phys_addr_t orig_addr,
+		size_t alloc_size, dma_addr_t tbl_dma_addr)
 {
+	unsigned int min_align_mask = dma_get_min_align_mask(dev) &
+			~((1 << IO_TLB_SHIFT) - 1);
 	unsigned int max_slots = get_max_slots(dma_get_seg_boundary(dev));
 	unsigned int nslots = nr_slots(alloc_size), stride = 1;
 	unsigned int index, wrap, count = 0, i;
@@ -503,7 +527,9 @@ static int find_slots(struct device *dev, size_t alloc_size,
 	 * For mappings greater than or equal to a page, we limit the stride
 	 * (and hence alignment) to a page size.
 	 */
-	if (alloc_size >= PAGE_SIZE)
+	if (min_align_mask)
+		stride = (min_align_mask + 1) >> IO_TLB_SHIFT;
+	else if (alloc_size >= PAGE_SIZE)
 		stride <<= (PAGE_SHIFT - IO_TLB_SHIFT);
 
 	spin_lock_irqsave(&io_tlb_lock, flags);
@@ -512,6 +538,12 @@ static int find_slots(struct device *dev, size_t alloc_size,
 
 	index = wrap = wrap_index(ALIGN(io_tlb_index, stride));
 	do {
+		if (!check_alignment(orig_addr, tbl_dma_addr, index,
+				     min_align_mask)) {
+			index = wrap_index(index + 1);
+			continue;
+		}
+
 		/*
 		 * If we find a slot that indicates we have 'nslots' number of
 		 * contiguous buffers, we allocate the buffers from that slot
@@ -557,6 +589,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 {
 	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(dev, io_tlb_start) &
 			dma_get_seg_boundary(dev);
+	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
 	unsigned int index, i;
 	phys_addr_t tlb_addr;
 
@@ -572,7 +605,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
-	index = find_slots(dev, alloc_size, tbl_dma_addr);
+	alloc_size += offset;
+	index = find_slots(dev, orig_addr, alloc_size, tbl_dma_addr);
 	if (index == -1) {
 		if (!(attrs & DMA_ATTR_NO_WARN))
 			dev_warn_ratelimited(dev,
@@ -589,7 +623,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	for (i = 0; i < nr_slots(alloc_size); i++)
 		io_tlb_orig_addr[index + i] = orig_addr + (i << IO_TLB_SHIFT);
 
-	tlb_addr = io_tlb_start + (index << IO_TLB_SHIFT);
+	tlb_addr = io_tlb_start + (index << IO_TLB_SHIFT) + offset;
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
 		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
@@ -604,8 +638,9 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 			      enum dma_data_direction dir, unsigned long attrs)
 {
 	unsigned long flags;
-	int i, count, nslots = nr_slots(alloc_size);
-	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
+	unsigned int offset = swiotlb_align_offset(hwdev, tlb_addr);
+	int i, count, nslots = nr_slots(alloc_size + offset);
+	int index = (tlb_addr - offset - io_tlb_start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = io_tlb_orig_addr[index];
 
 	/*
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
