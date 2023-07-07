Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09126EB64D9
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jul 2023 09:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AC7vG1A2pMZEGPxwZG9McURvrIvQLWC1/NGcjUkvtzc=; b=xOa6aEo3lprHeweOfhBEoh9AGy
	HwoOgPgzYALBAvuXqCANSrs8SkeTppZluaGKu4Omt/PqOn/2Y4QFY8ut9avv5MfGkqpL2lQ0oPkpu
	zc9CLcNcw9M5Xur4BBZYdG4q6B7nN0WHMxyNQmvntOiZXStu14S0cqA1gJrncU44IyL5uQLwcoNXJ
	l8ksKHmPZ39AeCl9W0vEleAOfOPUYmcj9u03aomc6BV2Cc0lEeBbFawfETH7gtbejYYQHxt6x8/Mk
	14Sjdeyq2MTgovxYWozb1jEIJN6Ggz//tP8jGWHwpFoO122FD8PmWTV1hDiZ+84ZbzMtDde9hNvbi
	61z6jg3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHi2u-0049j6-0J;
	Fri, 07 Jul 2023 09:46:36 +0000
Received: from [89.144.223.112] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qHi2s-0049hq-14;
	Fri, 07 Jul 2023 09:46:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/4] nvme: update discard limits in nvme_config_discard
Date: Fri,  7 Jul 2023 11:46:14 +0200
Message-Id: <20230707094616.108430-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707094616.108430-1-hch@lst.de>
References: <20230707094616.108430-1-hch@lst.de>
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

nvme_config_discard currently skips updating the discard limits if they
were set before because blk_queue_max_discard_sectors used to update the
configurable max_discard_sectors limit unconditionally.  Now that this
has been fixed we can update the discard limits even if they were set
to deal with the case of a reset changing the limits after e.g. a
firmware update.

Fixes: 3831761eb859 ("nvme: only reconfigure discard if necessary")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 47d7ba2827ff29..2d6c1f4ad7f5c8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1734,10 +1734,6 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 
 	queue->limits.discard_granularity = size;
 
-	/* If discard is already enabled, don't reset queue limits */
-	if (queue->limits.max_discard_sectors)
-		return;
-
 	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
 	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
 
-- 
2.39.2


