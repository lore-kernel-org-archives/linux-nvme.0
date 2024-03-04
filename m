Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A93DC48BF6
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 15:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZLj5W501AVQC/4cgjQTrXpTD5MZ6OlMizDkHBWuICk4=; b=IL5+RDj6Yf5ds2R1tehioPDfbR
	2coP0kCK+lvGBWQSWJE465iK1XLY9N7GGBBAqNCeNp1CugRhMquODfwCPJMdQ6Frg/aPiiCcc/Veq
	baTPcnjic1Ellvt0+3DMt5pZ3F62+OMpznR6aPKrkLcx6lcwz7ym7/BKXnaBliys7quWlJmTqP1NS
	MItLpIoZ1m/iSqfPZTPPJkcqtoi+g8Y0u42WLMlrC+UBn4ZGfMfdzQa2gt1vI4j/lgwdDhAlATYvI
	W1l24p/XEAxOQKTokb84d4smCObdwFHAGZcIrx/hkgikvgrfEYkzDgzD25bFWx1sOIIYE/mmGQHqI
	pSbx4SQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhA6u-00000009Yq5-35uO;
	Mon, 04 Mar 2024 15:20:12 +0000
Received: from [206.0.71.24] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8xL-00000009IBe-2MwT;
	Mon, 04 Mar 2024 14:06:18 +0000
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
Subject: [PATCH 12/16] nvme: don't query identify data in configure_metadata
Date: Mon,  4 Mar 2024 07:04:56 -0700
Message-Id: <20240304140500.78583-13-hch@lst.de>
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

Move reading the Identify Namespace Data Structure, NVM Command Set out
of configure_metadata into the caller.  This allows doing the identify
call outside the frozen I/O queues, and prepares for using data from
the Identify data structure for other purposes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 49 ++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9abcc389f0f3ae..a742fa10dd3091 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1855,32 +1855,26 @@ static int nvme_identify_ns_nvm(struct nvme_ctrl *ctrl, unsigned int nsid,
 	return ret;
 }
 
-static int nvme_init_ms(struct nvme_ctrl *ctrl, struct nvme_ns_head *head,
-		struct nvme_id_ns *id)
+static void nvme_init_ms(struct nvme_ctrl *ctrl, struct nvme_ns_head *head,
+		struct nvme_id_ns *id, struct nvme_id_ns_nvm *nvm)
 {
 	bool first = id->dps & NVME_NS_DPS_PI_FIRST;
 	unsigned lbaf = nvme_lbaf_index(id->flbas);
-	struct nvme_id_ns_nvm *nvm;
-	int ret = 0;
 	u32 elbaf;
 
 	head->pi_size = 0;
 	head->ms = le16_to_cpu(id->lbaf[lbaf].ms);
-	if (!(ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)) {
+	if (!nvm || !(ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)) {
 		head->pi_size = sizeof(struct t10_pi_tuple);
 		head->guard_type = NVME_NVM_NS_16B_GUARD;
 		goto set_pi;
 	}
 
-	ret = nvme_identify_ns_nvm(ctrl, head->ns_id, &nvm);
-	if (ret)
-		goto set_pi;
-
 	elbaf = le32_to_cpu(nvm->elbaf[lbaf]);
 
 	/* no support for storage tag formats right now */
 	if (nvme_elbaf_sts(elbaf))
-		goto free_data;
+		goto set_pi;
 
 	head->guard_type = nvme_elbaf_guard_type(elbaf);
 	switch (head->guard_type) {
@@ -1894,8 +1888,6 @@ static int nvme_init_ms(struct nvme_ctrl *ctrl, struct nvme_ns_head *head,
 		break;
 	}
 
-free_data:
-	kfree(nvm);
 set_pi:
 	if (head->pi_size && head->ms >= head->pi_size)
 		head->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
@@ -1906,22 +1898,17 @@ static int nvme_init_ms(struct nvme_ctrl *ctrl, struct nvme_ns_head *head,
 		head->pi_offset = 0;
 	else
 		head->pi_offset = head->ms - head->pi_size;
-
-	return ret;
 }
 
-static int nvme_configure_metadata(struct nvme_ctrl *ctrl,
-		struct nvme_ns_head *head, struct nvme_id_ns *id)
+static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
+		struct nvme_ns_head *head, struct nvme_id_ns *id,
+		struct nvme_id_ns_nvm *nvm)
 {
-	int ret;
-
-	ret = nvme_init_ms(ctrl, head, id);
-	if (ret)
-		return ret;
+	nvme_init_ms(ctrl, head, id, nvm);
 
 	head->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
 	if (!head->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
-		return 0;
+		return;
 
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
 		/*
@@ -1930,7 +1917,7 @@ static int nvme_configure_metadata(struct nvme_ctrl *ctrl,
 		 * remap the separate metadata buffer from the block layer.
 		 */
 		if (WARN_ON_ONCE(!(id->flbas & NVME_NS_FLBAS_META_EXT)))
-			return 0;
+			return;
 
 		head->features |= NVME_NS_EXT_LBAS;
 
@@ -1957,7 +1944,6 @@ static int nvme_configure_metadata(struct nvme_ctrl *ctrl,
 		else
 			head->features |= NVME_NS_METADATA_SUPPORTED;
 	}
-	return 0;
 }
 
 static u32 nvme_max_drv_segments(struct nvme_ctrl *ctrl)
@@ -2092,6 +2078,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		struct nvme_ns_info *info)
 {
 	bool vwc = ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT;
+	struct nvme_id_ns_nvm *nvm = NULL;
 	struct nvme_id_ns *id;
 	sector_t capacity;
 	unsigned lbaf;
@@ -2108,6 +2095,12 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		goto out;
 	}
 
+	if (ns->ctrl->ctratt & NVME_CTRL_ATTR_ELBAS) {
+		ret = nvme_identify_ns_nvm(ns->ctrl, info->nsid, &nvm);
+		if (ret < 0)
+			goto out;
+	}
+
 	blk_mq_freeze_queue(ns->disk->queue);
 	lbaf = nvme_lbaf_index(id->flbas);
 	ns->head->lba_shift = id->lbaf[lbaf].ds;
@@ -2115,12 +2108,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
 
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
-
-	ret = nvme_configure_metadata(ns->ctrl, ns->head, id);
-	if (ret < 0) {
-		blk_mq_unfreeze_queue(ns->disk->queue);
-		goto out;
-	}
+	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm);
 	nvme_set_chunk_sectors(ns, id);
 	if (!nvme_update_disk_info(ns, id))
 		capacity = 0;
@@ -2165,6 +2153,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 
 	ret = 0;
 out:
+	kfree(nvm);
 	kfree(id);
 	return ret;
 }
-- 
2.39.2


