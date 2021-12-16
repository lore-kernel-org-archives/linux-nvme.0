Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A0FC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 16:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/pPKkXtT6Xrl9aqdgr4UGNl+ZJEtLSBkw/CIGk0Ps8Y=; b=T1OXsG9ZDUCHqw3MzmXxP6vyA1
	HL6bYKaxbD0bVcpCVy0iIoRHe94TpkcvLvFJhKSipt9SfOTaN4a3w2KW7qbVeaW2Y6VZxdbPxQ8IZ
	T5RFy6irk/fVIxmj4NjZ7XnqXElU0pid6c534mO+N2RRtcpNmF/p18JK/W7vYzFeqstZ5mB0TPce+
	Vzi7vl49tFAjUDb1ydDxrEBP19Ga227WJ5ikDe/b1E6cX0kHpqHA7xAUIjixMFaL2FcUiZyjcdcoC
	cFfpSsDf/NCcPxzNdCdV6EqMuOGswmBTfNI8kZs/mAuMV0AtY1glChK7zDmHbs65rMUaFmAeeeOLV
	ORzicaQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxu1d-006kpB-Ef; Thu, 16 Dec 2021 16:54:37 +0000
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxtmb-006fmG-JS
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 16:39:07 +0000
Received: by mail-il1-x132.google.com with SMTP id d17so4620534ils.8
 for <linux-nvme@lists.infradead.org>; Thu, 16 Dec 2021 08:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/pPKkXtT6Xrl9aqdgr4UGNl+ZJEtLSBkw/CIGk0Ps8Y=;
 b=OrdIjvCOXY0D0TMhorH3nRbwYFZcB54ze7TN98Pgntko5rub26f5OWcC/o8nw+ATvJ
 ROzMEapHo1abx6igYSx+SJv5yWUw2fodYo3ajfEfxj9MofnbX3x2lrp3et8IeSYo48CS
 ti1UsKR7wA0orUTz52eSlAWp7e0C9m0rtZBJHbUNIq6TzSNBvArOFDLElnPV0DsZ6yDj
 I44eRTDecpJ1D/pLGhoMs6EEa3oNO59aebTWElSx6pYfkf+Oq99xFlTxEy7Q1d/7INDQ
 kC3Fdr2lz8524jQZtl0KlShO4HoqGMtJMi59DNh8isyZ0fBJuGPEjmoyjPZHnCu7/lvT
 m5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/pPKkXtT6Xrl9aqdgr4UGNl+ZJEtLSBkw/CIGk0Ps8Y=;
 b=M57IY6udWRgQhW+QUvKhC5uKDIvi5zsIzbBt3rwk1LbMIGzlx47i5tkw2CiAns9aqi
 /DVb7imQdR9ZpSwvHoILV7/qAb1CmxwUuI6vna7PQbNY5eORr4UZLBoyY5bOOU1r9sTW
 qPVZgVv+WU/iYv912pqUeQMZz2g4Meu5+gejwcU8x3ilHGC4x2QWTSpKnUrldkL8YO7p
 K6xD+5qzQPMwwLvMaTxnFIxo/Bf60mCzb+Afso+qgHbUxNvccx2hBvEKFsNsJ/M9GCa7
 GmUNnjUeM4UGB3510wiZDUczLD7oLOfg/xivUQs0w3H6KwDV4f+GYdpWqs5AcLTHDKp0
 jO5w==
X-Gm-Message-State: AOAM530CSD7OFl1P0DdIq3PjVVGA2SJJ8YkUHo54lLkuMvmcRZj50QDY
 hwWyEyJl9aK2JA8Lhi0amvMtUA==
X-Google-Smtp-Source: ABdhPJwQb6QdZqPg4FFtSRHmv+JA7S9z28uquNJFXf+nY1Sz3Gy2ArQ3OY+7RONlUp8vi3Km9w7CEQ==
X-Received: by 2002:a05:6e02:15c8:: with SMTP id
 q8mr10367323ilu.21.1639672744121; 
 Thu, 16 Dec 2021 08:39:04 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id t17sm71816ilm.46.2021.12.16.08.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Dec 2021 08:39:03 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/4] block: add mq_ops->queue_rqs hook
Date: Thu, 16 Dec 2021 09:38:58 -0700
Message-Id: <20211216163901.81845-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216163901.81845-1-axboe@kernel.dk>
References: <20211216163901.81845-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_083905_675740_BD1D34A3 
X-CRM114-Status: GOOD (  22.14  )
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         | 26 +++++++++++++++++++++++---
 include/linux/blk-mq.h |  8 ++++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 75154cc788db..51991232824a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2553,6 +2553,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	struct blk_mq_hw_ctx *this_hctx;
 	struct blk_mq_ctx *this_ctx;
+	struct request *rq;
 	unsigned int depth;
 	LIST_HEAD(list);
 
@@ -2561,7 +2562,28 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
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
@@ -2573,8 +2595,6 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	this_ctx = NULL;
 	depth = 0;
 	do {
-		struct request *rq;
-
 		rq = rq_list_pop(&plug->mq_list);
 
 		if (!this_hctx) {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 772f8f921526..550996cf419c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -492,6 +492,14 @@ struct blk_mq_ops {
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


