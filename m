Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4930AC48BE5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 14:41:43 +0000 (UTC)
Received: from bombadil.infradead.org (unknown [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AEF261490
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 14:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AEF261490
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jCCa/UUeUOeAhCc5AQuxZqjAPIEcn81xLTVXLq/FOcs=; b=z4155vap8Hdz3m
	E3KGZ07GPVv4EvpXGxqnVt3I+OUKRMvTLxZ0sNWVosFMkI77IWlki80aWTZU+hBi/c1WguKugeDYY
	gmdyHCUUNO1FX+n28qHGYcDTXTeDPLKOa1SQao06KbjfbY9MG/mcsSsVHNUqHY7IMl4k1L3S0xVXQ
	0kyTHuNyvOLPXFapQXC+DDcFv2r9nfwLDuN5x9NkJJh/tk/hXIAXwcO79N4A8cycGL+i7Qbi2v8Zs
	Aw8hClLkQvBNwEf+5P5Es5L2DEnbtux0xjNMIAHmyK/qi+RqOmHkFOlm5uJvnEYrNJstvt7RWRxmH
	+qzaabhKo2plRshH7R1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltAFT-000fAE-3V; Tue, 15 Jun 2021 14:41:03 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt9OR-000FmL-8f
 for linux-nvme@bombadil.infradead.org; Tue, 15 Jun 2021 13:46:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Z68LkCUmDD1nAgyIVV8eDB5tD3wnOea53zdJx0rCkHk=; b=dAytNuC80vR9hJHa8/h0SfSaAy
 KR8Z5JvwOZilCv06/HH+MhFFFi4WlXXU0dtzfB2spubN2Fs9d4gx9Uq9sagdYx38pz6ovwi4NPTUu
 2pIoOWenUDmzNBpXuQSYttttbMJXODmAnKqHRHrzhI9VDaJyYuhh0TcooH/8BFRsZQij0GPYmYQyZ
 n3DraWHE99iqsU52u10Dq4fm1VkRKXTODkrYwsFJdGbbC/hWGuxWEm7EwhBSHx82ZQfZqfOxyJiF1
 WqJWNDmhlcCXaxonGQ/ff1H3TJFzXTo8Y/8y8xWPcR+bFPfdihtXxh0Z4LpzZcAfUwXz1L/IisEAJ
 xMSjfL9w==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt8rF-006nEF-04; Tue, 15 Jun 2021 13:12:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 05/16] blk-mq: factor out a "classic" poll helper
Date: Tue, 15 Jun 2021 15:10:23 +0200
Message-Id: <20210615131034.752623-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615131034.752623-1-hch@lst.de>
References: <20210615131034.752623-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Factor the code to do the classic full metal polling out of blk_poll into
a separate blk_mq_poll_classic helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 block/blk-mq.c | 120 +++++++++++++++++++++++--------------------------
 1 file changed, 56 insertions(+), 64 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9b3fe1062061..f4bb6e1db36a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -69,6 +69,14 @@ static inline struct blk_mq_hw_ctx *blk_qc_to_hctx(struct request_queue *q,
 	return q->queue_hw_ctx[(qc & ~BLK_QC_T_INTERNAL) >> BLK_QC_T_SHIFT];
 }
 
+static inline struct request *blk_qc_to_rq(struct blk_mq_hw_ctx *hctx,
+		blk_qc_t qc)
+{
+	if (blk_qc_t_is_internal(qc))
+		return blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(qc));
+	return blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(qc));
+}
+
 /*
  * Check if any of the ctx, dispatch list or elevator
  * have pending work in this hardware queue.
@@ -3874,15 +3882,20 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 	return ret;
 }
 
-static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
-				     struct request *rq)
+static bool blk_mq_poll_hybrid(struct request_queue *q, blk_qc_t qc)
 {
+	struct blk_mq_hw_ctx *hctx = blk_qc_to_hctx(q, qc);
+	struct request *rq = blk_qc_to_rq(hctx, qc);
 	struct hrtimer_sleeper hs;
 	enum hrtimer_mode mode;
 	unsigned int nsecs;
 	ktime_t kt;
 
-	if (rq->rq_flags & RQF_MQ_POLL_SLEPT)
+	/*
+	 * If a request has completed on queue that uses an I/O scheduler, we
+	 * won't get back a request from blk_qc_to_rq.
+	 */
+	if (!rq || (rq->rq_flags & RQF_MQ_POLL_SLEPT))
 		return false;
 
 	/*
@@ -3924,32 +3937,48 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 
 	__set_current_state(TASK_RUNNING);
 	destroy_hrtimer_on_stack(&hs.timer);
+
+	/*
+	 * If we sleep, have the caller restart the poll loop to reset the
+	 * state.  Like for the other success return cases, the caller is
+	 * responsible for checking if the IO completed.  If the IO isn't
+	 * complete, we'll get called again and will go straight to the busy
+	 * poll loop.
+	 */
 	return true;
 }
 
