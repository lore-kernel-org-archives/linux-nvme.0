Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A947C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 10:11:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBEEB20714
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 10:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ac6OZ+uS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFbuki1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEEB20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1DVuQPqyOTqZmf97lkctelMUkx/aO20h+BAVgZLtxYc=; b=ac6OZ+uSFX2LcdJbzjsQ14NSl
	krAb8014zmB+C6u1/xUEN+UnHumO+nb982rHVTd/E7qy1VGvsDVtwT6z32Edi8M/nAzM/0ATpItgE
	5xs7+QZ5QtwGp4GbiSFMOrn1DJPKbiBbK8AXQm8dgxFLUfiEQQth+lDZQqXUmgIz/k+TuyJBai1p/
	3UwtPXfDIvmac1WhqhGavogCP9LO8cJBkPzN9ev3MyEgklEQH9LGe/jstUBC1An4QURa+fVT3r2eq
	ENS/fQ5XBftOsYgqtAZ430Kqo5+Po6k16wmNu7hLcsHK5q7ihSEwRrTaL+qszPPKKDbh310jYvXP3
	vkLxSQB4A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0MZe-0002dt-0e; Tue, 28 Jul 2020 10:11:06 +0000
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0MZa-0002d1-R9
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 10:11:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595931061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMZxBZxNZuHUTHZg7Jatjv3EfCbGgzzoSBcqTwalyeM=;
 b=eFbuki1iGyG3kJn7zU+m66/ZcVSrCEk/P6TporP9vPSEdHne2+Hm5Ys5/1VapyFcW0RYSn
 oBElkuR1h9pXwVavxaoLUIsU6j+2fvmueHd2vWoa1F5IZEgNi7HvI/S3YUWHj23KyEo3UG
 N5VkvLe2w6NDXLMXbx1oxZCGPUPh4yA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-AWIaLSxmPJeZwl-wFXBsjg-1; Tue, 28 Jul 2020 06:10:57 -0400
X-MC-Unique: AWIaLSxmPJeZwl-wFXBsjg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2905800688;
 Tue, 28 Jul 2020 10:10:55 +0000 (UTC)
