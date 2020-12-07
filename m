Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60387C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 21:42:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9E922396D
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 21:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E922396D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:From:Subject:Mime-Version:Message-Id:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zDzltEt8JIMJ/d39YuDgclOsu3M678oF6EXICNLM4E0=; b=VQSuFNlDrEZYumIxKzWiZ+xMz1
	nJEjrFyfVjJ/vDnm2t717mAlcOHIeH7D+9Gka3udxV1K5fJgGUir64o9x/+5k7ZtsbpiYUY7eqhKc
	iprRUG8leievhAj7ZeEukRkZRIDQ6wNgF4rfQyNCD71A+gBkqKYp0WdwxUEqPZWSvgGxEcuUJDJEZ
	yvKvB2bP6KE7TQ2ffayZ0j0BDQ3kgweOe7xAsMjVclyl7NKZAXAXzDP9aMs6gRzlCHGbFrOGneQz/
	QYRNbRWrqO/eFM62cidAZjmmAMUlRyEVRyr+oJ//ZOHTIPctgD4cAM3SpHCDGCxv7uEFi/FsnxCfI
	mCEzNrEw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmOHM-0007o8-Ir; Mon, 07 Dec 2020 21:42:44 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmOHJ-0007nJ-RH
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 21:42:42 +0000
Received: by mail-pf1-x449.google.com with SMTP id q22so10726748pfj.20
 for <linux-nvme@lists.infradead.org>; Mon, 07 Dec 2020 13:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=pDfU68hJbVrMhlby67/fptgGuh7zYii/tAwKwJs5ABQ=;
 b=XdTC5hS/AEdpujA2auDl0oiHQKAaDQNA+nqMfmnrCYYh60Dkvw/1dR+Uqim2ZTfKsp
 txd6ggR8/zez7Zopxjyt7hFhg16FOh9vUa/pXxIDhK+3h4EDtFXrjhqL5cntIgghjp78
 ulJUbMrWsBU+5TEyIgHX8fexxcALt9nHZBo3XCOJPIqefrFS0wzdLA7WXahxLjvxiGkl
 v0n+2BtTMPhtMBsVBEKn3ddkOgQDAN6kf3O1t4yOqCsAkjcSdX1RYDrxh56ZF07FMCyl
 cdYnuWXwrQg9M7pCQyE28aW30Zxaev8zo58FYDpaSSNWOoUB952tGlfLyFT5aFK2dMyW
 hpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=pDfU68hJbVrMhlby67/fptgGuh7zYii/tAwKwJs5ABQ=;
 b=OoxhHMtojQZqi3h6HS8CpnVCVBFjni8+vZraMvBMgaUXfbXNYpNGBXReO9ylS4c+Gt
 pzANYZiOzDiBHSFfjPURApS3hrH15T5ZOXYWgarZglbWodfHeEXj7sUXb8/NN4Do0pBa
 /QBu+WlLMdwS/FMR++HUsLebRuU70EZcLX4l6NBkzn4WP3HoENrKD5w+rgTz0C8Dn2yj
 Jugyqr6UWzB9yd76Y3qfnvFt0G4mLdKHIU2a37GEXLrEp6sxqcxtJ8UvcL7PuP7gfjxO
 S93QonWP+tuRrSavDsDENZ3rXncWotQ+mapeSZEH9Yv7jHJ9Nx37sp1GKb8R5UD0wbdk
 fuGA==
X-Gm-Message-State: AOAM531a2lNlR/NMYNq2iwIa/gev0x2nEhl5ek02b9UBoOKLm54G5I8w
 IWe8C+rYeAWe4134bOraz5y3usub1A==
X-Google-Smtp-Source: ABdhPJw1DKVB1ysvlps113dHRHd8Gdmd9wuw9y2HR7LIJxoQyNpy8ztEFdTjgj9WPEQ8k+rl387OW7IIVw==
X-Received: from jxgao.kir.corp.google.com
 ([2620:0:1008:11:3e52:82ff:fe62:cb61])
 (user=jxgao job=sendgmr) by 2002:a17:902:b70d:b029:da:5196:1181 with SMTP id
 d13-20020a170902b70db02900da51961181mr18297299pls.81.1607377356798; Mon, 07
 Dec 2020 13:42:36 -0800 (PST)
Date: Mon,  7 Dec 2020 13:42:04 -0800
Message-Id: <20201207214204.1839028-1-jxgao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH] [PATCH] Keep offset when mapping data via SWIOTLB.
From: Jianxiong Gao <jxgao@google.com>
To: kbusch@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_164241_926387_9ED2E747 
X-CRM114-Status: GOOD (  16.40  )
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

NVMe driver and other applications depend on the data offset
to operate correctly. Currently when unaligned data is mapped via
SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. When
booting with --swiotlb=force option and using NVMe as interface,
running mkfs.xfs on Rhel fails because of the unalignment issue.
This patch makes sure the mapped data preserves
its offset of the orginal address. Tested on latest kernel that
this patch fixes the issue.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/swiotlb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 781b9dca197c..56a35e71b3fd 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -483,6 +483,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	max_slots = mask + 1
 		    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
 		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
+ 
+	/*
+	 * We need to keep the offset when mapping, so adding the offset
+	 * to the total set we need to allocate in SWIOTLB
+	 */
+	alloc_size += offset_in_page(orig_addr);
 
 	/*
 	 * For mappings greater than or equal to a page, we limit the stride
@@ -567,6 +573,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	 */
 	for (i = 0; i < nslots; i++)
 		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
+	/*
+	 * When keeping the offset of the original data, we need to advance
+	 * the tlb_addr by the offset of orig_addr.
+	 */
+	tlb_addr += orig_addr & (PAGE_SIZE - 1);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
 		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
-- 
2.27.0



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
