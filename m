Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB06C54E41
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 14:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i6ZBWJoVrGrdvRvBJUYTrkVc+SIXHoDPMV8L7WkhNCc=; b=ZxJOnwVWGTB2jWGqx7QzbwGD+b
	Olcm1bO00ZqIA4TjQnXBMm5iKCuxBFBE++LZc+yu492EFcK87bSYGI+AE7KtVBr1IsCEUo1k1mh3w
	Ogzp04G+aPisEYgkid12QzM2wTK5q27o5hg3XVnq7sOXXdApBOF6px7MELVfTjao9y7kLlGb7mEVe
	fBTTjtzcH8B6ldpwv5+zdGP4Q3AxgRfWzbEre25+u6FVv6uMNmYHSB+i/oCKK+EoYI7SbCWLhdVk1
	aC2VYHr8UJrih7LsKIefB7062yal/+ZKqVxc3GvDVfGhV/hkyd3y2etscK9A+cXLLia08kZ1wJ32B
	V8cPQklw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8wR-00000009Hgj-2pqW;
	Mon, 04 Mar 2024 14:05:19 +0000
Received: from [206.0.71.24] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8wP-00000009Hfd-0CNQ;
	Mon, 04 Mar 2024 14:05:18 +0000
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
Subject: [PATCH 02/16] nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard
Date: Mon,  4 Mar 2024 07:04:46 -0700
Message-Id: <20240304140500.78583-3-hch@lst.de>
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

Move the handling of the NVME_QUIRK_DEALLOCATE_ZEROES quirk out of
nvme_config_discard so that it is combined with the normal write_zeroes
limit handling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6ae9aedf7bc278..a6c0b2f4cf796e 100644
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


