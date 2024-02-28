Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C30C47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 18:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r9zy5RWJb/mIoq28vhXh083goiK+ppSU6zxX3rtmziE=; b=03h5KiuKAX1l2YGSXk6DOkzpYg
	T4YzmuMjqOawTNiTC/6E0218yq6t0uDFMptErdA7x7kMsbmhvxG0ea9tehJWwOCfcikBNdrKLf7xL
	rHIJgr59G/7DzPRdrb3HEnQW6l4MXF/poseeYCrEG/15GEPZroMUC0d4vn+K7R1coYrV7AQoZe2us
	fpbSHioRwqzQzjsVZJCMNa3ecEkdetc+wwOhUuolbK/83MqFO/iLYVm/WUj+t6D1K4F1K83Ge40EQ
	rRKwkJkeJivTNQ303vljjf58/8zcaTojks8imVTMFrOr/olduQm93duV9Y3D0gB9u96/SgTocYu8x
	+E5PvuzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOQj-0000000AS0I-1tGF;
	Wed, 28 Feb 2024 18:13:21 +0000
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOPq-0000000ARJ6-3lu3;
	Wed, 28 Feb 2024 18:12:27 +0000
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
Subject: [PATCH 20/21] nvme: use the atomic queue limits update API
Date: Wed, 28 Feb 2024 10:12:14 -0800
Message-Id: <20240228181215.873854-21-hch@lst.de>
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

Changes the callchains that update queue_limits to build an on-stack
queue_limits and update it atomically.  Note that for now only the
admin queue actually passes it to the queue allocation function.
Doing the same for the gendisks used for the namespaces will require
a little more work.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/apple.c |   2 +
 drivers/nvme/host/core.c  | 126 +++++++++++++++++++-------------------
 drivers/nvme/host/nvme.h  |  11 +---
 drivers/nvme/host/zns.c   |  16 ++---
 4 files changed, 76 insertions(+), 79 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 12281fc6932d40..8b275d6afd9dfa 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1382,6 +1382,7 @@ static void devm_apple_nvme_mempool_destroy(void *data)
 
 static int apple_nvme_probe(struct platform_device *pdev)
 {
+	struct queue_limits lim = { };
 	struct device *dev = &pdev->dev;
 	struct apple_nvme *anv;
 	int ret;
@@ -1516,6 +1517,7 @@ static int apple_nvme_probe(struct platform_device *pdev)
 					 dma_max_mapping_size(anv->dev) >> 9);
 	anv->ctrl.max_segments = NVME_MAX_SEGS;
 
+	nvme_set_ctrl_limits(&anv->ctrl, &lim);
 	anv->ctrl.admin_q = blk_mq_alloc_queue(&anv->admin_tagset, NULL, NULL);
 	if (IS_ERR(anv->ctrl.admin_q)) {
 		ret = -ENOMEM;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f4ec8683b3b725..957fa388808b90 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1787,40 +1787,27 @@ static bool nvme_init_integrity(struct gendisk *disk, struct nvme_ns_head *head)
 	return true;
 }
 
-static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
-		struct nvme_ns_head *head)
+static void nvme_config_discard(struct nvme_ns *ns, struct queue_limits *lim)
 {
-	struct request_queue *queue = disk->queue;
-	u32 max_discard_sectors;
-
-	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(head, UINT_MAX)) {
-		max_discard_sectors = nvme_lba_to_sect(head, ctrl->dmrsl);
-	} else if (ctrl->oncs & NVME_CTRL_ONCS_DSM) {
-		max_discard_sectors = UINT_MAX;
-	} else {
-		blk_queue_max_discard_sectors(queue, 0);
-		return;
-	}
+	struct nvme_ctrl *ctrl = ns->ctrl;
 
 	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
 			NVME_DSM_MAX_RANGES);
 
-	/*
-	 * If discard is already enabled, don't reset queue limits.
-	 *
-	 * This works around the fact that the block layer can't cope well with
-	 * updating the hardware limits when overridden through sysfs.  This is
-	 * harmless because discard limits in NVMe are purely advisory.
-	 */
-	if (queue->limits.max_discard_sectors)
-		return;
+	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns->head, UINT_MAX))
+		lim->max_hw_discard_sectors =
+			nvme_lba_to_sect(ns->head, ctrl->dmrsl);
+	else if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
+		lim->max_hw_discard_sectors = UINT_MAX;
+	else
+		lim->max_hw_discard_sectors = 0;
+
+	lim->discard_granularity = lim->logical_block_size;
 
-	blk_queue_max_discard_sectors(queue, max_discard_sectors);
 	if (ctrl->dmrl)
-		blk_queue_max_discard_segments(queue, ctrl->dmrl);
+		lim->max_discard_segments = ctrl->dmrl;
 	else
