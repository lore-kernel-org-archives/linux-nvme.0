Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B3AC5DF87
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 10:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rbohVCOFBrQzIKPlk6YQn9KDh0uKrLvSydCyqkNsb/c=; b=ka1y5dcUX6GyRAvoZBGKCRPdw4
	BsuXsQVPefa6hM+2OIf+AQVoORBXrL18Hk+QmG18js04wJ5X6AmO/UpmF15hwtZJIgETV9OcqYRt1
	aCsKYjWh4SjwQX93iVpfad0RoKCN/svsPi/EbU1Khlj0o0ftwoAQMUwibDRQxgUb7gN89to4yTY3j
	oUkx6ZfRxk3xZWFtpmjzBopjxYGzKRjFLs8+88LMkX00C9AMvaYhgEwFX0igeBhUSHbnc+MLT5VPJ
	GtVeYPVj1xXRxP+4760TEoVU5dOs/9mMgkl6sMyDC6Ar6eeY5ZCnYUNr2enGQG/MUGiGx3oxXpMB+
	K5xkHH4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxMFD-0000000D3qv-3Vsi;
	Fri, 21 Aug 2026 10:13:03 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxMFA-0000000D3me-284F
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 10:13:02 +0000
X-UUID: ded58aba9d4811f19a56ed5b684f684d-20260821
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:32119a8a-272c-4da0-ab41-31aefa5e52e4,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:32119a8a-272c-4da0-ab41-31aefa5e52e4,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:1cf5d50f4d202c183102c635821d49ec,BulkI
	D:2608211812559TCYB9ES,BulkQuantity:0,SF:10|38|66|78|81|82|102|127|850|865
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ded58aba9d4811f19a56ed5b684f684d-20260821
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1910751995; Fri, 21 Aug 2026 18:12:52 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: john.g.garry@oracle.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v3 4/5] block: factor atomic write hardware limit stacking
Date: Fri, 21 Aug 2026 18:10:49 +0800
Message-Id: <20260821101050.1464087-5-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260821101050.1464087-1-sangyao@kylinos.cn>
References: <20260821101050.1464087-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_031300_855882_86D2D516 
X-CRM114-Status: GOOD (  10.17  )
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

blk_stack_atomic_writes_limits() stacks atomic write hardware limits and
checks whether @start meets the bottom-device alignment. Only the start
check depends on the top-to-bottom mapping.

Factor hardware limit stacking into blk_stack_atomic_writes_hw_limits()
so same-LBA multipath can stack atomic write limits without checking a
mapped start sector.

There is no behavior change for existing callers.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 block/blk-settings.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index f1a2e4fe4e77..eaba38370657 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -653,6 +653,14 @@ static unsigned int blk_round_down_sectors(unsigned int sectors, unsigned int lb
 	return sectors;
 }
 
+static void blk_clear_atomic_write_limits(struct queue_limits *lim)
+{
+	lim->atomic_write_hw_max = 0;
+	lim->atomic_write_hw_unit_max = 0;
+	lim->atomic_write_hw_unit_min = 0;
+	lim->atomic_write_hw_boundary = 0;
+}
+
 /* Check if second and later bottom devices are compliant */
 static bool blk_stack_atomic_writes_tail(struct queue_limits *t,
 				struct queue_limits *b)
@@ -726,8 +734,8 @@ static bool blk_stack_atomic_writes_head(struct queue_limits *t,
 	return true;
 }
 
-static void blk_stack_atomic_writes_limits(struct queue_limits *t,
-				struct queue_limits *b, sector_t start)
+static bool blk_stack_atomic_writes_hw_limits(struct queue_limits *t,
+				struct queue_limits *b)
 {
 	if (!(b->features & BLK_FEAT_ATOMIC_WRITES))
 		goto unsupported;
@@ -735,9 +743,6 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
 	if (!b->atomic_write_hw_unit_min)
 		goto unsupported;
 
-	if (!blk_atomic_write_start_sect_aligned(start, b))
-		goto unsupported;
-
 	/* UINT_MAX indicates no stacking of bottom devices yet */
 	if (t->atomic_write_hw_max == UINT_MAX) {
 		if (!blk_stack_atomic_writes_head(t, b))
@@ -747,13 +752,19 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
 			goto unsupported;
 	}
 	blk_stack_atomic_writes_chunk_sectors(t);
-	return;
+	return true;
 
 unsupported:
-	t->atomic_write_hw_max = 0;
-	t->atomic_write_hw_unit_max = 0;
-	t->atomic_write_hw_unit_min = 0;
-	t->atomic_write_hw_boundary = 0;
+	blk_clear_atomic_write_limits(t);
+	return false;
+}
+
+static void blk_stack_atomic_writes_limits(struct queue_limits *t,
+				struct queue_limits *b, sector_t start)
+{
+	if (blk_stack_atomic_writes_hw_limits(t, b) &&
+	    !blk_atomic_write_start_sect_aligned(start, b))
+		blk_clear_atomic_write_limits(t);
 }
 
 #define STACK_MIN_NOT_ZERO(t, b, field) \
-- 
2.25.1

