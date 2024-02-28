Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680C2C47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 18:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1dZtXajpuKMdF1sDdjnE03FH/3FGPZJEuDV9A08Ydro=; b=W8O/HKS7RRcHOMs+TmGhNpyw+q
	JFufI49JvwSuBK5hIX+CebH7C0RVj0jdybvdCAjCX4QcuST+WvH9DT4gA5EUyX2hjC8xtcCK7t9rB
	srTYTJjOhYTN35Exa5o6i6xf3KpHc0qrWCqAIrHxHgjoMujUCz7n6U5bu6fpzCsVn+YOXUqAwQCxy
	uiqIxmWsjKrG16OxZAj5wsJm6DphyGJGOholDY0E4/dJuL87KR3rc2g+v2FtXtWQr/GscqhCAzcac
	rvKYAzP41fxgvTJ+vnmRbWU6e/vvRmkiTSQrNgase8TD4Tcjffd0Ej6pJTFtp+VcMsOJdvDodLIh1
	27zgAp5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOPt-0000000ARKd-3McK;
	Wed, 28 Feb 2024 18:12:29 +0000
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOPj-0000000ARDI-17cG;
	Wed, 28 Feb 2024 18:12:19 +0000
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
Subject: [PATCH 04/21] nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard
Date: Wed, 28 Feb 2024 10:11:58 -0800
Message-Id: <20240228181215.873854-5-hch@lst.de>
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

Move the handling of the NVME_QUIRK_DEALLOCATE_ZEROES quirk out of
nvme_config_discard so that it is combined with the normal write_zeroes
limit handling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 74cd384ca5fc73..ee1e13a658c314 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1816,9 +1816,6 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
 	else
 		blk_queue_max_discard_segments(queue, NVME_DSM_MAX_RANGES);
 	queue->limits.discard_granularity = queue_logical_block_size(queue);
-
-	if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
-		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
 }
 
 static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
@@ -2029,8 +2026,12 @@ static void nvme_update_disk_info(struct nvme_ctrl *ctrl, struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(ctrl, disk, head);
-	blk_queue_max_write_zeroes_sectors(disk->queue,
-					   ctrl->max_zeroes_sectors);
+
+	if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
+		blk_queue_max_write_zeroes_sectors(disk->queue, UINT_MAX);
+	else
+		blk_queue_max_write_zeroes_sectors(disk->queue,
+				ctrl->max_zeroes_sectors);
 }
 
 static bool nvme_ns_is_readonly(struct nvme_ns *ns, struct nvme_ns_info *info)
-- 
2.39.2


