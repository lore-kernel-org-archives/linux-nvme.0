Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBDCC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 15:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tdhX9v7AJD/H5YPJtsmtpqrKqOr13jzEpQfZYNXRTgQ=; b=kU1KtASLTok4hajXtLaBArpLwd
	JCfmpPEj/bomcuKHBzh5Jn+C8uUOSvaa3U2PNNldQzZBicONMImb9QkgqXZKlrJHHmI3PgSSKX8Bz
	my9DVcaMNGfRYOMk2pX9aN4q8oBxa37DnPJjQzKhqxAb3sWviXwPJgXZ2ZsZ+BDeME8c3hC1LyOPm
	gwM+1GK3rhD1+WMt+RKyX1asTMAh0RtVC/RRBafm71GLX47SFdY2tn9+tBcN8CyGwIfUuNbDiCiK9
	TylrxKxOqHgv7FELUw6witLPzVJrpn8tE5MFiP62boIccmFUmfI5beb8CbBUE9TVjAa4wtiYmnNZJ
	gq6AFErg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osQBA-006DY2-U3; Tue, 08 Nov 2022 15:06:20 +0000
Received: from [2001:4bb8:191:2450:b4e6:4796:2c38:d4bf] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osQ8D-006Brz-Oz; Tue, 08 Nov 2022 15:03:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 08/12] nvme-pci: set constant paramters in nvme_pci_alloc_ctrl
Date: Tue,  8 Nov 2022 16:02:48 +0100
Message-Id: <20221108150252.2123727-9-hch@lst.de>
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

Move setting of low-level constant parameters from nvme_reset_work to
nvme_pci_alloc_ctrl.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e1f60b1c6918f..87f7c8f5699ec 100644
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
@@ -3133,6 +3112,23 @@ static struct nvme_dev *nvme_pci_alloc_ctrl(struct pci_dev *pdev,
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


