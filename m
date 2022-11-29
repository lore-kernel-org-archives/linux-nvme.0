Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89F8C4321E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 13:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sqS4+cdSfq8GA9u9N8JhTlrYWXrnR2DXm+HcP1+L8Ic=; b=2bAmBAJgLbocSq+AVuZK453QVV
	HF8tDVfv9bGiDhomkonCqONxGNZqo1u4Z72skA/h0CaqKR0nwB+KD6+nhQd8K+RYfqvSAD//w5laJ
	0EBA6rLXoPXc6Xr2/2GE8kTZHS3+e4BLNdJH+yqrJowopSaDrRSoqtU+Pc9SzuwaEywGmWT8oDcdc
	xZ0GsUamoJX5j2qEU8jYIkhNuz3RpbajFNmzLIRJ1gyUimtNg4aFKHqYrqw3M3oOEOEt6+i0un+vg
	mvdrwvSKVWfd0wv9ke7OTxF5uRc1yRD/oB1rIYY9MSx6qg9tPlCY56MBA39anX51zKnH4S7dDTpXn
	TwyfIMQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00ZE-008ldv-PC; Tue, 29 Nov 2022 13:22:32 +0000
Received: from [2001:4bb8:192:26e7:691d:40a8:d7b5:b2f5] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00Z6-008lZr-OX; Tue, 29 Nov 2022 13:22:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 4/9] nvme-pci: remove nvme_disable_admin_queue
Date: Tue, 29 Nov 2022 14:22:03 +0100
Message-Id: <20221129132208.4337-5-hch@lst.de>
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

nvme_disable_admin_queue has only a single caller, and just calls two
other funtions, so remove it to clean up the remove path a little more.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 84226dce9b3b92..c6a02210d22b46 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1496,14 +1496,6 @@ static void nvme_suspend_io_queues(struct nvme_dev *dev)
 		nvme_suspend_queue(&dev->queues[i]);
 }
 
-static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
-{
-	struct nvme_queue *nvmeq = &dev->queues[0];
-
-	nvme_disable_ctrl(&dev->ctrl, shutdown);
-	nvme_poll_irqdisable(nvmeq);
-}
-
 /*
  * Called only on a device that has been disabled and after all other threads
  * that can check this device's completion queues have synced, except
@@ -2711,7 +2703,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 
 	if (!dead && dev->ctrl.queue_count > 0) {
 		nvme_disable_io_queues(dev);
-		nvme_disable_admin_queue(dev, shutdown);
+		nvme_disable_ctrl(&dev->ctrl, shutdown);
+		nvme_poll_irqdisable(&dev->queues[0]);
 	}
 	nvme_suspend_io_queues(dev);
 	nvme_suspend_queue(&dev->queues[0]);
-- 
2.30.2


