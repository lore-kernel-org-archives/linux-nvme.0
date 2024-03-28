Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18666C54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 06:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2PuKfd2HPXaUeVY1utfAeNp4JzDNZQK3RLvhIyvIdCk=; b=Hw+3r+B+d7u5uxFS6P8fzyOwbD
	NRkslJn7xmGkWCf6ru5StooR8Pc3K7HlPdt1Z5oqnCMVD9QAZHbQdIJw8mRMr8C22YCSBf2ZirPNZ
	OhfBr4A/axLY1ZJLXvcCvdip1YgOc+3Hfl5gU/ogOskRg1GOtQTU4Hl7dXViPm2tK81jwt2iZrNUW
	6JfGo49fVIIzYeW7y87Ju/NDmOBWmFIR6U0U4rO+RtWFKnl0E60loTZxXeLQ0l9EzhWqyWt9Fv2Qs
	BOCF7pAKSzr0lc+UckzKmVFiECnA+eAvxenDeCNQfgMKfpEGcO0jt3BV5qMF72eCCnvpm3SiShTmI
	OJ6S1VQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpj7r-0000000ChJ0-1XNT;
	Thu, 28 Mar 2024 06:20:35 +0000
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpj7o-0000000ChIR-2q3O;
	Thu, 28 Mar 2024 06:20:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH] nvme: split nvme_update_zone_info
Date: Thu, 28 Mar 2024 07:20:30 +0100
Message-Id: <20240328062030.2915583-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

nvme_update_zone_info does (admin queue) I/O to the device and can fail.
We fail to abort the queue limits update if that happen, but really
should avoid with the frozen I/O queue as much as possible anyway.

Split the logic into a helper to query the information that can be
called on an unfrozen queue and one to apply it to the queue limits.

Fixes: 9b130d681443 ("nvme: use the atomic queue limits update API")
Reported-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 17 ++++++++++-------
 drivers/nvme/host/nvme.h | 12 ++++++++++--
 drivers/nvme/host/zns.c  | 33 ++++++++++++++++++++-------------
 3 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 943d72bdd794ca..5d312adca06e57 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2076,6 +2076,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	bool vwc = ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT;
 	struct queue_limits lim;
 	struct nvme_id_ns_nvm *nvm = NULL;
+	struct nvme_zone_info zi = {};
 	struct nvme_id_ns *id;
 	sector_t capacity;
 	unsigned lbaf;
@@ -2098,6 +2099,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 			goto out;
 	}
 
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
+	    ns->head->ids.csi == NVME_CSI_ZNS) {
+		ret = nvme_query_zone_info(ns, lbaf, &zi);
+		if (ret < 0)
+			goto out;
+	}
+
 	blk_mq_freeze_queue(ns->disk->queue);
 	lbaf = nvme_lbaf_index(id->flbas);
 	ns->head->lba_shift = id->lbaf[lbaf].ds;
@@ -2112,13 +2120,8 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		capacity = 0;
 	nvme_config_discard(ns, &lim);
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-	    ns->head->ids.csi == NVME_CSI_ZNS) {
-		ret = nvme_update_zone_info(ns, lbaf, &lim);
-		if (ret) {
-			blk_mq_unfreeze_queue(ns->disk->queue);
-			goto out;
-		}
-	}
+	    ns->head->ids.csi == NVME_CSI_ZNS)
+		nvme_update_zone_info(ns, &lim, &zi);
 	ret = queue_limits_commit_update(ns->disk->queue, &lim);
 	if (ret) {
 		blk_mq_unfreeze_queue(ns->disk->queue);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 24193fcb8bd584..d0ed64dc7380e5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1036,10 +1036,18 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
 }
 #endif /* CONFIG_NVME_MULTIPATH */
 
+struct nvme_zone_info {
+	u64 zone_size;
+	unsigned int max_open_zones;
+	unsigned int max_active_zones;
+};
+
 int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data);
-int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf,
-		struct queue_limits *lim);
+int nvme_query_zone_info(struct nvme_ns *ns, unsigned lbaf,
+		struct nvme_zone_info *zi);
+void nvme_update_zone_info(struct nvme_ns *ns, struct queue_limits *lim,
+		struct nvme_zone_info *zi);
 #ifdef CONFIG_BLK_DEV_ZONED
 blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
 				       struct nvme_command *cmnd,
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 722384bcc765cd..1b9eb2acb383e4 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -35,8 +35,8 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
 	return 0;
 }
 
-int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf,
-		struct queue_limits *lim)
+int nvme_query_zone_info(struct nvme_ns *ns, unsigned lbaf,
+		struct nvme_zone_info *zi)
 {
 	struct nvme_effects_log *log = ns->head->effects;
 	struct nvme_command c = { };
@@ -89,27 +89,34 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf,
 		goto free_data;
 	}
 
-	ns->head->zsze =
-		nvme_lba_to_sect(ns->head, le64_to_cpu(id->lbafe[lbaf].zsze));
-	if (!is_power_of_2(ns->head->zsze)) {
+	zi->zone_size = le64_to_cpu(id->lbafe[lbaf].zsze);
+	if (!is_power_of_2(zi->zone_size)) {
 		dev_warn(ns->ctrl->device,
-			"invalid zone size:%llu for namespace:%u\n",
-			ns->head->zsze, ns->head->ns_id);
+			"invalid zone size: %llu for namespace: %u\n",
+			zi->zone_size, ns->head->ns_id);
 		status = -ENODEV;
 		goto free_data;
 	}
+	zi->max_open_zones = le32_to_cpu(id->mor) + 1;
+	zi->max_active_zones = le32_to_cpu(id->mar) + 1;
 
-	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, ns->queue);
-	lim->zoned = 1;
-	lim->max_open_zones = le32_to_cpu(id->mor) + 1;
-	lim->max_active_zones = le32_to_cpu(id->mar) + 1;
-	lim->chunk_sectors = ns->head->zsze;
-	lim->max_zone_append_sectors = ns->ctrl->max_zone_append;
 free_data:
 	kfree(id);
 	return status;
 }
 
+void nvme_update_zone_info(struct nvme_ns *ns, struct queue_limits *lim,
+		struct nvme_zone_info *zi)
+{
+	lim->zoned = 1;
+	lim->max_open_zones = zi->max_open_zones;
+	lim->max_active_zones = zi->max_active_zones;
+	lim->chunk_sectors = ns->head->zsze;
+	lim->max_zone_append_sectors = ns->ctrl->max_zone_append;
+	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, ns->queue);
+	ns->head->zsze = nvme_lba_to_sect(ns->head, zi->zone_size);
+}
+
 static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
 					  unsigned int nr_zones, size_t *buflen)
 {
-- 
2.39.2


