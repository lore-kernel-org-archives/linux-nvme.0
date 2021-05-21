Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E84C04FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 20:23:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFAE6135A
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 20:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFAE6135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nPS0sdRW9kLC8gKWT3uvaneccum6vT1umbZXpmwAGq4=; b=Iwv0ZdcURCE2iwoi3c3SJQbKSy
	f60vCLDmL4GlPn3WzBZaO8GS40udBNz8sV7QuAQfhLkfsyog380TLHepwpx5PT8r89VnUlma/ffdG
	mDSiWHOOmnb4r7JMWjWNmw16TRCeFvK2xyijpoWDPaySbfCcSzzB5zNSLjwlh24Mchc2yAJnQmY86
	wwYFxrSI0zUw4ao5A4W/3H7chhswMIh8NBNRmYEStxuWeEg6llLIh+xFc4jt9iQfrInfRZBAVBgZU
	JBL+MTjBbFIyCNIzyKnxCuXlgYE4mPkoUaYL3+UwwSdSHvyEZBTq2E5IQBuNBlu2Hs2lEP/aQqMO9
	TMjJxuoQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkBfV-0011g6-Ms; Fri, 21 May 2021 20:22:49 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkBea-0011O8-P9
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 20:21:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=5FpaVPff+N/DAkP2Palhx2nJFi8ESk/z+Ma7to/Wk9Q=; b=K4AoipXfW2RVQFQtqXmGj6WfUC
 SAUY8em1M5T3Okf+USgGTMbhLdeKJxeElFeNKSG7mzS9wPH4/71/6eNjnhdTM72nuOCZ0tmJ+i0zH
 OrJFMFHI2vthMTsYextZR3BVdK4Ns2bvHqfzLXdBrYoOyS/4syCGBs6kpTHcMvwTKEd0+XrdiIeOq
 vluEKPWXnZQ7pTB0n1N6OUOsvkVeTmB2mhplC2oxaVJuUF0DCxt4MJlPAG9Su41B1LGFOh78+1M2/
 IHFxQxYUrXl6J2mMzlc/Zw4Vr1lcd2SAqTW5uxh/UibVdD7wlYSUwNG3l54/S2svRfb8kQLrbDa6B
 6jODbsvA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkBeY-00HPOW-6a
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 20:21:51 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47FE5613E1;
 Fri, 21 May 2021 20:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621628509;
 bh=v3hdv3iu9HLCg2cedhbPjMkbdA9FOAxbHYeM5WwndgQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PUzIS+ONKMYdkLxeXjeuSDUDiFqQ9F71W3lNP/8av7Nt5tsUxHODAXe11Ie/SkOvW
 3JpQS8iojO1quACYhIlPrP0Wq6qn0OMr42+GYaQzLCxv3a8SnjjyGuepDdFcQEcE8D
 ST1V/sQGwD3oXppkuSeekDZeLpzbwPJUspZWpFDkE7d4CehyYa5eocEYMUcjnV/bg2
 4M4s/iM64+P/oMcxlEkvi/Q6IjH/C6a5yFsnLXgZffKxHsH5M62Co5GW0FcCtVNAGT
 k+c9/W3i3ceSl75pdQ9rfJ5bArnaU0lw/PULB89rOuD7m1q+YY/F0zaE9tpjnvbciQ
 DShdCLWcqNLqQ==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org
Cc: Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>, Ming Lei <ming.lei@redhat.com>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 3/4] block: return errors from blk_execute_rq()
Date: Fri, 21 May 2021 13:21:44 -0700
Message-Id: <20210521202145.3674904-4-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210521202145.3674904-1-kbusch@kernel.org>
References: <20210521202145.3674904-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_132150_285062_D79DC321 
X-CRM114-Status: GOOD (  13.54  )
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

The synchronous blk_execute_rq() had not provided a way for its callers
to know if its request was successful or not. Return the blk_status_t
result of the request.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3:

  Return blk_status_t instead of errno.

  Removed "extern" header declaration, and named the parameters.

 block/blk-exec.c       | 7 +++++--
 include/linux/blkdev.h | 4 +++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index 38f88552aa31..d6cd501c0d34 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -21,7 +21,7 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
 {
 	struct completion *waiting = rq->end_io_data;
 
-	rq->end_io_data = NULL;
+	rq->end_io_data = (void *)(uintptr_t)error;
 
 	/*
 	 * complete last, if this is a stack request the process (and thus
@@ -85,8 +85,9 @@ static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
  * Description:
  *    Insert a fully prepared request at the back of the I/O scheduler queue
  *    for execution and wait for completion.
+ * Return: The blk_status_t result provided to blk_mq_end_request().
  */
-void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
+blk_status_t blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
 	unsigned long hang_check;
@@ -103,5 +104,7 @@ void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
 		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
 	else
 		wait_for_completion_io(&wait);
+
+	return (blk_status_t)(uintptr_t)rq->end_io_data;
 }
 EXPORT_SYMBOL(blk_execute_rq);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2c28577b50f4..2d2b477241ba 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -936,10 +936,12 @@ extern int blk_rq_map_kern(struct request_queue *, struct request *, void *, uns
 extern int blk_rq_map_user_iov(struct request_queue *, struct request *,
 			       struct rq_map_data *, const struct iov_iter *,
 			       gfp_t);
-extern void blk_execute_rq(struct gendisk *, struct request *, int);
 extern void blk_execute_rq_nowait(struct gendisk *,
 				  struct request *, int, rq_end_io_fn *);
 
+blk_status_t blk_execute_rq(struct gendisk *bd_disk, struct request *rq,
+			    int at_head);
+
 /* Helper to convert REQ_OP_XXX to its string format XXX */
 extern const char *blk_op_str(unsigned int op);
 
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
