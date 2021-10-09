Return-Path: <SRS0=Gd08=O5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E52DC433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Oct 2021 03:49:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EBAB60EE2
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Oct 2021 03:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0EBAB60EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lsnd5bz51Eoj7FVdYQnhgphg9dovoD3/HvhZkNxThUA=; b=MhAwtsFe1uHrhL
	/krKUrPyfBdqdYltFqEamyE/ka2ILgkAOoqvHmlJAe99AO8rODhGzALB2FhgBsgYMB3sbK0ytXuP8
	P0OcqSW6OQaooW6lCrXyFetjVb+8//yjH6dOiuKY+0Momocy+6/q9DZGXKPI5uUUHAFIm0RLtUlPs
	VFengfk52pj0RBlxJ0DQUf1i8s7nOfgbuBFYTj3DGER2yTuYy4tkcHdV6tM77HAnsyXd5ZDx2tGR7
	X/n5j0yQW5j6iWyBDX/vt89RdBxk5rw0zwenZ5r3pcCpagRTRDEmDDKbpBkGna2vKtdjz3kAYwGZK
	ewbbdX1z0OE9HBYmxSVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mZ3M9-0052Nq-88; Sat, 09 Oct 2021 03:49:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mZ3Le-0052Ci-Gq
 for linux-nvme@lists.infradead.org; Sat, 09 Oct 2021 03:48:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633751313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=91Ivbtcl5lbEwlAWg2XEl9eYPQ9eUKvnJ38fLDhz0JI=;
 b=i7almkhol0FE9uwe/8JHOpvpVQ/jvM3CYP2Gseq7R1dVomKqtAAw720J+vDfTSdpBDngly
 36+iD+FXxN7gIWIrTLWGvWhh6iiZVp207poKGYN3THeKJwayXZIfKcqetlWMS6onh2DeFM
 7XFsDAya0TT4BfXPjXVJLr/h+/wSfEI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-HUr-8sUkPp-pVbyKOiSzBg-1; Fri, 08 Oct 2021 23:48:30 -0400
X-MC-Unique: HUr-8sUkPp-pVbyKOiSzBg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9DB5362F8;
 Sat,  9 Oct 2021 03:48:28 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58B465F4FF;
 Sat,  9 Oct 2021 03:48:22 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 6/6] blk-mq: support concurrent queue quiesce/unquiesce
Date: Sat,  9 Oct 2021 11:47:13 +0800
Message-Id: <20211009034713.1489183-7-ming.lei@redhat.com>
In-Reply-To: <20211009034713.1489183-1-ming.lei@redhat.com>
References: <20211009034713.1489183-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211008_204834_660423_C28E08A2 
X-CRM114-Status: GOOD (  18.34  )
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

blk_mq_quiesce_queue() has been used a bit wide now, so far we don't support
concurrent/nested quiesce. One biggest issue is that unquiesce can happen
unexpectedly in case that quiesce/unquiesce are run concurrently from
more than one context.

This patch introduces q->mq_quiesce_depth to deal concurrent quiesce,
and we only unquiesce queue when it is the last/outer-most one of all
contexts.

Several kernel panic issue has been reported[1][2][3] when running stress
quiesce test. And this patch has been verified in these reports.

[1] https://lore.kernel.org/linux-block/9b21c797-e505-3821-4f5b-df7bf9380328@huawei.com/T/#m1fc52431fad7f33b1ffc3f12c4450e4238540787
[2] https://lore.kernel.org/linux-block/9b21c797-e505-3821-4f5b-df7bf9380328@huawei.com/T/#m10ad90afeb9c8cc318334190a7c24c8b5c5e0722
[3] https://listman.redhat.com/archives/dm-devel/2021-September/msg00189.html

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 21 ++++++++++++++++++---
 include/linux/blkdev.h |  2 ++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 21bf4c3f0825..cb58f21c5be9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -209,7 +209,12 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
  */
 void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 {
-	blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
+	unsigned long flags;
+
+	spin_lock_irqsave(&q->queue_lock, flags);
+	if (!q->quiesce_depth++)
+		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
+	spin_unlock_irqrestore(&q->queue_lock, flags);
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
@@ -250,10 +255,20 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
  */
 void blk_mq_unquiesce_queue(struct request_queue *q)
 {
-	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
+	unsigned long flags;
+	bool run_queue = false;
+
+	spin_lock_irqsave(&q->queue_lock, flags);
+	WARN_ON_ONCE(q->quiesce_depth <= 0);
+	if (q->quiesce_depth > 0 && !--q->quiesce_depth) {
+		blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
+		run_queue = true;
+	}
+	spin_unlock_irqrestore(&q->queue_lock, flags);
 
 	/* dispatch requests which are inserted during quiescing */
-	blk_mq_run_hw_queues(q, true);
+	if (run_queue)
+		blk_mq_run_hw_queues(q, true);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0e960d74615e..74c60e2d61f9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -315,6 +315,8 @@ struct request_queue {
 	 */
 	struct mutex		mq_freeze_lock;
 
+	int			quiesce_depth;
+
 	struct blk_mq_tag_set	*tag_set;
 	struct list_head	tag_set_list;
 	struct bio_set		bio_split;
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
