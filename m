Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B9AC5478C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 18:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6qmqyp3X6vguqRsPEv+PAHrA12TOnC+qT7k44PIG4D8=; b=XbhPm2j1I9NbUNbCxsLQMZegU+
	JC9Wgv9IjjuhlYDwcWHLNK5uxizsEwbnMIMgwUiDIxgTv28dm8+05kEvd67jFaRJsNXuMVvUV2dXb
	Aam3EVIVlnkemEDFGg8CW6DhUnhQdpKJQ7PDAUwOvwyScRcGNfL2uKwTtxYXKJxwSSYPceQVGxqBZ
	rVFqf+V0BHuj/JKByMfAN6yQlQ2qdVlUYOyE2lJG0ztovzwyXjuSUkOWhKNyLMsfEaBsmXycpnjSE
	xcZgYvSsYkyUzBaEZj6Ap2F0CwhhpMKdXh2Eb8IE9Ii4nateJmBEkoarCltvHEWTDufwOb8y2UVb7
	cER0Sixw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOQ8-0000000ARU7-1I7E;
	Wed, 28 Feb 2024 18:12:44 +0000
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOPl-0000000AREV-0bfr;
	Wed, 28 Feb 2024 18:12:21 +0000
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
Subject: [PATCH 09/21] nvme: don't use nvme_update_disk_info for the multipath disk
Date: Wed, 28 Feb 2024 10:12:03 -0800
Message-Id: <20240228181215.873854-10-hch@lst.de>
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

Currently nvme_update_ns_info_block calls nvme_update_disk_info both for
the namespace attached disk, and the multipath one (if it exists).  This
is very different from how other stacking drivers work, and leads to
a lot of complexity.

Switch to setting the disk capacity and initializing the integrity
profile, and let blk_stack_limits which already is called just below
deal with updating the other limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 105046a7957272..0bf30580f29d5b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2159,7 +2159,8 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 
 	if (nvme_ns_head_multipath(ns->head)) {
 		blk_mq_freeze_queue(ns->head->disk->queue);
-		nvme_update_disk_info(ns->ctrl, ns->head->disk, ns->head, id);
+		nvme_init_integrity(ns->head->disk, ns->head);
+		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
 		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
 		nvme_mpath_revalidate_paths(ns);
 		blk_stack_limits(&ns->head->disk->queue->limits,
-- 
2.39.2


