Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B101CC55ABA
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 02:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nhpvLW3dAtZnazuTRyAT4gK0O6HdZEeWdUAnQYiacSk=; b=wQ0c5au9J5or/MZ0hquT29jfCH
	EbGkp4mq9DyYXWK0y/4rL3r6ShPuJ7owA/Pdqn8ovGmtP/skVshBCvr6AL+7ikcvKDQxzLsTTGnU6
	dI6se+V+0ikR5Yb/vNle1zbap5VLyLn4mkqqWzR+Y80WTK4WKiYYv6upyhqtONrHQ2dH3TQUyDZsY
	JScyZBkzyT3WXhzvSCkg8JgoSmrmDJXfQWu/8zFJ8jJPJoI6A3Vwm2JW1DfdTUjUcahQMyZkaN7Y5
	L3CbHBkeu8KSRwo9L7RI3MYQ3jO1KEiJ+tnVCmGei9oS27bYtbwFN9enwELFyeHhFU968fOXM7LNN
	xacY7H8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wro96-00000004q10-0g2E;
	Thu, 06 Aug 2026 02:47:48 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wro94-00000004pzW-1C9k
	for linux-nvme@lists.infradead.org;
	Thu, 06 Aug 2026 02:47:47 +0000
X-UUID: 2f43a2e8914111f1aa26b74ffac11d73-20260806
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:44dc73f2-efb9-4882-a671-6d9907bdd905,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:44dc73f2-efb9-4882-a671-6d9907bdd905,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:9bee64b52ec2cd609e7e9d9bea0f0120,BulkI
	D:2608061020071ICVMFH9,BulkQuantity:1,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:41,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2f43a2e8914111f1aa26b74ffac11d73-20260806
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 253893869; Thu, 06 Aug 2026 10:47:37 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v2 2/4] block: factor block size and alignment handling out of blk_stack_limits
Date: Thu,  6 Aug 2026 10:46:56 +0800
Message-Id: <20260806024658.4193386-3-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260806024658.4193386-1-sangyao@kylinos.cn>
References: <20260806024658.4193386-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_194746_622385_EDF67597 
X-CRM114-Status: GOOD (  18.03  )
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

Topology limits are the block size and alignment limits that the top
device exposes after its data is placed at an offset on a bottom device.
blk_stack_limits() uses start, the first data sector in the bottom device
used by the top device, to calculate alignment_offset.

It then stacks logical_block_size, physical_block_size, io_min, io_opt and
chunk_sectors, checks that they are compatible, and rounds max_sectors,
max_hw_sectors and max_dev_sectors down to the final logical_block_size.

Keep these operations together because the checks and rounding must run
after the final logical and physical block sizes are known. Factor them
into a static blk_stack_topology_limits() helper.

There is no behavior change.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 block/blk-settings.c | 169 ++++++++++++++++++++++++-------------------
 1 file changed, 93 insertions(+), 76 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8274631290db..1aff818aaaac 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -756,6 +756,96 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
 	t->atomic_write_hw_boundary = 0;
 }
 
