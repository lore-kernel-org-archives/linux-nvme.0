Return-Path: <SRS0=MVBk=JW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877F3C433ED
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 09:01:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE68D613AB
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 09:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE68D613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FiYn5WaxfjfGJmO9BpnBQaTFuTA34XjBH8TB4WLjg84=; b=FaKO+sU4Kek74PFWswvvb1hXq
	fME9WITK51xthwmJERaSVP6fyF0DnP3dUB4jS4MxZVFp/KZL4AerSVwkJpUKuJkd21Zl3vdOWJM6S
	ET7W9socjboTSE71b0hKM4q8BN+Ch+2VioX+VYaHTDBvRDeSk/Aayh7TNQZufqBSxce6l64BpQU6S
	mL/hF0r3Tx6Y8C7v3Z+OxiCsjYtgB7WM+2XMvHSKnYhURZQLus3sosunXsNbvvO7UiD7gukUsjTCJ
	Ja/T0w2SgAsPZ+o48Dv78+5QsH0Raazw8viy+PWRBDBkzqaA890gXQocMV3Tcnwwho7sxNbCxzLjk
	rlfA3MZLw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1laadU-005KAW-Nx; Sun, 25 Apr 2021 09:01:04 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laabS-005Jtu-0f
 for linux-nvme@desiato.infradead.org; Sun, 25 Apr 2021 08:58:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=3LuFfzevb60+uhPD/IWPbLI9CooPtCWm72NIAvuzaMY=; b=C5ZWEBxbjGVXbJlLIDjszRH7hC
 SiSAeZy1p8XBMdeOEHTtovNVAtUb34Jw6tU+o35faK06wU0EsY7O9uiB4DpgIJRHIF8N4I376YkZd
 VyiPERii+DUZAGrHVjX2Gh0iAOZ188PSD3LofoB14u793njrISdEQFv7x50+hQfBn4lDXz3Bx6K47
 LkUl+41WF6QWRytB5IG4rT3K6Z6wN3b6IUIdt8M1gmzymEKqdcUqh3LulbAZk2n3QZwqM6NyxztyO
 ePpX2jKi3SnDzYm0tnOe7WwIlTcpz3guGOLe51UW97XAq0OM9Dmrr1RIQnedpHSGTBbm4drqa9yUo
 hXsB0hnA==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laabP-00FMaI-Ck
 for linux-nvme@lists.infradead.org; Sun, 25 Apr 2021 08:58:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619341134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3LuFfzevb60+uhPD/IWPbLI9CooPtCWm72NIAvuzaMY=;
 b=LEvl70CiHMWehW148VmbJhGkqLnWpUlZ1g4ecpw1ZReaCV1gHPOnH6oOLfDuFERouSOrjl
 6jG+6Ydpc298J8aSRxYvRmGwxDOBNGA8Ft3qkfQXlvsgVp1/Grgn8MWAFM+Rg9cBzS75sq
 3c2UdsJPoKfFrpYzFwU3ozTzFWfezfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-NXm1uJmlMKufextPkATXxw-1; Sun, 25 Apr 2021 04:58:52 -0400
X-MC-Unique: NXm1uJmlMKufextPkATXxw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B19C1006C80;
 Sun, 25 Apr 2021 08:58:51 +0000 (UTC)
Received: from localhost (ovpn-13-143.pek2.redhat.com [10.72.13.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2919560BE5;
 Sun, 25 Apr 2021 08:58:46 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, Khazhy Kumykov <khazhy@google.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 8/8] blk-mq: clear stale request in tags->rq[] before freeing
 one request pool
Date: Sun, 25 Apr 2021 16:57:53 +0800
Message-Id: <20210425085753.2617424-9-ming.lei@redhat.com>
In-Reply-To: <20210425085753.2617424-1-ming.lei@redhat.com>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_015855_526614_58D8B44E 
X-CRM114-Status: GOOD (  20.63  )
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

refcount_inc_not_zero() in bt_tags_iter() still may read one freed
request.

Fix the issue by the following approach:

1) hold a per-tags spinlock when reading ->rqs[tag] and calling
refcount_inc_not_zero in bt_tags_iter()

