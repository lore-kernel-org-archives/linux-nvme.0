Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0E0C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 14:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QOO5RwoiW79cmpMlRxi7Z1RxDCv6vfH7Acb+wA+okLE=; b=DaAdW2pnDjuqHDcImvSDVlJ481
	w70lF+z+Ew6kPBgGtK21O7JeGdPkOKQUaUX1C1bod4nagvuL9hXU0wSPNC7LNAygnqMi3AUyz7HUg
	BSZe5p/sT/KnIto/OJUOSxEcVpG06P0/9lGSvzhBQqXwzRV9IDeX9tvHPWJrvOLrhi0Z3EyMjPQkE
	bueJCsStv23z+B/bry72hUIwlaPtzBLiQ2zVsHUOYq0Sg3MJHvcsEogBcVsyBhQBdERt1vuewgqCA
	/7RuqZ0tgVwssmKFUlegVjqvNcPp9F1F+Wd0tpKVUYDqa5d7fi7AsrI1eg3fWWY766iV2VZ2mTk00
	NUqW3csA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKL2n-007JCO-F9; Wed, 16 Feb 2022 14:12:33 +0000
Received: from [2001:4bb8:184:543c:6e8c:bf25:364a:5dde] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKL2f-007JB9-Bm; Wed, 16 Feb 2022 14:12:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: dwagner@suse.de,
	joshi.k@samsung.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme: also mark passthrough-only namespaces ready in
 nvme_update_ns_info
Date: Wed, 16 Feb 2022 15:12:20 +0100
Message-Id: <20220216141220.4162670-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220216141220.4162670-1-hch@lst.de>
References: <20220216141220.4162670-1-hch@lst.de>
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

Commit e7d65803e2bb ("nvme-multipath: revalidate paths during rescan")
introduced the NVME_NS_READY flag, which nvme_path_is_disabled() uses
to check if a path can be used or not.  We also need to set this flag
for devices that fail the ZNS feature validation and which are available
through passthrough devices only to that they can be used in multipathing
setups.

Fixes: e7d65803e2bb ("nvme-multipath: revalidate paths during rescan")
Reported-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cd6b1c5861f02..7814df10b5199 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1931,7 +1931,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	if (blk_queue_is_zoned(ns->queue)) {
 		ret = nvme_revalidate_zones(ns);
 		if (ret && !nvme_first_scan(ns->disk))
-			goto out;
+			return ret;
 	}
 
 	if (nvme_ns_head_multipath(ns->head)) {
@@ -1946,16 +1946,16 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	return 0;
 
 out_unfreeze:
-	blk_mq_unfreeze_queue(ns->disk->queue);
-out:
 	/*
 	 * If probing fails due an unsupported feature, hide the block device,
 	 * but still allow other access.
 	 */
 	if (ret == -ENODEV) {
 		ns->disk->flags |= GENHD_FL_HIDDEN;
+		set_bit(NVME_NS_READY, &ns->flags);
 		ret = 0;
 	}
+	blk_mq_unfreeze_queue(ns->disk->queue);
 	return ret;
 }
 
-- 
2.30.2


