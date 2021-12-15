Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54470C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Dec 2021 16:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1SBA0bhDbSks9/dge4Z1VfI7VEjTmMQutlQnA9v9Dz8=; b=NnVWTWPKQuTANRLi7Ii3GlrNx2
	pDulBNFKuZH9johhTsvmLMHbFPhQbyVhE5XicYcMtbhsjrB6dn01XsJVQurhMzxRh1BwHghViWIYc
	4cW4jDinruyZGG+CfIxz5Lg7fJ9i6uBsN50rAIAKgig+jB+Rhr8m53HAFtbIhpNP4vBFlMcYDvAjl
	UfnF+zUxjm1aDecBXfR9P0/hYUoLfC/bayk3Ao912JFRllb0LBqkxQBxDzufyk/u0rIpPoaNuK37P
	JxECsT0U5jPYayL9nFc3u9Nm5yPmpvBxUNSUPvanxIEWqqlxOw9MbJT0uqFoo8q/iT/O7rUkCjwEo
	FFjP1j3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxXSZ-001qge-Jy; Wed, 15 Dec 2021 16:48:55 +0000
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxX4r-001gpT-7p
 for linux-nvme@lists.infradead.org; Wed, 15 Dec 2021 16:24:28 +0000
Received: by mail-io1-xd2a.google.com with SMTP id m9so31159678iop.0
 for <linux-nvme@lists.infradead.org>; Wed, 15 Dec 2021 08:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1SBA0bhDbSks9/dge4Z1VfI7VEjTmMQutlQnA9v9Dz8=;
 b=KcE1I3I84+u1z1UaTcDjbPgiHeZZ49EnH/BJxurLAuXFhmmId2tMc5oNxowuep5rVF
 964O1i4qbiO4mxZi3567hCfxFGs5q4k1qaInNcGbid91PIB154svBJq+nDMQgaz5ZHma
 uytYifB64BhE8xTKdND/UitbkEyzN5bjx1nCVLgYPrz9DB3dMKSvbuH9PxOWolGiVN/y
 hB+LBaaqTn/KXlF6gv7rvsL5Ob4Dpq5oz3ufmMKV3pMFaHd1/ioTibLewpjUHA1ZBxCO
 ywAR2eueZjtKR7eqhGyO40PSOvqDzkNA80liuHG+48e/5TnLwPcl5CLjjY+yOwTIzfur
 O31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1SBA0bhDbSks9/dge4Z1VfI7VEjTmMQutlQnA9v9Dz8=;
 b=1klgtjiUfPAqiQccKK2As7kfa380O4uZh0s0dke4i1F8qafGfWBLtxLBc7qI91QQ8E
 rcpdtQi26g/nqv8w6A5COwSW98QZP9vFKLG9up2lIn0YdlGehP3Z4D6/f/LjeiR2waBX
 XsuQBrANTDSkkREcqnENvtFck9uHUmAG4ABIQWdSrRozGLXK53eY/Tu2G1kAkRMBbHXw
 +b/IwVAGsJqAEFymmd5XM81vcfFXohVDxXERwamDellVS4K6KgGJP4avkqN92trO0iji
 WsGBmkW/dggIG3OjxY11lqnzp/ERI2t/7nRoEsBH1VgtBko3wl27XHibgyjN8o7BxInJ
 9y/w==
X-Gm-Message-State: AOAM5339JtGJavOCQUqmW0u1P64ZeeeA7/ET9CXRP1z+psmusfMzXkaM
 fQC+wVHf66dQ7ELKVoL7frIgDT1HK4jQSQ==
X-Google-Smtp-Source: ABdhPJx1Y7YEULBa/TFG/Z2C6+4RHrgZkmPXXhE0CVwjSmOwGWsnCpEcezCGgTn66cPMcEhn7viteA==
X-Received: by 2002:a05:6638:11cb:: with SMTP id
 g11mr6078664jas.139.1639585463729; 
 Wed, 15 Dec 2021 08:24:23 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id g1sm1153170ild.52.2021.12.15.08.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Dec 2021 08:24:23 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] block: add mq_ops->queue_rqs hook
Date: Wed, 15 Dec 2021 09:24:18 -0700
Message-Id: <20211215162421.14896-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211215162421.14896-1-axboe@kernel.dk>
References: <20211215162421.14896-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211215_082425_351661_E01C343B 
X-CRM114-Status: GOOD (  20.58  )
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

If we have a list of requests in our plug list, send it to the driver in
one go, if possible. The driver must set mq_ops->queue_rqs() to support
this, if not the usual one-by-one path is used.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         | 26 +++++++++++++++++++++++---
 include/linux/blk-mq.h |  8 ++++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e02e7017db03..f24394cb2004 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2512,6 +2512,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	struct blk_mq_hw_ctx *this_hctx;
 	struct blk_mq_ctx *this_ctx;
+	struct request *rq;
 	unsigned int depth;
 	LIST_HEAD(list);
 
@@ -2520,7 +2521,28 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	plug->rq_count = 0;
 
 	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
-		struct request_queue *q = rq_list_peek(&plug->mq_list)->q;
+		struct request_queue *q;
+
+		rq = rq_list_peek(&plug->mq_list);
+		q = rq->q;
+
+		/*
+		 * Peek first request and see if we have a ->queue_rqs() hook.
+		 * If we do, we can dispatch the whole plug list in one go. We
+		 * already know at this point that all requests belong to the
+		 * same queue, caller must ensure that's the case.
+		 *
+		 * Since we pass off the full list to the driver at this point,
+		 * we do not increment the active request count for the queue.
+		 * Bypass shared tags for now because of that.
+		 */
+		if (q->mq_ops->queue_rqs &&
+		    !(rq->mq_hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
+			blk_mq_run_dispatch_ops(q,
+				q->mq_ops->queue_rqs(&plug->mq_list));
+			if (rq_list_empty(plug->mq_list))
+				return;
+		}
 
 		blk_mq_run_dispatch_ops(q,
 				blk_mq_plug_issue_direct(plug, false));
@@ -2532,8 +2554,6 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	this_ctx = NULL;
 	depth = 0;
 	do {
-		struct request *rq;
-
 		rq = rq_list_pop(&plug->mq_list);
 
 		if (!this_hctx) {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 6f858e05781e..1e1cd9cfbbea 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -493,6 +493,14 @@ struct blk_mq_ops {
 	 */
 	void (*commit_rqs)(struct blk_mq_hw_ctx *);
 
+	/**
+	 * @queue_rqs: Queue a list of new requests. Driver is guaranteed
+	 * that each request belongs to the same queue. If the driver doesn't
+	 * empty the @rqlist completely, then the rest will be queued
+	 * individually by the block layer upon return.
+	 */
+	void (*queue_rqs)(struct request **rqlist);
+
 	/**
 	 * @get_budget: Reserve budget before queue request, once .queue_rq is
 	 * run, it is driver's responsibility to release the
-- 
2.34.1


