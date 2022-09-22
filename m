Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E1FC6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 08:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rk/AUBZkyK4WEL0xMD1MP1TuSlITkOAlqM4wbmizJuw=; b=XzmP7A+QiG4Jo2UeOnyyD6Yxxe
	IR/KSq0q45PtKBLhuKgRTuHQmDeXrTPzFXpEEJwL6qLRdDnMfZhaXIJzQ9PyHG7xF/fFwiT4mZ4v3
	eGyK2z3vuB3cZ/2p3VXOPVu7vUv/puPZR4uffn3pU0YXFAzkAJQ3GUbFIouvDvobcGJ/UN85U54ES
	63KlZOL1iL7SJMHGi7Gw5m/vtCw7aCXXRDIMxKKBdjcMizCrYxkzdqy8Lu2O7UcpeE8Wd9UqTPLBF
	SKQGaoQIbI2+jOw0dEa5KduaPsdnuRlhmIaR/naf4qb5OrJQSHUXD1YHMpOyROwwqm7bwZcXBJq+K
	nLQCOk7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHZm-00E9p1-B7; Thu, 22 Sep 2022 08:28:54 +0000
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHZj-00E9mw-4d
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 08:28:52 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQRkoi7_1663835274;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VQRkoi7_1663835274)
          by smtp.aliyun-inc.com;
          Thu, 22 Sep 2022 16:28:45 +0800
From: Liu Song <liusong@linux.alibaba.com>
To: hch@lst.de
Cc: axboe@kernel.dk,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	liusong@linux.alibaba.com,
	sagi@grimberg.me
Subject: [RFC PATCH v2] blk-mq: hctx has only one ctx mapping is no need to redirect the completion
Date: Thu, 22 Sep 2022 16:27:54 +0800
Message-Id: <1663835274-3703-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20220922062010.GA27946@lst.de>
References: <20220922062010.GA27946@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_012851_364641_EF25EAD4 
X-CRM114-Status: GOOD (  10.78  )
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

From: Liu Song <liusong@linux.alibaba.com>

High-performance NVMe devices usually support a larger number of hw queue,
which ensures a 1:1 mapping of hctx and ctx. In this case there will be no
remote request, so we don't need to care about it.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 block/blk-mq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c11949d..7f9be13 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1093,10 +1093,11 @@ bool blk_mq_complete_request_remote(struct request *rq)
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 
 	/*
-	 * For a polled request, always complete locally, it's pointless
-	 * to redirect the completion.
+	 * If the request's hctx has only one ctx mapping,
+	 * or is a polled request, both always complete locally,
+	 * it's pointless to redirect the completion.
 	 */
-	if (rq->cmd_flags & REQ_POLLED)
+	if (rq->mq_hctx->nr_ctx == 1 || rq->cmd_flags & REQ_POLLED)
 		return false;
 
 	if (blk_mq_complete_need_ipi(rq)) {
-- 
1.8.3.1


