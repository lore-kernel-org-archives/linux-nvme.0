Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FCBC5478C
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ycn6WxJyb+SvrOi5azfp7SOfA9OrxlxpsJfCVYd6NOY=; b=rnDKsL+3c7ReFOqsHFyUASb3Ua
	7zNYOw/KLqKa1SvkdytsW55d00wT5SY0YGX9bxjmTY68qo8a2LFHKBY9+KFWPvr78YGAidFcvhBVn
	KYzRjUmktGdiNCrpy9wZ4ugq/pLniDcaKYc4iwIRm2FexJ2vwO9Gx20WdYN8Lxf68CoQoJPWTZNVN
	A+Y/cFQ7Xr2KQTGPpd8jwdcWubgv8qUJtgUbwvjcW+gJCLy4YuEkXHeL5oSyuVkiotoPlzcBIN+UJ
	u6ANDnoHbh6DmEUtRRevhtxvFa70aam+SfFSSlWH0AgFZHSMQnj28HVtSYIQIPQtHUOl3iCXokciK
	4F0AeYNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8x2-00000009HyJ-3rce;
	Mon, 04 Mar 2024 14:05:57 +0000
Received: from [206.0.71.24] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8wv-00000009HuC-0rra;
	Mon, 04 Mar 2024 14:05:50 +0000
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
Subject: [PATCH 08/16] nvme: move a few things out of nvme_update_disk_info
Date: Mon,  4 Mar 2024 07:04:52 -0700
Message-Id: <20240304140500.78583-9-hch@lst.de>
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

Move setting up the integrity profile and setting the disk capacity out
of nvme_update_disk_info to get nvme_update_disk_info into a shape where
it just sets queue_limits eventually.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 46 +++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d356f3fa2cf8eb..63c2b581f7859e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1965,12 +1965,13 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 	blk_queue_write_cache(q, vwc, vwc);
 }
 
-static void nvme_update_disk_info(struct nvme_ctrl *ctrl, struct gendisk *disk,
-		struct nvme_ns_head *head, struct nvme_id_ns *id)
+static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
-	sector_t capacity = nvme_lba_to_sect(head, le64_to_cpu(id->nsze));
+	struct gendisk *disk = ns->disk;
+	struct nvme_ns_head *head = ns->head;
 	u32 bs = 1U << head->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt = 0;
+	bool valid = true;
 
 	/*
 	 * The block layer can't support LBA sizes larger than the page size
@@ -1978,8 +1979,8 @@ static void nvme_update_disk_info(struct nvme_ctrl *ctrl, struct gendisk *disk,
 	 * allow block I/O.
 	 */
 	if (head->lba_shift > PAGE_SHIFT || head->lba_shift < SECTOR_SHIFT) {
-		capacity = 0;
 		bs = (1 << 9);
+		valid = false;
 	}
 
 	atomic_bs = phys_bs = bs;
@@ -1992,7 +1993,7 @@ static void nvme_update_disk_info(struct nvme_ctrl *ctrl, struct gendisk *disk,
 		if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf)
 			atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
 		else
-			atomic_bs = (1 + ctrl->subsys->awupf) * bs;
+			atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
 	}
 
 	if (id->nsfeat & NVME_NS_FEAT_IO_OPT) {
@@ -2012,24 +2013,14 @@ static void nvme_update_disk_info(struct nvme_ctrl *ctrl, struct gendisk *disk,
 	blk_queue_io_min(disk->queue, phys_bs);
 	blk_queue_io_opt(disk->queue, io_opt);
 
-	/*
-	 * Register a metadata profile for PI, or the plain non-integrity NVMe
-	 * metadata masquerading as Type 0 if supported, otherwise reject block
-	 * I/O to namespaces with metadata except when the namespace supports
-	 * PI, as it can strip/insert in that case.
-	 */
-	if (!nvme_init_integrity(disk, head))
-		capacity = 0;
-
-	set_capacity_and_notify(disk, capacity);
-
-	nvme_config_discard(ctrl, disk, head);
+	nvme_config_discard(ns->ctrl, disk, head);
 
-	if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
+	if (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
 		blk_queue_max_write_zeroes_sectors(disk->queue, UINT_MAX);
 	else
 		blk_queue_max_write_zeroes_sectors(disk->queue,
-				ctrl->max_zeroes_sectors);
+				ns->ctrl->max_zeroes_sectors);
+	return valid;
 }
 
 static bool nvme_ns_is_readonly(struct nvme_ns *ns, struct nvme_ns_info *info)
@@ -2103,6 +2094,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		struct nvme_ns_info *info)
 {
 	struct nvme_id_ns *id;
+	sector_t capacity;
 	unsigned lbaf;
 	int ret;
 
@@ -2121,6 +2113,8 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	lbaf = nvme_lbaf_index(id->flbas);
 	ns->head->lba_shift = id->lbaf[lbaf].ds;
 	ns->head->nuse = le64_to_cpu(id->nuse);
+	capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
+
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
 	ret = nvme_configure_metadata(ns->ctrl, ns->head, id);
@@ -2129,7 +2123,19 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		goto out;
 	}
 	nvme_set_chunk_sectors(ns, id);
-	nvme_update_disk_info(ns->ctrl, ns->disk, ns->head, id);
+	if (!nvme_update_disk_info(ns, id))
+		capacity = 0;
+
+	/*
+	 * Register a metadata profile for PI, or the plain non-integrity NVMe
+	 * metadata masquerading as Type 0 if supported, otherwise reject block
+	 * I/O to namespaces with metadata except when the namespace supports
+	 * PI, as it can strip/insert in that case.
+	 */
+	if (!nvme_init_integrity(ns->disk, ns->head))
+		capacity = 0;
+
+	set_capacity_and_notify(ns->disk, capacity);
 
 	if (ns->head->ids.csi == NVME_CSI_ZNS) {
 		ret = nvme_update_zone_info(ns, lbaf);
-- 
2.39.2


