Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348C5C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 06:56:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7161208B3
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 06:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P2vHghAF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QIUBzW0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7161208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dErH3zUxzhVnVC4CFIg0SQA8GQq3PDS+P98RSBy0CTg=; b=P2vHghAFqIOIfUEkLJAjJ8APE
	+5Lmf5hs8xp0dI7pO4XnY9EahmYMiaSPN5yPGXJxUkT9gWaGL3WsCc+ipZ5LqJ3rki2FEG2CnfmBU
	+cH3SXj4eStpxdN05aowbZUxaNSFcHMkZ3D5FoF7GpNpc716GtOmqu6YrEgyjgrnCWJ+8NjXL28l9
	11TSMtgCw1z5teKp8ElFuJxF/4fFRh4ORZDdGYrezat5k/wMvbil5ttoSEwtKLz8aUEjcZoYq+2O5
	STw4w7JrXjJYxm6hdXm6cCq/LfuNA++65u92Flies41UoQcUYCZx2NGm9xya74bEkvIZe8mkI6KuH
	BM97Q5zUw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8I1O-00051U-AD; Wed, 19 Aug 2020 06:56:30 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I0v-0004rP-KE; Wed, 19 Aug 2020 06:56:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=yG7qWXKBUIxg7RQ3+cci8dpYxavPbFHR4ZLuySoica4=; b=QIUBzW0L+6A9SSAc6/gO+tDQ+b
 OxXtbUbEFqlmm0USEC/IXSplued4C+C6F0ZF30aKjG8eHH9Hw09fN5oDweD3DjZhb8ZVyBa3oNCMt
 gHqvdLdvetFUsHVA2naOyxN49WiwYumPj0OJ9vWKMBhULQu9DljH3ttkuIFc8Xzwt6Kk9NdAWGMVc
 M/hFcqjB5X000cNsrLFGiT0ucDiSShmdbC+Iz8B0HGkVX82jI1lTPPtC7Yho4FRHWN0jDXHB+oQYg
 jtcO/Q7MNp4OEwi61wxBreFz6GJBwroT31V+Pbx43dXQbOQjKpB13S5G4CjWrDHb//3KK5l+B0jlz
 QH4CysFQ==;
Received: from [2001:4bb8:198:f3b2:86b6:2277:f429:37a1] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I0s-0008Kv-H4; Wed, 19 Aug 2020 06:55:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Pawel Osciak <pawel@osciak.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matt Porter <mporter@kernel.crashing.org>, iommu@lists.linux-foundation.org
Subject: [PATCH 01/28] mm: turn alloc_pages into an inline function
Date: Wed, 19 Aug 2020 08:55:28 +0200
Message-Id: <20200819065555.1802761-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819065555.1802761-1-hch@lst.de>
References: <20200819065555.1802761-1-hch@lst.de>
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>, alsa-devel@alsa-project.org,
 linux-samsung-soc@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

To prevent a compiler error when a method call alloc_pages is
added (which I plan to for the dma_map_ops).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/gfp.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 67a0774e080b98..dd2577c5407112 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -550,8 +550,10 @@ extern struct page *alloc_pages_vma(gfp_t gfp_mask, int order,
 #define alloc_hugepage_vma(gfp_mask, vma, addr, order) \
 	alloc_pages_vma(gfp_mask, order, vma, addr, numa_node_id(), true)
 #else
-#define alloc_pages(gfp_mask, order) \
-		alloc_pages_node(numa_node_id(), gfp_mask, order)
+static inline struct page *alloc_pages(gfp_t gfp_mask, unsigned int order)
+{
+	return alloc_pages_node(numa_node_id(), gfp_mask, order);
+}
 #define alloc_pages_vma(gfp_mask, order, vma, addr, node, false)\
 	alloc_pages(gfp_mask, order)
 #define alloc_hugepage_vma(gfp_mask, vma, addr, order) \
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
