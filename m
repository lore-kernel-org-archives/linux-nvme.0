Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F36C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Jan 2022 11:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iWDZhCx4WfOjbjkCKSgQjjsWcEnBKzFq0pmqP92OyGQ=; b=S/HupM/nv7m9swdy9Ima2uRjS+
	f+mI8PFtOTBAhjRUxqDUt6O6e/OL48qlxI7LdMq8JWyzV4BHy7YfnmbJuUQW14kW0jUrpjsVQQLKS
	k2755MEiJCaRQw48J9WUfY0TV4bBeB6u6nYGhoTC0ur26I7IjD/071st+KfEySNixewqcynwVWPE5
	0GhR/BuIeXQJ//Blrc8wTa8a+mAwaBQcGjElNvoW2xSkZYWr6TYOX0kezUF0/waRDGScG3wQ/3HuE
	9N3lNJIbecxeb9drLzzpLjH4s0RF6DathVPX7NcTrLqW/DnfY3yN9wKPS87NxTfQprlodirlNZD/j
	sBBFTgDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBEL5-00HAc4-VI; Sat, 22 Jan 2022 11:13:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBEJn-00HA9k-AK
 for linux-nvme@lists.infradead.org; Sat, 22 Jan 2022 11:12:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642849946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iWDZhCx4WfOjbjkCKSgQjjsWcEnBKzFq0pmqP92OyGQ=;
 b=CQ02tPt6eUA/8QlQf33tT/t5jeLgqsIPAkLGRNVxaSfOZR/JnpyTSG/pkwphdYKp4n9ywD
 kqVLBmJUA9vdhXD9VKPCwRTR1VefdQWgRoBatoSGC+u3T3fLy2amGBgMao/b0vGp6FCq/F
 qGBiTIc3Vau7TiC3l5nTRqn6JXCbklk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-0Qe6dymAMrSf663s74Rv1A-1; Sat, 22 Jan 2022 06:12:22 -0500
X-MC-Unique: 0Qe6dymAMrSf663s74Rv1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71A0D1006AA3;
 Sat, 22 Jan 2022 11:12:21 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC90770D3D;
 Sat, 22 Jan 2022 11:12:17 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 08/13] block: export __blk_mq_unfreeze_queue
Date: Sat, 22 Jan 2022 19:10:49 +0800
Message-Id: <20220122111054.1126146-9-ming.lei@redhat.com>
In-Reply-To: <20220122111054.1126146-1-ming.lei@redhat.com>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220122_031227_462080_04E0442D 
X-CRM114-Status: GOOD (  18.95  )
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

blk_mq_unfreeze_queue() is used by scsi when releasing disk, so not
necessary to unfreeze into percpu mode, then the following
blk_cleanup_queue doesn't need to freeze queue from percpu mode, and
the implied RCU grace period may be avoided.

Meantime move clearing QUEUE_FLAG_INIT_DONE into this API, so that
when one disk is added, ->q_usage_counter can be switched to percpu
mode again.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 10 +++++++++-
 block/blk.h            |  1 -
 block/genhd.c          |  1 -
 include/linux/blk-mq.h |  1 +
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 66cc701921c1..d51b0aa2e4e4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -215,11 +215,18 @@ void blk_mq_freeze_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
 
+/*
+ * When 'force_atomic' is passed as true, this API is supposed to be
+ * called only in case that disk is removed or released.
+ */
 void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 {
 	mutex_lock(&q->mq_freeze_lock);
-	if (force_atomic)
+	if (force_atomic) {
+		/* When new disk is added, switch to percpu mode */
+		blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
 		q->q_usage_counter.data->force_atomic = true;
+	}
 	q->mq_freeze_depth--;
 	WARN_ON_ONCE(q->mq_freeze_depth < 0);
 	if (!q->mq_freeze_depth) {
@@ -228,6 +235,7 @@ void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 	}
 	mutex_unlock(&q->mq_freeze_lock);
 }
+EXPORT_SYMBOL_GPL(__blk_mq_unfreeze_queue);
 
 void blk_mq_unfreeze_queue(struct request_queue *q)
 {
diff --git a/block/blk.h b/block/blk.h
index 7b0f12260ae6..a038e25d8637 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -43,7 +43,6 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
 void blk_freeze_queue(struct request_queue *q);
-void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 void blk_queue_start_drain(struct request_queue *q);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
 bool submit_bio_checks(struct bio *bio);
diff --git a/block/genhd.c b/block/genhd.c
index b9b0db168ce1..5bd7bcd6246e 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -628,7 +628,6 @@ void del_gendisk(struct gendisk *disk)
 	/*
 	 * Allow using passthrough request again after the queue is torn down.
 	 */
-	blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
 	__blk_mq_unfreeze_queue(q, true);
 
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d2ad2ed11723..1645159d10f3 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -869,6 +869,7 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
+void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 void blk_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
-- 
2.31.1


