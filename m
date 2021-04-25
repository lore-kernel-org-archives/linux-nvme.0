Return-Path: <SRS0=MVBk=JW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462D5C43460
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 08:59:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E15613B2
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 08:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E15613B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RnUmVi/jpzWFmCC00gXcyaO+4SvjM3epVPhbWEMsKGE=; b=TAJ6RVdS/Nu0wa5ktJas96Nnz
	+0Ax1jhhQaOjIrjAtj+DZHBa9xa6d/J5paeauYCYgSF73ymjvB8du8d9xSYsBc5aQyO1uXOQO76eC
	JN+GH+UyLhpFmENkYuuycqH5cOb/uNMbydJqZfolTzwee7sZkIvT44sTP4hEdh08FwToct5DVnZsg
	TATdNHTDQUtviCg5jQYJNHGX0I7NMC1VMBCDsZJ5uEO1q5VNymclTaBgfaL15It9Yvfpp0dhsV7pm
	vzTlt9kzGCYQ1Qz/GD9HzOWqrQuPqLQI4Qoca2OGi8HuRDhOP9X5rxPa9ADRMUBDhe5qzltHGM0fO
	4u6iLV9Ow==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1laabL-005JtK-NM; Sun, 25 Apr 2021 08:58:51 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laab0-005JrB-Ce
 for linux-nvme@desiato.infradead.org; Sun, 25 Apr 2021 08:58:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=1ySprp4c/nxfZOZakpTyMDVQUGhmiCiKIQUYVlnHBwI=; b=SuE6Ne494lvuBIbS4yb1QCk6PJ
 xvVmtV2PjGuLUVNgNSeZtvqcnQadN90LUglW25jFdpQb0SKfYa+OfZtTI+xQJA5zpnsCk8x1Jm+kJ
 yqZomz5YbbrHBtSSrCrMbuHZhKAFF5kXQx1nzdhwIEWlgiKeE5dO1I7XIdx0GWKec9wHzU5RBlKvw
 GRvSMjVJ7KIzqs1puTuGFZKFdrFyP2Bs5AgAvweYgoZwfr6Xcte+wQpmXaQum4ECOwtj4ZfJW+BGh
 B/J3FaUCJ7RYpcjVlxGLnjzhFyseJwkdJpoYFF/VIjlQH0592YAmI7CKJWFpekZrs7Li0MUrWtVio
 17yUsU6w==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laaax-00FMY1-EX
 for linux-nvme@lists.infradead.org; Sun, 25 Apr 2021 08:58:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619341106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ySprp4c/nxfZOZakpTyMDVQUGhmiCiKIQUYVlnHBwI=;
 b=cjzzu0taTTMpVU1Mt9N1gYb+zxdaR8hMt+z/AJ7sY88sRJPEMPJKi7LxihqJCPQkXB0yhq
 u2eyTzjSxO81frkRlBGYXVkRUldPDChx/zjep/fl6pr18/CDz8Mu4ucwPMS1Xeu7DYNX7E
 Fag2e4JE2slmZw1Oe0+mFdJguRwYoTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-vZvJvkNQNY-Uikz2PyA_Fg-1; Sun, 25 Apr 2021 04:58:21 -0400
X-MC-Unique: vZvJvkNQNY-Uikz2PyA_Fg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 226ED1006C80;
 Sun, 25 Apr 2021 08:58:20 +0000 (UTC)
Received: from localhost (ovpn-13-143.pek2.redhat.com [10.72.13.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB99C690FD;
 Sun, 25 Apr 2021 08:58:15 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, Khazhy Kumykov <khazhy@google.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/8] Revert "blk-mq: Fix races between iterating over requests
 and freeing requests"
Date: Sun, 25 Apr 2021 16:57:48 +0800
Message-Id: <20210425085753.2617424-4-ming.lei@redhat.com>
In-Reply-To: <20210425085753.2617424-1-ming.lei@redhat.com>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_015827_594964_8A73225C 
X-CRM114-Status: GOOD (  27.68  )
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

This reverts commit 5ba3f5a6ca7ee2dffcae7fab25a1a1053e3264cb.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c   | 34 +------------------------------
 block/blk-mq-tag.c | 51 ++++++----------------------------------------
 block/blk-mq-tag.h |  4 +---
 block/blk-mq.c     | 21 ++++---------------
 block/blk-mq.h     |  1 -
 block/blk.h        |  2 --
 block/elevator.c   |  1 -
 7 files changed, 12 insertions(+), 102 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ca7f833e25a8..9bcdae93f6d4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -279,36 +279,6 @@ void blk_dump_rq_flags(struct request *rq, char *msg)
 }
 EXPORT_SYMBOL(blk_dump_rq_flags);
 
