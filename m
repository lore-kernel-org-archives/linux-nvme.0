Return-Path: <SRS0=L+eZ=7L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAEAC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 14:52:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF61D2077D
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 14:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lA0CgifI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbrkbGBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF61D2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XrfUXViJ2+5AsIgYSVa5gpqqC3oMXJq08jbNa2LgFgY=; b=lA0CgifI15YjCE
	es6iJ+mLkp42ADtBp54Ri0eTl7LgIC9o54upxnJDz5zkweq5zXNdFtSzx0/hkhcqB18Xg7YkCAoQv
	4NmFrrJrckJjGVxLox7eUZnLk0c+d0llVtgcUrr62XD0hUqYq3kuK998xyB/zpuQjZ5ne3UUWxIch
	Wx0RbokqXBGt4Pzkk7qrY0oNT9CSATtUZTsWtnSa7lDCAa7IybKpnttOXN+fPqogVcugxWOHJOHkl
	xguJD+CIS4sX/XNdy8SyYWuU/K0Gl0cqNtLu+N/yeK6beYPi3iVdvIppt7HBf3izrgKChMHTUSTmj
	7gk009dzbFTj14TaInsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jegMh-0005Vp-Sl; Fri, 29 May 2020 14:52:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jegMf-0005Ud-Ij
 for linux-nvme@lists.infradead.org; Fri, 29 May 2020 14:52:06 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A526820776;
 Fri, 29 May 2020 14:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590763925;
 bh=yUjck9Ck5IqzAHsdyjVWD/HT7fy28nfsAzucztHoAM0=;
 h=From:To:Cc:Subject:Date:From;
 b=qbrkbGBeJGHgxgFWZUWLHHUJdWJAg8Wk2z/h7hD4+sTXnI2I8ggMrWafS0+IDEhIY
 SkmHtQfxbHRzMfo6iA8VsfbaBnmIxjGovwcES4zPnG7kWewMc6Haz0vYuiq4mVYG2X
 YNdGYYuowMN9zHxzMwLJ91c+GKdv9ZWUT4LF4y88=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 linux-block@vger.kernel.org, axboe@kernel.dk
Subject: [PATCHv4 1/2] blk-mq: blk-mq: provide forced completion method
Date: Fri, 29 May 2020 07:51:59 -0700
Message-Id: <20200529145200.3545747-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200529_075205_633155_0B68D428 
X-CRM114-Status: GOOD (  10.94  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, alan.adamson@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Drivers may need to bypass error injection for error recovery. Rename
__blk_mq_complete_request() to blk_mq_force_complete_rq() and export
that function so drivers may skip potential fake timeouts after they've
reclaimed lost requests.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c         | 15 +++++++++++++--
 include/linux/blk-mq.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index cac11945f602..560a114a82f8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -556,7 +556,17 @@ static void __blk_mq_complete_request_remote(void *data)
 	q->mq_ops->complete(rq);
 }
 
-static void __blk_mq_complete_request(struct request *rq)
+/**
+ * blk_mq_force_complete_rq() - Force complete the request, bypassing any error
+ * 				injection that could drop the completion.
+ * @rq: Request to be force completed
+ *
+ * Drivers should use blk_mq_complete_request() to complete requests in their
+ * normal IO path. For timeout error recovery, drivers may call this forced
+ * completion routine after they've reclaimed timed out requests to bypass
+ * potentially subsequent fake timeouts.
+ */
+void blk_mq_force_complete_rq(struct request *rq)
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct request_queue *q = rq->q;
@@ -602,6 +612,7 @@ static void __blk_mq_complete_request(struct request *rq)
 	}
 	put_cpu();
 }
+EXPORT_SYMBOL_GPL(blk_mq_force_complete_rq);
 
 static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
 	__releases(hctx->srcu)
@@ -635,7 +646,7 @@ bool blk_mq_complete_request(struct request *rq)
 {
 	if (unlikely(blk_should_fake_timeout(rq->q)))
 		return false;
-	__blk_mq_complete_request(rq);
+	blk_mq_force_complete_rq(rq);
 	return true;
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d7307795439a..856bb10993cf 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -494,6 +494,7 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 bool blk_mq_complete_request(struct request *rq);
+void blk_mq_force_complete_rq(struct request *rq);
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 			   struct bio *bio, unsigned int nr_segs);
 bool blk_mq_queue_stopped(struct request_queue *q);
-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
