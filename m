Return-Path: <SRS0=oO1v=DX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67656C43457
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 14:28:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E797920866
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 14:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iERDPA6l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDJvM29Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E797920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=p7bphiRhZxZsPJWt6Uy5d+GXExztnsLGGhsxNMJIq6U=; b=iERDPA6l1H8GyqTnOFoNjqiw8
	ms2AImwurS6kZu2lDauOKIAS6NjdGEw3oYh6RPFcsaODOHIx/dQjd2frmgC/H5Ti6TZtFsr7SvlKd
	Bk7NaKAPdU1izzRMiAWNF69HF3vQuqG/DWxtVt7UDEzkEdRdube1FtGExb/RWm4wXnC0YU/ABFfE7
	15OZoiMwp2VQc0aTa5B+p5VlWRZ1DepWR76csIyOdsMW7a4lB2ItmJ5AhFWtg0Vi3FeXo7JiedNu0
	le2ddRRekGyp27NH6ZyqmLw8ZN1KDqQf76gYd3Co9bPBkROtPKUANf4Q1+sowMjPFmE9Jzj+oqaHg
	sb2PoxCyw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTQiv-0006eG-9j; Fri, 16 Oct 2020 14:28:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kTQis-0006de-SA
 for linux-nvme@lists.infradead.org; Fri, 16 Oct 2020 14:28:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602858526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SquF7vcULodKmU2T8C8jXbF8cJYghVDY1WRl/3cGs0s=;
 b=SDJvM29Y1yObPNyCyGQ9WBn72TGd/j2L6A6l5BPyzlslffMQkpEv/hG7JbWRqQg7r2tATu
 QgnVvrnNmsHn3odecLji1U4gisJw2NHq2z/KVfZVFbtsnumbbO3k/1zDahG0Dklc1Cxn3Z
 2sYaqUtlpkIw41B5FtoTDF98k+XLaoA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-rerpMqs8OXaOY1Rgc5ZcNA-1; Fri, 16 Oct 2020 10:28:44 -0400
X-MC-Unique: rerpMqs8OXaOY1Rgc5ZcNA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 054C057085;
 Fri, 16 Oct 2020 14:28:43 +0000 (UTC)
Received: from localhost (ovpn-12-93.pek2.redhat.com [10.72.12.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E7CE6EF55;
 Fri, 16 Oct 2020 14:28:36 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/4] blk-mq: think request as completed if it isn't IN_FLIGHT.
Date: Fri, 16 Oct 2020 22:28:09 +0800
Message-Id: <20201016142811.1262214-3-ming.lei@redhat.com>
In-Reply-To: <20201016142811.1262214-1-ming.lei@redhat.com>
References: <20201016142811.1262214-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201016_102846_985294_6CC3DF67 
X-CRM114-Status: GOOD (  14.45  )
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

MQ_RQ_COMPLETE is one transient state, because the .complete callback
ends or requeues this request, then the request state is updated to
IDLE.

blk_mq_request_completed() is often used by driver for avoiding
double completion with help of driver's specific sync approach. Such as,
NVMe TCP calls blk_mq_request_completed() in its timeout handler
and abort handler for avoiding double completion. If request's state
is updated to IDLE in either one, another code path may think this
request as not completed, and will complete it one more time. Then
double completion is triggered.

Yi reported[1] that 'refcount_t: underflow; use-after-free' of rq->ref
is triggered in blktests(nvme/012) on one very slow machine.

Fixes this issue by thinking request as completed if its state becomes
not IN_FLIGHT.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Cc: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blk-mq.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b23eeca4d677..9a0c1f8ac42d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -486,9 +486,15 @@ static inline int blk_mq_request_started(struct request *rq)
 	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
 }
 
+/*
+ * It is often called in abort handler for avoiding double completion,
+ * MQ_RQ_COMPLETE is one transient state because .complete callback
+ * may end or requeue this request, in either way the request is marked
+ * as IDLE. So return true if this request's state become not IN_FLIGHT.
+ */
 static inline int blk_mq_request_completed(struct request *rq)
 {
-	return blk_mq_rq_state(rq) == MQ_RQ_COMPLETE;
+	return blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT;
 }
 
 void blk_mq_start_request(struct request *rq);
-- 
2.25.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