-/**
- * blk_mq_wait_for_tag_iter - wait for preexisting tag iteration functions to finish
- * @set: Tag set to wait on.
- *
- * Waits for preexisting calls of blk_mq_all_tag_iter(),
- * blk_mq_tagset_busy_iter() and also for their atomic variants to finish
- * accessing hctx->tags->rqs[]. New readers may start while this function is
- * in progress or after this function has returned. Use this function to make
- * sure that hctx->tags->rqs[] changes have become globally visible.
- *
- * Waits for preexisting blk_mq_queue_tag_busy_iter(q, fn, priv) calls to
- * finish accessing requests associated with other request queues than 'q'.
- */
-void blk_mq_wait_for_tag_iter(struct blk_mq_tag_set *set)
-{
-	struct blk_mq_tags *tags;
-	int i;
-
-	if (set->tags) {
-		for (i = 0; i < set->nr_hw_queues; i++) {
-			tags = set->tags[i];
-			if (!tags)
-				continue;
-			down_write(&tags->iter_rwsem);
-			up_write(&tags->iter_rwsem);
-		}
-	}
-	synchronize_rcu();
-}
-
 /**
  * blk_sync_queue - cancel any pending callbacks on a queue
  * @q: the queue
@@ -442,10 +412,8 @@ void blk_cleanup_queue(struct request_queue *q)
 	 * it is safe to free requests now.
 	 */
 	mutex_lock(&q->sysfs_lock);
-	if (q->elevator) {
-		blk_mq_wait_for_tag_iter(q->tag_set);
+	if (q->elevator)
 		blk_mq_sched_free_requests(q);
-	}
 	mutex_unlock(&q->sysfs_lock);
 
 	percpu_ref_exit(&q->q_usage_counter);
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 39d5c9190a6b..d8eaa38a1bd1 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -209,24 +209,14 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 
 	if (!reserved)
 		bitnr += tags->nr_reserved_tags;
-	rcu_read_lock();
-	/*
-	 * The request 'rq' points at is protected by an RCU read lock until
-	 * its queue pointer has been verified and by q_usage_count while the
-	 * callback function is being invoked. See also the
-	 * percpu_ref_tryget() and blk_queue_exit() calls in
-	 * blk_mq_queue_tag_busy_iter().
-	 */
-	rq = rcu_dereference(tags->rqs[bitnr]);
+	rq = tags->rqs[bitnr];
+
 	/*
 	 * We can hit rq == NULL here, because the tagging functions
 	 * test and set the bit before assigning ->rqs[].
 	 */
-	if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx) {
-		rcu_read_unlock();
+	if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
 		return iter_data->fn(hctx, rq, iter_data->data, reserved);
-	}
-	rcu_read_unlock();
 	return true;
 }
 
@@ -264,17 +254,11 @@ struct bt_tags_iter_data {
 	unsigned int flags;
 };
 
-/* Include reserved tags. */
 #define BT_TAG_ITER_RESERVED		(1 << 0)
-/* Only include started requests. */
 #define BT_TAG_ITER_STARTED		(1 << 1)
-/* Iterate over tags->static_rqs[] instead of tags->rqs[]. */
 #define BT_TAG_ITER_STATIC_RQS		(1 << 2)
-/* The callback function may sleep. */
-#define BT_TAG_ITER_MAY_SLEEP		(1 << 3)
 
-static bool __bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr,
-			   void *data)
+static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 {
 	struct bt_tags_iter_data *iter_data = data;
 	struct blk_mq_tags *tags = iter_data->tags;
@@ -291,8 +275,7 @@ static bool __bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr,
 	if (iter_data->flags & BT_TAG_ITER_STATIC_RQS)
 		rq = tags->static_rqs[bitnr];
 	else
-		rq = rcu_dereference_check(tags->rqs[bitnr],
-					   lockdep_is_held(&tags->iter_rwsem));
+		rq = tags->rqs[bitnr];
 	if (!rq)
 		return true;
 	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
@@ -301,25 +284,6 @@ static bool __bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr,
 	return iter_data->fn(rq, iter_data->data, reserved);
 }
 
