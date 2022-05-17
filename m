Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971AAC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 06:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SxE/KGWMU/AOceGYHMSH7kVSHaDmfBJq5Hx3GU6lTjM=; b=a2GXQHIlsSbkpnK84jS3ctyXoH
	DgEI1iXKaKjV22KL1Fg6iHevIAbQez6Enf1NOo6/Jw4x7MDxRi/nuJLO4dRPhCQwyDBj3WCK4gMy7
	5KK8ymfbHKQ1V680oqUZcBFtT/B/jktvQGnRukCeJf7YSINrqIDLcTEwhpwLL0N4JrY5sJZHVKOEv
	HYtEH/Bx61q4P+nTakirlSDlF64yGHM6aG8FgDK54JlDKFjQyno05HL9hoq9KyR7zGmdj//Se6x6H
	Iuc1cuJtlkSJadZYIt8fXZn8o5ubIovGJJc1LKmyVBK+VY1bzqwXgUsJjRnwC0pvqfoKfD9yUw0N3
	SMO5w6PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqr3J-00BtpZ-Nj; Tue, 17 May 2022 06:51:29 +0000
Received: from [2001:4bb8:19a:7bdf:afb1:9e:37ad:b912] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqr0z-00Bsdb-Ow; Tue, 17 May 2022 06:49:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org
Subject: [PATCH 1/3] blk-mq: remove __blk_execute_rq_nowait
Date: Tue, 17 May 2022 08:48:59 +0200
Message-Id: <20220517064901.3059255-2-hch@lst.de>
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

We don't want to plug for synchronous execution that where we immediately
wait for the request.  Once that is done not a whole lot of code is
shared, so just remove __blk_execute_rq_nowait.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 70 ++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ed1869a305c46..aae0c8a325904 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1203,28 +1203,6 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
 	plug->rq_count++;
 }
 
-static void __blk_execute_rq_nowait(struct request *rq, bool at_head,
-		rq_end_io_fn *done, bool use_plug)
-{
-	WARN_ON(irqs_disabled());
-	WARN_ON(!blk_rq_is_passthrough(rq));
-
-	rq->end_io = done;
-
-	blk_account_io_start(rq);
-
-	if (use_plug && current->plug) {
-		blk_add_rq_to_plug(current->plug, rq);
-		return;
-	}
-	/*
-	 * don't check dying flag for MQ because the request won't
-	 * be reused after dying flag is set
-	 */
-	blk_mq_sched_insert_request(rq, at_head, true, false);
-}
-
-
 /**
  * blk_execute_rq_nowait - insert a request to I/O scheduler for execution
  * @rq:		request to insert
@@ -1240,8 +1218,16 @@ static void __blk_execute_rq_nowait(struct request *rq, bool at_head,
  */
 void blk_execute_rq_nowait(struct request *rq, bool at_head, rq_end_io_fn *done)
 {
-	__blk_execute_rq_nowait(rq, at_head, done, true);
+	WARN_ON(irqs_disabled());
+	WARN_ON(!blk_rq_is_passthrough(rq));
 
+	rq->end_io = done;
+
+	blk_account_io_start(rq);
+	if (current->plug)
+		blk_add_rq_to_plug(current->plug, rq);
+	else
+		blk_mq_sched_insert_request(rq, at_head, true, false);
 }
 EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
 
@@ -1277,27 +1263,33 @@ static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
 blk_status_t blk_execute_rq(struct request *rq, bool at_head)
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
-	unsigned long hang_check;
 
-	/*
-	 * iopoll requires request to be submitted to driver, so can't
-	 * use plug
-	 */
+	WARN_ON(irqs_disabled());
+	WARN_ON(!blk_rq_is_passthrough(rq));
+
 	rq->end_io_data = &wait;
-	__blk_execute_rq_nowait(rq, at_head, blk_end_sync_rq,
-			!blk_rq_is_poll(rq));
+	rq->end_io = blk_end_sync_rq;
 
-	/* Prevent hang_check timer from firing at us during very long I/O */
-	hang_check = sysctl_hung_task_timeout_secs;
+	blk_account_io_start(rq);
+	blk_mq_sched_insert_request(rq, at_head, true, false);
 
-	if (blk_rq_is_poll(rq))
+	if (blk_rq_is_poll(rq)) {
 		blk_rq_poll_completion(rq, &wait);
-	else if (hang_check)
-		while (!wait_for_completion_io_timeout(&wait,
-				hang_check * (HZ/2)))
-			;
-	else
-		wait_for_completion_io(&wait);
+	} else {
+		/*
+		 * Prevent hang_check timer from firing at us during very long
+		 * I/O
+		 */
+		unsigned long hang_check = 
+			sysctl_hung_task_timeout_secs;
+
+		if (hang_check)
+			while (!wait_for_completion_io_timeout(&wait,
+					hang_check * (HZ/2)))
+				;
+		else
+			wait_for_completion_io(&wait);
+	}
 
 	return (blk_status_t)(uintptr_t)rq->end_io_data;
 }
-- 
2.30.2


