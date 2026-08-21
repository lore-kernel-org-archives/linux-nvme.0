Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553F4C5DF7D
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 10:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hquGvxMNhUE6luQ0i8xotPnpcTM0M5DVn0iPlWy2uqU=; b=nF6sL25g/77eoSRQ7BPp72zScn
	LywWkygpog0L1gQ0r0yIhj0hDNnFHKVyRWf/85TzW6JkL2875DAdaI2QjrVQcut5t3AZAERcpAhEb
	o98lWb60+2Eow8MB1ku75ywbuduw0+tahnwor0xVOIQHzycDMX/jleBL3HEy/gIV0YXIPFxhikUdE
	uAT9Kw2zh5IsN22qXkRFHR+kajSn5UFmaykqU3z6A19LqLcGw43lp/Re86dAbTfH9oNFfwDQ8fWyN
	jRN48ml3p3VImK90RnyWdCcKm9GdLJJupGK+w1vBgLcUTDCX8mIjRkRDX4K5NOqinVwiYwSyQa0H4
	rI3lJSkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxMFD-0000000D3qU-2wOd;
	Fri, 21 Aug 2026 10:13:03 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxMFB-0000000D3nG-07yF
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 10:13:02 +0000
X-UUID: dc356f289d4811f19a56ed5b684f684d-20260821
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:4f6659f8-d4d9-401c-9355-0e7532027461,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:4f6659f8-d4d9-401c-9355-0e7532027461,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:6f31db393d643e16dc98306b3e1f8e82,BulkI
	D:260821181255UZQH3ITJ,BulkQuantity:0,SF:10|38|66|78|81|82|102|127|850|865
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dc356f289d4811f19a56ed5b684f684d-20260821
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1660134943; Fri, 21 Aug 2026 18:12:48 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: john.g.garry@oracle.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v3 3/5] block: factor path limits out of blk_stack_limits
Date: Fri, 21 Aug 2026 18:10:48 +0800
Message-Id: <20260821101050.1464087-4-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260821101050.1464087-1-sangyao@kylinos.cn>
References: <20260821101050.1464087-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_031301_373258_0E6C0743 
X-CRM114-Status: GOOD (  12.12  )
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

Same-LBA multipath needs to stack path limits without applying
mapped-range topology calculations.

Factor this path limit stacking into blk_stack_path_limits(). It covers
execution features, sector and segment limits, write zeroes, discard
segments, zone append and DMA alignment.

There is no behavior change for existing callers.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 block/blk-settings.c | 77 +++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9e7cdaaefbca..f1a2e4fe4e77 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -756,6 +756,39 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
 	t->atomic_write_hw_boundary = 0;
 }
 
