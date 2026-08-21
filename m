Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A811C5DF7D
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 10:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6GnixlrlVMu2U5f/BqwtdYiE36GD1P9tP2KnWX6SyPg=; b=URfS1ePczROzfGmqYzpK+eFqEb
	/+2AEza6DqT3XqQQC51LkWpshRXABS02ZRfiAfTfwcEHhdhIPCsp1TIPZni030vPjW1P0Kb4wZ26I
	EUqxdDodXfcNlfljTzhgz2DVt79VaFKGfVQ1Nuo6FLh3YACswd0H2uwW7j9N3OH3orufscWWDnvEO
	sN6I480gFfpHmtdXduYCjpgI1gjzyaFLwv1JNFQFjjOwQx2NY+B3XZ3PjYlvQmUO9HQkDkCRSAK7b
	5hBLiV8tI0FYzbyNY4YH/7zkB2R32xr4xX5fTX1cAdZ+F6gLc3/d0/9PA9N2jec+UVbfDIQBJXea4
	rRhzqhmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxMF6-0000000D3kW-3Xf1;
	Fri, 21 Aug 2026 10:12:56 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxMF1-0000000D3gF-1ps0
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 10:12:55 +0000
X-UUID: d939b2169d4811f19a56ed5b684f684d-20260821
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:2cf01720-94b9-4422-beb7-16f1368fd4d3,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:2cf01720-94b9-4422-beb7-16f1368fd4d3,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:bc9f3f81d87d2f505ba3dba1ac5a9d6b,BulkI
	D:260821181246OPWNA6I4,BulkQuantity:0,SF:10|38|66|78|81|82|102|127|850|865
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d939b2169d4811f19a56ed5b684f684d-20260821
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 884222368; Fri, 21 Aug 2026 18:12:43 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: john.g.garry@oracle.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v3 2/5] block: factor mapped-range topology out of blk_stack_limits
Date: Fri, 21 Aug 2026 18:10:47 +0800
Message-Id: <20260821101050.1464087-3-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260821101050.1464087-1-sangyao@kylinos.cn>
References: <20260821101050.1464087-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_031251_780336_6EF8AA34 
X-CRM114-Status: GOOD (  16.90  )
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

Block sizes, I/O granularities, chunk boundaries and alignment offsets
must be stacked and checked when a top-device range is mapped onto a
bottom device.

Factor this code into blk_stack_topology_limits(). Keep rounding of the
maximum sector limits there because it depends on the resulting logical
block size.

There is no behavior change.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 block/blk-settings.c | 168 +++++++++++++++++++++++--------------------
 1 file changed, 92 insertions(+), 76 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8274631290db..9e7cdaaefbca 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -756,6 +756,95 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
 	t->atomic_write_hw_boundary = 0;
 }
 
+/*
+ * Stack block sizes, I/O granularities, chunk boundaries and alignment for a
+ * bottom-device range mapped at @start. Round maximum sector limits after the
+ * resulting logical block size is known.
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
+		top = max(t->physical_block_size, t->io_min) + t->alignment_offset;
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
@@ -780,8 +869,8 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
 int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 		     sector_t start)
 {
-	unsigned int top, bottom, alignment;
-	int ret = 0;
+	unsigned int alignment;
+	int ret;
 
 	t->features |= (b->features & BLK_FEAT_INHERIT_MASK);
 
@@ -798,8 +887,6 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	if (!(b->features & BLK_FEAT_PCI_P2PDMA))
 		t->features &= ~BLK_FEAT_PCI_P2PDMA;
 
-	t->flags |= (b->flags & BLK_FLAG_MISALIGNED);
-
 	t->max_sectors = min_not_zero(t->max_sectors, b->max_sectors);
 	t->max_user_sectors = min_not_zero(t->max_user_sectors,
 			b->max_user_sectors);
@@ -830,80 +917,9 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 
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

