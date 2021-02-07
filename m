Return-Path: <SRS0=2jH7=HJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F184BC433E0
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 16:04:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B041E64E40
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 16:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B041E64E40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7wIHNrKmcWp02j60TzZHtaFldiWhFWTn78VjTi+w6WQ=; b=zZG2fS1Hj+h+B+eAzllUOTjNN
	OAkHFLk9Rg5Sx4evACemzFUmrd9NeAloPHCdTW1qsSzsquZ1er+6+ZG+uz5/RQ7lzjBYsQX7Ll8YF
	74NDt3WKnGUu6Xg2xf5V1QxhZN1gRHDnCEFJHNmjTewn644jRiEU6xdr2m5eVkaebJrHud5Sa2QsR
	ug+LsBJ/L04BcoR4qbPxVIe+8+D4ZQGWOF/spNkYjTfAdTQgCf7ARM/qU7AJbWbs3Hc3B4q2+BDN+
	hqCmbiIzeF3gboTw4AK3ObLFa6I4FK9YpOfIRB0Xl6W5aENLkj/Q8GuNN6/rL9busgxPVKpXSLgdx
	3h2ZeNllA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l8mXc-0004uQ-1o; Sun, 07 Feb 2021 16:04:04 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l8mXY-0004su-HN
 for linux-nvme@merlin.infradead.org; Sun, 07 Feb 2021 16:04:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=ubOlCUGHJri/4twyQ0EfD+rGfZwkXK2LGVnk3cdA+Rs=; b=BFltfNeYkCuYP5FgFjA0HKESjW
 A0NgNG+YiVFFNaw5Yyz5iwPfTbI+qZ6U/5axVCo1QMNeoPQVUArNAHwzo0xFkmDy1EXKob3IQ8DPt
 Kk5q08sxfvEjJTMw89Ac81JmwqMJst9+CH1weT+TBVWbtLlX1ijsJYDweJaxyzRo/pHeHRV2R4keK
 Iz5FOlxH7csMHAkJN7L5z1WYvcKr5R6lmfcG7XR6wWofeJbF7HfGvsHbMxRmRJuSQJ2fvbKUeCSRy
 7B7viVFT+dJUgTYwcKOfxdfIkBsOKVNCK5vq0qkvoQcMJbng4tyEAnZg43nK7GNFlWXPcqxT+nu1z
 p1fEe67w==;
Received: from [2001:4bb8:184:7d04:4590:5583:6cb7:77c7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l8mXS-004tPC-8f; Sun, 07 Feb 2021 16:03:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: jxgao@google.com,
	gregkh@linuxfoundation.org
Subject: [PATCH 8/9] swiotlb: respect min_align_mask
Date: Sun,  7 Feb 2021 17:03:26 +0100
Message-Id: <20210207160327.2955490-9-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210207160327.2955490-1-hch@lst.de>
References: <20210207160327.2955490-1-hch@lst.de>
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
 kernel/dma/swiotlb.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8eb84c337fe90c..adcc3c87e10078 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -470,6 +470,14 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
 
 #define slot_addr(start, idx)	((start) + ((idx) << IO_TLB_SHIFT))
 
+/*
+ * Return the offset into a iotlb slot required to keep the device happy.
+ */
+static unsigned int swiotlb_align_offset(struct device *dev, u64 addr)
+{
+	return addr & dma_get_min_align_mask(dev) & (IO_TLB_SIZE - 1);
+}
+
 /*
  * Carefully handle integer overflow which can occur when boundary_mask == ~0UL.
  */
@@ -491,24 +499,29 @@ static unsigned int wrap_index(unsigned int index)
  * Find a suitable number of IO TLB entries size that will fit this request and
  * allocate a buffer from that IO TLB pool.
  */
-static int find_slots(struct device *dev, size_t alloc_size)
+static int find_slots(struct device *dev, phys_addr_t orig_addr,
+		size_t alloc_size)
 {
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
 	dma_addr_t tbl_dma_addr =
 		phys_to_dma_unencrypted(dev, io_tlb_start) & boundary_mask;
 	unsigned int max_slots = get_max_slots(boundary_mask);
-	unsigned int nslots = nr_slots(alloc_size), stride = 1;
+	unsigned int iotlb_align_mask =
+		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
+	unsigned int nslots = nr_slots(alloc_size), stride;
 	unsigned int index, wrap, count = 0, i;
 	unsigned long flags;
 
 	BUG_ON(!nslots);
 
 	/*
-	 * For mappings greater than or equal to a page, we limit the stride
-	 * (and hence alignment) to a page size.
+	 * For mappings with an alignment requirement don't bother looping to
+	 * unaligned slots once we found an aligned one.  For allocations of
+	 * PAGE_SIZE or larger only look for page aligned allocations.
 	 */
+	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
 	if (alloc_size >= PAGE_SIZE)
-		stride <<= (PAGE_SHIFT - IO_TLB_SHIFT);
+		stride = max(stride, stride << (PAGE_SHIFT - IO_TLB_SHIFT));
 
 	spin_lock_irqsave(&io_tlb_lock, flags);
 	if (unlikely(nslots > io_tlb_nslabs - io_tlb_used))
@@ -516,6 +529,12 @@ static int find_slots(struct device *dev, size_t alloc_size)
 
 	index = wrap = wrap_index(ALIGN(io_tlb_index, stride));
 	do {
+		if ((slot_addr(tbl_dma_addr, index) & iotlb_align_mask) !=
+		    (orig_addr & iotlb_align_mask)) {
+			index = wrap_index(index + 1);
+			continue;
+		}
+
 		/*
 		 * If we find a slot that indicates we have 'nslots' number of
 		 * contiguous buffers, we allocate the buffers from that slot
@@ -559,6 +578,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		size_t mapping_size, size_t alloc_size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
+	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
 	unsigned int index, i;
 	phys_addr_t tlb_addr;
 
@@ -574,7 +594,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
-	index = find_slots(dev, alloc_size);
+	index = find_slots(dev, orig_addr, alloc_size + offset);
 	if (index == -1) {
 		if (!(attrs & DMA_ATTR_NO_WARN))
 			dev_warn_ratelimited(dev,
@@ -588,10 +608,10 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	 * This is needed when we sync the memory.  Then we sync the buffer if
 	 * needed.
 	 */
-	for (i = 0; i < nr_slots(alloc_size); i++)
+	for (i = 0; i < nr_slots(alloc_size + offset); i++)
 		io_tlb_orig_addr[index + i] = slot_addr(orig_addr, i);
 
-	tlb_addr = slot_addr(io_tlb_start, index);
+	tlb_addr = slot_addr(io_tlb_start, index) + offset;
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
 		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
@@ -606,8 +626,9 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
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
