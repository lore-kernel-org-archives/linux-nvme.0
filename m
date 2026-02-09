Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5978EE6B71
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Feb 2026 08:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FIIS95fEwo+jEe5cxv+20tAPZNHNe4qebAom0W0d6P0=; b=BkJKO2TkQ09LCMkpTMrHHbfSMf
	vYPq16gTgIEAl6Ff4bIwumrFb3f2dHTvzKx4h/Kd7Ekdrd0x3Z0HZC5hpywhRdsVo+eH6c+bhpglA
	srDqwofcFqIuxnRSV1/J+B6n/5TpvzYtAuJERiur/erf8ODV/UPVXNF3eG7VelSAH66Lea7HzGl4X
	IvY7dAgwMIrXS87IsYKNUG99CiZXawyqE6f1adP7PmhU+ud9Sh/5G22md0osnKsTVjmif4Fopr6+O
	MDA8Z2NH2MBzQVZB7+PvRIq3xTOJzInAI0skU1MOQD3eeeT/ywpNpn6hsgrWJqwzcXfgAiDOWzc/D
	x/2Vybmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpMej-0000000F1hu-49vn;
	Mon, 09 Feb 2026 08:30:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpMei-0000000F1gR-1sYX;
	Mon, 09 Feb 2026 08:30:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2F0BF60008;
	Mon,  9 Feb 2026 08:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65620C19422;
	Mon,  9 Feb 2026 08:29:59 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	sven@kernel.org,
	j@jannau.net,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	yukuai@fnnas.com
Subject: [PATCH 1/4] nvme-rdma: move blk_mq_update_nr_hw_queues after nvme_unfreeze
Date: Mon,  9 Feb 2026 16:29:50 +0800
Message-ID: <20260209082953.3053721-2-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209082953.3053721-1-yukuai@fnnas.com>
References: <20260209082953.3053721-1-yukuai@fnnas.com>
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

blk_mq_update_nr_hw_queues() freezes and unfreezes queues internally.
When the queue is already frozen before this call, the freeze depth
becomes 2. The internal unfreeze only decrements it to 1, leaving the
queue still frozen when debugfs_create_files() is called.

This triggers WARN_ON_ONCE(q->mq_freeze_depth != 0) in
debugfs_create_files() and risks deadlock.

Fix this by moving nvme_unfreeze() before blk_mq_update_nr_hw_queues()
so the queue is unfrozen before the call, allowing the internal
freeze/unfreeze to work correctly.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 35c0822edb2d..b0253d90ac86 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -898,9 +898,9 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			nvme_unfreeze(&ctrl->ctrl);
 			goto out_wait_freeze_timed_out;
 		}
+		nvme_unfreeze(&ctrl->ctrl);
 		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
 			ctrl->ctrl.queue_count - 1);
-		nvme_unfreeze(&ctrl->ctrl);
 	}
 
 	/*
-- 
2.51.0


