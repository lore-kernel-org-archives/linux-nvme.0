Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF57EC433E9
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 19:30:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7ECE64F64
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 19:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7ECE64F64
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0umbIXjP5O5Dt6/RD3GY/uZlgteUXarGIoJH1Mfw2cg=; b=MZalp1ijIpO5MhNak2LVeJ0AJ
	g/kEB0u7dnLayfujRBTErTIC096/NFu91sOnrhuSQxtzea6D9q0K8q/yAQUDRD9NY6gxdc2ykSV2i
	jzJalP6GfzcYia66l0fPAl+QL2U4z9qtEbja+soWjDjG6bPavNLGeVMu5uC89Fl4xs15ysqDK1Y9R
	UkFiiWq9Geuc8aPvVqAU7D2NxNVjPpMK9lHd0OGz523u9wSzw/tFMkGHqnvbxFWOG+FzYAz3wnsOl
	/S/D94g1TzSx0eZ5mFjw3hmE8ai/thc2FQKmQMiNlTwZSdRKpf8711GHqrng8Y/si52Io4WVLs2KU
	tfCfZfKiA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7kL5-00084g-1K; Thu, 04 Feb 2021 19:30:51 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7kKz-00083K-A5
 for linux-nvme@merlin.infradead.org; Thu, 04 Feb 2021 19:30:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=aNExqVOngs3fyjX5iVLKFHU/FqiI2RGh2IjJXa7kL2s=; b=qC6NHyx1bwXxfdi2cVmw/hWcDx
 9RQAXH6/jk37jaGW8bVFm2EMqeDykMZ7EurZiXdDHQ/zEXuc1P8BtUcqAAimVyVw0vWpmwCQCSnxT
 OJ3ZUrvDu75eyrKGVRTkfw2918JuurNlyxFvkRLLfSQiq430VeiXsNl8EFwf1ZsonK1UVkOrZWP9a
 +VDVluh3z1+8PXXjn8RRZQwicM2i8CeTsLS4dNM+k8Nd1u46faDBljOEfMo4bJnhqv6WJEmCdJcXb
 8Jv4KLo+EsU1Etrf+QkurLbRVfN7Scm1nxyHnoGzRm0oa3AOi1N7lxi/70foMzd9v48BcaDH/fhRz
 TphTv9yg==;
Received: from [2001:4bb8:184:7d04:e998:f47:b9fb:7611] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l7kKx-001Jhk-JC; Thu, 04 Feb 2021 19:30:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: jxgao@google.com,
	gregkh@linuxfoundation.org
Subject: [PATCH 2/8] swiotlb: add a io_tlb_offset helper
Date: Thu,  4 Feb 2021 20:30:29 +0100
Message-Id: <20210204193035.2606838-3-hch@lst.de>
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

Replace the very genericly named OFFSET macro with a little inline
helper that hardcodes the alignment to the only value ever passed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 7c42df6e61001d..838dbad10ab916 100644
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
