Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFD0C44508
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 08:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xIZ6qRExbPn7qKQLZNWfShYUkaAQGdpQ4rbB62Uq+9k=; b=N2hHLoBI5i5KtPz14Z1Vc8iNdQ
	KSGnN32DpOyc+8XPPlzulBt1QZD6lX6MndH3zusJdkVZ6lADVc9QHBYqtR8+QEKXP8bM5ODNc56P8
	yBwGeCBexpaGoj2qDjuTpNOFXnZrFUvxZhNRrKCy4qsrBK/nFP8gVb1aFEoUQ/9XIy0ssuLi8rX+L
	z0h64+2CF2t3UVObNG1ILLt/D1E8X9duMmW05NOZa+M9PZaxU9SCQ3Y0qGHutUVpGLo/H9Xit5RD/
	PDbg/0A05vYuSVpTJwXifcXahE2JLDxj9naaA1sqe6E+EVfVcBrcdu6f2pDfDhDAZmFJKlp0G4SWB
	U9NlIHlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whkWk-00000001eHk-0iJb;
	Thu, 09 Jul 2026 08:54:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whkS4-00000001YRL-3rox
	for linux-nvme@bombadil.infradead.org;
	Thu, 09 Jul 2026 08:49:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=xIZ6qRExbPn7qKQLZNWfShYUkaAQGdpQ4rbB62Uq+9k=; b=TQ3XK8bJigwBPWQnNb46P7oYrD
	PS6MFUai0Xess1EjknR4gdhsYWhG2WLtBjVbfvSKhjzL/AXzvNaqmSD2EntwLktpAa0XuU4ehlc+/
	MoXsQmTytBs1ldtkKM0YXVjmdUhYAOsgMjsOF/WvzQhCmlc9hnC0cGlanLiPj7VyhjMAgO49CUq0t
	bHLr+xe8ULF0j5viAM2UwWFEP3/WKxIKYzDor9wBXSq1NuuB4uv/ck39mQcjrz39zPP5nwoJauVCO
	e+VQ//a/JFW6Gdiexxwtu4OEq8OqFmI9V8nzlPdsmkBb2kBBW4Irjg66JZiSBYxxrX6x4GmhBrne1
	BKRc0lOg==;
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1whkS0-00000008yba-01kZ
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 08:49:46 +0000
X-UUID: 188127767b7311f1aa26b74ffac11d73-20260709
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ce51439b-b2dc-4a1d-af92-b96187a7ae38,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:ce51439b-b2dc-4a1d-af92-b96187a7ae38,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:f8cb6f004a3e50bd8a4490085dd22f56,BulkI
	D:260709162246RCBM95B1,BulkQuantity:1,Recheck:0,SF:10|66|78|81|82|102|127|
	136|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 188127767b7311f1aa26b74ffac11d73-20260709
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 644923052; Thu, 09 Jul 2026 16:49:28 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Yao Sang <sangyao@kylinos.cn>
Subject: [RFC PATCH v1 2/2] nvme: stop using queue_limits_stack_bdev for namespace heads
Date: Thu,  9 Jul 2026 16:48:25 +0800
Message-Id: <20260709084826.3208740-3-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260709084826.3208740-1-sangyao@kylinos.cn>
References: <20260709084826.3208740-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_094944_981212_27B96D90 
X-CRM114-Status: GOOD (  18.28  )
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

NVMe namespace heads are not generic stacked block devices. Updating a head
with queue_limits_stack_bdev() pulls in bdev offset, alignment, and generic
stacking policy that belongs to mapped devices, while NVMe needs to refresh
namespace Identify data and preserve head user caps.

Add an NVMe-local helper that copies refreshed namespace configuration,
keeps head user caps from queue_limits_start_update(), preserves
the existing write-cache and compatibility feature inheritance, and merges
request limits conservatively. Head-level execution features are kept only
when every usable path supports them.

Keep the helper local to NVMe for now so field ownership can be reviewed
before any block core helper is considered.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 drivers/nvme/host/core.c | 142 ++++++++++++++++++++++++++++++---------
 1 file changed, 112 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b96fa993a08f..d5e45dc13041 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2509,12 +2509,117 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
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
@@ -2528,35 +2633,12 @@ static int nvme_update_ns_head_limits(struct nvme_ns *ns,
 
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
 
 	set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
-- 
2.25.1


