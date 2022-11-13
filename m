Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397B6C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 16:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JskPbanT7ns+OWNy0b/lpfB1mdd2cepy0iLXfthLb7w=; b=F/3Yzp3cYW3MoiYJfa9xOc6Jwp
	MvWQhX9W2fnES4aa7KEhv0poeEZOF5c/8dC4pj4wWafrqGpHPbJsYr0LH2IUC5zBbAz/21tn9Zi6V
	2rs8ugZwBKXFFGIHccoXdD4WmsNMAXt4Uj7a8/zoV0wGPYh4vq2vlh3ntvFFCfyCoYEoHI6GP32Xt
	VihbWqdUR+G/qv7HkrGCSv7YuqRNgJ1bZvAQ+FKigzXx9Hu4fVifwMQ4wajWqCuRWT2Xzxcp31cLj
	RUsnCHoYQzQJQSKOWq45OI71XXWnpTZgEa5amHTGpArxa5vA33xuKvQbjoU3mzvjxv6SkHPcYZXkj
	uy5/uGjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFaw-00CCDU-Ml; Sun, 13 Nov 2022 16:12:30 +0000
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFaf-00CBzw-Pn; Sun, 13 Nov 2022 16:12:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 08/13] nvme-pci: set constant paramters in nvme_pci_alloc_ctrl
Date: Sun, 13 Nov 2022 17:11:33 +0100
Message-Id: <20221113161138.883195-9-hch@lst.de>
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

Move setting of low-level constant parameters from nvme_reset_work to
nvme_pci_alloc_ctrl.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Tested-by Gerd Bayer <gbayer@linxu.ibm.com>
---
 drivers/nvme/host/pci.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 03c83cd724ec5..9dcb35f148009 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2841,21 +2841,6 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_start_admin_queue(&dev->ctrl);
 	}
 
-	dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
-
-	/*
-	 * Limit the max command size to prevent iod->sg allocations going
-	 * over a single page.
-	 */
-	dev->ctrl.max_hw_sectors = min_t(u32,
-		NVME_MAX_KB_SZ << 1, dma_max_mapping_size(dev->dev) >> 9);
-	dev->ctrl.max_segments = NVME_MAX_SEGS;
-
-	/*
-	 * Don't limit the IOMMU merged segment size.
-	 */
-	dma_set_max_seg_size(dev->dev, 0xffffffff);
-
 	mutex_unlock(&dev->shutdown_lock);
 
 	/*
@@ -2869,12 +2854,6 @@ static void nvme_reset_work(struct work_struct *work)
 		goto out;
 	}
 
-	/*
-	 * We do not support an SGL for metadata (yet), so we are limited to a
-	 * single integrity segment for the separate metadata pointer.
-	 */
-	dev->ctrl.max_integrity_segments = 1;
-
 	result = nvme_init_ctrl_finish(&dev->ctrl, was_suspend);
 	if (result)
 		goto out;
@@ -3133,6 +3112,23 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 			     quirks);
 	if (ret)
 		goto out_put_device;
+	
+	dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
+	dma_set_max_seg_size(&pdev->dev, 0xffffffff);
+
+	/*
+	 * Limit the max command size to prevent iod->sg allocations going
+	 * over a single page.
+	 */
+	dev->ctrl.max_hw_sectors = min_t(u32,
+		NVME_MAX_KB_SZ << 1, dma_max_mapping_size(&pdev->dev) >> 9);
+	dev->ctrl.max_segments = NVME_MAX_SEGS;
+
+	/*
+	 * There is no support for SGLs for metadata (yet), so we are limited to
+	 * a single integrity segment for the separate metadata pointer.
+	 */
+	dev->ctrl.max_integrity_segments = 1;
 	return dev;
 
 out_put_device:
-- 
2.30.2


