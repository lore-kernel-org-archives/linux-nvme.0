Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3905EC5478C
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 14:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=srPAaXD84GtFyIb0hxHH8yNM2Wm+rIoF6ypTyDb0y3g=; b=1AeHnNzdQpocVA2wB8vTSynM1D
	8gLxFayYjNgK16jsHgz7AMadl5iXszbts468H5FX+/Hnc5O/BAq8c4lBtO9we8OkIBQ6aRxZVLEYE
	nlqKIALMs+PE9nlkuV6BDvyJ/br8ZEAL2aYRfOe+8XDGbtquREW4UHsFrt66HW5ntgsEGcF794fhY
	MBMBa39NcDd2qQZot9bH6YMXo+HpQ9D/ssfwhti38rMSiQ86al45VpPntO6S1KkF40LW/NVTlshoa
	BhwOLO82voX4mWam3Z9rDBrV7IOWrq3ddEv4Y+p9KlmdLpZ7c9SCmI2HzEuJMd4+7LlVkeNfAq6MY
	3wZPBXAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8wP-00000009Hfg-2xff;
	Mon, 04 Mar 2024 14:05:17 +0000
Received: from [206.0.71.24] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8wJ-00000009Hem-3uWO;
	Mon, 04 Mar 2024 14:05:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 01/16] nvme: set max_hw_sectors unconditionally
Date: Mon,  4 Mar 2024 07:04:45 -0700
Message-Id: <20240304140500.78583-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304140500.78583-1-hch@lst.de>
References: <20240304140500.78583-1-hch@lst.de>
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

All transports set a max_hw_sectors value in the nvme_ctrl, so make
the code using it unconditional and clean it up using a little helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cb13f7c79eaf9c..6ae9aedf7bc278 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1944,19 +1944,19 @@ static int nvme_configure_metadata(struct nvme_ctrl *ctrl,
 	return 0;
 }
 
+static u32 nvme_max_drv_segments(struct nvme_ctrl *ctrl)
+{
+	return ctrl->max_hw_sectors / (NVME_CTRL_PAGE_SIZE >> SECTOR_SHIFT) + 1;
+}
+
 static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 		struct request_queue *q)
 {
 	bool vwc = ctrl->vwc & NVME_CTRL_VWC_PRESENT;
 
-	if (ctrl->max_hw_sectors) {
-		u32 max_segments =
-			(ctrl->max_hw_sectors / (NVME_CTRL_PAGE_SIZE >> 9)) + 1;
-
-		max_segments = min_not_zero(max_segments, ctrl->max_segments);
-		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
-		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
-	}
+	blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
+	blk_queue_max_segments(q, min_t(u32, USHRT_MAX,
+		min_not_zero(nvme_max_drv_segments(ctrl), ctrl->max_segments)));
 	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
 	blk_queue_dma_alignment(q, 3);
 	blk_queue_write_cache(q, vwc, vwc);
-- 
2.39.2