-static bool blk_mq_poll_hybrid(struct request_queue *q,
-			       struct blk_mq_hw_ctx *hctx, blk_qc_t cookie)
+static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
+		bool spin)
 {
-	struct request *rq;
+	struct blk_mq_hw_ctx *hctx = blk_qc_to_hctx(q, cookie);
+	long state = current->state;
+	int ret;
 
-	if (q->poll_nsec == BLK_MQ_POLL_CLASSIC)
-		return false;
+	hctx->poll_considered++;
 
-	if (!blk_qc_t_is_internal(cookie))
-		rq = blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));
-	else {
-		rq = blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(cookie));
-		/*
-		 * With scheduling, if the request has completed, we'll
-		 * get a NULL return here, as we clear the sched tag when
-		 * that happens. The request still remains valid, like always,
-		 * so we should be safe with just the NULL check.
-		 */
-		if (!rq)
-			return false;
-	}
+	do {
+		hctx->poll_invoked++;
 
-	return blk_mq_poll_hybrid_sleep(q, rq);
+		ret = q->mq_ops->poll(hctx);
+		if (ret > 0) {
+			hctx->poll_success++;
+			__set_current_state(TASK_RUNNING);
+			return ret;
+		}
+
+		if (signal_pending_state(state, current))
+			__set_current_state(TASK_RUNNING);
+		if (current->state == TASK_RUNNING)
+			return 1;
+
+		if (ret < 0 || !spin)
+			break;
+		cpu_relax();
+	} while (!need_resched());
+
+	__set_current_state(TASK_RUNNING);
+	return 0;
 }
 
 /**
@@ -3966,9 +3995,6 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
  */
 int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
-	struct blk_mq_hw_ctx *hctx;
-	long state;
-
 	if (!blk_qc_t_valid(cookie) ||
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return 0;
@@ -3976,46 +4002,12 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	if (current->plug)
 		blk_flush_plug_list(current->plug, false);
 
-	hctx = blk_qc_to_hctx(q, cookie);
-
-	/*
-	 * If we sleep, have the caller restart the poll loop to reset
-	 * the state. Like for the other success return cases, the
-	 * caller is responsible for checking if the IO completed. If
-	 * the IO isn't complete, we'll get called again and will go
-	 * straight to the busy poll loop. If specified not to spin,
-	 * we also should not sleep.
-	 */
-	if (spin && blk_mq_poll_hybrid(q, hctx, cookie))
-		return 1;
-
-	hctx->poll_considered++;
-
-	state = current->state;
-	do {
-		int ret;
-
-		hctx->poll_invoked++;
-
-		ret = q->mq_ops->poll(hctx);
-		if (ret > 0) {
-			hctx->poll_success++;
-			__set_current_state(TASK_RUNNING);
-			return ret;
-		}
-
-		if (signal_pending_state(state, current))
-			__set_current_state(TASK_RUNNING);
-
-		if (current->state == TASK_RUNNING)
+	/* If specified not to spin, we also should not sleep. */
+	if (spin && q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
+		if (blk_mq_poll_hybrid(q, cookie))
 			return 1;
-		if (ret < 0 || !spin)
-			break;
-		cpu_relax();
-	} while (!need_resched());
-
-	__set_current_state(TASK_RUNNING);
-	return 0;
+	}
+	return blk_mq_poll_classic(q, cookie, spin);
 }
 EXPORT_SYMBOL_GPL(blk_poll);
 
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
