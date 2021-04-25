Return-Path: <SRS0=MVBk=JW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38B3C433ED
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 08:59:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4148C613B4
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 08:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4148C613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Bl+UdSqax0VpQAGohBiJvqnil2tooGol2z9z2XuxNkY=; b=RQZ3PEX4rlXSnqbdr4FGHVW1Q
	od0eR2t21hxHBWTk7NcfVMGQ0HM9JmwPP44Kw+obmADegs0Za0N6T+Oo6wY+/plT0lveLEnsPP4E6
	JiaGotyL/F1q3LVdriot5Cio1ikDbg8ADRskwrn2wqMbTRpgSk2/VbFBK++BhcsLLkcw44NRHvKWQ
	bKMhKeeO9Qcvoemzl7X/QCbsrVkJt7/riFOj2T3doKMv/qDvXZs26mnF37gt6YXihsuigTUkkEKGA
	Pu+v9GY6nw0Ar9W1mf9uBhW1VAIe4WU3hO+AKlLO9/0+Gnu1hNzqeTB6OA1dATOHtSILvQRdjaFdG
	F9N1OxC8w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1laabl-005Jx6-Gy; Sun, 25 Apr 2021 08:59:17 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laab8-005Jrh-1q
 for linux-nvme@desiato.infradead.org; Sun, 25 Apr 2021 08:58:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=nlKUIawhhdfke5e91nvF9IFytrIJPg/rQRLeCbz+53s=; b=EaiWHlI8DLIeZFx//Shb86glJh
 SKd/Tf3ivlp53UjRoepH4DMoC+xWxoKYKt+UQtgQ/7EtOG7gdxTeKPgTkgbeesGqmZhqS6Qkn7J2b
 MtyGs0s34rsW18WOir9oEXRLzgnriNUWylOY3mTgvmAb6VR/9fAF7Ky3gXQlnAD2qEth4IJNE01DE
 g9xi17WUzMOyZ1BFQJTqla3QtIutOc5J9dyIq+vyjIIgEYBpIYtSz6mXWpA1mkQs1CUjMR8mV+vgb
 e0n2NZre3GQj3MTlBE7iTLP4dgCHWjICMLAVEmAhS0BwGuRrjfmj3PupX1Zeg6U8uiYKm+MhCZYfd
 UesdmCLg==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laab5-00FMZ6-JO
 for linux-nvme@lists.infradead.org; Sun, 25 Apr 2021 08:58:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619341114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlKUIawhhdfke5e91nvF9IFytrIJPg/rQRLeCbz+53s=;
 b=ABeue2HGJuqycUxWpaNpotL06DTjpfyfEaCOTsrdYQGdErZuJVerb/4Nbvzq3IBsLc3QOU
 yB0GlF0e21W1s7JtpEVVcsR81k5OlA3JB9xrMlvStpFkCnIIimTfcwlGHPtEtvNf2Bmled
 0JykcRD/15LuMmrZ3usNmSELe5RYvJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-liBRZltwP2y6AS6-HBKHbA-1; Sun, 25 Apr 2021 04:58:31 -0400
X-MC-Unique: liBRZltwP2y6AS6-HBKHbA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F23F1898297;
 Sun, 25 Apr 2021 08:58:29 +0000 (UTC)
Received: from localhost (ovpn-13-143.pek2.redhat.com [10.72.13.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCA7F690F5;
 Sun, 25 Apr 2021 08:58:28 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, Khazhy Kumykov <khazhy@google.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/8] blk-mq: blk_mq_complete_request_locally
Date: Sun, 25 Apr 2021 16:57:50 +0800
Message-Id: <20210425085753.2617424-6-ming.lei@redhat.com>
In-Reply-To: <20210425085753.2617424-1-ming.lei@redhat.com>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_015835_727928_BAE11194 
X-CRM114-Status: GOOD (  13.14  )
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

Add blk_mq_complete_request_locally() for completing request via
blk_mq_tagset_busy_iter(), so that we can avoid request UAF related
with queue releasing, or request freeing.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 16 ++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 927189a55575..e3d1067b10c3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -681,6 +681,22 @@ void blk_mq_complete_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
+/**
+ * blk_mq_complete_request_locally - end I/O on a request locally
+ * @rq:		the request being processed
+ *
+ * Description:
+ *	Complete a request by calling the ->complete_rq directly,
+ *	and it is usually used in error handling via
+ *	blk_mq_tagset_busy_iter().
+ **/
+void blk_mq_complete_request_locally(struct request *rq)
+{
+	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
+	rq->q->mq_ops->complete(rq);
+}
+EXPORT_SYMBOL(blk_mq_complete_request_locally);
+
 static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
 	__releases(hctx->srcu)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2c473c9b8990..f630bf9e497e 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -511,6 +511,7 @@ void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 void blk_mq_complete_request(struct request *rq);
 bool blk_mq_complete_request_remote(struct request *rq);
+void blk_mq_complete_request_locally(struct request *rq);
 bool blk_mq_queue_stopped(struct request_queue *q);
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
 void blk_mq_start_hw_queue(struct blk_mq_hw_ctx *hctx);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
