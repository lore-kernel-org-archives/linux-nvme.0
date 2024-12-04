Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F85E77169
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2024 00:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=S94HHxgSOg+k4dICKX9cLxvwuloHT/5joAHlQnBfZYY=; b=C9F2t/y4bfs4C4I8pa/jEN434+
	DGRaUPpE8hpUeTd9geSkyUdEKo3xiYzIXJRQmbHtTt1+7Yi7ogLpWtRuBcB4YYIj1FpOSXNXU1G+x
	o1s1K2FN2H29oJ/F/lm9lh3cPggTSjbzFJJUasivSxEflRTCyLr4h78wOFES5kGBdAjqw6VPfFd78
	latC8ef8PqNDMfLN+cIUbMsUBrSWuiNADmWWtXsg62u9lVOVh0/isMwghh9p7xsFw6fu6BD2akpkg
	N0VpQFrn3BZjl+rttuNaUFr/cDnFAFtFeYsj+gEGjY2FSk//yXld3kZgj0Ex2lR4/V+aWGnn6GYlh
	bMmVpYXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIdTY-0000000B8XM-1VpB;
	Wed, 04 Dec 2024 00:42:44 +0000
Received: from softbank126143049138.biz.bbtec.net ([126.143.49.138] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tIdTX-0000000B8X1-0S13;
	Wed, 04 Dec 2024 00:42:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	Leon Romanovsky <leon@kernel.org>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Subject: [PATCH] nvme-pci: don't use dma_alloc_noncontiguous with 0 merge boundary
Date: Wed,  4 Dec 2024 09:42:40 +0900
Message-ID: <20241204004240.687875-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Only call into nvme_alloc_host_mem_single which uses
dma_alloc_noncontiguous when there is non-null dma merge boundary.
Without this we'll call into dma_alloc_noncontiguous for device using
dma-direct, which can work fine as long as the preferred size is below the
MAX_ORDER of the page allocator, but blows up with a warning if it is
too large.

Fixes: 63a5c7a4b4c4 ("nvme-pci: use dma_alloc_noncontigous if possible")
Reported-by: Leon Romanovsky <leon@kernel.org>
Reported-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4c644bb7f069..778f124c2e21 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2172,6 +2172,7 @@ static int nvme_alloc_host_mem_multi(struct nvme_dev *dev, u64 preferred,
 
 static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 {
+	unsigned long dma_merge_moundary = dma_get_merge_boundary(dev->dev);
 	u64 min_chunk = min_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);
 	u64 hmminds = max_t(u32, dev->ctrl.hmminds * 4096, PAGE_SIZE * 2);
 	u64 chunk_size;
@@ -2180,7 +2181,7 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 	 * If there is an IOMMU that can merge pages, try a virtually
 	 * non-contiguous allocation for a single segment first.
 	 */
-	if (!(PAGE_SIZE & dma_get_merge_boundary(dev->dev))) {
+	if (dma_merge_moundary && (PAGE_SIZE & dma_merge_moundary) == 0) {
 		if (!nvme_alloc_host_mem_single(dev, preferred))
 			return 0;
 	}
-- 
2.45.2


