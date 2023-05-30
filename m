Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FA4C7EE23
	for <linux-nvme@archiver.kernel.org>; Tue, 30 May 2023 02:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qQkRn78F4m8QN2PjOiwEOoJXrUMDRX+JHKVaHWxbwlQ=; b=utpNGvi4RJyZoNUSOAB/rlIgzC
	ycmr/uFH185Cxrry4xfWB7v8N0rnIVjNtxjRVrKZGyC5F5GZaT6Nnr+ATS9rDOte1JkTQXEDEBPrO
	0Qs958WMciUFUt9gtyts9VkQ+kYJv14o379RvQyh0mj714KMuwfqacOpYCmMedhdKg23dj3PNQD5P
	3MV8LwsKM1A1RVtflrLJdKKBh4A7hvB3jItTGGjH7eSp5ZPy1yx2zJa83LHilNznuUKaBBt4Bx24E
	BwQOdk/Zmog3WsP9YccxPIP8XQRzDS9pCWd+FRAp+g9ru0f56mW8ZxziEGmCh5Y/MCr+jxtg32k88
	p07DZWwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3pJN-00CDF7-0Z;
	Tue, 30 May 2023 02:42:13 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q3pJJ-00CDEO-0B;
	Tue, 30 May 2023 02:42:11 +0000
X-UUID: 8e759512fe9311ed912e1518a6540028-20230529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qQkRn78F4m8QN2PjOiwEOoJXrUMDRX+JHKVaHWxbwlQ=;
	b=JV8vPxj8ra8ZUq7c+io7j7bi+5MP8Fbtov19lVhQrfAPLHcH/01DU/o6SkKplWFuhmfClgmKxJUGGjNvyMH9vrQ+FRhZsJNPBwyljG4Y0DqFWMzqBmXLL7rGQj97e3vyunE2Mim9LE7LJWeITZ/BymuRaxYf17MK13Fli2xqyVo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:29e69b29-1eca-4ebc-897e-aced24fd51b2,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:2bf5bf3c-de1e-4348-bc35-c96f92f1dcbb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 8e759512fe9311ed912e1518a6540028-20230529
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <powen.kao@mediatek.com>)
	(musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 55560948; Mon, 29 May 2023 19:42:02 -0700
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 May 2023 10:41:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 May 2023 10:41:25 +0800
From: Po-Wen Kao <powen.kao@mediatek.com>
To: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
	<stanley.chu@mediatek.com>, <powen.kao@mediatek.com>,
	<alice.chao@mediatek.com>, <naomi.chu@mediatek.com>,
	<chun-hung.wu@mediatek.com>, <cc.chou@mediatek.com>,
	<eddie.huang@mediatek.com>, Ed Tsai <ed.tsai@mediatek.com>,
	<linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
Subject: [PATCH v1 1/1] nvme: complete directly for hctx with only one ctx mapping
Date: Tue, 30 May 2023 10:41:19 +0800
Message-ID: <20230530024120.17196-1-powen.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230529_194209_124573_5F8AA112 
X-CRM114-Status: GOOD (  13.58  )
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

From: Ed Tsai <ed.tsai@mediatek.com>

Refer to
commit f168420c62e7
("blk-mq: don't redirect completion for hctx withs only one ctx mapping")
When nvme applies a 1:1 mapping of hctx and ctx, there will be no remote
request.

But for ufs, the submission and completion queue could be asymmetric.
(e.g. Multiple SQs share one CQ) Therefore, 1:1 mapping of hctx and
ctx won't complete request on the submission cpu. In this situation,
put this condition in block layer could violate the
QUEUE_FLAG_SAME_FORCE, as a result, move this back to nvme.

Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
---
 block/blk-mq.c           | 8 +++-----
 drivers/nvme/host/nvme.h | 4 ++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1749f5890606..b60c78f5ad46 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1181,12 +1181,10 @@ bool blk_mq_complete_request_remote(struct request *rq)
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 
 	/*
-	 * For request which hctx has only one ctx mapping,
-	 * or a polled request, always complete locally,
-	 * it's pointless to redirect the completion.
+	 * For a polled request, always complete locally, it's pointless
+	 * to redirect the completion.
 	 */
-	if (rq->mq_hctx->nr_ctx == 1 ||
-		rq->cmd_flags & REQ_POLLED)
+	if (rq->cmd_flags & REQ_POLLED)
 		return false;
 
 	if (blk_mq_complete_need_ipi(rq)) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7cf8e44d135e..acc9b1ce071d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -702,6 +702,10 @@ static inline bool nvme_try_complete_req(struct request *req, __le16 status,
 	nvme_should_fail(req);
 	if (unlikely(blk_should_fake_timeout(req->q)))
 		return true;
+	if (likely(req->mq_hctx->nr_ctx == 1)) {
+		WRITE_ONCE(req->state, MQ_RQ_COMPLETE);
+		return false;
+	}
 	return blk_mq_complete_request_remote(req);
 }
 
-- 
2.18.0


