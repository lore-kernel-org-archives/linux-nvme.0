Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4EBC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 06:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2qQqsbLS3ydp9csYqg2WjkbU0OZZf5YYAjcs0Mqvi6o=; b=HW5TPnM5QoJJPald2crSa3oCzQ
	N3c0+IV3uoxpz0YlW0gcvM8wHRujJlV/jkmiMtg7bcpGw7Vl7vhHrcRdqURDkDsGL+WQfIF/MuEcY
	46/2ZT1R96/1zfxp0eTesXOsKLaSAZCxuyEp1IB4Cw5WG+BjVNZFdkOVD5QZ/JeSFqTL5XTRW4znN
	nnZlca8NDmazU3vQWIJ+bAKNFIxiCFspKszNLjaYlIRODcGvPsXRjK/3RTA2kUEllODNizW3nAkN2
	ff1xqIQl7A8U5EVIu0fZzsnUXXhk6yU89KVPJnCXJry75a2lBqvgei6VpAPP5YzBX1Zlryb8XdzX6
	Ed9JyNFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqr3e-00Btyr-1s; Tue, 17 May 2022 06:51:50 +0000
Received: from [2001:4bb8:19a:7bdf:afb1:9e:37ad:b912] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqr12-00BsfA-HG; Tue, 17 May 2022 06:49:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org
Subject: [PATCH 2/3] blk-mq: avoid a mess of casts for blk_end_sync_rq
Date: Tue, 17 May 2022 08:49:00 +0200
Message-Id: <20220517064901.3059255-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517064901.3059255-1-hch@lst.de>
References: <20220517064901.3059255-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Instead of trying to cast a __bitwise 32-bit integer to a larger integer
and then a pointer, just allow a struct with the blk_status_t and the
completion on stack and set the end_io_data to that.  Use the
opportunity to move the code to where it belongs and drop rather
confusing comments.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index aae0c8a325904..0169b624edda1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1151,24 +1151,6 @@ void blk_mq_start_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_start_request);
 
-/**
- * blk_end_sync_rq - executes a completion event on a request
- * @rq: request to complete
- * @error: end I/O status of the request
- */
-static void blk_end_sync_rq(struct request *rq, blk_status_t error)
-{
-	struct completion *waiting = rq->end_io_data;
-
-	rq->end_io_data = (void *)(uintptr_t)error;
-
-	/*
-	 * complete last, if this is a stack request the process (and thus
-	 * the rq pointer) could be invalid right after this complete()
-	 */
-	complete(waiting);
-}
-
 /*
  * Allow 2x BLK_MAX_REQUEST_COUNT requests on plug queue for multiple
  * queues. This is important for md arrays to benefit from merging
@@ -1231,6 +1213,19 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head, rq_end_io_fn *done)
 }
 EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
 
+struct blk_rq_wait {
+	struct completion done;
+	blk_status_t ret;
+};
+
+static void blk_end_sync_rq(struct request *rq, blk_status_t ret)
+{
+	struct blk_rq_wait *wait = rq->end_io_data;
+
+	wait->ret = ret;
+	complete(&wait->done);
+}
+
 static bool blk_rq_is_poll(struct request *rq)
 {
 	if (!rq->mq_hctx)
@@ -1262,7 +1257,9 @@ static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
  */
 blk_status_t blk_execute_rq(struct request *rq, bool at_head)
 {
-	DECLARE_COMPLETION_ONSTACK(wait);
+	struct blk_rq_wait wait = {
+		.done = COMPLETION_INITIALIZER_ONSTACK(wait.done),
+	};
 
 	WARN_ON(irqs_disabled());
 	WARN_ON(!blk_rq_is_passthrough(rq));
@@ -1274,7 +1271,7 @@ blk_status_t blk_execute_rq(struct request *rq, bool at_head)
 	blk_mq_sched_insert_request(rq, at_head, true, false);
 
 	if (blk_rq_is_poll(rq)) {
-		blk_rq_poll_completion(rq, &wait);
+		blk_rq_poll_completion(rq, &wait.done);
 	} else {
 		/*
 		 * Prevent hang_check timer from firing at us during very long
@@ -1284,14 +1281,14 @@ blk_status_t blk_execute_rq(struct request *rq, bool at_head)
 			sysctl_hung_task_timeout_secs;
 
 		if (hang_check)
-			while (!wait_for_completion_io_timeout(&wait,
+			while (!wait_for_completion_io_timeout(&wait.done,
 					hang_check * (HZ/2)))
 				;
 		else
-			wait_for_completion_io(&wait);
+			wait_for_completion_io(&wait.done);
 	}
 
-	return (blk_status_t)(uintptr_t)rq->end_io_data;
+	return wait.ret;
 }
 EXPORT_SYMBOL(blk_execute_rq);
 
-- 
2.30.2


