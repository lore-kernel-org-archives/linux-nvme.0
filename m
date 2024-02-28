Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FD6C5478C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 18:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bP1BMOdz5eRXCtql9e1ghRRopFUjHFxglKPL1jDlH0I=; b=A8cwNNie6Ow7povwlGn6yC306d
	1ZMV07mbVzY0Q//IVBV6yLgyTFwOz/ASdxEAI3DYrSmQdWqYdCBe130ZSUmUYZGd8Qw6a28h1J8KP
	qfWXTGwLQXY02NaY4nKZeBBssTaHWpA2+5BekP1OIPfABQld4096fD8KQa2kfS5v/IZ9zAZ0V5CD3
	WUrqA7TJUkh6YPo2KkzbIZjMvEg1alBmSEuDNEv9DJUOtj2By2wgFbkSvQEZ+AXkWixVRCfVHcqja
	Z31jb7CPuZ+OfXJiqm4EOp3NoLdkNwLMjqPb2SGgl38nhSN5YaSYEjWGDXV6vy3oSBieBsjdfXGWf
	WBuZ9phQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOQQ-0000000ARjW-1Uov;
	Wed, 28 Feb 2024 18:13:02 +0000
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOPp-0000000ARI3-1j3V;
	Wed, 28 Feb 2024 18:12:25 +0000
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
Subject: [PATCH 17/21] nvme-loop: initialize max_hw_sectors earlier
Date: Wed, 28 Feb 2024 10:12:11 -0800
Message-Id: <20240228181215.873854-18-hch@lst.de>
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

Initialize max_hw_sectors a little earlier so that
nvme_alloc_admin_tag_set can rely on it to set the initial queue limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/loop.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index e589915ddef85c..d8e33427a921bb 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -351,6 +351,8 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	if (error)
 		return error;
 	ctrl->ctrl.queue_count = 1;
+	ctrl->ctrl.max_hw_sectors =
+		(NVME_LOOP_MAX_SEGMENTS - 1) << PAGE_SECTORS_SHIFT;
 
 	error = nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
 			&nvme_loop_admin_mq_ops,
@@ -372,9 +374,6 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	if (error)
 		goto out_cleanup_tagset;
 
-	ctrl->ctrl.max_hw_sectors =
-		(NVME_LOOP_MAX_SEGMENTS - 1) << PAGE_SECTORS_SHIFT;
-
 	nvme_unquiesce_admin_queue(&ctrl->ctrl);
 
 	error = nvme_init_ctrl_finish(&ctrl->ctrl, false);
-- 
2.39.2


