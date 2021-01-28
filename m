Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60A5C433E9
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 00:39:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6952360C3D
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 00:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6952360C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:To:From:Subject:References:Mime-Version:Message-Id:In-Reply-To:Date:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kepd6r2xThqBDBDaJOIdE1vXeG4ZZ6SBCUvbAkbU6wQ=; b=ng9aJewbnbNFCCEsmjZwogiKWi
	+15o3tIHEDVzE9gPzHRSXj2VdhKhi09/id6c6c6NBbUwcAfTIj1LN57tFh0byMNTuFzhd/jL6tAv6
	XWvesncuQ+G9b5eav14vUMKwwrrQ8s1K5KjwwgkKGEkb9616nufhtv9SfjDo5TGP/lHyHr2NfthxW
	uHN1EB4o7bYWan2R9TJRJAsVwxF3e88mQC3Q12wXeNS+Q3p5sJoHVMAtkYRuAkW3pESyPklQQPDE6
	qtzX894p6Dr+hbkz3JCi+iks1mm5bW4mJLTpRzA4Hu7pmPfCui4wAJPz/66swAtLskOxuSlu5Zkp4
	bKJGPAZw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4vKv-0006HT-4V; Thu, 28 Jan 2021 00:39:01 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4vKl-0006F2-Lt
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 00:38:53 +0000
Received: by mail-pg1-x549.google.com with SMTP id s17so2646872pgv.14
 for <linux-nvme@lists.infradead.org>; Wed, 27 Jan 2021 16:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to; bh=qnjnlmt/aDtctSbauuE/youvqobwVlPzhUiWyRCjmfE=;
 b=qJxdZcF/2iL7L7BpzsbCYhi4F1nBavg4WlPlFpgXDOY5JnypjMuB5Jl8F1glrX+A4C
 n5cFVsxGI6pfe/w0G7OBYdhPN9oZnZgnLpywUZwj5ri8PaSP2OWVp0agQOBxmWy3mIvz
 KSFd69aDCb0KQBfTmnJ62PQ3um4VDyswVGzu5SPQyhwapIATIv82EijymGjd/0268xT2
 wv/zpLEU0J95cFOqUQnbGni/pwRmqfy6nQ96Wx3eJcvOVyYCLU49ayvU8D/1YZcpSmEQ
 cQVhVPIIf6skPQ09HLkASCP/JwRrVQzdGPjF5JYdynrGeqJ4Xp2kxKWvkcG5Zs6dpAi0
 huSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to;
 bh=qnjnlmt/aDtctSbauuE/youvqobwVlPzhUiWyRCjmfE=;
 b=kBA+tdiAgtsx8qpJgb9JZtzk0grsH7pOTYe6bd2OLArj3Y83G/939w3WqurPXdzQNK
 UrJp4XQAEeIDMXHBqSwTmhGUPyf1b3A1FG+epsMHn82hoIZE00kQMqAfr2rLG+sUZx6p
 Iu07J4GvuGDJCd1UL/l9xUOyBINRdp8Hurm7xOwNbwqZIxTZMH7h2iXjh4UmQ52OluXL
 o7T1nOOQakeMbZMiUJS19WHIPYAEUhVkGCkRrwEI8OkS/2rqUUMmNIHkTWo2PX5jzqsZ
 aaq3gqsC1z6Wt45LS1qpwGfmWZv60kMdkIKZ5KL92F3UrrxfoN76SlVFRO2hKuKluhv+
 1DRQ==
X-Gm-Message-State: AOAM533YQxmOoUDPASbkTg6Br/QZRUzjjd9Qv7vNQMD70iCRSsdn6aUS
 yIO7DJ4NLiFu96J/D75d+9kz1p7mgw==
