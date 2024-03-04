Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1F7C48BF6
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 14:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fAfN2af5jtAk4J06WzedZD1OoJhGAyL9gXSoILZXeJ0=; b=mwXmY3K0O128aRwWbvF7+0lh5c
	RQyqIZQByl8v7y1PY+apPzkF1kMdDOK19GkyScTig3p9kMue/CV4tlYqUiEQy8FzDqUC74HQxjCTA
	/rrMnP3E39aQmk5MN4sNUWzEugQDEkowA9uyp/zHhD2OcC6ujuzVkgP3sWt/X/QD8S4I8JXs8U1cx
	y8BBY9Ucv09T1AbZZL374AcyYc0FOSg7E7Oc1c0rXm+SbtZMmJX4UufjHNqGwJM2gL3Wr6DJbBNU0
	CTaSTs7t0TzAW6RRf26L89amLIoih52ffQoCcdngtFYzPRMK397F2kOxlDFbWL3HmH8rXrnHD54fw
	aRpKoFwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8xt-00000009Iav-0JcY;
	Mon, 04 Mar 2024 14:06:49 +0000
Received: from [206.0.71.24] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8xh-00000009ISB-1a0j;
	Mon, 04 Mar 2024 14:06:39 +0000
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
Subject: [PATCH 16/16] nvme-multipath: use atomic queue limits API for stacking limits
Date: Mon,  4 Mar 2024 07:05:00 -0700
Message-Id: <20240304140500.78583-17-hch@lst.de>
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

Switch to the queue_limits_* helpers to stack the bdev limits, which also
includes updating the readahead settings.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6413ce24fb4b1c..3f985b93a19f98 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2188,6 +2188,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	}
 
 	if (!ret && nvme_ns_head_multipath(ns->head)) {
+		struct queue_limits lim;
+
 		blk_mq_freeze_queue(ns->head->disk->queue);
 		if (unsupported)
 			ns->head->disk->flags |= GENHD_FL_HIDDEN;
@@ -2196,10 +2198,11 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
 		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
 		nvme_mpath_revalidate_paths(ns);
-		blk_stack_limits(&ns->head->disk->queue->limits,
-				 &ns->queue->limits, 0);
 
-		disk_update_readahead(ns->head->disk);
+		lim = queue_limits_start_update(ns->head->disk->queue);
+		queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
+					ns->head->disk->disk_name);
+		ret = queue_limits_commit_update(ns->head->disk->queue, &lim);
 		blk_mq_unfreeze_queue(ns->head->disk->queue);
 	}
 
-- 
2.39.2