+/*
+ * Stack and check logical_block_size, physical_block_size, io_min, io_opt,
+ * chunk_sectors and alignment_offset for a bottom-device range, then round
+ * max_sectors, max_hw_sectors and max_dev_sectors to logical_block_size.
+ */
+static int blk_stack_topology_limits(struct queue_limits *t,
+		const struct queue_limits *b, sector_t start)
+{
+	unsigned int top, bottom, alignment;
+	int ret = 0;
+
+	t->flags |= b->flags & BLK_FLAG_MISALIGNED;
+
+	alignment = queue_limit_alignment_offset(b, start);
+
+	/*
+	 * The bottom device has a different alignment. Check that it is
+	 * compatible with the current top alignment.
+	 */
+	if (t->alignment_offset != alignment) {
+		top = max(t->physical_block_size, t->io_min) +
+			t->alignment_offset;
+		bottom = max(b->physical_block_size, b->io_min) + alignment;
+
+		/* Verify that top and bottom intervals line up. */
+		if (max(top, bottom) % min(top, bottom)) {
+			t->flags |= BLK_FLAG_MISALIGNED;
+			ret = -1;
+		}
+	}
+
+	t->logical_block_size = max(t->logical_block_size,
+				    b->logical_block_size);
+	t->physical_block_size = max(t->physical_block_size,
+				     b->physical_block_size);
+	t->io_min = max(t->io_min, b->io_min);
+	t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
+
+	/* Set non-power-of-2 compatible chunk_sectors boundary. */
+	if (b->chunk_sectors)
+		t->chunk_sectors = gcd(t->chunk_sectors, b->chunk_sectors);
+
+	/* Physical block size a multiple of the logical block size? */
+	if (t->physical_block_size & (t->logical_block_size - 1)) {
+		t->physical_block_size = t->logical_block_size;
+		t->flags |= BLK_FLAG_MISALIGNED;
+		ret = -1;
+	}
+
+	/* Minimum I/O a multiple of the physical block size? */
+	if (t->io_min & (t->physical_block_size - 1)) {
+		t->io_min = t->physical_block_size;
+		t->flags |= BLK_FLAG_MISALIGNED;
+		ret = -1;
+	}
+
+	/* Optimal I/O a multiple of the physical block size? */
+	if (t->io_opt & (t->physical_block_size - 1)) {
+		t->io_opt = 0;
+		t->flags |= BLK_FLAG_MISALIGNED;
+		ret = -1;
+	}
+
+	/* chunk_sectors a multiple of the physical block size? */
+	if (t->chunk_sectors % (t->physical_block_size >> SECTOR_SHIFT)) {
+		t->chunk_sectors = 0;
+		t->flags |= BLK_FLAG_MISALIGNED;
+		ret = -1;
+	}
+
+	/* Find lowest common alignment_offset. */
+	t->alignment_offset = lcm_not_zero(t->alignment_offset, alignment) %
+		max(t->physical_block_size, t->io_min);
+
+	/* Verify that new alignment_offset is on a logical block boundary. */
+	if (t->alignment_offset & (t->logical_block_size - 1)) {
+		t->flags |= BLK_FLAG_MISALIGNED;
+		ret = -1;
+	}
+
+	t->max_sectors = blk_round_down_sectors(t->max_sectors,
+						t->logical_block_size);
+	t->max_hw_sectors = blk_round_down_sectors(t->max_hw_sectors,
+						   t->logical_block_size);
+	t->max_dev_sectors = blk_round_down_sectors(t->max_dev_sectors,
+						    t->logical_block_size);
+
+	return ret;
+}
+
 /**
  * blk_stack_limits - adjust queue_limits for stacked devices
  * @t:	the stacking driver limits (top device)
@@ -780,8 +870,8 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
 int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 		     sector_t start)
 {
-	unsigned int top, bottom, alignment;
-	int ret = 0;
+	unsigned int alignment;
+	int ret;
 
 	t->features |= (b->features & BLK_FEAT_INHERIT_MASK);
 
@@ -798,8 +888,6 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	if (!(b->features & BLK_FEAT_PCI_P2PDMA))
 		t->features &= ~BLK_FEAT_PCI_P2PDMA;
 
-	t->flags |= (b->flags & BLK_FLAG_MISALIGNED);
-
 	t->max_sectors = min_not_zero(t->max_sectors, b->max_sectors);
 	t->max_user_sectors = min_not_zero(t->max_user_sectors,
 			b->max_user_sectors);
@@ -830,80 +918,9 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 
 	t->max_segment_size = min_not_zero(t->max_segment_size,
 					   b->max_segment_size);
-
-	alignment = queue_limit_alignment_offset(b, start);
-
-	/* Bottom device has different alignment.  Check that it is
-	 * compatible with the current top alignment.
-	 */
-	if (t->alignment_offset != alignment) {
-
-		top = max(t->physical_block_size, t->io_min)
-			+ t->alignment_offset;
-		bottom = max(b->physical_block_size, b->io_min) + alignment;
-
-		/* Verify that top and bottom intervals line up */
-		if (max(top, bottom) % min(top, bottom)) {
-			t->flags |= BLK_FLAG_MISALIGNED;
-			ret = -1;
-		}
-	}
-
-	t->logical_block_size = max(t->logical_block_size,
-				    b->logical_block_size);
-
-	t->physical_block_size = max(t->physical_block_size,
-				     b->physical_block_size);
-
-	t->io_min = max(t->io_min, b->io_min);
-	t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
 	t->dma_alignment = max(t->dma_alignment, b->dma_alignment);
 
-	/* Set non-power-of-2 compatible chunk_sectors boundary */
-	if (b->chunk_sectors)
-		t->chunk_sectors = gcd(t->chunk_sectors, b->chunk_sectors);
-
-	/* Physical block size a multiple of the logical block size? */
-	if (t->physical_block_size & (t->logical_block_size - 1)) {
-		t->physical_block_size = t->logical_block_size;
-		t->flags |= BLK_FLAG_MISALIGNED;
-		ret = -1;
-	}
-
-	/* Minimum I/O a multiple of the physical block size? */
-	if (t->io_min & (t->physical_block_size - 1)) {
-		t->io_min = t->physical_block_size;
-		t->flags |= BLK_FLAG_MISALIGNED;
-		ret = -1;
-	}
-
-	/* Optimal I/O a multiple of the physical block size? */
-	if (t->io_opt & (t->physical_block_size - 1)) {
-		t->io_opt = 0;
-		t->flags |= BLK_FLAG_MISALIGNED;
-		ret = -1;
-	}
-
-	/* chunk_sectors a multiple of the physical block size? */
-	if (t->chunk_sectors % (t->physical_block_size >> SECTOR_SHIFT)) {
-		t->chunk_sectors = 0;
-		t->flags |= BLK_FLAG_MISALIGNED;
-		ret = -1;
-	}
-
-	/* Find lowest common alignment_offset */
-	t->alignment_offset = lcm_not_zero(t->alignment_offset, alignment)
-		% max(t->physical_block_size, t->io_min);
-
-	/* Verify that new alignment_offset is on a logical block boundary */
-	if (t->alignment_offset & (t->logical_block_size - 1)) {
-		t->flags |= BLK_FLAG_MISALIGNED;
-		ret = -1;
-	}
-
-	t->max_sectors = blk_round_down_sectors(t->max_sectors, t->logical_block_size);
-	t->max_hw_sectors = blk_round_down_sectors(t->max_hw_sectors, t->logical_block_size);
-	t->max_dev_sectors = blk_round_down_sectors(t->max_dev_sectors, t->logical_block_size);
+	ret = blk_stack_topology_limits(t, b, start);
 
 	/* Discard alignment and granularity */
 	if (b->discard_granularity) {
-- 
2.25.1


