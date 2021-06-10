Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95900C48BE5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 21:45:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C141613CA
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 21:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C141613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8Wa5tZaiHHG61yWJsTmA0En7Fz+UQjeHLdYWt0lVbdE=; b=Nu18DKnH9wmYrT
	mYOFxxVJLl6V70O5HmgNsuxepqYv1ILrZsnRxjwkyuX1O8BC8w71Y7YKbrF1BnCwYthzybYprml9e
	JPuZ7fxrWLS4Jn8CaDd+9e3oFJ6x5rn66Hzmw95sghlfpquNDpjw/oNQ8Dy4vjZ36UGqHQDdD+plH
	xQSeUR+xwe+Ql03Uur7/KaHp114ZN1xqBH1z33UmUrhK3lPmAuSWvI/jooZBK8fKXoJ1Oa3UXzCXC
	o6K5R5xTHrKqP6W36p1JFphOd+ZnPN3CZB3mQ7TLpwHbjEUL5idYXTdfWj5NW+gfV5YkXqyS2ReL8
	KTzEFGYZYksk5nYwjlFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lrSU6-002Zzu-6t; Thu, 10 Jun 2021 21:45:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrSTt-002Zrt-9F
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 21:44:54 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6420C61414;
 Thu, 10 Jun 2021 21:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623361493;
 bh=U0uZCNmLiIP5o+5Of/2tZr5Nhk05OgI6O4Ki2vMfDjg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VDVENoL+/WTEQm311Xvdz18EoVjtGrkd6Ho+g9OGiL8wPZMeulu7zfZaBDLhyZJbl
 ap9KpsTZnR/86cXDVz01ueaZlLm90HrgYs9X70yATAaKATwPLxQp3wpT41PD2nJ1YD
 OFID5nG8gctmIU80cY+QefawjZy7I89AZ5eGZBbA/Gktl5AzPPzjXQ4cR1UO4ScLaa
 lrfTN6m6ftiZK2ajNCm6pwSFOyZdPyC/iWugNCVXpnxkG/bOVOVyk/8R6GtTodh1mn
 Kl2EntjumYgJ9MK+WDMUEcE223hVWC4l7TSxe6EVf3/J0vzbWT0sxdSNZqIficUzZn
 ONZp5pUZT0SqA==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 linux-block@vger.kernel.org
Cc: axboe@kernel.dk, Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>, Ming Lei <ming.lei@redhat.com>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 1/4] block: support polling through blk_execute_rq
Date: Thu, 10 Jun 2021 14:44:34 -0700
Message-Id: <20210610214437.641245-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210610214437.641245-1-kbusch@kernel.org>
References: <20210610214437.641245-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210610_144453_360391_87C0B029 
X-CRM114-Status: GOOD (  11.61  )
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

Poll for completions if the request's hctx is a polling type.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-exec.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index beae70a0e5e5..38f88552aa31 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -63,6 +63,19 @@ void blk_execute_rq_nowait(struct gendisk *bd_disk, struct request *rq,
 }
 EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
 
+static bool blk_rq_is_poll(struct request *rq)
+{
+	return rq->mq_hctx && rq->mq_hctx->type == HCTX_TYPE_POLL;
+}
+
+static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
+{
+	do {
+		blk_poll(rq->q, request_to_qc_t(rq->mq_hctx, rq), true);
+		cond_resched();
+	} while (!completion_done(wait));
+}
+
 /**
  * blk_execute_rq - insert a request into queue for execution
  * @bd_disk:	matching gendisk
@@ -83,7 +96,10 @@ void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
 
 	/* Prevent hang_check timer from firing at us during very long I/O */
 	hang_check = sysctl_hung_task_timeout_secs;
-	if (hang_check)
+
+	if (blk_rq_is_poll(rq))
+		blk_rq_poll_completion(rq, &wait);
+	else if (hang_check)
 		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
 	else
 		wait_for_completion_io(&wait);
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
