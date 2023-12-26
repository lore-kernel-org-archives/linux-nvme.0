Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9F5C46CD4
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Dec 2023 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IX2hFBVseSLmXpGcVawyAqPPixafe24/o4s6aqFA9Hs=; b=qf14MmHpekKAF4Kh5ZwB4n+Yc8
	bW016eugI8x4/8e/ufqAjyMZbr6PKvHQsaOnUe6QQ4qzDNjcSS3wpIiNuxMfsWr9MPhDAqE3JStZy
	sHH7dYCYOh9RzNhfJAw9UOpoV3inUFxnsB1R21h9msRGVoNapwe9JJskFffrHh3w7K7R5Sap/H2+y
	gAyeXvLBoWFFN8L0LfUz3N6lA0ovSHu2OghFzx7S5PH19HxeB2BNOHdEjEAvjy7FyK5Azoyer1kak
	Ao9PQPoJeN27mGeZOJNWpuE8T0UopSwzMv73UtsVeVhrau9hKWcUl9zbKBjcokPl+K94isDvUelPZ
	mWZFLQGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rI3HF-00Bw0X-0O;
	Tue, 26 Dec 2023 08:59:05 +0000
Received: from [89.144.222.247] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rI3HD-00Bvyr-0T;
	Tue, 26 Dec 2023 08:59:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/4] nvme: also skip discard granularity updates in nvme_config_discard
Date: Tue, 26 Dec 2023 08:58:42 +0000
Message-Id: <20231226085844.203878-3-hch@lst.de>
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

Don't just skip the discard sectors and segments but also the granularity
if a value was already set before.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 56107cfc97b7bc..6c52b0ab382c85 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1727,7 +1727,6 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
 		struct nvme_ns_head *head)
 {
 	struct request_queue *queue = disk->queue;
-	u32 size = queue_logical_block_size(queue);
 
 	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(head, UINT_MAX))
 		ctrl->max_discard_sectors =
@@ -1741,8 +1740,6 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
 	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
 			NVME_DSM_MAX_RANGES);
 
-	queue->limits.discard_granularity = size;
-
 	/*
 	 * If discard is already enabled, don't reset queue limits.
 	 *
@@ -1755,6 +1752,7 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
 
 	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
 	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
+	queue->limits.discard_granularity = queue_logical_block_size(queue);
 
 	if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
 		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
-- 
2.39.2


