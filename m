Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A974CC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 05:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qj05rkT/EeEhOfDZo3NT+yLwx+AF7EyNRSqNMfiAr0E=; b=xu5SxqUCzoot+wc0iFXbavVgyR
	OxaONrdD18WF7mo4bEpj6AYGsStaBVAqyL1OYYk/PouR8NX8RQOPZmcRrzyRlQj+nSnucX3XqhB/Y
	5H8DwCd+I+QefiRmnMpDs83YMQDXbprgoFnUKxfIFf39NZ1EU1u/4sAdwEsiqYxux7/3EBk7Z0Shp
	xZdKGqxiZ2rt6E+EM/GIWMoj81zf41IX7zDgobAdnqzZZMrEg+dtmDbz0S9TtP9IKE9lW+oFiLioZ
	xHpWfdetknDPD4v8HlzJfYjxlm2zDob4pSGg5Md3jW8y9BdFpAxOBByRON/d8e+Tpum8IOQfyQ+VY
	fgadpyXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBVFl-000LJg-4c; Wed, 13 Jul 2022 05:49:41 +0000
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBVFc-000LDU-QX; Wed, 13 Jul 2022 05:49:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <j.granados@samsung.com>,
	kbusch@kernel.org,
	sagi@grimberg.me
Cc: joshi.k@samsung.com,
	linux-nvme@lists.infradead.org,
	gost.dev@samsung.com,
	k.jensen@samsung.com
Subject: [PATCH 5/5] nvme: enable generic interface (/dev/ngXnY) for unknown command sets
Date: Wed, 13 Jul 2022 07:49:14 +0200
Message-Id: <20220713054914.1888305-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713054914.1888305-1-hch@lst.de>
References: <20220713054914.1888305-1-hch@lst.de>
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

From: Joel Granados <j.granados@samsung.com>

Extend nvme_alloc_ns() and nvme_validate_ns() for unknown command-set as
well. Both are made to use a new helper (nvme_update_ns_info_cs_indep)
which is similar to nvme_update_ns_info but performs fewer operations
to get the generic interface up.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Joel Granados <j.granados@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
[hch: rebased on other refactoring patches]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dca7580f785a8..f865d0b185c32 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1954,6 +1954,31 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
 	blk_queue_chunk_sectors(ns->queue, iob);
 }
 
+static int nvme_update_ns_info_generic(struct nvme_ns *ns,
+		struct nvme_ns_info *info)
+{
+	blk_mq_freeze_queue(ns->disk->queue);
+	nvme_set_queue_limits(ns->ctrl, ns->queue);
+	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
+	blk_mq_unfreeze_queue(ns->disk->queue);
+
+	if (nvme_ns_head_multipath(ns->head)) {
+		blk_mq_freeze_queue(ns->head->disk->queue);
+		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
+		nvme_mpath_revalidate_paths(ns);
+		blk_stack_limits(&ns->head->disk->queue->limits,
+				 &ns->queue->limits, 0);
+		ns->head->disk->flags |= GENHD_FL_HIDDEN;
+		blk_mq_unfreeze_queue(ns->head->disk->queue);
+	}
+
+	/* Hide the block-interface for these devices */
+	ns->disk->flags |= GENHD_FL_HIDDEN;
+	set_bit(NVME_NS_READY, &ns->flags);
+
+	return 0;
+}
+
 static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		struct nvme_ns_info *info)
 {
@@ -2024,17 +2049,15 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	case NVME_CSI_ZNS:
 		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
 			dev_warn(ns->ctrl->device,
-	"nsid %u not supported without CONFIG_BLK_DEV_ZONED\n",
+	"block device for nsid %u not supported without CONFIG_BLK_DEV_ZONED\n",
 				info->nsid);
-			return -ENODEV;
+			return nvme_update_ns_info_generic(ns, info);
 		}
 		return nvme_update_ns_info_block(ns, info);
 	case NVME_CSI_NVM:
 		return nvme_update_ns_info_block(ns, info);
 	default:
-		dev_warn(ns->ctrl->device, "unknown csi %u for nsid %u\n",
-			info->ids.csi, info->nsid);
-		return -ENODEV;
+		return nvme_update_ns_info_generic(ns, info);
 	}
 }
 
@@ -4341,7 +4364,8 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	 * data structure to find all the generic information that is needed to
 	 * set up a namespace.  If not fall back to the legacy version.
 	 */
-	if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
+	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) ||
+	    (info.ids.csi != NVME_CSI_NVM && info.ids.csi != NVME_CSI_ZNS)) {
 		if (nvme_ns_info_from_id_cs_indep(ctrl, &info))
 			return;
 	} else {
-- 
2.30.2


