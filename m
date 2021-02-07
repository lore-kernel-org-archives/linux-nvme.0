Return-Path: <SRS0=2jH7=HJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4FDC433E6
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 16:04:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F7D764DF6
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 16:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7D764DF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dyuMeCEgHp+Y6PzFSjjohIZh8jzKFgT5TQJeVzUIg8s=; b=E1YiEoqEo1ezQ6UiKYAIhUSdG
	Y68IpggNGKoWkCYWk73DNRE3Il5Qb/kIp2wetCs2kIhm6GcTWLzeAJIEtM5ImwPwJDj3ePGTRreDC
	pvhk6c+PHYU4j9i5JXqUQVwqBJWRlU8+65ZPGZbslxxvh3FUsf0yno/OqJ/x/nNi6CD+lTTyx4BQ8
	wfJLqurp7IIIepfoPloLlTyCu5cuGll1/3uWITxpIKU8zsYiCumTdTZyh8NpeAKytRwOjlH3bFK5K
	kGZGS4C4ZxMTq69QDLSY17NOx9Wo2c1tVHJSB2ii7HhsOoSHxLUCd0BT+mm1KTbhjiKuRjnpvRb2j
	XUSEgo64A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l8mXT-0004qM-E1; Sun, 07 Feb 2021 16:03:55 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l8mXP-0004op-VA
 for linux-nvme@merlin.infradead.org; Sun, 07 Feb 2021 16:03:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=P2VjsEbMa6DUn4kH4ljL8IHLanLORae4Kn0TQUwBJwc=; b=G8BVZGDZU1zwnIL0427hAeTpsJ
 oy5PimlhiBe+6Cy4Sw9njhyTb2Cwfl923XAsxFVSWzyUiYBYmNP8AahaQ8G5Z9Posd02dfeeK7Qiy
 aRC6qTLBarABVsPwTYqrWuDTTebrc3USRRbfKMnDNhcYZrN+3mWYRfwXamVR6VRGAAo3+RizZ/v/O
 EkTMu7115BC5gXLeTXJczmWFng0qSzanNkY6x1DWCe5RCWmSY2bUrwIGcigRxB17o7VTM+4SCdmwy
 W6OPMDSZQh1LndAA0ZzSg/+V/l5GYCTIMyKqaZNbrTmJ42jU4rdPtGAilza+pDuY6k8xw5pJNbrxl
 9103yklA==;
Received: from [2001:4bb8:184:7d04:4590:5583:6cb7:77c7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l8mXN-004tOX-2k; Sun, 07 Feb 2021 16:03:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: jxgao@google.com,
	gregkh@linuxfoundation.org
Subject: [PATCH 6/9] swiotlb: refactor swiotlb_tbl_map_single
Date: Sun,  7 Feb 2021 17:03:24 +0100
Message-Id: <20210207160327.2955490-7-hch@lst.de>
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

Split out a bunch of a self-contained helpers to make the function easier
to follow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 179 +++++++++++++++++++++----------------------
 1 file changed, 89 insertions(+), 90 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index b38b1553c4663a..381c24ef1ac1d0 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -468,134 +468,133 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
 	}
 }
 
-phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
-		size_t mapping_size, size_t alloc_size,
-		enum dma_data_direction dir, unsigned long attrs)
-{
-	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(hwdev, io_tlb_start);
-	unsigned long flags;
-	phys_addr_t tlb_addr;
-	unsigned int nslots, stride, index, wrap;
-	int i;
-	unsigned long mask;
-	unsigned long offset_slots;
-	unsigned long max_slots;
-	unsigned long tmp_io_tlb_used;
-
-	if (no_iotlb_memory)
-		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
-
-	if (mem_encrypt_active())
-		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
+#define slot_addr(start, idx)	((start) + ((idx) << IO_TLB_SHIFT))
 
-	if (mapping_size > alloc_size) {
-		dev_warn_once(hwdev, "Invalid sizes (mapping: %zd bytes, alloc: %zd bytes)",
-			      mapping_size, alloc_size);
-		return (phys_addr_t)DMA_MAPPING_ERROR;
-	}
-
-	mask = dma_get_seg_boundary(hwdev);
+/*
+ * Carefully handle integer overflow which can occur when boundary_mask == ~0UL.
+ */
+static inline unsigned long get_max_slots(unsigned long boundary_mask)
+{
+	if (boundary_mask == ~0UL)
+		return 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
+	return nr_slots(boundary_mask + 1);
+}
 
-	tbl_dma_addr &= mask;
+static unsigned int wrap_index(unsigned int index)
+{
+	if (index >= io_tlb_nslabs)
+		return 0;
+	return index;
+}
 
-	offset_slots = nr_slots(tbl_dma_addr);
+/*
+ * Find a suitable number of IO TLB entries size that will fit this request and
+ * allocate a buffer from that IO TLB pool.
+ */
+static int find_slots(struct device *dev, size_t alloc_size)
+{
+	unsigned long boundary_mask = dma_get_seg_boundary(dev);
+	dma_addr_t tbl_dma_addr =
+		phys_to_dma_unencrypted(dev, io_tlb_start) & boundary_mask;
+	unsigned int max_slots = get_max_slots(boundary_mask);
+	unsigned int nslots = nr_slots(alloc_size), stride = 1;
+	unsigned int index, wrap, count = 0, i;
+	unsigned long flags;
 
-	/*
-	 * Carefully handle integer overflow which can occur when mask == ~0UL.
-	 */
-	max_slots = mask + 1
-		    ? nr_slots(mask + 1)
-		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
+	BUG_ON(!nslots);
 
 	/*
 	 * For mappings greater than or equal to a page, we limit the stride
 	 * (and hence alignment) to a page size.
 	 */
-	nslots = nr_slots(alloc_size);
 	if (alloc_size >= PAGE_SIZE)
-		stride = (1 << (PAGE_SHIFT - IO_TLB_SHIFT));
-	else
-		stride = 1;
+		stride <<= (PAGE_SHIFT - IO_TLB_SHIFT);
 
-	BUG_ON(!nslots);
-
-	/*
-	 * Find suitable number of IO TLB entries size that will fit this
-	 * request and allocate a buffer from that IO TLB pool.
-	 */
 	spin_lock_irqsave(&io_tlb_lock, flags);
-
 	if (unlikely(nslots > io_tlb_nslabs - io_tlb_used))
 		goto not_found;
 
-	index = ALIGN(io_tlb_index, stride);
-	if (index >= io_tlb_nslabs)
-		index = 0;
-	wrap = index;
-
+	index = wrap = wrap_index(ALIGN(io_tlb_index, stride));
 	do {
-		while (iommu_is_span_boundary(index, nslots, offset_slots,
-					      max_slots)) {
-			index += stride;
-			if (index >= io_tlb_nslabs)
-				index = 0;
-			if (index == wrap)
-				goto not_found;
-		}
-
 		/*
 		 * If we find a slot that indicates we have 'nslots' number of
 		 * contiguous buffers, we allocate the buffers from that slot
 		 * and mark the entries as '0' indicating unavailable.
 		 */
-		if (io_tlb_list[index] >= nslots) {
-			int count = 0;
-
-			for (i = index; i < (int) (index + nslots); i++)
-				io_tlb_list[i] = 0;
-			for (i = index - 1;
-			     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 &&
-			     io_tlb_list[i]; i--)
-				io_tlb_list[i] = ++count;
-			tlb_addr = io_tlb_start + (index << IO_TLB_SHIFT);
-
-			/*
-			 * Update the indices to avoid searching in the next
-			 * round.
-			 */
-			io_tlb_index = ((index + nslots) < io_tlb_nslabs
-					? (index + nslots) : 0);
-
-			goto found;
+		if (!iommu_is_span_boundary(index, nslots,
+					    nr_slots(tbl_dma_addr),
+					    max_slots)) {
+			if (io_tlb_list[index] >= nslots)
+				goto found;
 		}
-		index += stride;
-		if (index >= io_tlb_nslabs)
-			index = 0;
+		index = wrap_index(index + stride);
 	} while (index != wrap);
 
 not_found:
-	tmp_io_tlb_used = io_tlb_used;
-
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
-	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
-		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
-			 alloc_size, io_tlb_nslabs, tmp_io_tlb_used);
-	return (phys_addr_t)DMA_MAPPING_ERROR;
+	return -1;
+
 found:
+	for (i = index; i < index + nslots; i++)
+		io_tlb_list[i] = 0;
+	for (i = index - 1;
+	     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 &&
+	     io_tlb_list[i]; i--)
+		io_tlb_list[i] = ++count;
+
+	/*
+	 * Update the indices to avoid searching in the next round.
+	 */
+	if (index + nslots < io_tlb_nslabs)
+		io_tlb_index = index + nslots;
+	else
+		io_tlb_index = 0;
 	io_tlb_used += nslots;
+
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
+	return index;
+}
+
+phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
+		size_t mapping_size, size_t alloc_size,
+		enum dma_data_direction dir, unsigned long attrs)
+{
+	unsigned int index, i;
+	phys_addr_t tlb_addr;
+
+	if (no_iotlb_memory)
+		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
+
+	if (mem_encrypt_active())
+		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
+
+	if (mapping_size > alloc_size) {
+		dev_warn_once(dev, "Invalid sizes (mapping: %zd bytes, alloc: %zd bytes)",
+			      mapping_size, alloc_size);
+		return (phys_addr_t)DMA_MAPPING_ERROR;
+	}
+
+	index = find_slots(dev, alloc_size);
+	if (index == -1) {
+		if (!(attrs & DMA_ATTR_NO_WARN))
+			dev_warn_ratelimited(dev,
+	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
+				 alloc_size, io_tlb_nslabs, io_tlb_used);
+		return (phys_addr_t)DMA_MAPPING_ERROR;
+	}
 
 	/*
 	 * Save away the mapping from the original address to the DMA address.
 	 * This is needed when we sync the memory.  Then we sync the buffer if
 	 * needed.
 	 */
-	for (i = 0; i < nslots; i++)
-		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
+	for (i = 0; i < nr_slots(alloc_size); i++)
+		io_tlb_orig_addr[index + i] = slot_addr(orig_addr, i);
+
+	tlb_addr = slot_addr(io_tlb_start, index);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
 		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
-
 	return tlb_addr;
 }
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
