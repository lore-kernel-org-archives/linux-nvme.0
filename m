Return-Path: <SRS0=9U1b=CX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447D4C43461
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 02:09:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87E121655
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 02:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="odqlT6v8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ms3KEPRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87E121655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6vyjTJDCR95r9gqEe83seGxEKtnBC08cVj+JZl8nYLY=; b=odqlT6v8qcvnIV7B28ur+hmwL
	1eHJ45kG4k2ByCjondvFOhLPdnNmWDln2/0WTfw4sBkdi3CRv4R45QXr8NFJIoI1Wz3KJjKW3Ps4i
	aPpnTDCM3ROeZaV76D+mq0luS2uCIMjjS1M6MylABEFKrS93L8KqdRMruwMpP4kz8skn4qdsoWryp
	Wifvg3TlHI7wkdR8QJADan88jcvTTppj86ta6GG2I+wQnvFOyuw+kYaFHX085eCo6u3//CG0tyJ/k
	SwUK7kOd+Gyqjo7uJ9xDkmdzv55GN4nDScidzJXgy5wf4x74Jv6AgZLRyMCPmAe14gw0rkHg7geTJ
	OYLGSkt9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHdvX-00070M-0w; Mon, 14 Sep 2020 02:09:07 +0000
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHdvU-0006zn-MJ
 for linux-nvme@lists.infradead.org; Mon, 14 Sep 2020 02:09:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600049344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d4KrjG+hpr/NvnFCCl/oxIpUDq3do9AAwekXW/8myO0=;
 b=Ms3KEPRQAX6WCEiO7c9q1Zi/pY41ue96u4M2qeS82ixZQCQOTjSNdMLCo6t/gBfUtdv2kO
 k/EVa3OZ0dvX03hUKw+813btMJRbkJGMkxAWzxl+7JRJcrm+6qol4GbNKyXmc1qFbU2fyW
 oE5qRnW71gTUDj11y0r/+jj9+XlRBMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-AluOSSMaOraaQbfd78bX1w-1; Sun, 13 Sep 2020 22:09:00 -0400
X-MC-Unique: AluOSSMaOraaQbfd78bX1w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1779F1074651;
 Mon, 14 Sep 2020 02:08:59 +0000 (UTC)
Received: from localhost (ovpn-12-38.pek2.redhat.com [10.72.12.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D47F5DA7B;
 Mon, 14 Sep 2020 02:08:54 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH V6 3/4] blk-mq: add tagset quiesce interface
Date: Mon, 14 Sep 2020 10:08:26 +0800
Message-Id: <20200914020827.337615-4-ming.lei@redhat.com>
In-Reply-To: <20200914020827.337615-1-ming.lei@redhat.com>
References: <20200914020827.337615-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200913_220904_768045_DAD35C16 
X-CRM114-Status: GOOD (  19.38  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Chao Leng <lengchao@huawei.com>, Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

drivers that have shared tagsets may need to quiesce potentially a lot
of request queues that all share a single tagset (e.g. nvme). Add an interface
to quiesce all the queues on a given tagset. This interface is useful because
it can speedup the quiesce by doing it in parallel.

For tagsets that have BLK_MQ_F_BLOCKING set, we kill request queue's dispatch
percpu-refcount such that all of them wait for the counter becoming zero. For
tagsets that don't have BLK_MQ_F_BLOCKING set, we simply call a single
synchronize_rcu as this is sufficient.

This patch is against Sagi's original post.
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chao Leng <lengchao@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c         | 59 +++++++++++++++++++++++++++++++++++-------
 include/linux/blk-mq.h |  2 ++
 2 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 65b39a498479..fb609fc38cf5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -214,16 +214,7 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
-/**
- * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
- * @q: request queue.
- *
- * Note: this function does not prevent that the struct request end_io()
- * callback function is invoked. Once this function is returned, we make
- * sure no dispatch can happen until the queue is unquiesced via
- * blk_mq_unquiesce_queue().
- */
-void blk_mq_quiesce_queue(struct request_queue *q)
+static void __blk_mq_quiesce_queue(struct request_queue *q, bool wait)
 {
 	bool blocking = !!(q->tag_set->flags & BLK_MQ_F_BLOCKING);
 	bool was_quiesced =__blk_mq_quiesce_queue_nowait(q);
@@ -231,6 +222,9 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 	if (!was_quiesced && blocking)
 		percpu_ref_kill(&q->dispatch_counter);
 
+	if (!wait)
+		return;
+
 	/*
 	 * In case of F_BLOCKING, if driver unquiesces its queue being
 	 * quiesced, it can cause bigger trouble, and we simply return &
@@ -244,6 +238,20 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 	else
 		synchronize_rcu();
 }
+
+/*
+ * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
+ * @q: request queue.
+ *
+ * Note: this function does not prevent that the struct request end_io()
+ * callback function is invoked. Once this function is returned, we make
+ * sure no dispatch can happen until the queue is unquiesced via
+ * blk_mq_unquiesce_queue().
+ */
+void blk_mq_quiesce_queue(struct request_queue *q)
+{
+	__blk_mq_quiesce_queue(q, true);
+}
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
 
 /*
@@ -265,6 +273,37 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 
+void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+
+	mutex_lock(&set->tag_list_lock);
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		__blk_mq_quiesce_queue(q, false);
+
+	/* wait until all queues' quiesce is done */
+	if (set->flags & BLK_MQ_F_BLOCKING) {
+		list_for_each_entry(q, &set->tag_list, tag_set_list)
+			wait_event(q->mq_quiesce_wq,
+				   percpu_ref_is_zero(&q->dispatch_counter));
+	} else {
+		synchronize_rcu();
+	}
+	mutex_unlock(&set->tag_list_lock);
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_tagset);
+
+void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+
+	mutex_lock(&set->tag_list_lock);
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_unquiesce_queue(q);
+	mutex_unlock(&set->tag_list_lock);
+}
+EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
+
 void blk_mq_wake_waiters(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index df642055f02c..90da3582b91d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -519,6 +519,8 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
+void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set);
+void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set);
 
 unsigned int blk_mq_rq_cpu(struct request *rq);
 
-- 
2.25.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
