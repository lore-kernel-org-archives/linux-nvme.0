Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80264C4451B
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 02:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BRO98f6YEA/j9dlNyrE0A2jsQKzeqIngJSoOI3wEv5A=; b=YLsloS/VqKWAPDSFOaqOry+JDI
	2BsewIA9ICZ6wmiCD3yYYNveSd2eybb2/XCcnYghu42w8pImicdMjGupcB15d5DIBTomwfMiBWcPL
	Q8t6vw33Q6bddJ25fCuVGpsX3jiKeTgylW0U/6XhCQKSS2j23kuKAxihpYBiE4YB15XZdwQ5NQx/i
	TWfWZGOEkcyNSp/2ohnBiFr/P31XZNZocaus8zlqk+86+QugZ9gvlBGuTCMAumlJ+FeVFO3MGnVjT
	RNw04oYjPondEc+vNAMeTAazf0ryBM0MWriyyAaNG37jRaImSxnezNpFnhacFRt/aLmNwtKGckMCq
	3D9lmJxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wldel-00000005gjY-1dC8;
	Mon, 20 Jul 2026 02:22:59 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wldee-00000005ghG-2Laa
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 02:22:54 +0000
X-UUID: e3b8dfc683e111f1aa26b74ffac11d73-20260720
X-CTIC-Tags: HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-CACHE: Type:Local,Time:202607201014+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ba45b0d1-5f71-41aa-a3e9-82fd39765666,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-50,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-INFO: VERSION:1.3.12,REQID:ba45b0d1-5f71-41aa-a3e9-82fd39765666,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-50,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-30
X-CID-META: VersionHash:e7bac3a,CLOUDID:a2f50a9585a13576ed1b26a36bc0409a,BulkI
	D:260717122115Y30Q5PIG,BulkQuantity:1,Recheck:0,SF:10|13|66|78|81|82|102|1
	27|136|307|312|320|328|341|342|344|347|350|351|850|865|898|10035|15035|200
	20|25000|26021,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e3b8dfc683e111f1aa26b74ffac11d73-20260720
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1295290830; Mon, 20 Jul 2026 10:22:43 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Cc: Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v1 2/2] nvme: stop using queue_limits_stack_bdev for namespace heads
Date: Mon, 20 Jul 2026 10:22:05 +0800
Message-Id: <20260720022205.1798805-3-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260720022205.1798805-1-sangyao@kylinos.cn>
References: <20260720022205.1798805-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260719_192253_070629_996EFC28 
X-CRM114-Status: GOOD (  20.09  )
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

NVMe namespace heads are not generic stacked block devices. Updating a
head with queue_limits_stack_bdev() pulls in bdev offset, alignment, and
generic stacking policy that belongs to mapped devices, while NVMe needs
to refresh namespace Identify data and preserve head user caps.

Add NVMe-local helpers that copy refreshed namespace configuration, keep
head user caps from queue_limits_start_update(), preserve the existing
write-cache and compatibility feature inheritance, and merge request
limits conservatively.

Execution features and request limits continue to accumulate
conservatively as paths are refreshed. This change does not attempt to
widen head limits when a restrictive path disappears; recomputing limits
from the complete live path set is a separate problem.

Keep the helper local to NVMe so its field ownership remains explicit and
does not impose NVMe namespace-head policy on mapped devices.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 drivers/nvme/host/core.c | 142 ++++++++++++++++++++++++++++++---------
 1 file changed, 112 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e351cb615b10..320bfdf39616 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2518,12 +2518,117 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	return ret;
 }
 
