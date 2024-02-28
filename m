Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F9DC5478C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 18:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g1hf0PV9tDActAZ78IxZXAhJOYzxZnd6FmjGsbrzvYk=; b=S24kzDXp4Q6OVG4YQFtS5AZY9U
	GfHwRqVpqNsTD2vXWT1YES6VQKIxDUSugCiFMOT+CIfU79aqCJRSCH2CXDGrj1wZ1u3FglBP/t9oc
	uCnu2UVHO4j0mWUBcoD6ITtpsr9Y+lpSuG9O3XmARSEBvmK9MWnEmD1m7jV0qvtIvCoPH0JofPPbK
	fqF/gnVd4RFhE4pB5xl6UXvCD6aetqrXmMv6HHiGq1KIle7sgbyIOfijQtEcr+AZbNQZjzNWg4c6R
	1w0U7TCEFzz5S9X3zspEXLpxF/WR7+TMJGXYCuFeGr2TaQmSnRx3J+nIMBc+cYOitXZGfgNSwfjeP
	A5aLGDEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOQE-0000000ARYq-215l;
	Wed, 28 Feb 2024 18:12:50 +0000
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOPm-0000000ARFq-0839;
	Wed, 28 Feb 2024 18:12:22 +0000
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
Subject: [PATCH 11/21] nvme: move setting the write cache flags out of nvme_set_queue_limits
Date: Wed, 28 Feb 2024 10:12:05 -0800
Message-Id: <20240228181215.873854-12-hch@lst.de>
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

nvme_set_queue_limits is used on the admin queue and all gendisks
including hidden ones that don't support block I/O.  The write cache
setting on the other hand only makes sense for block I/O.  Move the
blk_queue_write_cache call to nvme_update_ns_info_block instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3d839945edd85d..dcb8d0590ed0f3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1954,15 +1954,12 @@ static u32 nvme_max_drv_segments(struct nvme_ctrl *ctrl)
 static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 		struct request_queue *q)
 {
-	bool vwc = ctrl->vwc & NVME_CTRL_VWC_PRESENT;
-
 	blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
 	blk_queue_max_segments(q, min_t(u32, USHRT_MAX,
 		min_not_zero(nvme_max_drv_segments(ctrl), ctrl->max_segments)));
 	blk_queue_max_integrity_segments(q, ctrl->max_integrity_segments);
 	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
 	blk_queue_dma_alignment(q, 3);
-	blk_queue_write_cache(q, vwc, vwc);
 }
 
 static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id)
@@ -2093,6 +2090,7 @@ static int nvme_update_ns_info_generic(struct nvme_ns *ns,
 static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		struct nvme_ns_info *info)
 {
+	bool vwc = ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT;
 	struct nvme_id_ns *id;
 	sector_t capacity;
 	unsigned lbaf;
@@ -2154,6 +2152,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3)))
 		ns->head->features |= NVME_NS_DEAC;
 	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
+	blk_queue_write_cache(ns->disk->queue, vwc, vwc);
 	set_bit(NVME_NS_READY, &ns->flags);
 	blk_mq_unfreeze_queue(ns->disk->queue);
 
-- 
2.39.2


