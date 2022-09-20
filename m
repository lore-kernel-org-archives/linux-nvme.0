Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E58C54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 17:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OqxAlEPtmkav4SKfqFf0wQs2hk0/Grl7Lm0ATTRBRg4=; b=JC+g4X/0RI2RaigqjoQfK6oVt9
	f2AIVf8FSb1+VLcEdKBJwKosj6ugO0znJiCUtSxTAKxjbRNhQIo4aF6xXVZsg1Eil2NycAmGvafaT
	8SGJ1vMV9ke4uBIXEFwxgDbsG3Q9KsgPdYsNRvj/7cLY7biLGXtF4bE/dt7ASxj2c7wJzTz1R3Xx3
	D10FLtvLtdSittrrc9tyYZA4MaQw5+smVSxLyPrlWL3qi40fzELaxOvad85xwAGUDg42DZq+q4NmH
	TI5sZ7AQjMe9s41oU5UvhYhO0rw1eix3N1f6B5D/mafIWJKry236tyEUA/01Q8G7o2PuyprHVfu06
	SCKSc+mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagro-005Lq1-8p; Tue, 20 Sep 2022 17:17:04 +0000
Received: from [77.247.85.102] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagrQ-005LaE-P7; Tue, 20 Sep 2022 17:16:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 07/13] nvme-fc: keep ctrl->sqsize in sync with opts->queue_size
Date: Tue, 20 Sep 2022 19:16:05 +0200
Message-Id: <20220920171611.1289361-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220920171611.1289361-1-hch@lst.de>
References: <20220920171611.1289361-1-hch@lst.de>
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

Also update the sqsize field when capping the queue size, and remove the
check a queue size that is larger than sqsize given that sqsize is only
initialized from opts->queue_size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/fc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 42767fb754552..ee376111f5610 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3165,15 +3165,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 			"to maxcmd\n",
 			opts->queue_size, ctrl->ctrl.maxcmd);
 		opts->queue_size = ctrl->ctrl.maxcmd;
-	}
-
-	if (opts->queue_size > ctrl->ctrl.sqsize + 1) {
-		/* warn if sqsize is lower than queue_size */
-		dev_warn(ctrl->ctrl.device,
-			"queue_size %zu > ctrl sqsize %u, reducing "
-			"to sqsize\n",
-			opts->queue_size, ctrl->ctrl.sqsize + 1);
-		opts->queue_size = ctrl->ctrl.sqsize + 1;
+		ctrl->ctrl.sqsize = opts->queue_size - 1;
 	}
 
 	ret = nvme_fc_init_aen_ops(ctrl);
-- 
2.30.2


