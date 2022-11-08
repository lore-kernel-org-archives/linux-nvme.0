Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2ADFC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 15:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dPb84pC5XO9PxUo0wPu0hMwTzXlZugKuSjvS13P354A=; b=S3giOjOO6+2rjBb6QDXGeRi6Rr
	05RefS9lSGCCUnYYe+hP7dlyuAnDn71su5pcLWBt0q3mUzioWarlUkpmFcQwHv+Eg7MJS/gBW5lk2
	6vhVs03pXCxd6lVb9Nm8HXZVTG9sJMM+3k9uHcVKA6REFMSICauBN1dJVQ1eVzpXQ5YDciKWtu8Do
	IaXOwUFWB4nwloXKPQA0s/tfiXVvj/6HSHPf8PHU7+QROLS3EOwqEb6p56DgyQKRGzqGx1gy5/gaY
	6JdnO6PiLfYakqpIXgs/xbV1g6reDIhg5siuMEQ4rWrxEHrZ4+nxfrdj/frqxU3LWJOWji506g9zR
	KxCYF2xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osQCH-006EIz-Ki; Tue, 08 Nov 2022 15:07:29 +0000
Received: from [2001:4bb8:191:2450:b4e6:4796:2c38:d4bf] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osQ8J-006Btp-7R; Tue, 08 Nov 2022 15:03:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 10/12] nvme-pci: split nvme_dbbuf_dma_alloc
Date: Tue,  8 Nov 2022 16:02:50 +0100
Message-Id: <20221108150252.2123727-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221108150252.2123727-1-hch@lst.de>
References: <20221108150252.2123727-1-hch@lst.de>
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

Move the clearing of the already allocated doorbell buffer memory to
the caller, and instead move printing the error for the allocation
failure into the helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 45 +++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 64e2bd2d4f61e..1b3c96a4b7c90 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -239,36 +239,28 @@ static inline unsigned int nvme_dbbuf_size(struct nvme_dev *dev)
 	return dev->nr_allocated_queues * 8 * dev->db_stride;
 }
 
-static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
+static void nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
 {
 	unsigned int mem_size = nvme_dbbuf_size(dev);
 
-	if (dev->dbbuf_dbs) {
-		/*
-		 * Clear the dbbuf memory so the driver doesn't observe stale
-		 * values from the previous instantiation.
-		 */
-		memset(dev->dbbuf_dbs, 0, mem_size);
-		memset(dev->dbbuf_eis, 0, mem_size);
-		return 0;
-	}
-
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
@@ -2855,11 +2847,16 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
-	if (dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP) {
-		result = nvme_dbbuf_dma_alloc(dev);
-		if (result)
-			dev_warn(dev->dev,
-				 "unable to allocate dma for dbbuf\n");
+	if (dev->dbbuf_dbs) {
+		/*
+		 * Clear the dbbuf memory so the driver doesn't observe stale
+		 * values from the previous instantiation.
+		 */
+		memset(dev->dbbuf_dbs, 0, nvme_dbbuf_size(dev));
+		memset(dev->dbbuf_eis, 0, nvme_dbbuf_size(dev));
+	} else {
+		if (dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP)
+			nvme_dbbuf_dma_alloc(dev);
 	}
 
 	if (dev->ctrl.hmpre) {
-- 
2.30.2


