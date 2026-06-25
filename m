Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7738CCDE008
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 00:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O501A11+c5lrbcuM2q8qsA+g5jQ3kM2k2DHVrGgBOoI=; b=xbAMkPubdfF83q69ZrM469dtRA
	fd0WH3akKqeOOrXMOCyeIltO5DOniYka7zN0dqo/+IxTc5JCHoYNY8x8h1OgawQ9mIjUTvgas1Jte
	Klh9PBdES1UuUg4cxmeE8x+HNCoyE2xyeqtutfDn/ZFI8n69rQHi2hWI6s9omXsTEDvXhvS+przIF
	7pISqu9ywTHu/qF0+VMALxBAjqvvaKb4GxxneQqmLci2p6MmPcnUDldP1qvUw5sscYKrEH0BKhNzz
	6Z3lLuJaVa2SjiexRIw5Op10n2J36zoUJubQ+YsY1nYjBb0QFKCzSqSYLVG95US37v1tMsKyIsr18
	piCcuwNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcuuh-0000000A3pL-1pQt;
	Fri, 26 Jun 2026 00:59:23 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcuue-0000000A3oI-3fnU
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 00:59:22 +0000
X-UUID: 407f223870fa11f1aa26b74ffac11d73-20260626
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9878d4ba-c41e-4bfe-a2f1-0d09c3df8b86,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:82ac674ad9ffdc5ce39413b471dbd656,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 407f223870fa11f1aa26b74ffac11d73-20260626
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 668597166; Fri, 26 Jun 2026 08:59:15 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v2 2/2] nvme: zns: include zone index in invalid zone type error
Date: Wed, 25 Jun 2026 10:00:00 +0800
Message-ID: <f6e5d4c3b2a1.v2.1782280600.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.v2.1782280600.git.liuxixin@kylinos.cn>
References: <cover.1782280420.git.liuxixin@kylinos.cn> <cover.v2.1782280600.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: nvme-ecn124/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_175921_263471_F084702C 
X-CRM114-Status: UNSURE (   8.01  )
X-CRM114-Notice: Please train this message.
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

Include the zone index when reporting an invalid zone type during zone
descriptor parsing.

Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 drivers/nvme/host/zns.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 8ed1b6a33454..b2c3d4e5f6a7 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -155,7 +155,8 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
 	struct blk_zone zone = { };
 
 	if ((entry->zt & 0xf) != NVME_ZONE_TYPE_SEQWRITE_REQ) {
-		dev_err(ns->ctrl->device, "invalid zone type %#x\n", entry->zt);
+		dev_err(ns->ctrl->device, "invalid zone type %#x at zone %u\n",
+			entry->zt, idx);
 		return -EINVAL;
 	}
 
-- 
2.43.0


