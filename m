Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FCCC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 05:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a5AoHDTz3pZgaGcIWioLFI/FZTdrPft8ctREukQL2bE=; b=HULjLDn7HSNqEVa51gGutLTtOr
	25y414NAt/cGoSGl8+OKqz0fmJoYYtNc6ZnmsQOQBjY245bSf7OVNw7QSOGGRM24gvHV96r+s9wqu
	eoNcoCi0BrJnJxmp+bevxO6eEyBAYQ3Z+GPtludCPOs8bb68CJLVweB+1IGFUoz9BXLckiCfGWo/4
	7LzTkt+dCQes8Gaoz81cfL+GiP9duIfaT7r0/g5ie/97l9yxdBPFYQPnIjVSZLI1/JHWzdkmlUtjL
	pwul9EYaVJAfJ5G4oZGq5CtGvUAWF7LmyHpZF5R6A+j0tPON7y4KTKm8eIHaPTZdbpsu1Y+JqcQ0K
	q+u+REAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDJG7-00B2d7-Bi; Mon, 18 Jul 2022 05:25:31 +0000
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDJFx-00B2Wj-BK; Mon, 18 Jul 2022 05:25:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <j.granados@samsung.com>,
	kbusch@kernel.org,
	sagi@grimberg.me
Cc: joshi.k@samsung.com,
	linux-nvme@lists.infradead.org,
	gost.dev@samsung.com,
	k.jensen@samsung.com,
	=?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH 5/5] nvme: enable generic interface (/dev/ngXnY) for unknown command sets
Date: Mon, 18 Jul 2022 07:25:03 +0200
Message-Id: <20220718052503.235270-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220718052503.235270-1-hch@lst.de>
References: <20220718052503.235270-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Javier González <javier.gonz@samsung.com>
---
 drivers/nvme/host/core.c | 41 +++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dca7580f785a8..bbdf0f95331f3 100644
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
@@ -2023,18 +2048,19 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	switch (info->ids.csi) {
 	case NVME_CSI_ZNS:
 		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
-			dev_warn(ns->ctrl->device,
-	"nsid %u not supported without CONFIG_BLK_DEV_ZONED\n",
+			dev_info(ns->ctrl->device,
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
+		dev_info(ns->ctrl->device,
+			"block device for nsid %u not supported (csi %u)\n",
+			info->nsid, info->ids.csi);
+		return nvme_update_ns_info_generic(ns, info);
 	}
 }
 
@@ -4341,7 +4367,8 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
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


