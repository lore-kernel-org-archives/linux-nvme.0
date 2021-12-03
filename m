Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFA7C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Dec 2021 21:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YKuHL/KZVSVISLRG3bffZqV5xT2zA+0nRRE7V8Ac64s=; b=JoVdc2ADME5RzKAIOowfCnUkii
	jRHOrye6y7zReAbCBTFgAMqVDBI67vs2ldH+k2qMBGqoCiL9vG+S3SSnzhWlPwA4h4hnjXCcvq3wJ
	f6n3lqcfEH1wxLRWQn2+iENPzIPcanM1LVZREmQSFB5sGdwBQ51b/rF+giq+ITpyXmC4wiabzEgoo
	iE6lqcHeK2sKqRWoRtuBlKmhbHtFNtzORsqW5kRIUf8AE9f7c7O1or0+UCAWOZdfDZTuiQm56/08O
	Q9MkGswpU8079FjgI8LFCoM2Tv67Y1P/sfLW3RDe7Z50vqZvMQrFg45FKOEx3pKoWSTJ02Itg7dGF
	ikqQSdUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mtGNl-00H3pD-7y; Fri, 03 Dec 2021 21:46:17 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mtGNQ-00H3l4-7t
 for linux-nvme@lists.infradead.org; Fri, 03 Dec 2021 21:45:57 +0000
Received: by mail-pl1-x633.google.com with SMTP id y7so3040636plp.0
 for <linux-nvme@lists.infradead.org>; Fri, 03 Dec 2021 13:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YKuHL/KZVSVISLRG3bffZqV5xT2zA+0nRRE7V8Ac64s=;
 b=f2pSf5NdbjG+w/joZ1zBUGX9AvZuLkRcIX6k9Z1K5WUfF55j+mNKn8BO3w26nyqVAh
 OiT/XrQOw4blpksIu5ZdNwXqsGJyen3+UV8FpWsGMQF2/Ub0Y4oibFeedh9lpSyaq9b2
 CdPwBRqR7jyyfhQ6t6vYMm2xcKEt/WoVocCNv0c58jNU2kAiRPirlIYj9bLkWsnN4JUc
 yeVtBrCltmVRWQTntZSojr7QsgwPr2OwdFh7aq3v9lR5O4uEQfYU8ze6IEVz8KonMgz7
 RQcVILOU4QnYQAacLRbmNcdyaBDXmi3a/v6ctis/TSKi9N+UtZJ82xAfuPIzhLCLaakX
 2w2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YKuHL/KZVSVISLRG3bffZqV5xT2zA+0nRRE7V8Ac64s=;
 b=m0K3oCbT/kQhYVBfue7B94aK/6AaeuvCZN36dli3K0G1ollyePsDPM9QaDovfjN3bv
 UnbdcZZNdN+SmeG2yMCI6o4sxSwQy5s9/+4CdKwEAbMksPSo4F2Xkw9Ut9Kv7R1KAuAl
 +kMnjBqXeAlKHAw/v6HgvTJMPNcAMebHDelwbzdbTW1k6Ug/NFXQaBz/qDSJislovDio
 u3eASNXXUuff7iKS2SeOUjSw0MsyMoA/QerM3HEYKPNQqtRb61QKf1A8UmZAznoc2Wld
 YFkjr/sxBQj71BpjQLCFBlUD71ZrJxcRVViLWhLgTW3L7f1+L8tykJ9UnYS4mtB39rW3
 1FtA==
X-Gm-Message-State: AOAM5317zOr6V6JcY/WzXCjLn/+tdMup8BTrhvKlsMq5XM1t1cGRVU3w
 1gTYa918v4eG5q8qYXRHXWl/0AGFUquw39kF
X-Google-Smtp-Source: ABdhPJxFFSbx8kIz6tEOf+g5FlRKymbAnBz6UtS9KiqXcbYifv9l8XECHjDyvGiAuD0R9PiLyfRRaA==
X-Received: by 2002:a17:90b:4d90:: with SMTP id
 oj16mr17092107pjb.2.1638567954222; 
 Fri, 03 Dec 2021 13:45:54 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id f4sm4436225pfj.61.2021.12.03.13.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Dec 2021 13:45:53 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] block: add mq_ops->queue_rqs hook
Date: Fri,  3 Dec 2021 14:45:41 -0700
Message-Id: <20211203214544.343460-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203214544.343460-1-axboe@kernel.dk>
References: <20211203214544.343460-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211203_134556_305690_C214F4CF 
X-CRM114-Status: GOOD (  19.60  )
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
 block/blk-mq.c         | 24 +++++++++++++++++++++---
 include/linux/blk-mq.h |  8 ++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 22ec21aa0c22..9ac9174a2ba4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2513,6 +2513,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	struct blk_mq_hw_ctx *this_hctx;
 	struct blk_mq_ctx *this_ctx;
+	struct request *rq;
 	unsigned int depth;
 	LIST_HEAD(list);
 
@@ -2521,7 +2522,26 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	plug->rq_count = 0;
 
 	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
-		blk_mq_run_dispatch_ops(plug->mq_list->q,
+		struct request_queue *q;
+
+		rq = plug->mq_list;
+		q = rq->q;
+
+		/*
+		 * Peek first request and see if we have a ->queue_rqs() hook.
+		 * If we do, we can dispatch the whole plug list in one go. We
+		 * already know at this point that all requests belong to the
+		 * same queue, caller must ensure that's the case.
+		 */
+		if (q->mq_ops->queue_rqs &&
+		    !(rq->mq_hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
+			blk_mq_run_dispatch_ops(q,
+				q->mq_ops->queue_rqs(&plug->mq_list));
+			if (rq_list_empty(plug->mq_list))
+				return;
+		}
+
+		blk_mq_run_dispatch_ops(q,
 				blk_mq_plug_issue_direct(plug, false));
 		if (rq_list_empty(plug->mq_list))
 			return;
@@ -2531,8 +2551,6 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	this_ctx = NULL;
 	depth = 0;
 	do {
-		struct request *rq;
-
 		rq = rq_list_pop(&plug->mq_list);
 
 		if (!this_hctx) {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ecdc049b52fa..cdd183757ea0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -494,6 +494,14 @@ struct blk_mq_ops {
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


