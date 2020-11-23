Return-Path: <SRS0=38m3=E5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454D3C388F9
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2020 22:18:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B341B20644
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2020 22:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1zlH4hUv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="B2IBeB19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B341B20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:From:Subject:Mime-Version:Message-Id:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zcVj7L1av29W0KdppaiA7PohdVm05T1kKv8s3HuOsu0=; b=1zlH4hUvtIter5xBNdiUea6O+S
	mtBCpJV2B1SgwRfCBg86/QQWS/yzOkhdyOvYhzOPbuxEWw26X/U3nktA99qh2bjX9BgczD//ts+YF
	6KtmJq6rpa0q4igxOTTWnf4KDadDNViAziQVtscSV6iff5qdIuAFHVEbnmv95Tut9enX18lQH4J/k
	n02FbLVMhiGBJJZiZMS6DCdO/aqTi2GFLetRNRfOKpJj4YnlQuEfWUJgDaI2VlAvb8NT+zx5GUlUT
	6XjoPWaRSEbEw7aFevwlKnsFvC3xd43UUzfU9smlLySXdnI1b8Uu5oxF1xTHuczqyirosWRHUsgak
	gBeK/lzA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khKA7-0002MA-N3; Mon, 23 Nov 2020 22:18:19 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khKA5-0002KH-8p
 for linux-nvme@lists.infradead.org; Mon, 23 Nov 2020 22:18:18 +0000
Received: by mail-pl1-x64a.google.com with SMTP id m20so1566829pls.21
 for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2020 14:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=YXylx3GCNHyHYBMQqsysdmzOVSsOtZin9cWyUbZGeSg=;
 b=B2IBeB19zTfs1xYaSNHLZDMsX3f0wvPupU1x6jQPo5zn0gD36JBXuYQIEFhSNZxQVc
 C+cutJyz7ixR0Zct99A8r8T+So46A9nmiDQAiQPQ5yQjyxNdxDFUrysbVUSvhoni3QWw
 qUNVsxjAQfDFmPr/HsEzGJYkQnVTRasJjwEaq22nHHkqnYRTLt+shTBNv1s7AsybXR/Q
 824VelCSQrO4ugrRqHUlEk05gL3618qDH7DQJgTrPp+XFCkLDAXfPJGZuCyUvB/ENZaN
 2sVT81n9zsSeivwzCcBMIGwGmXPrm13GhQHUsNjzlDceRfzYvC0buQx2dzAsdSmshJuR
 IjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=YXylx3GCNHyHYBMQqsysdmzOVSsOtZin9cWyUbZGeSg=;
 b=Yjp/Y0S4Cw1XbyAUBnDeeRrt4coAUd5KxhIjBiSnmfLwk6cxJQvkO1wcAVYjbfl5Zt
 yAKzeot3sg/dp5V5F2RVlowCb8g7EzGGnyyMpcPvxFEl3zmdmW3VsTI75HGqEmD8Beue
 jwMMCfxxqLDk2K/Q9Ni25VQwu5n0Z/+PJ6Yv15nbGqKXCjXHKZb8rryPcO0UhA35LwnD
 39V5I34JAl0BR4Etj7klXz4ndJPH1JymiBrDhaDXZD6utsHAAcKzzjZ1BDaschflKLLE
 bPmR4mz+jfBkwlnX3Oz2mlfxzZCWpH/Ph68BZx9flO4mnDuczdpLjDJnCMlD8xeagTcF
 Jk0w==
X-Gm-Message-State: AOAM5325f3ZKOLn+LeQzrSRb90njKrj8wJmc5IuGWCxMy4eg1xA2g9O0
 GvguFd5vG3G9wT9qHG8Up5utnjb4Tw==
X-Google-Smtp-Source: ABdhPJwaHIC5Agde+mPQGxwaVJCi4Ya+RC1h3w/HtrSv/HBYs4qc50kEx9QHD7poWbsARQ0erwEZDcV4cA==
X-Received: from jxgao.kir.corp.google.com
 ([2620:0:1008:11:3e52:82ff:fe62:cb61])
 (user=jxgao job=sendgmr) by 2002:a17:90a:5b07:: with SMTP id
 o7mr1213160pji.58.1606169891131; Mon, 23 Nov 2020 14:18:11 -0800 (PST)
Date: Mon, 23 Nov 2020 14:18:07 -0800
Message-Id: <20201123221807.3344263-1-jxgao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH] [PATCH] Adding offset keeping option when mapping data via
 SWIOTLB.
From: Jianxiong Gao <jxgao@google.com>
To: kbusch@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201123_171817_373253_85C099FF 
X-CRM114-Status: GOOD (  21.21  )
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
Cc: sagi@grimberg.me, konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, iommu@lists.linux-foundation.org,
 David Rientjes <rientjes@google.com>, Jianxiong Gao <jxgao@google.com>,
 robin.murphy@arm.com, hch@lst.de, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

NVMe driver and other applications may depend on the data offset
to operate correctly. Currently when unaligned data is mapped via
SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. When
booting with --swiotlb=force option and using NVMe as interface,
running mkfs.xfs on Rhel fails because of the unalignment issue.
This patch adds an option to make sure the mapped data preserves
its offset of the orginal addrss. Tested on latest kernel that
this patch fixes the issue.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 drivers/nvme/host/pci.c     |  3 ++-
 include/linux/dma-mapping.h |  8 ++++++++
 kernel/dma/swiotlb.c        | 13 +++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0578ff253c47..a366fb8a1ff0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -833,7 +833,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 				iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
 	else
 		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
-					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
+				rq_dma_dir(req),
+			       	DMA_ATTR_NO_WARN|DMA_ATTR_SWIOTLB_KEEP_OFFSET);
 	if (!nr_mapped)
 		goto out;
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 956151052d45..e46d23d9fa20 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -61,6 +61,14 @@
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
 
+/*
+ * DMA_ATTR_SWIOTLB_KEEP_OFFSET: used to indicate that the buffer has to keep
+ * its offset when mapped via SWIOTLB. Some application functionality depends
+ * on the address offset, thus when buffers are mapped via SWIOTLB, the offset
+ * needs to be preserved.
+ */
+#define DMA_ATTR_SWIOTLB_KEEP_OFFSET	(1UL << 10)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 781b9dca197c..f43d7be1342d 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -483,6 +483,13 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	max_slots = mask + 1
 		    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
 		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
+ 
+	/*
+	 * If we need to keep the offset when mapping, we need to add the offset
+	 * to the total set we need to allocate in SWIOTLB
+	 */
+	if (attrs & DMA_ATTR_SWIOTLB_KEEP_OFFSET)
+		alloc_size += offset_in_page(orig_addr);
 
 	/*
 	 * For mappings greater than or equal to a page, we limit the stride
@@ -567,6 +574,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	 */
 	for (i = 0; i < nslots; i++)
 		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
+	/*
+	 * When keeping the offset of the original data, we need to advance
+	 * the tlb_addr by the offset of orig_addr.
+	 */
+	if (attrs & DMA_ATTR_SWIOTLB_KEEP_OFFSET)
+		tlb_addr += orig_addr & (PAGE_SIZE - 1);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
 		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
-- 
2.27.0



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
