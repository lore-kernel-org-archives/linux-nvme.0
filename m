Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88E6CA5FED
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2026 12:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eZVBFBhd4oOB+QKs5AJD8QAzmM6latD3F6TpFObjOwY=; b=dAAkgsvLiI8RVuSWvL33caOxT/
	yZA55bMk35trodcdFYLLqZ/gSpNUaOjU0w0Z5vv+wgiFr21mPDxzfH50nv9oG0orObmJNrENnoo9t
	g0+IFuB5KY/STMpv8eHJkUWlBVp2Qa7WEhvSiVm4xOzzO7x3TVsKmZ2ykZzxDc87JCA65kHonpbYy
	3DqOdna03nzPPkUv0MkYdv1qIShFHtxcltRNinhat1nx252dHEGEGJnONrAauy9JFXblOnw0D9asd
	0UU8Mv1LOJ6kd+Vav/JmAL9BowBj4Es9XZ+VOB47JZVhQEnm3+NpykO2iz2oO03cLmhMNBe2XSSOi
	LYGrNYjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE3sk-00000000hMB-1v3H;
	Tue, 06 Oct 2026 12:02:54 +0000
Received: from [212.185.66.20] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE3sh-00000000hLP-0d1r;
	Tue, 06 Oct 2026 12:02:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org
Cc: sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	ahuang12@lenovo.com,
	sunjw10@lenovo.com,
	iommu@lists.linux.dev
Subject: [PATCH] Revert "nvme-pci: clamp max_hw_sectors based on DMA optimized limitation"
Date: Tue,  6 Oct 2026 14:02:48 +0200
Message-ID: <20261006120248.147654-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
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

This turns down to cause up to 15% performance regressions on standard
large transfer workloads.  Revert it and hope the IOVA allocator can
eventually be fixed to remove the need for the original workaround.

This reverts commit 3710e2b056cb92ad816e4d79fa54a6a5b6ad8cbd.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5440cf18b55b..82e308fe4f4c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3747,7 +3747,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	 */
 	dev->ctrl.max_hw_sectors = min_t(u32,
 			NVME_MAX_BYTES >> SECTOR_SHIFT,
-			dma_opt_mapping_size(&pdev->dev) >> 9);
+			dma_max_mapping_size(&pdev->dev) >> 9);
 	dev->ctrl.max_segments = NVME_MAX_SEGS;
 	dev->ctrl.max_integrity_segments = 1;
 	return dev;
-- 
2.53.0


