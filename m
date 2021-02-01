Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5447DC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 18:30:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25AA64E2C
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 18:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25AA64E2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:To:From:Subject:References:Mime-Version:Message-Id:In-Reply-To:Date:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WqUcQl5hhj5OmGvIX0DqznpHAbLHCpRMIAv9kHqAuww=; b=oaMjQH8N5HUI9o6A2bQoRT6r6/
	OCodp10vTqTY16mn3QYCg07Ki+Y2Rj1YNf68hTkiEfAa1844YKCK5YyrXHEXayF0D91sWma1FcqFF
	3cduPdvjT4nMP9HCKfQVOQ4IqZiHIR7FhIVb46HGPYZ+01pCWSJiPosA2jhIPbbLpk6WFabmkPeyS
	X9QNYeJgRVzPfbQNcy5AytRH3W88IZrmwf0N+ZF1f/bLNs95j7oDSTU+kWWuvgWZJOB4ndAp21j0z
	pdi4j43tWOgORAfj4nwoVPkUstoEBaREdBSK2InbJGAsBJyOiKASL9VS8iIfgsGtqYigbLXxZ3Jyh
	jWGSydQQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6dy4-0000er-LS; Mon, 01 Feb 2021 18:30:32 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6dy0-0000dC-8s
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 18:30:29 +0000
Received: by mail-pf1-x449.google.com with SMTP id z13so11343879pfn.18
 for <linux-nvme@lists.infradead.org>; Mon, 01 Feb 2021 10:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to; bh=y6NSNhQIEZdVx/Woig+GF08BnyECPQsRFpv07tNfeBE=;
 b=XldHocSXWNUmvdcXbIrpvBTLb8nXbBn2Zduuok2rj8hE3W3V31QvgZdnPupEQPoZYP
 ETcbawsrzB76ohyeg2EXVwurYZEhXJ/VZgHEXTMjIpxXKEksDxYo6OVzRXSgYOttSMez
 fpHSpVUOfiiyl97UtYRwutY0a8N+NzpRYjiVoQnubo8dMHCinvMkqw9DLbx60CPQaKu5
 aAmM3CSeUECVn0FaX9Rvc3tsejqbDZGEniUKipSNYQ8lldAM3RhDm5KJKUols8brZ5bO
 oqQq1Ii8r1vO+vj8I+iVgBnRx/30desHgf9YzFbiYY4AtFRcgWAoeraREgbHciFMwXa2
 /f7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to;
 bh=y6NSNhQIEZdVx/Woig+GF08BnyECPQsRFpv07tNfeBE=;
 b=qP4mtNUODipqTGbWTRUQFTLvhIUPF2bg0SwrIC6Ltv2QB1UNwIU1lki574YFfbYfiu
 iCMz224/ljxneFDbIoW4ZypmLifzM6rrxZxxZWwBjEx4Wnd6w+hMgMLax5wtxkfBTQfd
 mn8IRrhRUEu0yEPoRPzIFnV4gJqAzLSvA/bIZJo6L4fKb95H93GE7kVc2h/h2Hz0q4+f
 BpIpOOfacWNMRLtPDYuyYW4HCZp64uAIMePS9ppX8uObAt2+eDXv6SJCHZEE7GNWehC5
 pcyG4m7hh1WQeD93RkF3DkBeaZjbz7BNDRXWwVGVm9bCsQl+/gIC4L0K4xxVJRdMyQWp
 61cg==
X-Gm-Message-State: AOAM531klym9S8Kay3fAGGIk8YnnykE4DGzhGLR67cxa3L8obOw/a115
 /CS9AYC3PvJDE8ZXEuezz16inSgyjA==
X-Google-Smtp-Source: ABdhPJyEh8WHTSX3KID/KGB0QXG7CYFZ82eK6gqBoiX6SQN2IPJo3M4LuIvQvOzXGRBAfT0DQgR6FOjGCw==
X-Received: from jxgao.kir.corp.google.com
 ([2620:0:1008:11:695f:7f9e:413c:e3c7])
 (user=jxgao job=sendgmr) by 2002:a63:5223:: with SMTP id
 g35mr18277246pgb.255.1612204225231; 
 Mon, 01 Feb 2021 10:30:25 -0800 (PST)
Date: Mon,  1 Feb 2021 10:30:16 -0800
In-Reply-To: <20210201183017.3339130-1-jxgao@google.com>
Message-Id: <20210201183017.3339130-3-jxgao@google.com>
Mime-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH V2 2/3] Add swiotlb offset preserving mapping when
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
X-CRM114-CacheID: sfid-20210201_133028_432940_0ED99CA6 
X-CRM114-Status: GOOD (  18.38  )
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
 kernel/dma/swiotlb.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 7c42df6e6100..eeb640df35f3 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -468,7 +468,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(hwdev, io_tlb_start);
 	unsigned long flags;
 	phys_addr_t tlb_addr;
-	unsigned int nslots, stride, index, wrap;
+	unsigned int nslots, stride, index, wrap, min_align_mask, page_offset;
 	int i;
 	unsigned long mask;
 	unsigned long offset_slots;
@@ -500,12 +500,16 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 		    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
 		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
 
+	min_align_mask = dma_get_min_align_mask(hwdev);
+	page_offset = orig_addr & min_align_mask;
+	alloc_size += page_offset;
+
 	/*
 	 * For mappings greater than or equal to a page, we limit the stride
 	 * (and hence alignment) to a page size.
 	 */
 	nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
-	if (alloc_size >= PAGE_SIZE)
+	if ((alloc_size >= PAGE_SIZE) || (min_align_mask > (1 << IO_TLB_SHIFT)))
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
@@ -598,7 +607,11 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 			      enum dma_data_direction dir, unsigned long attrs)
 {
 	unsigned long flags;
-	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	unsigned int num_page_offset_slabs;
+	unsigned int min_align_mask = dma_get_min_align_mask(hwdev);
+	int i, count;
+	int nslots = ALIGN(alloc_size + (tlb_addr & min_align_mask),
+			1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
 	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = io_tlb_orig_addr[index];
 
@@ -610,6 +623,14 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
 		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_FROM_DEVICE);
 
+	/*
+	 * When dma_get_min_align_mask is used, we may have padded more slabs
+	 * when padding exceeds one slab. We need to move index back to the
+	 * beginning of the padding.
+	 */
+	num_page_offset_slabs = (tlb_addr & min_align_mask) / (1 << IO_TLB_SHIFT);
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
