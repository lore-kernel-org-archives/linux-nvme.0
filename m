Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB339C55174
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 02:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EhDMQDe+GeAZ+Emvu6jp50WHu2bvfPwAgwvLRRG0htU=; b=EtzfFpiZaHEgYS7H5cQa/XDe7F
	m1LleYjLwf6W/eqjP2ru2NHD/M8cIn11T2/lP16cjvP82UIGkfEtfPn37yiRBKGLUyTsw4Z219Sjn
	WPamQMZcNXSvpkjdMRsS8NHbsN6Auh1mCzdYz4GZwSKtu+DeKCk0rX+07CNRaXQlQbks6hiSl91Eb
	3In1mVFLfRmI2kifsI7WJvtgHiXYP7DJ9wrn6NNvoEAKGD2fP2VZEneiYZHTH5ccXrtZvKV5ySEwA
	tsy5lD6wr3gfR53pOw/T/HNwVvn+KrkV2em6i2QtIFo88wg+VccVWx1lC7hMkFFpzuGsUm9UCZmPY
	CTuukw0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wro9J-00000004q6j-2Gne;
	Thu, 06 Aug 2026 02:48:01 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wro9G-00000004q4k-328J
	for linux-nvme@lists.infradead.org;
	Thu, 06 Aug 2026 02:48:00 +0000
X-UUID: 3684f8cc914111f1aa26b74ffac11d73-20260806
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4f58fb76-ed6c-45e0-9ceb-17c53064162f,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:4f58fb76-ed6c-45e0-9ceb-17c53064162f,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:5c52547a3a1c626f87d5a788f3e6c566,BulkI
	D:26080610475311K4PVD8,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3684f8cc914111f1aa26b74ffac11d73-20260806
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 445037446; Thu, 06 Aug 2026 10:47:49 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v2 4/4] block, nvme: use lower-level limit helpers for namespace heads
Date: Thu,  6 Aug 2026 10:46:58 +0800
Message-Id: <20260806024658.4193386-5-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260806024658.4193386-1-sangyao@kylinos.cn>
References: <20260806024658.4193386-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_194759_074665_5973BEDA 
X-CRM114-Status: GOOD (  25.34  )
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

An NVMe namespace head and each path refer to the same namespace.
queue_limits_stack_bdev() treats the path as a bottom-device range and
applies all of blk_stack_limits(), including topology rules and start-based
atomic write checks. These mapped-device rules should not be used when
updating the namespace head.

Make blk_stack_path_limits() and the existing
blk_stack_atomic_writes_limits() public when adding their first caller
outside the block layer. Keep the existing names and parameter types.

Refresh logical_block_size, physical_block_size, io_min, io_opt,
discard_granularity, zone_write_granularity and the write stream limits
from the namespace that was just scanned. Keep chunk_sectors conservative
for non-zoned namespaces because NVME_QUIRK_STRIPE_SIZE can make it
controller-specific, while zoned namespaces refresh the zone size directly.

Use blk_stack_path_limits() for the all-path execution feature bits and
hardware limits that must work for every path, and use
blk_stack_atomic_writes_limits() with a zero start sector. Keep the
non-path feature handling in NVMe: the namespace head needs only inherited
features that can describe an NVMe path. Zoned is handled with the
namespace layout, and RAID partial stripes are not an NVMe namespace-head
property.

Keep max_user_* from queue_limits_start_update(), rebuild the integrity
profile with nvme_init_integrity(), and retain the existing write zeroes,
discard and zone resource updates in NVMe.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 block/blk-settings.c     |  23 +++++++-
 drivers/nvme/host/core.c | 115 +++++++++++++++++++++++++++++----------
 include/linux/blkdev.h   |   4 ++
 3 files changed, 109 insertions(+), 33 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 40cd3490f168..877834e88745 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -726,8 +726,14 @@ static bool blk_stack_atomic_writes_head(struct queue_limits *t,
 	return true;
 }
 
-static void blk_stack_atomic_writes_limits(struct queue_limits *t,
-				struct queue_limits *b, sector_t start)
+/**
+ * blk_stack_atomic_writes_limits - stack atomic write limits
+ * @t: the stacking driver limits (top device)
+ * @b: the underlying queue limits (bottom device)
+ * @start: first data sector within bottom device
+ */
+void blk_stack_atomic_writes_limits(struct queue_limits *t,
+		struct queue_limits *b, sector_t start)
 {
 	if (!(b->features & BLK_FEAT_ATOMIC_WRITES))
 		goto unsupported;
@@ -755,8 +761,18 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
 	t->atomic_write_hw_unit_min = 0;
 	t->atomic_write_hw_boundary = 0;
 }
