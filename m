Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0C0C433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KE6NcInukbfZDCibBSQLpU+dxxMwcKGFFKuMbhvjw8E=; b=oGGO0gNZVWpzytD2EhfFFTn75J
	S4FYQ36Etc+9PuiJkoHnyJW3qDOWkzkWcUMnnGnWokUXhQurxyB8rRcjluaahUW3KujRf+s36cSMp
	TI7ovMW0b5BjD5tTt4EkGRFIQAwDZb6UkIIIyvt909TRl70eGii2IJ9poDr65aPXZ0TSLSl9mRYhA
	xywNHz+q8MH1LcsLV0V5q7B83RBn2pI/10BTfJfNfMS1514JxC8RGPjDC8g2O8uSptjawOVcviuf6
	/0JSmVD0gpO3S2U1jFSbvoMswBl4ZZoXJiv6Ef9CgtYA2AwH8h6CuOp0dJpelgzLWR0bTLQW0aJSm
	++CTldfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFbH-00CCSF-L9; Sun, 13 Nov 2022 16:12:51 +0000
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFan-00CC5F-Ip; Sun, 13 Nov 2022 16:12:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 10/13] nvme-pci: simplify nvme_dbbuf_dma_alloc
Date: Sun, 13 Nov 2022 17:11:35 +0100
Message-Id: <20221113161138.883195-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221113161138.883195-1-hch@lst.de>
References: <20221113161138.883195-1-hch@lst.de>
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

Move the OACS check and the error checking into nvme_dbbuf_dma_alloc so
that an upcoming second caller doesn't have to duplicate this boilerplate
code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c2e3a87237da8..4da339690ec67 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -239,10 +239,13 @@ static inline unsigned int nvme_dbbuf_size(struct nvme_dev *dev)
 	return dev->nr_allocated_queues * 8 * dev->db_stride;
 }
 
-static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
+static void nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
 {
 	unsigned int mem_size = nvme_dbbuf_size(dev);
 
+	if (!(dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP))
+		return;
+
 	if (dev->dbbuf_dbs) {
 		/*
 		 * Clear the dbbuf memory so the driver doesn't observe stale
@@ -250,25 +253,27 @@ static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
 		 */
 		memset(dev->dbbuf_dbs, 0, mem_size);
 		memset(dev->dbbuf_eis, 0, mem_size);
-		return 0;
+		return;
 	}
 
 	dev->dbbuf_dbs = dma_alloc_coherent(dev->dev, mem_size,
 					    &dev->dbbuf_dbs_dma_addr,
 					    GFP_KERNEL);
 	if (!dev->dbbuf_dbs)
-		return -ENOMEM;
+		goto fail;
 	dev->dbbuf_eis = dma_alloc_coherent(dev->dev, mem_size,
 					    &dev->dbbuf_eis_dma_addr,
 					    GFP_KERNEL);
-	if (!dev->dbbuf_eis) {
-		dma_free_coherent(dev->dev, mem_size,
-				  dev->dbbuf_dbs, dev->dbbuf_dbs_dma_addr);
-		dev->dbbuf_dbs = NULL;
-		return -ENOMEM;
-	}
+	if (!dev->dbbuf_eis)
+		goto fail_free_dbbuf_dbs;
+	return;
 
-	return 0;
+fail_free_dbbuf_dbs:
+	dma_free_coherent(dev->dev, mem_size, dev->dbbuf_dbs,
+			  dev->dbbuf_dbs_dma_addr);
+	dev->dbbuf_dbs = NULL;
+fail:
+	dev_warn(dev->dev, "unable to allocate dma for dbbuf\n");
 }
 
 static void nvme_dbbuf_dma_free(struct nvme_dev *dev)
@@ -2855,12 +2860,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
-	if (dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP) {
-		result = nvme_dbbuf_dma_alloc(dev);
-		if (result)
-			dev_warn(dev->dev,
-				 "unable to allocate dma for dbbuf\n");
-	}
+	nvme_dbbuf_dma_alloc(dev);
 
 	if (dev->ctrl.hmpre) {
 		result = nvme_setup_host_mem(dev);
-- 
2.30.2


