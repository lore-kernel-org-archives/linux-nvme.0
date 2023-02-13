Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACFAC636D4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 07:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uY9aFO2ocTYYgU9JyhMZgAAV1nCngmQzuUx1xaFIAfI=; b=rShwIVZbI+Wd639r6MSIJgTsH+
	xTzr7hy7qgFUhO3qHAA62atzv8/7/ow6/bDw7Mtqjkn2WPy5azqaCJtFNCtfGOQmRiGf19Pi19S6z
	aCDUIZM7xxQEpy08wOTXvzXtJqR8F0b0maOgzXGADRJG4E3h+sTVxtnGJb3Z+3sOtK9gzWMuZF1EN
	oU1G7qifPW0G8mCOHNXo6bbFrbLN0rD1Pt8vqOK5hcuK9Ay67V8Py9r8HF6PNP9SLogFBSQZyb5G3
	4o4m7p8fDXwx3vQWr85RxB3E9B/ckTNh+3OIs/fN2jHV37jGJA6RCUn3suegYlLi5waCo6U3ItSP0
	5hM91RCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRT8l-00DQoz-25; Mon, 13 Feb 2023 07:20:43 +0000
Received: from [2001:4bb8:181:6771:cbc2:a0cd:a935:7961] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRT8h-00DQo9-2V; Mon, 13 Feb 2023 07:20:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: sagi@grimberg.me,
	kbusch@kernel.org
Cc: mikelley@microsoft.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-pci: set the DMA mask earlier
Date: Mon, 13 Feb 2023 08:20:35 +0100
Message-Id: <20230213072035.288225-1-hch@lst.de>
X-Mailer: git-send-email 2.39.1
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

Set the DMA mask before calling dma_addressing_limited, which depends on it.

Note that this stop checking the return value of dma_set_mask_and_coherent
as this function can only fail for masks < 32-bit.

Fixes: 3f30a79c2e2c ("nvme-pci: set constant paramters in nvme_pci_alloc_ctrl")
Reported-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/nvme/host/pci.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c734934c407ccf..e2a8b330ba518a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2509,18 +2509,12 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 {
 	int result = -ENOMEM;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	int dma_address_bits = 64;
 
 	if (pci_enable_device_mem(pdev))
 		return result;
 
 	pci_set_master(pdev);
 
-	if (dev->ctrl.quirks & NVME_QUIRK_DMA_ADDRESS_BITS_48)
-		dma_address_bits = 48;
-	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(dma_address_bits)))
-		goto disable;
-
 	if (readl(dev->bar + NVME_REG_CSTS) == -1) {
 		result = -ENODEV;
 		goto disable;
@@ -2998,7 +2992,11 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 			     quirks);
 	if (ret)
 		goto out_put_device;
-	
+
+	if (dev->ctrl.quirks & NVME_QUIRK_DMA_ADDRESS_BITS_48)
+		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
+	else
+		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
 	dma_set_max_seg_size(&pdev->dev, 0xffffffff);
 
-- 
2.39.1


