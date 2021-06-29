Return-Path: <SRS0=UYep=LX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A82C11F66
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 07:50:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22C661DBC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 07:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22C661DBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8UYB9zNIZswnz+TPAFagaPISP9vypPIVg1bG5p8cOEU=; b=d3gKgvf1kC680b
	lYAN/kQr8zYoszB2WmmU7j1oYXJtJd37iVppSgPOQmWMK4YiFXgHSmKsXAk1DrjFVKBBkdrQOA116
	uHO+PQLV7aqerqM9cgJa3CQap2KkfhPzkWwsFCkwOdqINUPcrltxgu1Qc+ZehDV8V7D86kKPv9Npw
	e03R/GTokz9JtHPHze8ZEXVPOC+Sff7/y724mBlYIS32k6U2YKFF7o+otBVTr8NhCLGjJnOg+K+B2
	FCnJlb0CjsXzaHEtSXbTIdjiBPeBmw5qh9pZgUg8oNX5xlCb1pOOR8psQ+qw2cYIXvkry49kvuBpU
	r4WktuN3IheO7A6nQd2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ly8Vv-00A6KL-KJ; Tue, 29 Jun 2021 07:50:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ly8Vj-00A6Gg-DY
 for linux-nvme@lists.infradead.org; Tue, 29 Jun 2021 07:50:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624953022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/sK6AunQ5QlMOQJ8G9+eFl+B0+tOEEvgGaeTW3pvcl4=;
 b=gMuRMf8MlAto/0EwaeaKa72pUeTCkySbuR1zgkIHb9Ic2bu6FndjrVfmmGzRLWEy09+XHt
 t8RFfBdobaJgcFAFngncQu8Pk5FR6nIL/00aPKwb40nv+V9Zx/0IXfUrnzCBPuueyLFWfm
 v6Ip1qsky2RYAG25Szb4MFZ9jUrqQa0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-sVw30hPJP-C_OQdRxEiNeQ-1; Tue, 29 Jun 2021 03:50:18 -0400
X-MC-Unique: sVw30hPJP-C_OQdRxEiNeQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7796610B7464;
 Tue, 29 Jun 2021 07:50:17 +0000 (UTC)
Received: from localhost (ovpn-13-8.pek2.redhat.com [10.72.13.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 215B260877;
 Tue, 29 Jun 2021 07:50:12 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 John Garry <john.garry@huawei.com>
Subject: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't use
 managed irq
Date: Tue, 29 Jun 2021 15:49:50 +0800
Message-Id: <20210629074951.1981284-2-ming.lei@redhat.com>
In-Reply-To: <20210629074951.1981284-1-ming.lei@redhat.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210629_005023_590237_96A30904 
X-CRM114-Status: GOOD (  20.03  )
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

hctx is deactivated when all CPU in hctx->cpumask become offline by
draining all requests originated from this hctx and moving new
allocation to active hctx. This way is for avoiding inflight IO when
the managed irq is shutdown.

Some drivers(nvme fc, rdma, tcp, loop) doesn't use managed irq, so
they needn't to deactivate hctx. Also, they are the only user of
blk_mq_alloc_request_hctx() which is used for connecting io queue.
And their requirement is that the connect request can be submitted
via one specified hctx on which all CPU in its hctx->cpumask may have
become offline.

Address the requirement for nvme fc/rdma/loop, so the reported kernel
panic on the following line in blk_mq_alloc_request_hctx() can be fixed.

	data.ctx = __blk_mq_get_ctx(q, cpu)

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: Wen Xiong <wenxiong@us.ibm.com>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 6 +++++-
 include/linux/blk-mq.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index df5dc3b756f5..74632f50d969 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -494,7 +494,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	data.hctx = q->queue_hw_ctx[hctx_idx];
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
-	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
+	cpu = cpumask_first(data.hctx->cpumask);
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	if (!q->elevator)
@@ -2570,6 +2570,10 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
 		return 0;
 
+	/* Controller doesn't use managed IRQ, no need to deactivate hctx */
+	if (hctx->flags & BLK_MQ_F_NOT_USE_MANAGED_IRQ)
+		return 0;
+
 	/*
 	 * Prevent new request from being allocated on the current hctx.
 	 *
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 21140132a30d..600c5dd1a069 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -403,6 +403,7 @@ enum {
 	 */
 	BLK_MQ_F_STACKING	= 1 << 2,
 	BLK_MQ_F_TAG_HCTX_SHARED = 1 << 3,
+	BLK_MQ_F_NOT_USE_MANAGED_IRQ = 1 << 4,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
 	BLK_MQ_F_NO_SCHED	= 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