+#define STACK_MIN_NOT_ZERO(t, b, field) \
+	((t)->field = min_not_zero((t)->field, (b)->field))
+#define STACK_MIN(t, b, field) \
+	((t)->field = min((t)->field, (b)->field))
+
+static void blk_stack_path_limits(struct queue_limits *t,
+		const struct queue_limits *b)
+{
+	/*
+	 * These features must be supported by the top queue and every path that
+	 * can execute I/O. Clear them when a path does not support them.
+	 */
+	if (!(b->features & BLK_FEAT_NOWAIT))
+		t->features &= ~BLK_FEAT_NOWAIT;
+	if (!(b->features & BLK_FEAT_POLL))
+		t->features &= ~BLK_FEAT_POLL;
+	if (!(b->features & BLK_FEAT_PCI_P2PDMA))
+		t->features &= ~BLK_FEAT_PCI_P2PDMA;
+
+	STACK_MIN_NOT_ZERO(t, b, max_hw_sectors);
+	STACK_MIN_NOT_ZERO(t, b, max_dev_sectors);
+	STACK_MIN_NOT_ZERO(t, b, seg_boundary_mask);
+	STACK_MIN_NOT_ZERO(t, b, virt_boundary_mask);
+	STACK_MIN_NOT_ZERO(t, b, max_segments);
+	STACK_MIN_NOT_ZERO(t, b, max_integrity_segments);
+	STACK_MIN_NOT_ZERO(t, b, max_segment_size);
+	STACK_MIN(t, b, max_write_zeroes_sectors);
+	STACK_MIN(t, b, max_hw_wzeroes_unmap_sectors);
+	STACK_MIN_NOT_ZERO(t, b, max_discard_segments);
+	STACK_MIN(t, b, max_hw_zone_append_sectors);
+	t->dma_alignment = max(t->dma_alignment, b->dma_alignment);
+}
+
 /*
  * Stack block sizes, I/O granularities, chunk boundaries and alignment for a
  * bottom-device range mapped at @start. Round maximum sector limits after the
@@ -873,51 +906,14 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	int ret;
 
 	t->features |= (b->features & BLK_FEAT_INHERIT_MASK);
-
-	/*
-	 * Some feaures need to be supported both by the stacking driver and all
-	 * underlying devices.  The stacking driver sets these flags before
-	 * stacking the limits, and this will clear the flags if any of the
-	 * underlying devices does not support it.
-	 */
-	if (!(b->features & BLK_FEAT_NOWAIT))
-		t->features &= ~BLK_FEAT_NOWAIT;
-	if (!(b->features & BLK_FEAT_POLL))
-		t->features &= ~BLK_FEAT_POLL;
-	if (!(b->features & BLK_FEAT_PCI_P2PDMA))
-		t->features &= ~BLK_FEAT_PCI_P2PDMA;
+	blk_stack_path_limits(t, b);
 
 	t->max_sectors = min_not_zero(t->max_sectors, b->max_sectors);
 	t->max_user_sectors = min_not_zero(t->max_user_sectors,
 			b->max_user_sectors);
-	t->max_hw_sectors = min_not_zero(t->max_hw_sectors, b->max_hw_sectors);
-	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);
-	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
-					b->max_write_zeroes_sectors);
 	t->max_user_wzeroes_unmap_sectors =
 			min(t->max_user_wzeroes_unmap_sectors,
 			    b->max_user_wzeroes_unmap_sectors);
-	t->max_hw_wzeroes_unmap_sectors =
-			min(t->max_hw_wzeroes_unmap_sectors,
-			    b->max_hw_wzeroes_unmap_sectors);
-
-	t->max_hw_zone_append_sectors = min(t->max_hw_zone_append_sectors,
-					b->max_hw_zone_append_sectors);
-
-	t->seg_boundary_mask = min_not_zero(t->seg_boundary_mask,
-					    b->seg_boundary_mask);
-	t->virt_boundary_mask = min_not_zero(t->virt_boundary_mask,
-					    b->virt_boundary_mask);
-
-	t->max_segments = min_not_zero(t->max_segments, b->max_segments);
-	t->max_discard_segments = min_not_zero(t->max_discard_segments,
-					       b->max_discard_segments);
-	t->max_integrity_segments = min_not_zero(t->max_integrity_segments,
-						 b->max_integrity_segments);
-
-	t->max_segment_size = min_not_zero(t->max_segment_size,
-					   b->max_segment_size);
-	t->dma_alignment = max(t->dma_alignment, b->dma_alignment);
 
 	ret = blk_stack_topology_limits(t, b, start);
 
@@ -927,8 +923,9 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 
 		t->max_discard_sectors = min_not_zero(t->max_discard_sectors,
 						      b->max_discard_sectors);
-		t->max_hw_discard_sectors = min_not_zero(t->max_hw_discard_sectors,
-							 b->max_hw_discard_sectors);
+		t->max_hw_discard_sectors =
+			min_not_zero(t->max_hw_discard_sectors,
+				     b->max_hw_discard_sectors);
 		t->discard_granularity = max(t->discard_granularity,
 					     b->discard_granularity);
 		t->discard_alignment = lcm_not_zero(t->discard_alignment, alignment) %
-- 
2.25.1