-		blk_queue_max_discard_segments(queue, NVME_DSM_MAX_RANGES);
-	queue->limits.discard_granularity = queue_logical_block_size(queue);
+		lim->max_discard_segments = NVME_DSM_MAX_RANGES;
 }
 
 static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
@@ -1942,20 +1929,20 @@ static u32 nvme_max_drv_segments(struct nvme_ctrl *ctrl)
 	return ctrl->max_hw_sectors / (NVME_CTRL_PAGE_SIZE >> SECTOR_SHIFT) + 1;
 }
 
-static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
-		struct request_queue *q)
+void nvme_set_ctrl_limits(struct nvme_ctrl *ctrl, struct queue_limits *lim)
 {
-	blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
-	blk_queue_max_segments(q, min_t(u32, USHRT_MAX,
-		min_not_zero(nvme_max_drv_segments(ctrl), ctrl->max_segments)));
-	blk_queue_max_integrity_segments(q, ctrl->max_integrity_segments);
-	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
-	blk_queue_dma_alignment(q, 3);
+	lim->max_hw_sectors = ctrl->max_hw_sectors;
+	lim->max_segments = min_t(u32, USHRT_MAX,
+		min_not_zero(nvme_max_drv_segments(ctrl), ctrl->max_segments));
+	lim->max_integrity_segments = ctrl->max_integrity_segments;
+	lim->virt_boundary_mask = NVME_CTRL_PAGE_SIZE - 1;
+	lim->max_segment_size = UINT_MAX;
+	lim->dma_alignment = 3;
 }
 
-static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id)
+static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
+		struct queue_limits *lim)
 {
-	struct gendisk *disk = ns->disk;
 	struct nvme_ns_head *head = ns->head;
 	u32 bs = 1U << head->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt = 0;
@@ -1991,23 +1978,19 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 		io_opt = bs * (1 + le16_to_cpu(id->nows));
 	}
 
-	blk_queue_logical_block_size(disk->queue, bs);
 	/*
 	 * Linux filesystems assume writing a single physical block is
 	 * an atomic operation. Hence limit the physical block size to the
 	 * value of the Atomic Write Unit Power Fail parameter.
 	 */
-	blk_queue_physical_block_size(disk->queue, min(phys_bs, atomic_bs));
-	blk_queue_io_min(disk->queue, phys_bs);
-	blk_queue_io_opt(disk->queue, io_opt);
-
-	nvme_config_discard(ns->ctrl, disk, head);
-
+	lim->logical_block_size = bs;
+	lim->physical_block_size = min(phys_bs, atomic_bs);
+	lim->io_min = phys_bs;
+	lim->io_opt = io_opt;
 	if (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
-		blk_queue_max_write_zeroes_sectors(disk->queue, UINT_MAX);
+		lim->max_write_zeroes_sectors = UINT_MAX;
 	else
-		blk_queue_max_write_zeroes_sectors(disk->queue,
-				ns->ctrl->max_zeroes_sectors);
+		lim->max_write_zeroes_sectors = ns->ctrl->max_zeroes_sectors;
 	return valid;
 }
 
@@ -2022,7 +2005,8 @@ static inline bool nvme_first_scan(struct gendisk *disk)
 	return !disk_live(disk);
 }
 
-static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
+static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id,
+		struct queue_limits *lim)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	u32 iob;
@@ -2050,25 +2034,33 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
 		return;
 	}
 
-	blk_queue_chunk_sectors(ns->queue, iob);
+	lim->chunk_sectors = iob;
 }
 
 static int nvme_update_ns_info_generic(struct nvme_ns *ns,
 		struct nvme_ns_info *info)
 {
+	struct queue_limits lim;
+	int ret;
+
 	blk_mq_freeze_queue(ns->disk->queue);
-	nvme_set_queue_limits(ns->ctrl, ns->queue);
+	lim = queue_limits_start_update(ns->disk->queue);
+	nvme_set_ctrl_limits(ns->ctrl, &lim);
+	ret = queue_limits_commit_update(ns->disk->queue, &lim);
 	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
 	blk_mq_unfreeze_queue(ns->disk->queue);
 
 	/* Hide the block-interface for these devices */
-	return -ENODEV;
+	if (!ret)
+		ret = -ENODEV;
+	return ret;
 }
 
 static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		struct nvme_ns_info *info)
 {
 	bool vwc = ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT;
+	struct queue_limits lim;
 	struct nvme_id_ns_nvm *nvm = NULL;
 	struct nvme_id_ns *id;
 	sector_t capacity;
@@ -2098,11 +2090,26 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	ns->head->nuse = le64_to_cpu(id->nuse);
 	capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
 
-	nvme_set_queue_limits(ns->ctrl, ns->queue);
+	lim = queue_limits_start_update(ns->disk->queue);
+	nvme_set_ctrl_limits(ns->ctrl, &lim);
 	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm);