-static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
-{
-	struct bt_tags_iter_data *iter_data = data;
-	struct blk_mq_tags *tags = iter_data->tags;
-	bool res;
-
-	if (iter_data->flags & BT_TAG_ITER_MAY_SLEEP) {
-		down_read(&tags->iter_rwsem);
-		res = __bt_tags_iter(bitmap, bitnr, data);
-		up_read(&tags->iter_rwsem);
-	} else {
-		rcu_read_lock();
-		res = __bt_tags_iter(bitmap, bitnr, data);
-		rcu_read_unlock();
-	}
-
-	return res;
-}
-
 /**
  * bt_tags_for_each - iterate over the requests in a tag map
  * @tags:	Tag map to iterate over.
@@ -393,12 +357,10 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 {
 	int i;
 
-	might_sleep();
-
 	for (i = 0; i < tagset->nr_hw_queues; i++) {
 		if (tagset->tags && tagset->tags[i])
 			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
-				BT_TAG_ITER_STARTED | BT_TAG_ITER_MAY_SLEEP);
+					      BT_TAG_ITER_STARTED);
 	}
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
@@ -582,7 +544,6 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
-	init_rwsem(&tags->iter_rwsem);
 
 	if (blk_mq_is_sbitmap_shared(flags))
 		return tags;
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index d1d73d7cc7df..0290c308ece9 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -17,11 +17,9 @@ struct blk_mq_tags {
 	struct sbitmap_queue __bitmap_tags;
 	struct sbitmap_queue __breserved_tags;
 
-	struct request __rcu **rqs;
+	struct request **rqs;
 	struct request **static_rqs;
 	struct list_head page_list;
-
-	struct rw_semaphore iter_rwsem;
 };
 
 extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8b59f6b4ec8e..79c01b1f885c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -496,10 +496,8 @@ static void __blk_mq_free_request(struct request *rq)
 	blk_crypto_free_request(rq);
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx = NULL;
-	if (rq->tag != BLK_MQ_NO_TAG) {
+	if (rq->tag != BLK_MQ_NO_TAG)
 		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
-		rcu_assign_pointer(hctx->tags->rqs[rq->tag], NULL);
-	}
 	if (sched_tag != BLK_MQ_NO_TAG)
 		blk_mq_put_tag(hctx->sched_tags, ctx, sched_tag);
 	blk_mq_sched_restart(hctx);
@@ -841,20 +839,9 @@ EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
 struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
 {
-	struct request *rq;
-
 	if (tag < tags->nr_tags) {
-		/*
-		 * Freeing tags happens with the request queue frozen so the
-		 * rcu dereference below is protected by the request queue
-		 * usage count. We can only verify that usage count after
-		 * having read the request pointer.
-		 */
-		rq = rcu_dereference_check(tags->rqs[tag], true);
-		WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && rq &&
-			     percpu_ref_is_zero(&rq->q->q_usage_counter));
-		prefetch(rq);
-		return rq;
+		prefetch(tags->rqs[tag]);
+		return tags->rqs[tag];
 	}
 
 	return NULL;
@@ -1125,7 +1112,7 @@ static bool blk_mq_get_driver_tag(struct request *rq)
 		rq->rq_flags |= RQF_MQ_INFLIGHT;
 		__blk_mq_inc_active_requests(hctx);
 	}
-	rcu_assign_pointer(hctx->tags->rqs[rq->tag], rq);
+	hctx->tags->rqs[rq->tag] = rq;
 	return true;
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9ccb1818303b..3616453ca28c 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -226,7 +226,6 @@ static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 					   struct request *rq)
 {
 	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
-	rcu_assign_pointer(hctx->tags->rqs[rq->tag], NULL);
 	rq->tag = BLK_MQ_NO_TAG;
 
 	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
diff --git a/block/blk.h b/block/blk.h
index d88b0823738c..529233957207 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -185,8 +185,6 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 void blk_account_io_start(struct request *req);
 void blk_account_io_done(struct request *req, u64 now);
 
-void blk_mq_wait_for_tag_iter(struct blk_mq_tag_set *set);
-
 /*
  * Internal elevator interface
  */
diff --git a/block/elevator.c b/block/elevator.c
index aae9cff6d5ae..7c486ce858e0 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -201,7 +201,6 @@ static void elevator_exit(struct request_queue *q, struct elevator_queue *e)
 {
 	lockdep_assert_held(&q->sysfs_lock);
 
-	blk_mq_wait_for_tag_iter(q->tag_set);
 	blk_mq_sched_free_requests(q);
 	__elevator_exit(q, e);
 }
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
