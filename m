Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FECAC433E2
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 09:45:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B52E21D40
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 09:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1pP1WMq6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Er59G1Du"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B52E21D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8EVbAn93Ey8bFkOgjHGZrhErNWzFVAN5zRrpN7vShBs=; b=1pP1WMq6X6iTrghj4IiyGDP1my
	qmNP1J1377CvpQX+wZC0ogU8SGJbzmVP6h5kvkvzyGZjtmOLQw8v8QT1hd/FxbVF1SaGMXA8kPwDo
	1soSjZOMSK6vnk3OzZU+2LLw5DUWQC2MMLCOxN9qlyl6etyqs6CLyrbs+nG48CYzgRLFEZm98btBw
	mosElYBccPL3RU26lLW0683dY9AAnDz13nHCZfkM8GlYHQ9v0JIwCUs9OqdBAOiZGJgX6u0A60uvP
	JTUn63NY2R/VXsDE9/sK0FN7hOA7HcCOv9LfV/ojWL4U3SwXavGJV4Pb/H7I1gYibYQcHQrkKNFC2
	VPlw2BGg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGfcG-0005aS-Ue; Fri, 11 Sep 2020 09:45:12 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGfcE-0005ZJ-9y
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 09:45:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599817509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NqddnxdLvy7sSDr9O0Tc09AYl4o2yN5z3yG4wqceViY=;
 b=Er59G1DuO6Vu6Of67vXL2HPBkkrxk+nTrk+puHgyikpj00ACyn05tIrJhb8Lv0e9iCr5HI
 eCxmkprd9NlS2TleTB5PIi1dVjEILmUjw1Lm1nywq/6ThTBrNKLrQaOhmo4Y8NHuBNF6tr
 6kRjNi4grqjc7eGulPpziQhDp/pqJIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-v7At820LN6O0r06hihtswQ-1; Fri, 11 Sep 2020 05:45:07 -0400
X-MC-Unique: v7At820LN6O0r06hihtswQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 668F68030A2;
 Fri, 11 Sep 2020 09:45:06 +0000 (UTC)
Received: from localhost (ovpn-13-69.pek2.redhat.com [10.72.13.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B7AB7838A;
 Fri, 11 Sep 2020 09:45:02 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] blk-mq: always allow reserved allocation in hctx_may_queue
Date: Fri, 11 Sep 2020 17:44:53 +0800
Message-Id: <20200911094453.160109-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_054510_483110_57711B97 
X-CRM114-Status: GOOD (  14.83  )
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
Cc: David Milburn <dmilburn@redhat.com>, "Ewan D . Milne" <emilne@redhat.com>,
 Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

NVMe shares tagset between fabric queue and admin queue or between
connect_q and NS queue, so hctx_may_queue() can be called to allocate
request for these queues.

Tags can be reserved in these tagset. Before error recovery, there is
often lots of in-flight requests which can't be completed, and new
reserved request may be needed in error recovery path. However,
hctx_may_queue() can always return false because there is too many
in-flight requests which can't be completed during error handling.
Finally, everything can't move on.

Fix this issue by always allowing reserved tag allocation in
hctx_may_queue(). This ways is reasonable because reserved tag
suppose to be ready any time.

Cc: David Milburn <dmilburn@redhat.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c | 3 ++-
 block/blk-mq.c     | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index c31c4a0478a5..aacf10decdbd 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -76,7 +76,8 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 			    struct sbitmap_queue *bt)
 {
-	if (!data->q->elevator && !hctx_may_queue(data->hctx, bt))
+	if (!data->q->elevator && !(data->flags & BLK_MQ_REQ_RESERVED) &&
+			!hctx_may_queue(data->hctx, bt))
 		return BLK_MQ_NO_TAG;
 
 	if (data->shallow_depth)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ccb500e38008..91cff275451d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1147,15 +1147,17 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
 	struct sbitmap_queue *bt = rq->mq_hctx->tags->bitmap_tags;
 	unsigned int tag_offset = rq->mq_hctx->tags->nr_reserved_tags;
 	int tag;
+	bool reserved = blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags,
+			rq->internal_tag);
 
 	blk_mq_tag_busy(rq->mq_hctx);
 
-	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
+	if (reserved) {
 		bt = rq->mq_hctx->tags->breserved_tags;
 		tag_offset = 0;
 	}
 
-	if (!hctx_may_queue(rq->mq_hctx, bt))
+	if (!reserved && !hctx_may_queue(rq->mq_hctx, bt))
 		return false;
 	tag = __sbitmap_queue_get(bt);
 	if (tag == BLK_MQ_NO_TAG)
-- 
2.25.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
