Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED00C46467
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 13:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Bb8tjufSZjQLxxGjWnqmE3dgJu7ezrwgS/IO6o6Xus=; b=3LdyCz5od3Y30peBj1OEa2NelT
	+4Xlxg8+pgfKoSyu7wIu8jarc03/d9U3uaCZ9NqP2wy8e7XUBL2LaxxiFNYEhJM5A/iLD+c3pFwCd
	Tf6fP+Oll0L1sB0PAcqyj7v5Aamenwknja8gN2hpVbsVJZ94W7ycclLC2A3upoatWkPAeBrJSvZV1
	+GzqDnwtm2TXecXOt/GjROwk+onSLvKx872I8acD1YpOKXnzMqV45SQ0ixebM5h5qMaem5viNZPUT
	6Ubck6OTjkZKO4ZrGvj1fMnDbs1Bu7MrTq6swSofs7w+br9+S7/LNL6X0PupjoLBs4wmO/PsvpDsF
	UFnBiQuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00ZJ-008lgY-Dr; Tue, 29 Nov 2022 13:22:37 +0000
Received: from [2001:4bb8:192:26e7:691d:40a8:d7b5:b2f5] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00ZA-008las-5r; Tue, 29 Nov 2022 13:22:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 5/9] nvme-pci: remove nvme_pci_disable
Date: Tue, 29 Nov 2022 14:22:04 +0100
Message-Id: <20221129132208.4337-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221129132208.4337-1-hch@lst.de>
References: <20221129132208.4337-1-hch@lst.de>
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

nvme_pci_disable has a single caller, fold it into that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c6a02210d22b46..c3d9b23699d3f3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2657,18 +2657,6 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 	pci_release_mem_regions(to_pci_dev(dev->dev));
 }
 
-static void nvme_pci_disable(struct nvme_dev *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
-
-	pci_free_irq_vectors(pdev);
-
-	if (pci_is_enabled(pdev)) {
-		pci_disable_pcie_error_reporting(pdev);
-		pci_disable_device(pdev);
-	}
-}
-
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
 	bool dead = true, freeze = false;
@@ -2708,7 +2696,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	}
 	nvme_suspend_io_queues(dev);
 	nvme_suspend_queue(&dev->queues[0]);
-	nvme_pci_disable(dev);
+	pci_free_irq_vectors(pdev);
+	if (pci_is_enabled(pdev)) {
+		pci_disable_pcie_error_reporting(pdev);
+		pci_disable_device(pdev);
+	}
 	nvme_reap_pending_cqes(dev);
 
 	nvme_cancel_tagset(&dev->ctrl);
-- 
2.30.2


