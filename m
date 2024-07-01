Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5643FC3065A
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 05:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U0Knn9m9suWr0HwuV6YXzPRah7+Yr1TuKS4G5vkqDZc=; b=A0cEuxLQIsAnK4yxcRspKCp2iC
	4BJyyNbqsc9Nbzws30lOpp1p10gEoOsyncFrR5nCco3Wt2fLJfuH9SuajkevfjasPx9MLweYEXt0R
	hRwm62jp8pCdKUs9U2x/UN4wAOXYuWCfy+vim1pmH8s4oZJGp9hLKXwpHJ5QNyT5RrH3NlQiGLsE2
	tNl2NcUxeYbV7d0Oq/jyGMSHni811yxLCbrOv4nTFeXA/jum+jngYA24HwEpiZ0pomjXs0Q1CIZ44
	ahW7umKAYyFoa/aY07kqKE7RzjE6OY/OLm6wyXNsMNAO5kzt68ecIOCGaW+5ym6H77iEJYeg3pbND
	CT/hGAwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9QV-00000001iwJ-3leG;
	Mon, 01 Jul 2024 05:18:07 +0000
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9QS-00000001ivY-3aHR;
	Mon, 01 Jul 2024 05:18:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] block: remove a duplicate io_min check in blk_validate_limits
Date: Mon,  1 Jul 2024 07:17:50 +0200
Message-ID: <20240701051800.1245240-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701051800.1245240-1-hch@lst.de>
References: <20240701051800.1245240-1-hch@lst.de>
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

If io_min is larger than the cap, it must by definition be non-zero.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 2e559cf97cc834..ff8bbc101fedaa 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -279,8 +279,7 @@ static int blk_validate_limits(struct queue_limits *lim)
 	} else if (lim->io_opt) {
 		lim->max_sectors =
 			min(max_hw_sectors, lim->io_opt >> SECTOR_SHIFT);
-	} else if (lim->io_min &&
-		   lim->io_min > (BLK_DEF_MAX_SECTORS_CAP << SECTOR_SHIFT)) {
+	} else if (lim->io_min > (BLK_DEF_MAX_SECTORS_CAP << SECTOR_SHIFT)) {
 		lim->max_sectors =
 			min(max_hw_sectors, lim->io_min >> SECTOR_SHIFT);
 	} else {
-- 
2.43.0


