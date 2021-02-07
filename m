Return-Path: <SRS0=2jH7=HJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51028C433E0
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 16:03:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E6A64DF2
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 16:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E6A64DF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PQwG6lfah/MUFOgbszmIGO86nSuq0FOZjxMnKG0PZm4=; b=nCtVDJ5zPPwkya0Y7TJ4XXj9b
	bz81CWhhoFo84le9cxutnpbHZ0PtP2J7ONSuWnXSjMnvyuJGzG2PnGGq/sgChELNWpGXgg8ZmhwFt
	ZchrwdcGK/CY9UajVQ6klJpwjfl1hD/BgCe9KZ4LAZqc0RckPuSmbQpi52rmWhCjjyqNN29ZN5PXK
	Jpw6tfhnw8N9vwjDBz+FBhMPl7LZtZvE43h3wsN+QZnJWubc9N1NABqGTvEI4+EUa2gbZ7mNgd52K
	TkzdtufP/1p9EDiR2TaMJ6NreiVgo4QPFkkhfWjtdfzftkK2uYLNnsdfVkyDJuOSl1MHTlGtXMQc5
	VT+WoUIPw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l8mXG-0004mx-V9; Sun, 07 Feb 2021 16:03:42 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l8mXF-0004ma-Eb
 for linux-nvme@merlin.infradead.org; Sun, 07 Feb 2021 16:03:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=il2cphgHj/OPz8t3dFz6LRbdGqosPwXonL/f3xmBzyo=; b=lW0i2FRC/io17bJXBiEAQIrvMm
 jUaNrQSSZyqSAMCL5Qn7OZsyccNUT0RkAc6vIn6MOlz1OKgoC2ucuRUf4K9KwxJatdNrRno5ymhWP
 3B/xRaQgS3Y1vmIhf90WsUATxWTJv5QJrEnmO7bbjyhngX8BtrqDkaHpmxF8Q04gBmN+yR2twyZEw
 9RRLdS8RxfwBmBvbcuHtynHmo0PBhWXRatcGoumOqoCaQqzP9YyWBSK6+MXEp6Rq3j/H9vTuf8rEj
 nHSlg5NDIWlG5eKqEFyzmf0KgezaX9hRVZLHOScll20eos4gMgufjOylKyqlVEeyqb2j3Lc7J+KoS
 ow3N3xEw==;
Received: from [2001:4bb8:184:7d04:4590:5583:6cb7:77c7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l8mXC-004tNN-63; Sun, 07 Feb 2021 16:03:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: jxgao@google.com,
	gregkh@linuxfoundation.org
Subject: [PATCH 3/9] swiotlb: factor out an io_tlb_offset helper
Date: Sun,  7 Feb 2021 17:03:21 +0100
Message-Id: <20210207160327.2955490-4-hch@lst.de>
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

Replace the very genericly named OFFSET macro with a little inline
helper that hardcodes the alignment to the only value ever passed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 768187d0e17e31..7705821dcdbd27 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -50,9 +50,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/swiotlb.h>
 
-#define OFFSET(val,align) ((unsigned long)	\
-	                   ( (val) & ( (align) - 1)))
-
 #define SLABS_PER_PAGE (1 << (PAGE_SHIFT - IO_TLB_SHIFT))
 
 /*
@@ -192,6 +189,11 @@ void swiotlb_print_info(void)
 	       bytes >> 20);
 }
 
+static inline unsigned long io_tlb_offset(unsigned long val)
+{
+	return val & (IO_TLB_SEGSIZE - 1);
+}
+
 /*
  * Early SWIOTLB allocation may be too early to allow an architecture to
  * perform the desired operations.  This function allows the architecture to
@@ -241,7 +243,7 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 		      __func__, alloc_size, PAGE_SIZE);
 
 	for (i = 0; i < io_tlb_nslabs; i++) {
-		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
+		io_tlb_list[i] = IO_TLB_SEGSIZE - io_tlb_offset(i);
 		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
 	}
 	io_tlb_index = 0;
@@ -375,7 +377,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 		goto cleanup4;
 
 	for (i = 0; i < io_tlb_nslabs; i++) {
-		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
+		io_tlb_list[i] = IO_TLB_SEGSIZE - io_tlb_offset(i);
 		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
 	}
 	io_tlb_index = 0;
@@ -546,7 +548,9 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 
 			for (i = index; i < (int) (index + nslots); i++)
 				io_tlb_list[i] = 0;
-			for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE - 1) && io_tlb_list[i]; i--)
+			for (i = index - 1;
+			     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 &&
+			     io_tlb_list[i]; i--)
 				io_tlb_list[i] = ++count;
 			tlb_addr = io_tlb_start + (index << IO_TLB_SHIFT);
 
@@ -632,7 +636,9 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 		 * Step 2: merge the returned slots with the preceding slots,
 		 * if available (non zero)
 		 */
-		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
+		for (i = index - 1;
+		     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 &&
+		     io_tlb_list[i]; i--)
 			io_tlb_list[i] = ++count;
 
 		io_tlb_used -= nslots;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
