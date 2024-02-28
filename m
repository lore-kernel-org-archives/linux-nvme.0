Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F8AC5478C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 18:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zm4JLbDZWW3cDD71wNL5k2UJHQkkbzAlAsf9BMN7mGQ=; b=08E3/KIpugSvJPrX/9cXvxNfjO
	u5JhKT3714Ty6vm1y/VM4lBjGgZ91WA7/LY0n+XmrHVkBLCxDBeb+nB+oDK1h1S1GTLISruo0C/31
	l+DajLfYhevJwSZZRRmxMRbVtDlJQYTTrwzowSGRA0IHA5a7JpiT4bmN4oYmr9g4/OT5re3G9w2bT
	CimsPJLJAGKkh2ui5NMgxhXXaY14oA8nHimE5qewNz0XvuV/wDS1sgJx5AuHJzvitdzbU5C/tPMm0
	++WeZprwUW0ruI1NpwuZZCv6/YhSsMc/DIvBQPnrqmsRJG50HOtz1/1aRw0Q/O4uTur3x1nC1EBMf
	aMJgpPMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOPx-0000000ARNQ-17Aw;
	Wed, 28 Feb 2024 18:12:33 +0000
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOPk-0000000ARDg-0wGq;
	Wed, 28 Feb 2024 18:12:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 06/21] nvme: move max_integrity_segments handling out of nvme_init_integrity
Date: Wed, 28 Feb 2024 10:12:00 -0800
Message-Id: <20240228181215.873854-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228181215.873854-1-hch@lst.de>
References: <20240228181215.873854-1-hch@lst.de>
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
---
 drivers/nvme/host/core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4a05045e409904..94d835f9dc90e9 100644
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