X-Google-Smtp-Source: ABdhPJxItXQ1+mD1tytZkMFhh6fWETP78nnpd+zRsRgJzoZEVagoHzp8VktIvxmKZTm1x9AHDy922qsZ4Q==
X-Received: from jxgao.kir.corp.google.com
 ([2620:0:1008:11:4d90:620d:7a68:ffc5])
 (user=jxgao job=sendgmr) by 2002:a17:90a:d181:: with SMTP id
 fu1mr8266312pjb.188.1611794325104; Wed, 27 Jan 2021 16:38:45 -0800 (PST)
Date: Wed, 27 Jan 2021 16:38:28 -0800
In-Reply-To: <20210128003829.1892018-1-jxgao@google.com>
Message-Id: <20210128003829.1892018-3-jxgao@google.com>
Mime-Version: 1.0
References: <20210128003829.1892018-1-jxgao@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 2/3] Add swiotlb offset preserving mapping when
 dma_dma_parameters->page_offset_mask is non zero.
From: Jianxiong Gao <jxgao@google.com>
To: jxgao@google.com, erdemaktas@google.com, marcorr@google.com, hch@lst.de, 
 m.szyprowski@samsung.com, robin.murphy@arm.com, gregkh@linuxfoundation.org,
 saravanak@google.com, heikki.krogerus@linux.intel.com, 
 rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
 dan.j.williams@intel.com, bgolaszewski@baylibre.com, jroedel@suse.de, 
 iommu@lists.linux-foundation.org, konrad.wilk@oracle.com, kbusch@kernel.org, 
 axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_193851_807728_8001AB2F 
X-CRM114-Status: GOOD (  16.86  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For devices that need to preserve address offset on mapping through
swiotlb, this patch adds offset preserving based on page_offset_mask
and keeps the offset if the mask is non zero. This is needed for
device drivers like NVMe.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
---
 kernel/dma/swiotlb.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 7c42df6e6100..4cab35f2c9bc 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -468,7 +468,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(hwdev, io_tlb_start);
 	unsigned long flags;
 	phys_addr_t tlb_addr;
-	unsigned int nslots, stride, index, wrap;
+	unsigned int nslots, stride, index, wrap, page_offset_mask, page_offset;
 	int i;
 	unsigned long mask;
 	unsigned long offset_slots;
@@ -500,12 +500,16 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 		    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
 		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
 
+	page_offset_mask = dma_get_page_offset_mask(hwdev);
+	page_offset = orig_addr & page_offset_mask;
+	alloc_size += page_offset;
+
 	/*
 	 * For mappings greater than or equal to a page, we limit the stride
 	 * (and hence alignment) to a page size.
 	 */
 	nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
-	if (alloc_size >= PAGE_SIZE)
+	if ((alloc_size >= PAGE_SIZE) || (page_offset_mask > (1 << IO_TLB_SHIFT)))
 		stride = (1 << (PAGE_SHIFT - IO_TLB_SHIFT));
 	else
 		stride = 1;
@@ -583,6 +587,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	 */
 	for (i = 0; i < nslots; i++)
 		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
+	/*
+	 * When keeping the offset of the original data, we need to advance
+	 * the tlb_addr by the offset of orig_addr.
+	 */
+	tlb_addr += page_offset;
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
 		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
@@ -598,7 +607,9 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 			      enum dma_data_direction dir, unsigned long attrs)
 {
 	unsigned long flags;
-	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	unsigned int num_page_offset_slabs, page_offset_mask = dma_get_page_offset_mask(hwdev);
+	int i, count;
+	int nslots = ALIGN(alloc_size + tlb_addr & page_offset_mask, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
 	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = io_tlb_orig_addr[index];
 
@@ -610,6 +621,14 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
 		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_FROM_DEVICE);
 
+	/*
+	 * When dma_get_page_offset_mask is used, we may have padded more slabs
+	 * when padding exceeds one slab. We need to move index back to the
+	 * beginning of the padding.
+	 */
+	num_page_offset_slabs =  (tlb_addr & page_offset_mask) / (1 << IO_TLB_SHIFT);
+	index -= num_page_offset_slabs;
+
 	/*
 	 * Return the buffer to the free list by setting the corresponding
 	 * entries to indicate the number of contiguous entries available.
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