Received: from T590 (ovpn-12-109.pek2.redhat.com [10.72.12.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 46120171F9;
 Tue, 28 Jul 2020 10:10:46 +0000 (UTC)
Date: Tue, 28 Jul 2020 18:10:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200728101042.GA1336890@T590>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me>
 <20200728071859.GA21629@lst.de> <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728093326.GC1326626@T590>
 <44f07df6-3107-3e7f-ee02-7bc43293ee6b@grimberg.me>
 <6a678d5d-22b2-5238-92c5-d68e2aafeb9e@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a678d5d-22b2-5238-92c5-d68e2aafeb9e@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_061102_976920_562A9CE6 
X-CRM114-Status: GOOD (  35.84  )
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
Cc: Jens Axboe <axboe@kernel.dk>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Ming Lin <mlin@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 28, 2020 at 02:43:06AM -0700, Sagi Grimberg wrote:
> =

> > > > > > I like the tagset based interface.=A0 But the idea of doing a p=
er-hctx
> > > > > > allocation and wait doesn't seem very scalable.
> > > > > > =

> > > > > > Paul, do you have any good idea for an interface that waits on
> > > > > > multiple srcu heads?=A0 As far as I can tell we could just have=
 a single
> > > > > > global completion and counter, and each call_srcu would just ju=
st
> > > > > > decrement it and then the final one would do the
> > > > > > wakeup.=A0 It would just
> > > > > > be great to figure out a way to keep the struct rcu_synchronize=
 and
> > > > > > counter on stack to avoid an allocation.
> > > > > > =

> > > > > > But if we can't do with an on-stack object I'd much rather just=
 embedd
> > > > > > the rcu_head in the hw_ctx.
> > > > > =

> > > > > I think we can do that, please see the following patch which
> > > > > is against Sagi's V5:
> > > > =

> > > > I don't think you can send a single rcu_head to multiple
> > > > call_srcu calls.
> > > =

> > > OK, then one variant is to put the rcu_head into blk_mq_hw_ctx, and p=
ut
> > > rcu_synchronize into blk_mq_tag_set.
> > =

> > I can cook up a spin,
> =

> Nope.. spoke too soon, the rcu_head needs to be in a context that has
> access to the counter (which is what you called blk_mq_srcu_sync).
> you want to add also a pointer to hctx? that is almost as big as
> rcu_synchronize...

We can just put rcu_head into hctx, and put the count & completion into
tag_set, and the tagset can be retrieved via hctx, something like the
following patch:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c3856377b961..129665da4dbd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -27,6 +27,7 @@
 #include <linux/crash_dump.h>
 #include <linux/prefetch.h>
 #include <linux/blk-crypto.h>
+#include <linux/rcupdate_wait.h>
 =

 #include <trace/events/block.h>
 =

@@ -209,6 +210,34 @@ void blk_mq_quiesce_queue_nowait(struct request_queue =
*q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 =

+static void blk_mq_wakeme_after_rcu(struct rcu_head *head)
+{
+
+	struct blk_mq_srcu_struct *srcu =3D container_of(head,
+			struct blk_mq_srcu_struct, head);
+	struct blk_mq_hw_ctx *hctx =3D (void *)srcu -
+		sizeof(struct blk_mq_hw_ctx);
+	struct blk_mq_tag_set *set =3D hctx->queue->tag_set;
+
+	if (atomic_dec_and_test(&set->quiesce_count))
+		complete(&set->quiesce_completion);
+}
+
+static void blk_mq_quiesce_blocking_queue_async(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	blk_mq_quiesce_queue_nowait(q);
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
+		init_rcu_head(&hctx->srcu->head);
+		call_srcu(&hctx->srcu->srcu, &hctx->srcu->head,
+				blk_mq_wakeme_after_rcu);
+	}
+}
+
 /**
  * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
  * @q: request queue.
@@ -228,7 +257,7 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 =

 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->flags & BLK_MQ_F_BLOCKING)
-			synchronize_srcu(hctx->srcu);
+			synchronize_srcu(&hctx->srcu->srcu);
 		else
 			rcu =3D true;
 	}
@@ -700,23 +729,23 @@ void blk_mq_complete_request(struct request *rq)
 EXPORT_SYMBOL(blk_mq_complete_request);
 =

 static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
-	__releases(hctx->srcu)
+	__releases(&hctx->srcu->srcu)
 {
 	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
 		rcu_read_unlock();
 	else
-		srcu_read_unlock(hctx->srcu, srcu_idx);
+		srcu_read_unlock(&hctx->srcu->srcu, srcu_idx);
 }
 =

 static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
-	__acquires(hctx->srcu)
+	__acquires(&hctx->srcu->srcu)
 {
 	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
 		/* shut up gcc false positive */
 		*srcu_idx =3D 0;
 		rcu_read_lock();
 	} else
-		*srcu_idx =3D srcu_read_lock(hctx->srcu);
+		*srcu_idx =3D srcu_read_lock(&hctx->srcu->srcu);
 }
 =

 /**
@@ -2599,7 +2628,7 @@ static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *=
tag_set)
 		     sizeof(struct blk_mq_hw_ctx));
 =

 	if (tag_set->flags & BLK_MQ_F_BLOCKING)
-		hw_ctx_size +=3D sizeof(struct srcu_struct);
+		hw_ctx_size +=3D sizeof(struct blk_mq_srcu_struct);
 =

 	return hw_ctx_size;
 }
@@ -2684,7 +2713,7 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk=
_mq_tag_set *set,
 		goto free_bitmap;
 =

 	if (hctx->flags & BLK_MQ_F_BLOCKING)
-		init_srcu_struct(hctx->srcu);
+		init_srcu_struct(&hctx->srcu->srcu);
 	blk_mq_hctx_kobj_init(hctx);
 =

 	return hctx;
@@ -2880,6 +2909,43 @@ static void queue_set_hctx_shared(struct request_que=
ue *q, bool shared)
 	}
 }
 =

+void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+
+	mutex_lock(&set->tag_list_lock);
+	if (set->flags & BLK_MQ_F_BLOCKING) {
+		int count =3D 0;
+
+		list_for_each_entry(q, &set->tag_list, tag_set_list)
+			count++;
+
+		atomic_set(&set->quiesce_count, count);
+		init_completion(&set->quiesce_completion);
+
+		list_for_each_entry(q, &set->tag_list, tag_set_list)
+			blk_mq_quiesce_blocking_queue_async(q);
+		wait_for_completion(&set->quiesce_completion);
+	} else {
+		list_for_each_entry(q, &set->tag_list, tag_set_list)
+			blk_mq_quiesce_queue_nowait(q);
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
 static void blk_mq_update_tag_set_depth(struct blk_mq_tag_set *set,
 					bool shared)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 23230c1d031e..9ef7fdb809a7 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -9,6 +9,11 @@
 struct blk_mq_tags;
 struct blk_flush_queue;
 =

+struct blk_mq_srcu_struct {
+	struct srcu_struct srcu;
+	struct rcu_head    head;
+};
+
 /**
  * struct blk_mq_hw_ctx - State for a hardware queue facing the hardware
  * block device
@@ -175,7 +180,7 @@ struct blk_mq_hw_ctx {
 	 * blocking (BLK_MQ_F_BLOCKING). Must be the last member - see also
 	 * blk_mq_hw_ctx_size().
 	 */
-	struct srcu_struct	srcu[];
+	struct blk_mq_srcu_struct	srcu[];
 };
 =

 /**
@@ -254,6 +259,9 @@ struct blk_mq_tag_set {
 =

 	struct mutex		tag_list_lock;
 	struct list_head	tag_list;
+
+	struct completion	quiesce_completion;
+	atomic_t		quiesce_count;
 };
 =

 /**
@@ -532,6 +540,8 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queu=
es);
 =

 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
+void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set);
+void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set);
 =

 unsigned int blk_mq_rq_cpu(struct request *rq);
 =


-- =

Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
