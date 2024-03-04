Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F84C5478C
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 14:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nws8FVYyqVVHYQigD+iaNJTps5x65HkcwfreKJD4bI0=; b=PfJz7TQS3fTlPAwYU2m+kZENJM
	QfgZ3Um/s1VZwhAUJgOqEw/yRvtdaqzHwS0rUu+JW0Vsp+B6GFZ1wPxxGZgqZTE/I8VJ0hcLbTWyJ
	MHyBqpA8RKOToLZfvUmEqgXEYD5dsh44X8rks/+Ofwqa9/QNrXSa6GK+wWb3zGhyx0FT89xfKK78Y
	KBkpQfG+nUrh1j5az/iUGS4CcqumGbcaWl8OztCv4nXAxL6QRhTQ1PwWxrTa6H3HHR3cTgdnTzUb4
	MmtG0ok3ds/9xQzkKfMEY3OT+Q2ICiNVnW8WJgYAB6tyu5U6eg4I3KOc3WEBsJuVbV3g3n/qptfwv
	ajOwk+CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8xC-00000009I5b-08yV;
	Mon, 04 Mar 2024 14:06:06 +0000
Received: from [206.0.71.24] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8x9-00000009Hzz-0Yph;
	Mon, 04 Mar 2024 14:06:04 +0000
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
Subject: [PATCH 10/16] nvme: move common logic into nvme_update_ns_info
Date: Mon,  4 Mar 2024 07:04:54 -0700
Message-Id: <20240304140500.78583-11-hch@lst.de>
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

nvme_update_ns_info_generic and nvme_update_ns_info_block share a
fair amount of logic related to not fully supported namespace
formats and updating the multipath information.  Move this logic
into the common caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 84 ++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ce70bfb66242e2..f0686a872d0e30 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2070,21 +2070,8 @@ static int nvme_update_ns_info_generic(struct nvme_ns *ns,
 	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
 	blk_mq_unfreeze_queue(ns->disk->queue);
 
-	if (nvme_ns_head_multipath(ns->head)) {
-		blk_mq_freeze_queue(ns->head->disk->queue);
-		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
-		nvme_mpath_revalidate_paths(ns);
-		blk_stack_limits(&ns->head->disk->queue->limits,
-				 &ns->queue->limits, 0);
-		ns->head->disk->flags |= GENHD_FL_HIDDEN;
-		blk_mq_unfreeze_queue(ns->head->disk->queue);
-	}
-
 	/* Hide the block-interface for these devices */
-	ns->disk->flags |= GENHD_FL_HIDDEN;
-	set_bit(NVME_NS_READY, &ns->flags);
-
-	return 0;
+	return -ENODEV;
 }
 
 static int nvme_update_ns_info_block(struct nvme_ns *ns,
@@ -2104,7 +2091,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		/* namespace not allocated or attached */
 		info->is_removed = true;
 		ret = -ENODEV;
-		goto error;
+		goto out;
 	}
 
 	blk_mq_freeze_queue(ns->disk->queue);
@@ -2162,54 +2149,67 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 			goto out;
 	}
 
-	if (nvme_ns_head_multipath(ns->head)) {
-		blk_mq_freeze_queue(ns->head->disk->queue);
-		nvme_init_integrity(ns->head->disk, ns->head);
-		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
-		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
-		nvme_mpath_revalidate_paths(ns);
-		blk_stack_limits(&ns->head->disk->queue->limits,
-				 &ns->queue->limits, 0);
-		disk_update_readahead(ns->head->disk);
-		blk_mq_unfreeze_queue(ns->head->disk->queue);
-	}
-
 	ret = 0;
 out:
-	/*
-	 * If probing fails due an unsupported feature, hide the block device,
-	 * but still allow other access.
-	 */
-	if (ret == -ENODEV) {
-		ns->disk->flags |= GENHD_FL_HIDDEN;
-		set_bit(NVME_NS_READY, &ns->flags);
-		ret = 0;
-	}
-
-error:
 	kfree(id);
 	return ret;
 }
 
 static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
+	bool unsupported = false;
+	int ret;
+
 	switch (info->ids.csi) {
 	case NVME_CSI_ZNS:
 		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
 			dev_info(ns->ctrl->device,
 	"block device for nsid %u not supported without CONFIG_BLK_DEV_ZONED\n",
 				info->nsid);
-			return nvme_update_ns_info_generic(ns, info);
+			ret = nvme_update_ns_info_generic(ns, info);
+			break;
 		}
-		return nvme_update_ns_info_block(ns, info);
+		ret = nvme_update_ns_info_block(ns, info);
+		break;
 	case NVME_CSI_NVM:
-		return nvme_update_ns_info_block(ns, info);
+		ret = nvme_update_ns_info_block(ns, info);
+		break;
 	default:
 		dev_info(ns->ctrl->device,
 			"block device for nsid %u not supported (csi %u)\n",
 			info->nsid, info->ids.csi);
-		return nvme_update_ns_info_generic(ns, info);
+		ret = nvme_update_ns_info_generic(ns, info);
+		break;
 	}
+
+	/*
+	 * If probing fails due an unsupported feature, hide the block device,
+	 * but still allow other access.
+	 */
+	if (ret == -ENODEV) {
+		ns->disk->flags |= GENHD_FL_HIDDEN;
+		set_bit(NVME_NS_READY, &ns->flags);
+		unsupported = true;
+		ret = 0;
+	}
+
+	if (!ret && nvme_ns_head_multipath(ns->head)) {
+		blk_mq_freeze_queue(ns->head->disk->queue);
+		if (unsupported)
+			ns->head->disk->flags |= GENHD_FL_HIDDEN;
+		else
+			nvme_init_integrity(ns->head->disk, ns->head);
+		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
+		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
+		nvme_mpath_revalidate_paths(ns);
+		blk_stack_limits(&ns->head->disk->queue->limits,
+				 &ns->queue->limits, 0);
+
+		disk_update_readahead(ns->head->disk);
+		blk_mq_unfreeze_queue(ns->head->disk->queue);
+	}
+
+	return ret;
 }
 
 #ifdef CONFIG_BLK_SED_OPAL
-- 
2.39.2