2) clearing stale request referred via ->rqs[tag] before freeing
request pool, the per-tags spinlock is held for clearing stale
->rq[tag]

So after we cleared stale requests, bt_tags_iter() won't observe
freed request any more, also the clearing will wait for pending
request reference.

The idea of clearing ->rqs[] is borrowed from John Garry's previous
patch and one recent David's patch.

Cc: John Garry <john.garry@huawei.com>
Cc: David Jeffery <djeffery@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c |  9 ++++++++-
 block/blk-mq-tag.h |  3 +++
 block/blk-mq.c     | 39 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 489d2db89856..402a7860f6c9 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -265,10 +265,12 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	bool reserved = iter_data->flags & BT_TAG_ITER_RESERVED;
 	struct request *rq;
 	bool ret;
+	unsigned long flags;
 
 	if (!reserved)
 		bitnr += tags->nr_reserved_tags;
 
+	spin_lock_irqsave(&tags->lock, flags);
 	/*
 	 * We can hit rq == NULL here, because the tagging functions
 	 * test and set the bit before assigning ->rqs[].
@@ -277,8 +279,12 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 		rq = tags->static_rqs[bitnr];
 	else
 		rq = tags->rqs[bitnr];
-	if (!rq || !refcount_inc_not_zero(&rq->ref))
+	if (!rq || !refcount_inc_not_zero(&rq->ref)) {
+		spin_unlock_irqrestore(&tags->lock, flags);
 		return true;
+	}
+	spin_unlock_irqrestore(&tags->lock, flags);
+
 	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
 	    !blk_mq_request_started(rq))
 		ret = true;
@@ -524,6 +530,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
+	spin_lock_init(&tags->lock);
 
 	if (blk_mq_is_sbitmap_shared(flags))
 		return tags;
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 7d3e6b333a4a..f942a601b5ef 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -20,6 +20,9 @@ struct blk_mq_tags {
 	struct request **rqs;
 	struct request **static_rqs;
 	struct list_head page_list;
+
+	/* used to clear rqs[] before one request pool is freed */
+	spinlock_t lock;
 };
 
 extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9a4d520740a1..1f913f786c1f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2307,6 +2307,38 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	return BLK_QC_T_NONE;
 }
 
+static size_t order_to_size(unsigned int order)
+{
+	return (size_t)PAGE_SIZE << order;
+}
+
+/* called before freeing request pool in @tags */
+static void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
+		struct blk_mq_tags *tags, unsigned int hctx_idx)
+{
+	struct blk_mq_tags *drv_tags = set->tags[hctx_idx];
+	struct page *page;
+	unsigned long flags;
+
+	spin_lock_irqsave(&drv_tags->lock, flags);
+	list_for_each_entry(page, &tags->page_list, lru) {
+		unsigned long start = (unsigned long)page_address(page);
+		unsigned long end = start + order_to_size(page->private);
+		int i;
+
+		for (i = 0; i < set->queue_depth; i++) {
+			struct request *rq = drv_tags->rqs[i];
+			unsigned long rq_addr = (unsigned long)rq;
+
+			if (rq_addr >= start && rq_addr < end) {
+				WARN_ON_ONCE(refcount_read(&rq->ref) != 0);
+				cmpxchg(&drv_tags->rqs[i], rq, NULL);
+			}
+		}
+	}
+	spin_unlock_irqrestore(&drv_tags->lock, flags);
+}
+
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx)
 {
@@ -2325,6 +2357,8 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		}
 	}
 
+	blk_mq_clear_rq_mapping(set, tags, hctx_idx);
+
 	while (!list_empty(&tags->page_list)) {
 		page = list_first_entry(&tags->page_list, struct page, lru);
 		list_del_init(&page->lru);
@@ -2384,11 +2418,6 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 	return tags;
 }
 
-static size_t order_to_size(unsigned int order)
-{
-	return (size_t)PAGE_SIZE << order;
-}
-
 static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 			       unsigned int hctx_idx, int node)
 {
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
