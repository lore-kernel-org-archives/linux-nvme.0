Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A08C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 08:53:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6415C20936
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 08:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QhiDVguU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSLq76+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6415C20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eP6AJlFasarA31T5MTZrao3HKr4BOfR1jYB8gmrb39k=; b=QhiDVguU0S5cPeYSwtnzmbC63
	7VDHwSZ+WUTHRf/yhLF/7sVcAufDBIuVUZ1citHkXzWRc7ZMwoqDwQ4NQSWP++iujUJeqUqhzmQB+
	jqnTLPM+YTjMYeqOVZpW8BGHFcgGHCmRlCMwAh2wtQuY0/0R6JPTMF4q2aW8nNLbs94eV8gMKwNUz
	j5jzSe8doSynmcc+oqwkzhD1WaUP5Jqs4e4WRZHKzZ83ch5U3Wjsr1jfqCGF2wP/hEqGoBwSJojSg
	a64pnn9PdDpotKqucThYS7Of3qltTBDUMtO0PerStX256qLAKgTr6GCNYLLh5CUNeOws0FLJmX3BN
	xvsYJIXSA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUnOf-00030G-FC; Tue, 20 Oct 2020 08:53:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUnOc-0002zD-K5
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 08:53:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603184010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4oDUZuYctKO2IhywzwXf/gS+GjO9UXFqR9rKJje1jxs=;
 b=LSLq76+Zn+Xa0R/y9GLsM7QLlyjkHRF573qD03hnhuXmp+4KyrrK+9ACDc0EM86X17TQ8h
 EniYeDmp2yMF+Rjdf50/ue1HrwKbtpPKZu4N6qp7i0Tomx/YRP4T3qlZRC8kQN3DSaxw7h
 +p7gDkrP/JMpjjE8otvU4EbbAPaXo98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-wvrevCDwPfS8odjO8FIEtQ-1; Tue, 20 Oct 2020 04:53:26 -0400
X-MC-Unique: wvrevCDwPfS8odjO8FIEtQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1DFA1006C8B;
 Tue, 20 Oct 2020 08:53:24 +0000 (UTC)
Received: from localhost (ovpn-12-164.pek2.redhat.com [10.72.12.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01FDB27CDC;
 Tue, 20 Oct 2020 08:53:17 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH V2 1/4] blk-mq: check rq->state explicitly in
 blk_mq_tagset_count_completed_rqs
Date: Tue, 20 Oct 2020 16:52:58 +0800
Message-Id: <20201020085301.1553959-2-ming.lei@redhat.com>
In-Reply-To: <20201020085301.1553959-1-ming.lei@redhat.com>
References: <20201020085301.1553959-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_045330_687522_6ADC94ED 
X-CRM114-Status: GOOD (  16.57  )
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
Cc: Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

blk_mq_tagset_count_completed_rqs() is called from
blk_mq_tagset_wait_completed_request() for draining requests being
completed remotely. What we need to do is to make sure that request->state
is switched to non-MQ_RQ_COMPLETE.

So check MQ_RQ_COMPLETE explicitly in blk_mq_tagset_count_completed_rqs().

Meantime mark flush request as IDLE in its .end_io() for aligning to
end normal request because flush request may stay in inflight tags in case
of !elevator, so we need to change its state into IDLE.

Cc: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c  | 2 ++
 block/blk-mq-tag.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 53abb5c73d99..f6a07ae533c9 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -231,6 +231,8 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 		return;
 	}
 
+	WRITE_ONCE(flush_rq->state, MQ_RQ_IDLE);
+
 	if (fq->rq_status != BLK_STS_OK)
 		error = fq->rq_status;
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9c92053e704d..10ff8968b93b 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -367,7 +367,7 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
 {
 	unsigned *count = data;
 
-	if (blk_mq_request_completed(rq))
+	if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
 		(*count)++;
 	return true;
 }
-- 
2.25.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
