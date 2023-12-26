Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5596C46CD3
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Dec 2023 08:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=elqdaWbqyaqltl5Ygx+qXK9f+ginFO29Fda7oZPZ+ec=; b=3KQPGAjS4UWsd1T1/lMo20LYHo
	XD6BcjO4iWmtR4yObR7cmqMGjLnfXZHhpbobvQ/ZMBK6g5cieQTABB7ZkBMxWH6Mxr9vCISv5l8Z5
	I0NO0JC/UkaLqlR866Z68pszcJHvliD34n7Ynqxx4KTOcrO+TRdA6RROWazDtl7tTCLYgdpc7NPHt
	H7g4xDfP5cvJTUi1qW0RymE+6DDgYUntDYFu7egYotJMvjoAQ19q6hq0bzdng2LLx+j0rcSHhE0yX
	mj/+BwYDdOzMnW+c0Uz+8Z9MfgI7J79AV3cssAjfFD1wgNyLknKh4dwmwa6lObi/FVJspQpME8owQ
	Ea/2z1VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rI3HR-00Bw4u-0j;
	Tue, 26 Dec 2023 08:59:17 +0000
Received: from [89.144.222.247] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rI3HO-00Bw1k-02;
	Tue, 26 Dec 2023 08:59:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 4/4] nvme: simplify the max_discard_segments calculation
Date: Tue, 26 Dec 2023 08:58:44 +0000
Message-Id: <20231226085844.203878-5-hch@lst.de>
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

Just stash away the DMRL value in the nvme_ctrl struture, and leave
all interpretation to nvme_config_discard, where we know DSM is
supported by the time we're configuring the number of segments.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 13 +++++--------
 drivers/nvme/host/nvme.h |  2 +-
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 86b9a1c4876f5f..50818dbcfa1ae1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1752,7 +1752,10 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
 		return;
 
 	blk_queue_max_discard_sectors(queue, max_discard_sectors);
-	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
+	if (ctrl->dmrl)
+		blk_queue_max_discard_segments(queue, ctrl->dmrl);
+	else
+		blk_queue_max_discard_segments(queue, NVME_DSM_MAX_RANGES);
 	queue->limits.discard_granularity = queue_logical_block_size(queue);
 
 	if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
@@ -2912,11 +2915,6 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	struct nvme_id_ctrl_nvm *id;
 	int ret;
 
-	if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
-		ctrl->max_discard_segments = NVME_DSM_MAX_RANGES;
-	else
-		ctrl->max_discard_segments = 0;
-
 	/*
 	 * Even though NVMe spec explicitly states that MDTS is not applicable
 	 * to the write-zeroes, we are cautious and limit the size to the
@@ -2946,8 +2944,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	if (ret)
 		goto free_data;
 
-	if (id->dmrl)
-		ctrl->max_discard_segments = id->dmrl;
+	ctrl->dmrl = id->dmrl;
 	ctrl->dmrsl = le32_to_cpu(id->dmrsl);
 	if (id->wzsl)
 		ctrl->max_zeroes_sectors = nvme_mps_to_sectors(ctrl, id->wzsl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9a698c49ea0364..297b80430f1b69 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -297,13 +297,13 @@ struct nvme_ctrl {
 	u32 max_hw_sectors;
 	u32 max_segments;
 	u32 max_integrity_segments;
-	u32 max_discard_segments;
 	u32 max_zeroes_sectors;
 #ifdef CONFIG_BLK_DEV_ZONED
 	u32 max_zone_append;
 #endif
 	u16 crdt[3];
 	u16 oncs;
+	u8 dmrl;
 	u32 dmrsl;
 	u16 oacs;
 	u16 sqsize;
-- 
2.39.2