+EXPORT_SYMBOL_GPL(blk_stack_atomic_writes_limits);
 
-static void blk_stack_path_limits(struct queue_limits *t,
+/**
+ * blk_stack_path_limits - update limits that must hold for every I/O path
+ * @t: the queue limits to update
+ * @b: the queue limits for an I/O path
+ *
+ * Clear BLK_FEAT_NOWAIT, BLK_FEAT_POLL and BLK_FEAT_PCI_P2PDMA when they
+ * are not set in @b. Stack the sector, segment, integrity segment and DMA
+ * alignment limits that every path must support.
+ */
+void blk_stack_path_limits(struct queue_limits *t,
 		const struct queue_limits *b)
 {
 	/*
@@ -785,6 +801,7 @@ static void blk_stack_path_limits(struct queue_limits *t,
 					   b->max_segment_size);
 	t->dma_alignment = max(t->dma_alignment, b->dma_alignment);
 }
+EXPORT_SYMBOL_GPL(blk_stack_path_limits);
 
 /*
  * Stack and check logical_block_size, physical_block_size, io_min, io_opt,
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e3d27c0440db..181394380510 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -11,6 +11,7 @@
 #include <linux/compat.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
+#include <linux/gcd.h>
 #include <linux/hdreg.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -2520,12 +2521,89 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	return ret;
 }
 
-static void nvme_stack_zone_resources(struct queue_limits *t,
-				      const struct queue_limits *b)
+static void nvme_apply_ns_head_identify_limits(struct queue_limits *lim,
+		const struct queue_limits *ns_lim)
 {
-	t->max_open_zones = min_not_zero(t->max_open_zones, b->max_open_zones);
-	t->max_active_zones =
-		min_not_zero(t->max_active_zones, b->max_active_zones);
+	/*
+	 * The namespace scan sets these values from Identify data and limits
+	 * calculated from it. Refresh them instead of combining them with values
+	 * left from an earlier namespace scan.
+	 */
+	lim->features &= ~BLK_FEAT_ZONED;
+	lim->features |= ns_lim->features & BLK_FEAT_ZONED;
+	lim->logical_block_size = ns_lim->logical_block_size;
+	lim->physical_block_size = ns_lim->physical_block_size;
+	lim->io_min = ns_lim->io_min;
+	lim->io_opt = ns_lim->io_opt;
+	/* A non-zoned path may have a controller-specific stripe size. */
+	if (ns_lim->features & BLK_FEAT_ZONED)
+		lim->chunk_sectors = ns_lim->chunk_sectors;
+	else if (ns_lim->chunk_sectors)
+		lim->chunk_sectors = gcd(lim->chunk_sectors,
+					 ns_lim->chunk_sectors);
+	lim->alignment_offset = 0;
+	lim->discard_alignment = 0;
+	lim->flags &= ~BLK_FLAG_MISALIGNED;
+	lim->discard_granularity = ns_lim->discard_granularity;
+	lim->zone_write_granularity = ns_lim->zone_write_granularity;
+	lim->max_write_streams = ns_lim->max_write_streams;
+	lim->write_stream_granularity = ns_lim->write_stream_granularity;
+}
+
+static void nvme_apply_ns_head_operation_limits(struct queue_limits *lim,
+		const struct queue_limits *ns_lim)
+{
+	/* Keep the existing minimums for controller command limits. */
+	lim->max_write_zeroes_sectors =
+		min(lim->max_write_zeroes_sectors,
+		    ns_lim->max_write_zeroes_sectors);
+	lim->max_hw_wzeroes_unmap_sectors =
+		min(lim->max_hw_wzeroes_unmap_sectors,
+		    ns_lim->max_hw_wzeroes_unmap_sectors);
+	lim->max_discard_segments =
+		min_not_zero(lim->max_discard_segments,
+			     ns_lim->max_discard_segments);
+	if (ns_lim->discard_granularity)
+		lim->max_hw_discard_sectors =
+			min_not_zero(lim->max_hw_discard_sectors,
+				     ns_lim->max_hw_discard_sectors);
+	blk_stack_atomic_writes_limits(lim, ns_lim, 0);
+}
+
+static void nvme_apply_ns_head_zone_limits(struct queue_limits *lim,
+		const struct queue_limits *ns_lim)
+{
+	/*
+	 * Zone geometry was set above. max_hw_zone_append_sectors must work
+	 * for every path, while max_open_zones and max_active_zones are
+	 * namespace resources.
+	 */
+	lim->max_hw_zone_append_sectors =
+		min(lim->max_hw_zone_append_sectors,
+		    ns_lim->max_hw_zone_append_sectors);
+	lim->max_open_zones = min_not_zero(lim->max_open_zones,
+					   ns_lim->max_open_zones);
+	lim->max_active_zones =
+		min_not_zero(lim->max_active_zones,
+			     ns_lim->max_active_zones);
+}
+
+static void nvme_apply_ns_head_limits(struct queue_limits *lim,
+		const struct queue_limits *ns_lim)
+{
+	nvme_apply_ns_head_identify_limits(lim, ns_lim);
+	/*
+	 * Keep inherited non-path features that can describe an NVMe path.
+	 * Zoned was handled as namespace layout above, and the RAID partial
+	 * stripes flag is not an NVMe namespace-head property.
+	 */
+	lim->features |= ns_lim->features &
+		(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA |
+		 BLK_FEAT_ROTATIONAL | BLK_FEAT_STABLE_WRITES);
+	blk_stack_path_limits(lim, ns_lim);
+	nvme_apply_ns_head_operation_limits(lim, ns_lim);
+	if (lim->features & BLK_FEAT_ZONED)
+		nvme_apply_ns_head_zone_limits(lim, ns_lim);
 }
 
 static int nvme_update_ns_head_limits(struct nvme_ns *ns,
@@ -2539,35 +2617,12 @@ static int nvme_update_ns_head_limits(struct nvme_ns *ns,
 
 	lim = queue_limits_start_update(head_q);
 	memflags = blk_mq_freeze_queue(head_q);
-	/*
-	 * queue_limits mixes values that are the hardware limitations
-	 * for bio splitting with what is the device configuration.
-	 *
-	 * For NVMe the device configuration can change after e.g. a
-	 * Format command, and we really want to pick up the new format
-	 * value here. But we must still stack the queue limits to the
-	 * least common denominator for multipathing to split the bios
-	 * properly.
-	 *
-	 * To work around this, we explicitly set the device
-	 * configuration to those that we just queried, but only stack
-	 * the splitting limits in to make sure we still obey possibly
-	 * lower limitations of other controllers.
-	 */
-	lim.logical_block_size = ns_lim->logical_block_size;
-	lim.physical_block_size = ns_lim->physical_block_size;
-	lim.io_min = ns_lim->io_min;
-	lim.io_opt = ns_lim->io_opt;
-	queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
-				ns->head->disk->disk_name);
-	if (lim.features & BLK_FEAT_ZONED)
-		nvme_stack_zone_resources(&lim, ns_lim);
+
+	nvme_apply_ns_head_limits(&lim, ns_lim);
 	if (unsupported)
 		ns->head->disk->flags |= GENHD_FL_HIDDEN;
 	else
 		nvme_init_integrity(ns->head, &lim, info);
-	lim.max_write_streams = ns_lim->max_write_streams;
-	lim.write_stream_granularity = ns_lim->write_stream_granularity;
 	ret = queue_limits_commit_update(head_q, &lim);
 	if (ret)
 		goto unfreeze_head_queue;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9213a5716f95..b89930f1f7a6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1153,6 +1153,10 @@ static inline void blk_queue_disable_write_zeroes(struct request_queue *q)
  */
 extern void blk_set_queue_depth(struct request_queue *q, unsigned int depth);
 extern void blk_set_stacking_limits(struct queue_limits *lim);
+void blk_stack_path_limits(struct queue_limits *t,
+		const struct queue_limits *b);
+void blk_stack_atomic_writes_limits(struct queue_limits *t,
+		struct queue_limits *b, sector_t start);
 extern int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 			    sector_t offset);
 void queue_limits_stack_bdev(struct queue_limits *t, struct block_device *bdev,
-- 
2.25.1