-	nvme_set_chunk_sectors(ns, id);
-	if (!nvme_update_disk_info(ns, id))
+	nvme_set_chunk_sectors(ns, id, &lim);
+	if (!nvme_update_disk_info(ns, id, &lim))
 		capacity = 0;
+	nvme_config_discard(ns, &lim);
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
+	    ns->head->ids.csi == NVME_CSI_ZNS) {
+		ret = nvme_update_zone_info(ns, lbaf, &lim);
+		if (ret) {
+			blk_mq_unfreeze_queue(ns->disk->queue);
+			goto out;
+		}
+	}
+	ret = queue_limits_commit_update(ns->disk->queue, &lim);
+	if (ret) {
+		blk_mq_unfreeze_queue(ns->disk->queue);
+		goto out;
+	}
 
 	/*
 	 * Register a metadata profile for PI, or the plain non-integrity NVMe
@@ -2115,14 +2122,6 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 
 	set_capacity_and_notify(ns->disk, capacity);
 
-	if (ns->head->ids.csi == NVME_CSI_ZNS) {
-		ret = nvme_update_zone_info(ns, lbaf);
-		if (ret) {
-			blk_mq_unfreeze_queue(ns->disk->queue);
-			goto out;
-		}
-	}
-
 	/*
 	 * Only set the DEAC bit if the device guarantees that reads from
 	 * deallocated data return zeroes.  While the DEAC bit does not
@@ -3184,7 +3183,6 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->max_hw_sectors =
 		min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
 
-	nvme_set_queue_limits(ctrl, ctrl->admin_q);
 	ctrl->sgls = le32_to_cpu(id->sgls);
 	ctrl->kas = le16_to_cpu(id->kas);
 	ctrl->max_namespaces = le32_to_cpu(id->mnan);
@@ -4347,6 +4345,7 @@ EXPORT_SYMBOL_GPL(nvme_complete_async_event);
 int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 		const struct blk_mq_ops *ops, unsigned int cmd_size)
 {
+	struct queue_limits lim = {};
 	int ret;
 
 	memset(set, 0, sizeof(*set));
@@ -4366,7 +4365,8 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	if (ret)
 		return ret;
 
-	ctrl->admin_q = blk_mq_alloc_queue(set, NULL, NULL);
+	nvme_set_ctrl_limits(ctrl, &lim);
+	ctrl->admin_q = blk_mq_alloc_queue(set, &lim, NULL);
 	if (IS_ERR(ctrl->admin_q)) {
 		ret = PTR_ERR(ctrl->admin_q);
 		goto out_free_tagset;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 01e8bae7886584..f58c5c18daef65 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -756,6 +756,7 @@ static __always_inline void nvme_complete_batch(struct io_comp_batch *iob,
 	blk_mq_end_request_batch(iob);
 }
 
+void nvme_set_ctrl_limits(struct nvme_ctrl *ctrl, struct queue_limits *lim);
 blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data);
 void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
@@ -1038,8 +1039,9 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
 
 int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data);
+int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf,
+		struct queue_limits *lim);
 #ifdef CONFIG_BLK_DEV_ZONED
-int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf);
 blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
 				       struct nvme_command *cmnd,
 				       enum nvme_zone_mgmt_action action);
@@ -1050,13 +1052,6 @@ static inline blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns,
 {
 	return BLK_STS_NOTSUPP;
 }
-
-static inline int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
-{
-	dev_warn(ns->ctrl->device,
-		 "Please enable CONFIG_BLK_DEV_ZONED to support ZNS devices\n");
-	return -EPROTONOSUPPORT;
-}
 #endif
 
 static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 852261d7891362..722384bcc765cd 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -35,10 +35,10 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
 	return 0;
 }
 
-int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
+int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf,
+		struct queue_limits *lim)
 {
 	struct nvme_effects_log *log = ns->head->effects;
-	struct request_queue *q = ns->queue;
 	struct nvme_command c = { };
 	struct nvme_id_ns_zns *id;
 	int status;
@@ -99,12 +99,12 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 		goto free_data;
 	}
 
-	disk_set_zoned(ns->disk);
-	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
-	disk_set_max_open_zones(ns->disk, le32_to_cpu(id->mor) + 1);
-	disk_set_max_active_zones(ns->disk, le32_to_cpu(id->mar) + 1);
-	blk_queue_chunk_sectors(ns->queue, ns->head->zsze);
-	blk_queue_max_zone_append_sectors(ns->queue, ns->ctrl->max_zone_append);
+	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, ns->queue);
+	lim->zoned = 1;
+	lim->max_open_zones = le32_to_cpu(id->mor) + 1;
+	lim->max_active_zones = le32_to_cpu(id->mar) + 1;
+	lim->chunk_sectors = ns->head->zsze;
+	lim->max_zone_append_sectors = ns->ctrl->max_zone_append;
 free_data:
 	kfree(id);
 	return status;
-- 
2.39.2


