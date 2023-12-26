Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34B6C46CD3
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Dec 2023 08:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3kZXvp/gPXFBeAnMUgrGHsnFZo9JvRkzCHnvmzGz364=; b=Oli2X5J6+/HEolEN3ih9O/Whn8
	7+OvbjO/hqF2J5/0zHfQvEwqrknE0EMCsjeDGokUmx8hutmiiQx3f24elv/hZ/sxuTWxO5pCf90En
	TucF7H9gLcvV3K4H0mfLoRH0xnpBpeAMqRaYNIXt5tUt7i/RZd7baKZiuMstLDx+1EJK1ks+sVv+B
	ytS0MtFdelBUWDJixu0E2PEljUjUBeKsoiNDmvv/U+IJXwx60oPshbAnpwRVwN32QVlYrJs2NY3YT
	ByA9X2DnwZfELeFjPizYv1ky0M/Rzn89erLHg59W976HeiVb2YCS7cx1gcTLwqepYwfm5qgHbNfey
	yrSOMzew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rI3HM-00Bw2D-0S;
	Tue, 26 Dec 2023 08:59:12 +0000
Received: from [89.144.222.247] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rI3HJ-00Bw0a-0E;
	Tue, 26 Dec 2023 08:59:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 3/4] nvme: fix max_discard_sectors calculation
Date: Tue, 26 Dec 2023 08:58:43 +0000
Message-Id: <20231226085844.203878-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231226085844.203878-1-hch@lst.de>
References: <20231226085844.203878-1-hch@lst.de>
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

ctrl->max_discard_sectors stores a value that is potentially based of
the DMRSL field in Identify Controller, which is in units of LBAs and
thus dependent on the Format of a namespace.

Fix this by moving the calculation of max_discard_sectors entirely
into nvme_config_discard and replacing the ctrl->max_discard_sectors
value with a local variable so that the calculation is always
namespace-specific.

Fixes: 1a86924e4f46 ("nvme: fix interpretation of DMRSL")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 20 +++++++++-----------
 drivers/nvme/host/nvme.h |  1 -
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6c52b0ab382c85..86b9a1c4876f5f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1727,12 +1727,13 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
 		struct nvme_ns_head *head)
 {
 	struct request_queue *queue = disk->queue;
+	u32 max_discard_sectors;
 
-	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(head, UINT_MAX))
-		ctrl->max_discard_sectors =
-			nvme_lba_to_sect(head, ctrl->dmrsl);
-
-	if (ctrl->max_discard_sectors == 0) {
+	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(head, UINT_MAX)) {
+		max_discard_sectors = nvme_lba_to_sect(head, ctrl->dmrsl);
+	} else if (ctrl->oncs & NVME_CTRL_ONCS_DSM) {
+		max_discard_sectors = UINT_MAX;
+	} else {
 		blk_queue_max_discard_sectors(queue, 0);
 		return;
 	}
@@ -1750,7 +1751,7 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
 	if (queue->limits.max_discard_sectors)
 		return;
 
-	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
+	blk_queue_max_discard_sectors(queue, max_discard_sectors);
 	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
 	queue->limits.discard_granularity = queue_logical_block_size(queue);
 
@@ -2911,13 +2912,10 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	struct nvme_id_ctrl_nvm *id;
 	int ret;
 
-	if (ctrl->oncs & NVME_CTRL_ONCS_DSM) {
-		ctrl->max_discard_sectors = UINT_MAX;
+	if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
 		ctrl->max_discard_segments = NVME_DSM_MAX_RANGES;
-	} else {
-		ctrl->max_discard_sectors = 0;
+	else
 		ctrl->max_discard_segments = 0;
-	}
 
 	/*
 	 * Even though NVMe spec explicitly states that MDTS is not applicable
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 3dbd187896d8d8..9a698c49ea0364 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -297,7 +297,6 @@ struct nvme_ctrl {
 	u32 max_hw_sectors;
 	u32 max_segments;
 	u32 max_integrity_segments;
-	u32 max_discard_sectors;
 	u32 max_discard_segments;
 	u32 max_zeroes_sectors;
 #ifdef CONFIG_BLK_DEV_ZONED
-- 
2.39.2


