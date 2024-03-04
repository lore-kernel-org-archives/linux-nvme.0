Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25504C48BF6
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 14:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dOyMK2ptrXEWDJpz38lQqSuW+FjtDHYyLwOrq25LntQ=; b=rw6XQfiWwAKqbOJ37iLrqigs3H
	fdZ4LrhLfMprcZCApicWf7SifQw+G6WDbAOmUTn54QX6ydPQ4afN/ZZoLj8hs9A1Nnlh8Lm15grXy
	e3fPOIn9ZFCs11Oni6z24j65UcsQLAMOrPDyPcvJOh0EjhGZ7X7iuBIeKz8roa8/YqJGGB0R7YxFP
	YQKHJb06PDMxcbEF53s1SlR+8C6wRepM33YCURsbCSOcwgnEUPAnmf5s6d5Nmt9SJnrh6559i2cS7
	UH5VaixU9RyPcJYX0fCRjH8LUdU0nLoUpAU1eqEVBxQzBXUyp/7/s/1xpQ/OFh9pXCD7DfBRoxMQM
	M9EnvD8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8wd-00000009HmA-2Ent;
	Mon, 04 Mar 2024 14:05:31 +0000
Received: from [206.0.71.24] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8wa-00000009HjK-48p7;
	Mon, 04 Mar 2024 14:05:30 +0000
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
Subject: [PATCH 04/16] nvme: move max_integrity_segments handling out of nvme_init_integrity
Date: Mon,  4 Mar 2024 07:04:48 -0700
Message-Id: <20240304140500.78583-5-hch@lst.de>
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

max_integrity_segments is just a hardware limit and doesn't need to be
in nvme_init_integrity with the PI setup.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2817eea07e967d..c4a268d91796f2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1724,8 +1724,7 @@ int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-static void nvme_init_integrity(struct gendisk *disk,
-		struct nvme_ns_head *head, u32 max_integrity_segments)
+static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns_head *head)
 {
 	struct blk_integrity integrity = { };
 
@@ -1773,11 +1772,9 @@ static void nvme_init_integrity(struct gendisk *disk,
 	integrity.tuple_size = head->ms;
 	integrity.pi_offset = head->pi_offset;
 	blk_integrity_register(disk, &integrity);
-	blk_queue_max_integrity_segments(disk->queue, max_integrity_segments);
 }
 #else
-static void nvme_init_integrity(struct gendisk *disk,
-		struct nvme_ns_head *head, u32 max_integrity_segments)
+static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns_head *head)
 {
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
@@ -1954,6 +1951,7 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 	blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
 	blk_queue_max_segments(q, min_t(u32, USHRT_MAX,
 		min_not_zero(nvme_max_drv_segments(ctrl), ctrl->max_segments)));
+	blk_queue_max_integrity_segments(q, ctrl->max_integrity_segments);
 	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
 	blk_queue_dma_alignment(q, 3);
 	blk_queue_write_cache(q, vwc, vwc);
@@ -2017,8 +2015,7 @@ static void nvme_update_disk_info(struct nvme_ctrl *ctrl, struct gendisk *disk,
 	if (head->ms) {
 		if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
 		    (head->features & NVME_NS_METADATA_SUPPORTED))
-			nvme_init_integrity(disk, head,
-					    ctrl->max_integrity_segments);
+			nvme_init_integrity(disk, head);
 		else if (!nvme_ns_has_pi(head))
 			capacity = 0;
 	}
-- 
2.39.2


