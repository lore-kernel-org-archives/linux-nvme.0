Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5EFC5478C
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 14:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lz/u6g+BaZm0j76fBeLBRUF7ggXFm8PkVTCQUViNddw=; b=tUTEk8NuGjOrVvWjtASvIkDQ93
	QoINAk17kiuFb1WfReoiisj0ocUBQt7/5QYNn2tH9hZsXx4cvo1tFfAUd+zxipDbDDb1geGQlbv7N
	QNIs6ASMZBFWFFI1di9xXDFTSxlTNCvlMttO5mut/YPVLrueEZMMjnrXazS/SIASXCOuvD3+Ymmvh
	grcU9zD4NKBvIguncxk9SyVUvT5gZqQ5V7PjLFU76MVCbJe+0hvvHMkQDxNDju2/nAjGuC66VevGl
	ls+8cN7+asz1x7zGSBz7bPoAoPMNO2hooBX0o2ok7/BXE5nOsPP5jHP9Sr6ceDGxC8I04fqp8CLZg
	7QzgiCgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8wu-00000009Huj-0UjT;
	Mon, 04 Mar 2024 14:05:48 +0000
Received: from [206.0.71.24] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8wq-00000009Hrb-2zTv;
	Mon, 04 Mar 2024 14:05:45 +0000
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
Subject: [PATCH 07/16] nvme: don't use nvme_update_disk_info for the multipath disk
Date: Mon,  4 Mar 2024 07:04:51 -0700
Message-Id: <20240304140500.78583-8-hch@lst.de>
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
index 40fab7c47eae24..d356f3fa2cf8eb 100644
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


