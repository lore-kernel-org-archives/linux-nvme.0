Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA56C7EE24
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 06:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fed7/qbvbj02wPL3SQkDn/mfmHCcpMiy55cXzY1aF/8=; b=T9ruuRbhv0b92cBqatbs7FE+Zn
	ANiURwQhg14cRiszYkA5eU5yMbISQ+M2R8v0HcoUfh0PtM2Th713FNWGx3eAJuJ6UM7Bse0JQ88t1
	hrmTjR3pbcYqiycSOZGehyqrYe9Gc53nl3glpRJ8lfEy1bufBt6+mLUhZpwBKgc7ObIhzH8ywAp2u
	HRSVYXYTsqcbX32bHzZRQo1MFL9LKVNJN9itbRkHPIZyh/Jr8hE6NnD4Apd2vXN+N2xjG5QWNoRNL
	MmMUj6ssnUJAiACmuIvJTJg8gD5ODjwYqVW3v8UQXyEvNAUjms/dvyVpaoivybjcoVBvoLkgLcIYi
	q18r99ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjYov-00000000oV8-3zXF;
	Thu, 29 Aug 2024 06:39:49 +0000
Received: from [2001:4bb8:2c1:ef51:b1e3:1751:33fd:c3bc] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjYhF-00000000n0x-1au2;
	Thu, 29 Aug 2024 06:31:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Martin Wilck <mwilck@suse.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] nvme: move hidden device and multipath handling out of nvme_update_ns_info
Date: Thu, 29 Aug 2024 09:31:29 +0300
Message-ID: <20240829063142.2048109-3-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240829063142.2048109-1-hch@lst.de>
References: <20240829063142.2048109-1-hch@lst.de>
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

Turn nvme_update_ns_info into a pure multiplexer and move the real work
into nvme_update_ns_info_generic and nvme_update_ns_block, which allows
to set the flags more coherently while the queue is still frozen.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 55 ++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 51cb3b001b3757..81d2a09dd00f30 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2147,12 +2147,18 @@ static int nvme_update_ns_info_generic(struct nvme_ns *ns,
 	lim = queue_limits_start_update(ns->disk->queue);
 	nvme_set_ctrl_limits(ns->ctrl, &lim);
 	ret = queue_limits_commit_update(ns->disk->queue, &lim);
-	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
-	blk_mq_unfreeze_queue(ns->disk->queue);
+	if (ret)
+		goto out_unfreeze;
 
 	/* Hide the block-interface for these devices */
-	if (!ret)
-		ret = -ENODEV;
+	ns->disk->flags |= GENHD_FL_HIDDEN;
+	set_bit(NVME_NS_READY, &ns->flags);
+	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
+
+out_unfreeze:
+	blk_mq_unfreeze_queue(ns->disk->queue);
+	if (nvme_ns_head_multipath(ns->head) && !ret)
+		ret = nvme_update_ns_info_mpath(ns, info, true);
 	return ret;
 }
 
@@ -2163,6 +2169,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	struct nvme_id_ns_nvm *nvm = NULL;
 	struct nvme_zone_info zi = {};
 	struct nvme_id_ns *id;
+	bool unsupported = false;
 	sector_t capacity;
 	unsigned lbaf;
 	int ret;
@@ -2188,6 +2195,11 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    ns->head->ids.csi == NVME_CSI_ZNS) {
 		ret = nvme_query_zone_info(ns, lbaf, &zi);
+		if (ret == -ENODEV) {
+			unsupported = true;
+			ns->disk->flags |= GENHD_FL_HIDDEN;
+			goto done;
+		}
 		if (ret < 0)
 			goto out;
 	}
@@ -2238,6 +2250,8 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	 */
 	if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3)))
 		ns->head->features |= NVME_NS_DEAC;
+
+done:
 	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
 	set_bit(NVME_NS_READY, &ns->flags);
 	blk_mq_unfreeze_queue(ns->disk->queue);
@@ -2252,50 +2266,31 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 out:
 	kfree(nvm);
 	kfree(id);
+
+	if (nvme_ns_head_multipath(ns->head) && !ret)
+		ret = nvme_update_ns_info_mpath(ns, info, unsupported);
 	return ret;
 }
 
 static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
-	bool unsupported = false;
-	int ret;
-
 	switch (info->ids.csi) {
 	case NVME_CSI_ZNS:
 		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
 			dev_info(ns->ctrl->device,
 	"block device for nsid %u not supported without CONFIG_BLK_DEV_ZONED\n",
 				info->nsid);
-			ret = nvme_update_ns_info_generic(ns, info);
-			break;
+			return nvme_update_ns_info_generic(ns, info);
 		}
-		ret = nvme_update_ns_info_block(ns, info);
-		break;
+		return nvme_update_ns_info_block(ns, info);
 	case NVME_CSI_NVM:
-		ret = nvme_update_ns_info_block(ns, info);
-		break;
+		return nvme_update_ns_info_block(ns, info);
 	default:
 		dev_info(ns->ctrl->device,
 			"block device for nsid %u not supported (csi %u)\n",
 			info->nsid, info->ids.csi);
-		ret = nvme_update_ns_info_generic(ns, info);
-		break;
+		return nvme_update_ns_info_generic(ns, info);
 	}
-
-	/*
-	 * If probing fails due an unsupported feature, hide the block device,
-	 * but still allow other access.
-	 */
-	if (ret == -ENODEV) {
-		ns->disk->flags |= GENHD_FL_HIDDEN;
-		set_bit(NVME_NS_READY, &ns->flags);
-		unsupported = true;
-		ret = 0;
-	}
-
-	if (nvme_ns_head_multipath(ns->head) && !ret)
-		ret = nvme_update_ns_info_mpath(ns, info, unsupported);
-	return ret;
 }
 
 int nvme_ns_get_unique_id(struct nvme_ns *ns, u8 id[16],
-- 
2.43.0


