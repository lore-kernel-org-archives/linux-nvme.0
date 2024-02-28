Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F050EC47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 18:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hc0irG4v816AcBdPZAtLZLJPfPs5zn555CLxOuE/KbQ=; b=Gn2Y6VpMXcMggmTCUEDVuSBMnY
	Z4PbXYpw+aLQ8AuZHUGqj1LUzETMCDqcK6Hp8HuKzupK2pPY2w6XlM537UhsadX2sEJz8AHtx3v26
	UjEP4D0tFx2bQShp0rThX41zniv2yh40IVeuuHubf5gY2pGIK9YkMv/8iwkMsMOA+GZaxCjYcIkbI
	22u/B27oA//jvWSUVRNCYl3gN+15cQwHBS9yJtPsqUJlEF7D0vqvyh12UytBRUKYC+t0ojk6v6+X9
	wnJQHo+Dr4PzS1BWgF96CyMru/Ejtlc5iDT90dGx96K8+Wz9pPcGnT1J9GfZ50vYPzpTJpJht8Ruu
	42GAZZqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOQG-0000000ARaY-1Mwj;
	Wed, 28 Feb 2024 18:12:52 +0000
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOPm-0000000ARFz-2Z65;
	Wed, 28 Feb 2024 18:12:22 +0000
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
Subject: [PATCH 12/21] nvme: move common logic into nvme_update_ns_info
Date: Wed, 28 Feb 2024 10:12:06 -0800
Message-Id: <20240228181215.873854-13-hch@lst.de>
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

nvme_update_ns_info_generic and nvme_update_ns_info_block share a
fair amount of logic related to not fully supported namespace
formats and updating the multipath information.  Move this logic
into the common caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 79 +++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 42 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dcb8d0590ed0f3..78667ba89ec491 100644
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
@@ -2162,54 +2149,62 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
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
+	}
+
+	/*
+	 * If probing fails due an unsupported feature, hide the block device,
+	 * but still allow other access.
+	 */
+	if (ret == -ENODEV) {
+		ns->disk->flags |= GENHD_FL_HIDDEN;
+		set_bit(NVME_NS_READY, &ns->flags);
+		ret = 0;
+	}
+
+	if (!ret && nvme_ns_head_multipath(ns->head)) {
+		blk_mq_freeze_queue(ns->head->disk->queue);
+		if (!(ns->disk->flags & GENHD_FL_HIDDEN))
+			nvme_init_integrity(ns->head->disk, ns->head);
+		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
+		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
+		nvme_mpath_revalidate_paths(ns);
+		blk_stack_limits(&ns->head->disk->queue->limits,
+				 &ns->queue->limits, 0);
+		disk_update_readahead(ns->head->disk);
+		blk_mq_unfreeze_queue(ns->head->disk->queue);
 	}
+
+	return ret;
 }
 
 #ifdef CONFIG_BLK_SED_OPAL
-- 
2.39.2


