Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D5CC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 04:18:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF9D6135D
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 04:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1CF9D6135D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ihKlPlN9zwydhLY+F7oizuO1rR4V9KR/63VKywlcZ0I=; b=QhIVcsM56cm/KV
	1SBgfwraD0gmGojXe+iZwVK5aBujoIBHyftKQ8HecOwyztvyEi3lsZsh71+i02PyjXm+85Tl8IcJY
	Hq7vGuV3u1tGqiRoPpV4+wT0PtrD2eV1MiW7UuuXGb/XJOuJQpCzlqhUfeRiess4IhQEsWcK9ZzUH
	owr/YgMngo49D9ecR71GYQspxD+C4h9VYR+/bW4CzNFlVGexAKd5YpoIAmyodb0p0ORj7nM/Yy+xf
	N2P40kVWVNAP6/IIkCBJRB4O38ERExaMnAg9qQHa5bSD35cbaTFYlLL+usULXEgwUj1vFfgmGPysS
	wLnyYmcW77wksNJdcj3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVR2Z-009uV0-GK; Wed, 29 Sep 2021 04:17:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVR25-009uIQ-LL
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 04:17:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632889044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KrY+IS0jZG6xj97OVcmzVVUHAeJrr7PBDGZWgu5Io0k=;
 b=iJZx3SrcFEa9DI9Syv/L7hKZa+oXFe6dbBdCQexkBKanuTLq6VFuFmyYc8IsxQHoDnhuOt
 U6DBESRxJVzcknWu9AlihyBvXN8mlKGnsLbkX84GPynF9dretkvsuOcHvX/CFSMhxwUmDD
 5PlIt0eEYbH9Tc7miu8D9CDh/la6+5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-TXdVKvJuNLu7Y0fl6E3Atw-1; Wed, 29 Sep 2021 00:17:20 -0400
X-MC-Unique: TXdVKvJuNLu7Y0fl6E3Atw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDB9C801B3D;
 Wed, 29 Sep 2021 04:17:18 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8D2519C79;
 Wed, 29 Sep 2021 04:17:07 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/5] blk-mq: support nested blk_mq_quiesce_queue()
Date: Wed, 29 Sep 2021 12:15:59 +0800
Message-Id: <20210929041559.701102-6-ming.lei@redhat.com>
In-Reply-To: <20210929041559.701102-1-ming.lei@redhat.com>
References: <20210929041559.701102-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_211725_831258_4C5D6FD4 
X-CRM114-Status: GOOD (  19.22  )
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

Turns out that blk_mq_freeze_queue() isn't stronger[1] than
blk_mq_quiesce_queue() because dispatch may still be in-progress after
queue is frozen, and in several cases, such as switching io scheduler,
updating nr_requests & wbt latency, we still need to quiesce queue as a
supplement of freezing queue.

As we need to extend uses of blk_mq_quiesce_queue(), it is inevitable
for us to need support nested quiesce, especailly we can't let
unquiesce happen when there is quiesce originated from other contexts.

This patch introduces q->mq_quiesce_depth to deal concurrent quiesce,
and we only unquiesce queue when it is the last one from all contexts.

One kernel panic issue has been reported[2] when running stress test on
dm-mpath's updating nr_requests and suspending queue, and the similar
issue should exist on almost all drivers which use quiesce/unquiesce.

[1] https://marc.info/?l=linux-block&m=150993988115872&w=2
[2] https://listman.redhat.com/archives/dm-devel/2021-September/msg00189.html

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 20 +++++++++++++++++---
 include/linux/blkdev.h |  2 ++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 21bf4c3f0825..10f8a3d4e3a1 100644
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
 
@@ -250,10 +255,19 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
  */
 void blk_mq_unquiesce_queue(struct request_queue *q)
 {
-	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
+	unsigned long flags;
+	bool run_queue = false;
+
+	spin_lock_irqsave(&q->queue_lock, flags);
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
