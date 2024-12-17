Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CA6E77187
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 16:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TWPiSio5c8/HCvvSML0LvlWD8l4YSqz90UImKplqrD8=; b=Z4Sgy1C12oZYhhOvufEtzlQeX+
	NfBc6ypPRNYzMHvco8HHW1SaTAH/o2ZER2yAPKXbqXWYyruPgofz7lDtTE3t5xNaLnxhd6OtgFdYS
	D6R6wEsEgcD3fn1+5gtkOvpvBWWfYRuqpfOHHSN7kePJ4fKWCZLdXAsfSxECax9sw/RG/06TdT/Qc
	koYldmeFabeKKVTNakLqAcSXIIWmiTpfKcx2cqmxvNV0K1uzA+rQamhgPIsYNQkKNResFQjZ8tYwo
	7OEy4y/yFGOWH6ZyrJ6Eg/1vJg5JQeZKcQrDAD10X98wsHzNSZAKfBK112GLVsrJQONEdn2I7ClCH
	0qPNSyvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNaXa-0000000ECgn-0Gvq;
	Tue, 17 Dec 2024 16:35:22 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNa4J-0000000E583-0xFu
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 16:05:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9FBA25C5FEA;
	Tue, 17 Dec 2024 16:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B802C4CED3;
	Tue, 17 Dec 2024 16:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734451506;
	bh=DB82UMamGsd29tTD7UzEWTxuioiXlTLHeqMQU4t60m0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nEZywKqdk9Fly9JEBUaBV2yzsGp9UkLourKYNdejmv+7jBrlRB8ivW9ayZD6dpb/q
	 Tt5zNo+HhSzueKpRw9NqHbb5XynM0RLioVL+8cNUHPPAKVn0wsm/uL2acyPJOJCtnE
	 XDjuoLypww1Mu8fJPhiYc2OfgtekLpzzCh3kuyAFyOsXaeVy5a5QlPn7pILKy1yKf4
	 8MgaJwQws486++DCNIZrCCJBp0WMvi0lvCG6zDlvC3vhbhitLOMfxN0QEWLqT1BvTl
	 Shgs0q/bBHVV0C3zyrWs4Im90RfFny5v+3XEmk0ncmQbtNOtrWzlEtroRxtFXwOcKO
	 b5x8tmwIsduXg==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 2/3] PCI: endpoint: pci-epf-test: Use private DMA_MEMCPY channel
Date: Tue, 17 Dec 2024 17:04:50 +0100
Message-ID: <20241217160448.199310-5-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217160448.199310-4-cassel@kernel.org>
References: <Z2Gf9lv6hLROjM8e@ryzen>
 <20241217160448.199310-4-cassel@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2298; i=cassel@kernel.org; h=from:subject; bh=DB82UMamGsd29tTD7UzEWTxuioiXlTLHeqMQU4t60m0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNITFyrE71W9Gyr9WzUvwuv7/oV3rEqubi46ULo7qibg1 zLjEKNFHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjIU1FGhrlz2PeJbXrNNvUZ z8WannShqgeFHz5zrCkxkFcQK561qpyRYXKLmGWH3YLVrw6u1NE8EnJ4Va5f50JDNZMPn5kWr78 owA4A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_080507_344655_8E7DF04E 
X-CRM114-Status: GOOD (  12.14  )
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

First try to use a DMA channel with DMA_PRIVATE and DMA_MEMCPY.
If there is no such channel, fall back to a DMA_MEMCPY channel
(without DMA_PRIVATE).

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 24 +++----------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ef6677f34116..8315225d81bd 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -123,11 +123,9 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 {
 	struct dma_chan *chan = (dir == DMA_MEM_TO_DEV) ?
 				 epf_test->dma_chan_tx : epf_test->dma_chan_rx;
-	dma_addr_t dma_local = (dir == DMA_MEM_TO_DEV) ? dma_src : dma_dst;
 	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
 	struct pci_epf *epf = epf_test->epf;
 	struct dma_async_tx_descriptor *tx;
-	struct dma_slave_config sconf = {};
 	struct device *dev = &epf->dev;
 	int ret;
 
@@ -136,24 +134,7 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 		return -EINVAL;
 	}
 
-	if (epf_test->dma_private) {
-		sconf.direction = dir;
-		if (dir == DMA_MEM_TO_DEV)
-			sconf.dst_addr = dma_remote;
-		else
-			sconf.src_addr = dma_remote;
-
-		if (dmaengine_slave_config(chan, &sconf)) {
-			dev_err(dev, "DMA slave config fail\n");
-			return -EIO;
-		}
-		tx = dmaengine_prep_slave_single(chan, dma_local, len, dir,
-						 flags);
-	} else {
-		tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len,
-					       flags);
-	}
-
+	tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
 	if (!tx) {
 		dev_err(dev, "Failed to prepare DMA memcpy\n");
 		return -EIO;
@@ -225,7 +206,8 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 	filter.dma_mask = BIT(DMA_DEV_TO_MEM);
 
 	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
+	dma_cap_set(DMA_PRIVATE, mask);
+	dma_cap_set(DMA_MEMCPY, mask);
 	dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
 	if (!dma_chan) {
 		dev_info(dev, "Failed to get private DMA rx channel. Falling back to generic one\n");
-- 
2.47.1


