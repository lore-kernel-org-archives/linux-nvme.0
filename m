Return-Path: <SRS0=MVBk=JW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A684C433B4
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 08:58:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7FF613BD
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 08:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7FF613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VxGW6LezamYRk04hS91s5qPDYUUcE8JonVsHmkJz4MM=; b=hmXVO1uTu92UnRMP+boj9edga
	wSqYEXDIY/GXI7MeoqIfE7fEhFcA8+W+rHNaYS2ancYrwRX+5FRpx1TGzslGX+r8pUMR6WPpw19uT
	sADpgiG9xEbHA8d4IhieEAw1QInicbIq48YHhSj/ZBMweiJme0LGDOn+0o71OsIFEhyG0RCKGP0Y1
	zKD11TIWDSD3DRPfvGCIpnksa6gdgUyWSvh5z/VSCzGY1aJOLmmx4iK0KrsNwj9qZtoilmXiuD84M
	BumdnC1KHlkqb0WMt+Y6WMC6tmD94sXSVUJOq7wkOvjUTQO1sPw4sN4Q6BdV+17qRXIHB4awBYemE
	20c51WXpA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1laaax-005Jqz-O7; Sun, 25 Apr 2021 08:58:27 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laaao-005Jpq-Ne
 for linux-nvme@desiato.infradead.org; Sun, 25 Apr 2021 08:58:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=M74/hsQnSAa0X2C+IMiyjVk4wyeWitrFumK7BMvk4gA=; b=B9fwZiTbUnL3jYjZOeV2SRpKRr
 GwMOxpWFC9hReTGSoWfWq4UI/lQng/dglpzvbhTMOuIJzKwb/bz4CP3hPPVvRoWsLQaKcVKrbFa3i
 giPyrnCWnN/6b9hvxtW5VfzBogY3yC+1E0w/S3x3XPeLEKnh+99bV0fKwaimx54ch3iB64CMiyR0+
 wQiutLKqNF/+ZdtDmOk9FFjHsZAIum/OaHIrFgsTx6FBqGANIT3kQ+bPXoWNpjnUe54IgIiIkF1iQ
 7gqLGpxNl+7KBoWX87P4EFS4Cbd/kiS/GPh3Fu7jP+U3twRZnGGhI21qhKTf74WotJB0IqT2+syd5
 yQVE2LMg==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laaam-00FMXI-8v
 for linux-nvme@lists.infradead.org; Sun, 25 Apr 2021 08:58:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619341095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M74/hsQnSAa0X2C+IMiyjVk4wyeWitrFumK7BMvk4gA=;
 b=SnpKqMcu/oXNNY2zN1BwQf87A9ekZMQZvvMEC30h4dpWGbh7s/lMM27j8vpHoSOzdN5Uz+
 r/tt8Qa4stn+pQErJ69153q2yUZOXxJNQ5qPtSCrW1w23Mx1uidf0r3y382RqqElaUTU+V
 c0qrUwY+y36jnTjZ4gCjG6jSba01WrY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-V0FQV5NMMvm2rR2RedqVZA-1; Sun, 25 Apr 2021 04:58:11 -0400
X-MC-Unique: V0FQV5NMMvm2rR2RedqVZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA5718030CF;
 Sun, 25 Apr 2021 08:58:09 +0000 (UTC)
Received: from localhost (ovpn-13-143.pek2.redhat.com [10.72.13.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1691A10016F8;
 Sun, 25 Apr 2021 08:58:02 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, Khazhy Kumykov <khazhy@google.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/8] Revert "blk-mq: Fix races between
 blk_mq_update_nr_hw_queues() and iterating over tags"
Date: Sun, 25 Apr 2021 16:57:46 +0800
Message-Id: <20210425085753.2617424-2-ming.lei@redhat.com>
In-Reply-To: <20210425085753.2617424-1-ming.lei@redhat.com>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_015816_411193_DA629E05 
X-CRM114-Status: GOOD (  13.69  )
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

This reverts commit ac81d1ffd022b432d24fe79adf2d31f81a4acdc3.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index b0e0f074a864..39d5c9190a6b 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -376,31 +376,6 @@ void blk_mq_all_tag_iter_atomic(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 	__blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
 }
 
-/*
- * Iterate over all request queues in a tag set, find the first queue with a
- * non-zero usage count, increment its usage count and return the pointer to
- * that request queue. This prevents that blk_mq_update_nr_hw_queues() will
- * modify @set->nr_hw_queues while iterating over tags since
- * blk_mq_update_nr_hw_queues() only modifies @set->nr_hw_queues while the
- * usage count of all queues associated with a tag set is zero.
- */
-static struct request_queue *
-blk_mq_get_any_tagset_queue(struct blk_mq_tag_set *set)
-{
-	struct request_queue *q;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
-		if (percpu_ref_tryget(&q->q_usage_counter)) {
-			rcu_read_unlock();
-			return q;
-		}
-	}
-	rcu_read_unlock();
-
-	return NULL;
-}
-
 /**
  * blk_mq_tagset_busy_iter - iterate over all started requests in a tag set
  * @tagset:	Tag set to iterate over.
@@ -416,22 +391,15 @@ blk_mq_get_any_tagset_queue(struct blk_mq_tag_set *set)
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv)
 {
-	struct request_queue *q;
 	int i;
 
 	might_sleep();
 
-	q = blk_mq_get_any_tagset_queue(tagset);
-	if (!q)
-		return;
-
 	for (i = 0; i < tagset->nr_hw_queues; i++) {
 		if (tagset->tags && tagset->tags[i])
 			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
 				BT_TAG_ITER_STARTED | BT_TAG_ITER_MAY_SLEEP);
 	}
-
-	blk_queue_exit(q);
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
@@ -450,20 +418,13 @@ EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 void blk_mq_tagset_busy_iter_atomic(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv)
 {
-	struct request_queue *q;
 	int i;
 
-	q = blk_mq_get_any_tagset_queue(tagset);
-	if (!q)
-		return;
-
 	for (i = 0; i < tagset->nr_hw_queues; i++) {
 		if (tagset->tags && tagset->tags[i])
 			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
 					      BT_TAG_ITER_STARTED);
 	}
-
-	blk_queue_exit(q);
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter_atomic);
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
