Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148C6C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 06:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=92ZsyTZej7Tzp2ujdT2I/s/Q0ziuIH8GupKfWZhuTXM=; b=E0KMphmGBs1dl6FfE0W1xMPgkQ
	PWZSHgvJqdwU8pweUFadW7LsRrVdCE8oKn4zlsMn5FIRDufD+K0B+slTrPrtuRWtxY1QnYamnOR0V
	PP1CN9oGZLKQsfPQnK9io6Dk+UMzs6hToMN16C8YXU7hGsm5v0gCIYwLRRgX7KorL9ZKBDjeh0Him
	FGs5e4y/yy2Ca2ThuefAQ3LaVw/vBE6IdCtXm17DM53nykUrFGS8Ho/x2bryoT4S5YN1ljYpvbdNl
	1cH1DT4rprW96WxjIdhcMnMzptXSJAKVyjjTyIfyaY6T8fNyPKdW31rDl85Dry/N5L0YG0mqcD+3e
	9Nqd1Rtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPRm-000pY3-WB; Thu, 21 Jul 2022 06:14:07 +0000
Received: from [2001:4bb8:18a:6f7a:1b03:4d0e:b929:ebb2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPHh-000dqN-Aj; Thu, 21 Jul 2022 06:03:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <j.granados@samsung.com>,
	kbusch@kernel.org,
	sagi@grimberg.me
Cc: joshi.k@samsung.com,
	linux-nvme@lists.infradead.org,
	gost.dev@samsung.com,
	k.jensen@samsung.com,
	=?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH 6/6] nvme: enable generic interface (/dev/ngXnY) for unknown command sets
Date: Thu, 21 Jul 2022 08:03:20 +0200
Message-Id: <20220721060320.1704646-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721060320.1704646-1-hch@lst.de>
References: <20220721060320.1704646-1-hch@lst.de>
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
index 271c0de483a9b..bf43edeb74700 100644
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
 
@@ -4342,7 +4368,8 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
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