-static void nvme_stack_zone_resources(struct queue_limits *t,
-				      const struct queue_limits *b)
+static void nvme_apply_ns_head_identify_limits(struct queue_limits *lim,
+					       const struct queue_limits *ns_lim)
 {
-	t->max_open_zones = min_not_zero(t->max_open_zones, b->max_open_zones);
-	t->max_active_zones =
-		min_not_zero(t->max_active_zones, b->max_active_zones);
+	/*
+	 * Identify-derived namespace/head attributes come from the refreshed
+	 * NVMe namespace limits, not from generic mapped-device stacking.
+	 */
+	lim->features &= ~(BLK_FEAT_ZONED | BLK_FEAT_ATOMIC_WRITES);
+	lim->features |= ns_lim->features & BLK_FEAT_ZONED;
+	lim->logical_block_size = ns_lim->logical_block_size;
+	lim->physical_block_size = ns_lim->physical_block_size;
+	lim->io_min = ns_lim->io_min;
+	lim->io_opt = ns_lim->io_opt;
+	lim->chunk_sectors = ns_lim->chunk_sectors;
+	lim->discard_granularity = ns_lim->discard_granularity;
+	lim->max_hw_discard_sectors = ns_lim->max_hw_discard_sectors;
+	lim->max_discard_segments = ns_lim->max_discard_segments;
+	lim->zone_write_granularity = ns_lim->zone_write_granularity;
+	lim->max_hw_zone_append_sectors = ns_lim->max_hw_zone_append_sectors;
+	lim->max_write_streams = ns_lim->max_write_streams;
+	lim->write_stream_granularity = ns_lim->write_stream_granularity;
+
+	if ((ns_lim->features & BLK_FEAT_ATOMIC_WRITES) &&
+	    ns_lim->atomic_write_hw_unit_min) {
+		lim->features |= BLK_FEAT_ATOMIC_WRITES;
+		lim->atomic_write_hw_max = ns_lim->atomic_write_hw_max;
+		lim->atomic_write_hw_unit_min =
+			ns_lim->atomic_write_hw_unit_min;
+		lim->atomic_write_hw_unit_max =
+			ns_lim->atomic_write_hw_unit_max;
+		lim->atomic_write_hw_boundary =
+			ns_lim->atomic_write_hw_boundary;
+	} else {
+		lim->atomic_write_hw_max = 0;
+		lim->atomic_write_hw_unit_min = 0;
+		lim->atomic_write_hw_unit_max = 0;
+		lim->atomic_write_hw_boundary = 0;
+	}
+
+	if (lim->features & BLK_FEAT_ZONED) {
+		lim->max_open_zones = min_not_zero(lim->max_open_zones,
+						   ns_lim->max_open_zones);
+		lim->max_active_zones =
+			min_not_zero(lim->max_active_zones,
+				     ns_lim->max_active_zones);
+	} else {
+		lim->max_open_zones = 0;
+		lim->max_active_zones = 0;
+		lim->max_zone_append_sectors = 0;
+	}
+}
+
+static void nvme_apply_ns_head_feature_limits(struct queue_limits *lim,
+					      const struct queue_limits *ns_lim)
+{
+	/*
+	 * Keep the existing inheritance for compatibility feature bits.
+	 * Path execution features are handled separately below.
+	 */
+	lim->features |= ns_lim->features &
+		(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA |
+		 BLK_FEAT_ROTATIONAL | BLK_FEAT_STABLE_WRITES);
+
+	/*
+	 * Head-level execution capabilities are only safe if every usable path
+	 * supports them.
+	 */
+	if (!(ns_lim->features & BLK_FEAT_NOWAIT))
+		lim->features &= ~BLK_FEAT_NOWAIT;
+	if (!(ns_lim->features & BLK_FEAT_POLL))
+		lim->features &= ~BLK_FEAT_POLL;
+	if (!(ns_lim->features & BLK_FEAT_PCI_P2PDMA))
+		lim->features &= ~BLK_FEAT_PCI_P2PDMA;
+}
+
+static void nvme_apply_ns_head_request_limits(struct queue_limits *lim,
+					      const struct queue_limits *ns_lim)
+{
+	lim->max_hw_sectors = min_not_zero(lim->max_hw_sectors,
+					   ns_lim->max_hw_sectors);
+	lim->max_dev_sectors = min_not_zero(lim->max_dev_sectors,
+					    ns_lim->max_dev_sectors);
+	lim->max_write_zeroes_sectors =
+		min(lim->max_write_zeroes_sectors,
+		    ns_lim->max_write_zeroes_sectors);
+	lim->max_hw_wzeroes_unmap_sectors =
+		min(lim->max_hw_wzeroes_unmap_sectors,
+		    ns_lim->max_hw_wzeroes_unmap_sectors);
+	lim->seg_boundary_mask = min_not_zero(lim->seg_boundary_mask,
+					      ns_lim->seg_boundary_mask);
+	lim->virt_boundary_mask = min_not_zero(lim->virt_boundary_mask,
+					       ns_lim->virt_boundary_mask);
+	lim->max_segments = min_not_zero(lim->max_segments,
+					 ns_lim->max_segments);
+	lim->max_integrity_segments =
+		min_not_zero(lim->max_integrity_segments,
+			     ns_lim->max_integrity_segments);
+	lim->max_segment_size = min_not_zero(lim->max_segment_size,
+					     ns_lim->max_segment_size);
+	lim->dma_alignment = max(lim->dma_alignment, ns_lim->dma_alignment);
+	lim->max_secure_erase_sectors =
+		min_not_zero(lim->max_secure_erase_sectors,
+			     ns_lim->max_secure_erase_sectors);
+}
+
+static void nvme_apply_ns_head_limits(struct queue_limits *lim,
+				      const struct queue_limits *ns_lim)
+{
+	nvme_apply_ns_head_identify_limits(lim, ns_lim);
+	nvme_apply_ns_head_feature_limits(lim, ns_lim);
+	nvme_apply_ns_head_request_limits(lim, ns_lim);
 }
 
 static int nvme_update_ns_head_limits(struct nvme_ns *ns,
@@ -2537,35 +2642,12 @@ static int nvme_update_ns_head_limits(struct nvme_ns *ns,
 
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
-- 
2.25.1


