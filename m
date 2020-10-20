Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EDCC43457
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 08:56:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166F920936
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 08:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ji96bQBD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pf/fZqh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166F920936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZhteQQ6U6H6BFYvDkrBVbZy3n5Pc14q5t4VzIF53Ui8=; b=ji96bQBD9ijRymb+/+aVVI9t9
	Sk0Dq4tCrxRZgat7DdyxB2j3uuhtMABbrQkZihMcgRpONpT8CzdPve3wu/7k+llGIRId+lJ7HYYV0
	c4IlUqUdOADaLy97yWKZViDjLRfWwWZdo78RIYYm/fQS4WT+2X8uIHGn4u8tHfBXAZOvLc0Kh3LHv
	wck4WJhQ819/0X6yzi2D114MjWuUwNkKTaTueTRct+7zNwnvXH81JjNNgiMImm7gbj6LdKb66tpnB
	UT2TXRmA43V/Zea/yBXlCbN9DHo7baKSjvO0oQvMk1ZK3QSfWNjm21Ebf+Lp4EOwA9III3xB7WBKx
	Fy3IhTHXQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUnRN-0003iq-Ex; Tue, 20 Oct 2020 08:56:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUnRK-0003hh-HU
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 08:56:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603184178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KWXQFUE6Cit/fkoSdHUFvtd0q05EquKY/pGqsUnYzvc=;
 b=Pf/fZqh3Cz7SNGxNbugzmEKtgcEPhUL8QpdIGISZe+Dk6tR93v7LFxEQ+BZ6JzFBb40xOi
 ynNo2r8UljHNV9ZjznpcoRi4vgTdMdZowlaqHM7LBghpElRwFTpafaeZSRhhu1xVknemId
 D/LqRWngHqoU1KN6qBXyGKOpGaXgDAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-ZVQAXyIOM1ehiLdUFgEkFw-1; Tue, 20 Oct 2020 04:56:13 -0400
X-MC-Unique: ZVQAXyIOM1ehiLdUFgEkFw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC05A803F48;
 Tue, 20 Oct 2020 08:56:11 +0000 (UTC)
Received: from localhost (ovpn-12-164.pek2.redhat.com [10.72.12.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 169EF5B4BE;
 Tue, 20 Oct 2020 08:56:07 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH V8 1/4] block: use test_and_{clear|test}_bit to set/clear
 QUEUE_FLAG_QUIESCED
Date: Tue, 20 Oct 2020 16:55:52 +0800
Message-Id: <20201020085555.1554255-2-ming.lei@redhat.com>
In-Reply-To: <20201020085555.1554255-1-ming.lei@redhat.com>
References: <20201020085555.1554255-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_045618_626395_86AD04E3 
X-CRM114-Status: GOOD (  17.79  )
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-core.c | 13 +++++++++++++
 block/blk-mq.c   | 11 ++++++++---
 block/blk.h      |  2 ++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ac00d2fa4eb4..abdcc0a57c75 100644
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
index 696450257ac1..6ff538d74b62 100644
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
index dfab98465db9..f925268ce7fd 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -444,4 +444,6 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
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
