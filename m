Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC2AC44536
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jan 2026 08:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hSwIZs7SAOfn3xQedp8bk5balf5YCvUTkkXmHsTxmr4=; b=PHTiLew73hvHqAGAHsuA9kTpTr
	vMdmWLvllXwu/lCOcIMb/t3C9MgVFmpdvzKL/4OSbcVoapWDsfLHCf9fdo5gTTKmDBV7aFyP4gO8T
	xxxjoDgqM6eT69JyJjncBaBIxrAe31zVk2IijojS4/8qIsEJ9ES2MYUHpVlHNcgrjaQOVff7JUgd4
	5HB7e4q2CmZ+ksVKu4mHLMhqlHtslIHTOH3DaQzU+/kisWsibRBWcrmtjIK1KXJNAsatZlyo1JNU8
	Sc3qMfFM9LLIHrsmfCarCk0/CWqaWC9Ism+0xBMoNwpShruX1v1PrQ79mOVCc4dkP8emT4sCcLbxG
	SPOhS3bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viqPc-00000006gPe-0Y43;
	Thu, 22 Jan 2026 08:51:32 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viqPY-00000006gON-0Uh0
	for linux-nvme@lists.infradead.org;
	Thu, 22 Jan 2026 08:51:30 +0000
X-UUID: 853843dcf76f11f0b0f03b4cfa9209d1-20260122
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:b31b8eb8-54d3-4d26-be7b-e64a0730788f,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:67618d1f2bedeaf76babe88c7a1e3c46,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 853843dcf76f11f0b0f03b4cfa9209d1-20260122
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 263110825; Thu, 22 Jan 2026 16:51:19 +0800
From: zenghongling <zenghongling@kylinos.cn>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	zenghongling <zenghongling@kylinos.cn>
Subject: [PATCH] driver/nvme-tcp: Use string choice helpers for digest logging
Date: Thu, 22 Jan 2026 16:51:15 +0800
Message-Id: <20260122085115.1308834-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_005128_483854_DEBC8645 
X-CRM114-Status: UNSURE (   7.03  )
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

Use str_enabled_disabled string helpers for better readability and to
fix cocci warning.

Signed-off-by: zenghongling <zenghongling@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9a96df1a511c..d5c7e3c51220 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -19,6 +19,7 @@
 #include <linux/blk-mq.h>
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
+#include <linux/string_choices.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -1549,8 +1550,8 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	    (!queue->data_digest && ctrl_ddgst)) {
 		pr_err("queue %d: data digest mismatch host: %s ctrl: %s\n",
 			nvme_tcp_queue_id(queue),
-			queue->data_digest ? "enabled" : "disabled",
-			ctrl_ddgst ? "enabled" : "disabled");
+			str_enabled_disabled(ctrl_ddgst),
+			str_enabled_disabled(queue->data_digest));
 		goto free_icresp;
 	}
 
@@ -1559,8 +1560,8 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	    (!queue->hdr_digest && ctrl_hdgst)) {
 		pr_err("queue %d: header digest mismatch host: %s ctrl: %s\n",
 			nvme_tcp_queue_id(queue),
-			queue->hdr_digest ? "enabled" : "disabled",
-			ctrl_hdgst ? "enabled" : "disabled");
+			str_enabled_disabled(ctrl_hdgst),
+			str_enabled_disabled(queue->hdr_digest));
 		goto free_icresp;
 	}
 
-- 
2.25.1


