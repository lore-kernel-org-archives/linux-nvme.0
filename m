Return-Path: <SRS0=MVBk=JW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C16C433B4
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 09:00:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B804D613B4
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 09:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B804D613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=P311ZVDt7PMIVayic/mDZRxIYvZStApgjhCLuf0UAck=; b=ScZoQ7NHLkyAXOFxxr/dNxHMT
	mO2KczqALgr0Y+VWjG6UH5ropojc2x29xp62b6dDvn7L22rvRhZX+J0YSp2hUDUZnAjhbO6HWExuv
	D5aqI9zPZDiNt14BEAKRiYwGW3DYEJkaKR5lglow+F+hZej1Fq9RtmYeCDXmk4euveGFJyTECvVA0
	KYvjka5CUa67BTyAuVHs4TUnErB22fJmS9HBip4IRMbs+2dNy6OuKrwD4XiQqiwLl7l4fXtA7KcUl
	J6SmqgUZoX/URhyIRMikA1PQ3kcfg+D/C+zE3IZhV/4cYxzklTr68AkdK/5jKNMIX/wjiB/gGy3To
	EaGxAWZdQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1laacl-005K55-MI; Sun, 25 Apr 2021 09:00:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laabN-005JtZ-ME
 for linux-nvme@desiato.infradead.org; Sun, 25 Apr 2021 08:58:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=Kpa9pCDoik6FTiDJWFmgKud0dcOZjitGbcFr0C3GKKk=; b=KqptKFeKe/3PjjNaIZ8NIlGdcJ
 Q04L6fDhlRXYlz6PvayUQIJ5Fbl7LpRVYRIy3EMUWcl7Bbg9nstB8o+Tr3BIevk4lSIcr3jSMFTmg
 HqPYFAr4FNQjF2C+EmwPIrVNi9EztcMQd/5FGr96h6xf/s8Iaq/HOEj6zwB8m5m55YjSzdKSlOTNX
 2DGezCyARPlAjRAPBgkWVNfr50fhm9nfBQpgLE5FOPhnOECrcYeGny1A/VczRZQHd2C+M9grasFgF
 lApz4TLD4yhUr0kMb3Kl0MP/SwyAVKO8GqsPzLn8Ko1Q3N3/5U5czZKyM4hB75iQet99wsWj1ABtl
 CABe1ahg==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laabL-00FMa2-1u
 for linux-nvme@lists.infradead.org; Sun, 25 Apr 2021 08:58:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619341130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kpa9pCDoik6FTiDJWFmgKud0dcOZjitGbcFr0C3GKKk=;
 b=IVd3bu5uFGgNFxR2LXDFImSfnL+KgjUVcaWUsoiFKF+B09XlthtjZxa3mLRvWEMnLt1kxC
 OVt2FtI1oEI7r/3gVrEWFYUINivnOJR+i4HPvFiZaWsl0XCDECZpZZ1RxT3kz0zP2sm8Mx
 1ZYjn8v2fnvWJXjzfmx8zeHJ1OynL4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-kkmOzQfbOsO_XSpnEw0QZA-1; Sun, 25 Apr 2021 04:58:46 -0400
X-MC-Unique: kkmOzQfbOsO_XSpnEw0QZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA30D343A2;
 Sun, 25 Apr 2021 08:58:44 +0000 (UTC)
Received: from localhost (ovpn-13-143.pek2.redhat.com [10.72.13.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8314310016F8;
 Sun, 25 Apr 2021 08:58:37 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, Khazhy Kumykov <khazhy@google.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 7/8] blk-mq: grab rq->refcount before calling ->fn in
 blk_mq_tagset_busy_iter
Date: Sun, 25 Apr 2021 16:57:52 +0800
Message-Id: <20210425085753.2617424-8-ming.lei@redhat.com>
In-Reply-To: <20210425085753.2617424-1-ming.lei@redhat.com>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_015851_191360_385E95A4 
X-CRM114-Status: GOOD (  17.31  )
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

Grab rq->refcount before calling ->fn in blk_mq_tagset_busy_iter(), and
this way will prevent the request from being re-used when ->fn is
running. The approach is same as what we do during handling timeout.

Fix request UAF related with completion race or queue releasing:

- If one rq is referred before rq->q is frozen, then queue won't be
frozen before the request is released during iteration.

- If one rq is referred after rq->q is frozen, refcount_inc_not_zero()
will return false, and we won't iterate over this request.

However, still one request UAF not covered: refcount_inc_not_zero() may
read one freed request, and it will be handled in next patch.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c | 14 +++++++++++---
 block/blk-mq.c     | 14 +++++++++-----
 block/blk-mq.h     |  1 +
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 2a37731e8244..489d2db89856 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -264,6 +264,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	struct blk_mq_tags *tags = iter_data->tags;
 	bool reserved = iter_data->flags & BT_TAG_ITER_RESERVED;
 	struct request *rq;
+	bool ret;
 
 	if (!reserved)
 		bitnr += tags->nr_reserved_tags;
@@ -276,12 +277,15 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 		rq = tags->static_rqs[bitnr];
 	else
 		rq = tags->rqs[bitnr];
-	if (!rq)
+	if (!rq || !refcount_inc_not_zero(&rq->ref))
 		return true;
 	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
 	    !blk_mq_request_started(rq))
-		return true;
-	return iter_data->fn(rq, iter_data->data, reserved);
+		ret = true;
+	else
+		ret = iter_data->fn(rq, iter_data->data, reserved);
+	blk_mq_put_rq_ref(rq);
+	return ret;
 }
 
 /**
@@ -348,6 +352,10 @@ void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
  *		indicates whether or not @rq is a reserved request. Return
  *		true to continue iterating tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
+ *
+ * We grab one request reference before calling @fn and release it after
+ * @fn returns. So far we don't support to pass the request reference to
+ * one new conetxt in @fn.
  */
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3d1067b10c3..9a4d520740a1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -925,6 +925,14 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
 	return false;
 }
 
+void blk_mq_put_rq_ref(struct request *rq)
+{
+	if (is_flush_rq(rq, rq->mq_hctx))
+		rq->end_io(rq, 0);
+	else if (refcount_dec_and_test(&rq->ref))
+		__blk_mq_free_request(rq);
+}
+
 static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, void *priv, bool reserved)
 {
@@ -958,11 +966,7 @@ static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 	if (blk_mq_req_expired(rq, next))
 		blk_mq_rq_timed_out(rq, reserved);
 
-	if (is_flush_rq(rq, hctx))
-		rq->end_io(rq, 0);
-	else if (refcount_dec_and_test(&rq->ref))
-		__blk_mq_free_request(rq);
-
+	blk_mq_put_rq_ref(rq);
 	return true;
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 3616453ca28c..143afe42c63a 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -47,6 +47,7 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
 struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *start);
+void blk_mq_put_rq_ref(struct request *rq);
 
 /*
  * Internal helpers for allocating/freeing the request map
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
