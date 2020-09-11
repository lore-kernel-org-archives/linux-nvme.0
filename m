Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C8CC2D0A7
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 02:41:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF2A2076C
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 02:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TCjaKkUb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZ5jrSEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF2A2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=P+4t9uMUBb8C+tEitOSL8RD0UWSs+rD3BFjvsXFdWg0=; b=TCjaKkUb/3qfzJpYJhje/1+dR
	a6Plqvn5S5OlA/9HbKyTldHdBGelgTp+XaBJBx/r1S7DgXpAYEsNoYKYvF/99bpHNUsQ7Q82HwuU3
	rmnprNbLYDS02pV7Ppq2sTNZ3gEUqsV1wQmvlNGqSdd5tLFCvKUTpMHJXZ0LcwZOOEZFm5aqTRt+s
	E01BxF3C6k9IJINNznZ3eTnlXLQTo3/FHf1iSW4KOrlQbZUSO/sv54Tq9fAr62Z+hkBJ2DN4Yyy8E
	4olh97FQ/If7mtOuw2xxyvK1O88VQ9k+Lf+w8PZi9mdrpwWbeh+GVwi+ym0YJ2lI4RW3R2gqb4xoV
	FAkNuAs2Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGZ0R-0007Gy-TZ; Fri, 11 Sep 2020 02:41:43 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGZ0P-0007G5-My
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 02:41:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599792101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vtW9z6VONijS6LPAknM89jI7EAQ7BLxNeobi2PCAEUU=;
 b=LZ5jrSEYiI7B0Wt9bjlNdg1SXbwyxJ216VoTdzmxDcl+eU3EsVA9Ci2uyT4LTf+133h4LJ
 5wcNzSazaCG6B9sF/3HDYjDcHbkRqfCKv00fWGmnxFNBdxWcRI0Ixxs1VmCaUXY4RBmB2z
 t+3YpES+mYzrlPCSEVoOQyto66RnXsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-MBLu1NgfOgGFEc_nkQap-Q-1; Thu, 10 Sep 2020 22:41:39 -0400
X-MC-Unique: MBLu1NgfOgGFEc_nkQap-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7189B8018A3;
 Fri, 11 Sep 2020 02:41:37 +0000 (UTC)
Received: from localhost (ovpn-13-69.pek2.redhat.com [10.72.13.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DDE219C66;
 Fri, 11 Sep 2020 02:41:33 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH V5 1/4] block: use test_and_{clear|test}_bit to set/clear
 QUEUE_FLAG_QUIESCED
Date: Fri, 11 Sep 2020 10:41:14 +0800
Message-Id: <20200911024117.62480-2-ming.lei@redhat.com>
In-Reply-To: <20200911024117.62480-1-ming.lei@redhat.com>
References: <20200911024117.62480-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200910_224141_773098_0BF82EAD 
X-CRM114-Status: GOOD (  17.76  )
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
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Chao Leng <lengchao@huawei.com>, Sagi Grimberg <sagi@grimberg.me>,
 Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Prepare for replacing srcu with percpu-refcount for implementing queue
quiesce.

The following patch needs to avoid duplicated quiesce action for
BLK_MQ_F_BLOCKING, so use test_and_{clear|test}_bit to set/clear
QUEUE_FLAG_QUIESCED.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chao Leng <lengchao@huawei.com>
---
 block/blk-core.c | 13 +++++++++++++
 block/blk-mq.c   | 11 ++++++++---
 block/blk.h      |  2 ++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 093649bd252e..de440733609c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -107,6 +107,19 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_queue_flag_test_and_set);
 
+/**
+ * blk_queue_flag_test_and_clear - atomically test and clear a queue flag
+ * @flag: flag to be clear
+ * @q: request queue
+ *
+ * Returns the previous value of @flag - 0 if the flag was not set and 1 if
+ * the flag was set.
+ */
+bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q)
+{
+	return test_and_clear_bit(flag, &q->queue_flags);
+}
+
 void blk_rq_init(struct request_queue *q, struct request *rq)
 {
 	memset(rq, 0, sizeof(*rq));
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4abb71459f94..efd17a80fcdf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -199,13 +199,18 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
+static bool __blk_mq_quiesce_queue_nowait(struct request_queue *q)
+{
+	return blk_queue_flag_test_and_set(QUEUE_FLAG_QUIESCED, q);
+}
+
 /*
  * FIXME: replace the scsi_internal_device_*block_nowait() calls in the
  * mpt3sas driver such that this function can be removed.
  */
 void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 {
-	blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
+	__blk_mq_quiesce_queue_nowait(q);
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
@@ -224,7 +229,7 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 	unsigned int i;
 	bool rcu = false;
 
-	blk_mq_quiesce_queue_nowait(q);
+	__blk_mq_quiesce_queue_nowait(q);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->flags & BLK_MQ_F_BLOCKING)
@@ -246,7 +251,7 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
  */
 void blk_mq_unquiesce_queue(struct request_queue *q)
 {
-	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
+	blk_queue_flag_test_and_clear(QUEUE_FLAG_QUIESCED, q);
 
 	/* dispatch requests which are inserted during quiescing */
 	blk_mq_run_hw_queues(q, true);
diff --git a/block/blk.h b/block/blk.h
index c08762e10b04..312a060ea2a2 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -448,4 +448,6 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page);
 
+bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
+
 #endif /* BLK_INTERNAL_H */
-- 
2.25.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
