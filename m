Return-Path: <SRS0=2jH7=HJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A81C433E9
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 16:03:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9582E64E15
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 16:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9582E64E15
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NbtAspi4yHQbVfhu+UF2hadlqcrg6VFgS0QHGYeww7Q=; b=FD04wTQjQkQCFwtTFvb4Cgixc
	cTGfl/EMdGPaLzhk9BRq+L5mlPVpBD8Ubu5hh2q+g2j8hyTxrdoeCZEcXtlNLrv/Bks2zM6Ed0/a0
	DmHIcpP6FnEsR3tN56Wa1Tt4MKsyg17AfMlC3FBZ9XwVcW2q0au4SKReolJVmyTT9Ijc852V23LEJ
	WkaG8aAe3yKX5uNajtqLXpfT3xhDOziMxVbpIjXINe/XXgR2W47YPQNarzLxGucwe7stXNsdW5ayH
	H85XREjQvfRwSbZXigH0hk+d4AxyRLzOpQnwuZikJLncAh6uYnLFPU2Vf31s9Tzzp67PpwPAbngJS
	cLGsPTRlA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l8mXE-0004mL-HW; Sun, 07 Feb 2021 16:03:40 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l8mXC-0004m1-E4
 for linux-nvme@merlin.infradead.org; Sun, 07 Feb 2021 16:03:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=iJpy9rgsV39pmi8VppxtQncpkrsl1R47NfkrvocjC70=; b=Ma3cD9J0Cnocp2q20R2faVzzfD
 0jpzQbA7/8Lpuu7zqeonyAOBau2rMDR2n5vRgnvGAyv66ub2asEyz1x6dJ9zLPOUcCL00JgTn5FT2
 5hvgBKxBcaGaRT4fO/ibkld6JQ5FZWzdLKbWnIo9D7+2zsBnV62SmG/OJUgWV0rNYtEzQioZeLswN
 kxFYdCSwIgO3BY+Fkn1CUp+9jlaGJ/Fx5YI1DKKf9S5s5df5w0ifGQhIEQ/dd+1PKtMj6kKtfpzto
 LdStRjkPxGJlAhNMbqUqg+uXoVw3P8IKP/pRCLbqgHh3jOEYq2HEVlm0BjotRXy78KvSr8qnx3Rrj
 hUCpvi8Q==;
Received: from [2001:4bb8:184:7d04:4590:5583:6cb7:77c7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l8mX7-004tN7-W0; Sun, 07 Feb 2021 16:03:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: jxgao@google.com,
	gregkh@linuxfoundation.org
Subject: [PATCH 2/9] swiotlb: add a IO_TLB_SIZE define
Date: Sun,  7 Feb 2021 17:03:20 +0100
Message-Id: <20210207160327.2955490-3-hch@lst.de>
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

Add a new IO_TLB_SIZE define instead open coding it using
IO_TLB_SHIFT all over.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swiotlb.h |  1 +
 kernel/dma/swiotlb.c    | 14 +++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index d9c9fc9ca5d217..5857a937c63722 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -29,6 +29,7 @@ enum swiotlb_force {
  * controllable.
  */
 #define IO_TLB_SHIFT 11
+#define IO_TLB_SIZE (1 << IO_TLB_SHIFT)
 
 /* default to 64MB */
 #define IO_TLB_DEFAULT_SIZE (64UL<<20)
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 7c42df6e61001d..768187d0e17e31 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -171,7 +171,7 @@ void __init swiotlb_adjust_size(unsigned long new_size)
 	 * adjust/expand SWIOTLB size for their use.
 	 */
 	if (!io_tlb_nslabs) {
-		size = ALIGN(new_size, 1 << IO_TLB_SHIFT);
+		size = ALIGN(new_size, IO_TLB_SIZE);
 		io_tlb_nslabs = size >> IO_TLB_SHIFT;
 		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
 
@@ -491,20 +491,20 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 
 	tbl_dma_addr &= mask;
 
-	offset_slots = ALIGN(tbl_dma_addr, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	offset_slots = ALIGN(tbl_dma_addr, IO_TLB_SIZE) >> IO_TLB_SHIFT;
 
 	/*
 	 * Carefully handle integer overflow which can occur when mask == ~0UL.
 	 */
 	max_slots = mask + 1
-		    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
+		    ? ALIGN(mask + 1, IO_TLB_SIZE) >> IO_TLB_SHIFT
 		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
 
 	/*
 	 * For mappings greater than or equal to a page, we limit the stride
 	 * (and hence alignment) to a page size.
 	 */
-	nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	nslots = ALIGN(alloc_size, IO_TLB_SIZE) >> IO_TLB_SHIFT;
 	if (alloc_size >= PAGE_SIZE)
 		stride = (1 << (PAGE_SHIFT - IO_TLB_SHIFT));
 	else
@@ -598,7 +598,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 			      enum dma_data_direction dir, unsigned long attrs)
 {
 	unsigned long flags;
-	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	int i, count, nslots = ALIGN(alloc_size, IO_TLB_SIZE) >> IO_TLB_SHIFT;
 	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = io_tlb_orig_addr[index];
 
@@ -649,7 +649,7 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 
 	if (orig_addr == INVALID_PHYS_ADDR)
 		return;
-	orig_addr += (unsigned long)tlb_addr & ((1 << IO_TLB_SHIFT) - 1);
+	orig_addr += (unsigned long)tlb_addr & (IO_TLB_SIZE - 1);
 
 	switch (target) {
 	case SYNC_FOR_CPU:
@@ -707,7 +707,7 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 
 size_t swiotlb_max_mapping_size(struct device *dev)
 {
-	return ((size_t)1 << IO_TLB_SHIFT) * IO_TLB_SEGSIZE;
+	return ((size_t)IO_TLB_SIZE) * IO_TLB_SEGSIZE;
 }
 
 bool is_swiotlb_active(void)
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
