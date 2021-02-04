Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E02C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 19:30:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF9764F38
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 19:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF9764F38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kydmkkIlCJL91dcHru5L3JWq/yP7E1IXgYKmwK0RwQ4=; b=YV2PVsGllmh18X4ayh4viZNa1
	p/gTjDlEd5V8j7SxEzdG5F8fR314BHnAUZQSG7VvYh6zbyGq1j3hQ3S16xL3joejYZk5RkqnagWLy
	MScyuOwtlX7NsFPJ66biYcsl2WYQlvEzIJbI8FVhvSAsTeLGK/WUzdwU1fw+LUGQh/2wJAhBVsnaR
	mbpYUuh+Rluy3oTVDZYVpFpfwC8x++IM/Lb15cs1q+LX33HxoMSWNaluZ6DvQGT5rCOgC+TX7PYsx
	Yf5sFFxBFxtRUrgF1/NPea1PwPWxNizDjMb6m2lvvWV5JgK7Cc/UfELxaVfeUDCdySUpJJKqGEUPv
	x6L31dENg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7kL8-00086F-Iy; Thu, 04 Feb 2021 19:30:54 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7kL1-00083e-78
 for linux-nvme@merlin.infradead.org; Thu, 04 Feb 2021 19:30:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=oQiiO5Mmj4ynAqP+O8eOtHfBLcYiuclHcIvWqqgANZk=; b=s16Aw8S9+ROQYrLSZ9xJGb5FFQ
 f45Q7cZJVE8ES8qJ5bVbrxiziBI2OgjvmOX4TaDTIPP+JCoW8VwBLQHc3HVVMcKijTxAsXvdA5DIB
 tfsC4C/9GND2Y6RfdrNUIBwhodl0Bk+tVZ0aCK+qs/ktXhYR7Zv4whcvrhPUGOorxIDBT4QVC1Qwz
 NbZJaKOVOTvp9XC2ffWEQBlGD00jVCVE3Sp/EeVH/V4rTSwLHTcAXijzGQsLgzX/nCy8AHnhhknbh
 N7saozsgNMlx8o/Pe1OcGposesh+UETkMV24wfhYXcWXImO5EmJwkU03/wJTBRr0rKKZTb0RMW6FV
 6IE/Lz4Q==;
Received: from [2001:4bb8:184:7d04:e998:f47:b9fb:7611] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l7kKz-001Jhy-6Q; Thu, 04 Feb 2021 19:30:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: jxgao@google.com,
	gregkh@linuxfoundation.org
Subject: [PATCH 3/8] swiotlb: factor out a nr_slots helper
Date: Thu,  4 Feb 2021 20:30:30 +0100
Message-Id: <20210204193035.2606838-4-hch@lst.de>
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

Factor out a helper to find the number of slots for a given size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 838dbad10ab916..0c0b81799edbdb 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -194,6 +194,11 @@ static inline unsigned long io_tlb_offset(unsigned long val)
 	return val & (IO_TLB_SEGSIZE - 1);
 }
 
+static unsigned long nr_slots(u64 val)
+{
+	return ALIGN(val, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+}
+
 /*
  * Early SWIOTLB allocation may be too early to allow an architecture to
  * perform the desired operations.  This function allows the architecture to
@@ -493,20 +498,20 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 
 	tbl_dma_addr &= mask;
 
-	offset_slots = ALIGN(tbl_dma_addr, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	offset_slots = nr_slots(tbl_dma_addr);
 
 	/*
 	 * Carefully handle integer overflow which can occur when mask == ~0UL.
 	 */
 	max_slots = mask + 1
-		    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
+		    ? nr_slots(mask + 1)
 		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
 
 	/*
 	 * For mappings greater than or equal to a page, we limit the stride
 	 * (and hence alignment) to a page size.
 	 */
-	nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	nslots = nr_slots(alloc_size);
 	if (alloc_size >= PAGE_SIZE)
 		stride = (1 << (PAGE_SHIFT - IO_TLB_SHIFT));
 	else
@@ -602,7 +607,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 			      enum dma_data_direction dir, unsigned long attrs)
 {
 	unsigned long flags;
-	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	int i, count, nslots = nr_slots(alloc_size);
 	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = io_tlb_orig_addr[index];
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
