Return-Path: <SRS0=GOb3=P4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F73C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 07:12:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798A861156
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 07:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 798A861156
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/LFoXX5nM/cJctvoZ+y0b85oe33+SISHRqi7zfTBt/k=; b=pcz26wjv7T0DusRmEq2Q04YAXJ
	dtTxTg0WYiIB9eyK0SXP29HVQTer5tG6CBEKVHLIjzgAgmED9+nTuhgSYtdzYzAwC4ksW+rQNbjMv
	L7MMcWChgkp1c5tJhuDkCdZ4MxPkopJ2ZoSvivxyynoGtRJkZWSlD/hfS0a6ty3tDh6GL9dn+bITg
	wS9i+zh14dKbqz38SU1QOhiixVg+N2c/+caxL6X2MxaL86VrJsmUVRYifPaGO3BKVIDn0RD6eFdSO
	Rk3DR70uUgdGSOd4jpC1wYmgxdaljRxXQna0Ulr3XVb3iGRIg/L1ifhkMe3RXA+TAgjVpBmhqx18e
	An/MR2MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkLJ0-000qA2-Vw; Tue, 09 Nov 2021 07:12:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkLIy-000q9H-CQ
 for linux-nvme@lists.infradead.org; Tue, 09 Nov 2021 07:12:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636441947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/LFoXX5nM/cJctvoZ+y0b85oe33+SISHRqi7zfTBt/k=;
 b=aNxPKyRza96C6Skh1+jehxdrD82HyVrH4m+H1Bdjf6lk8HnIKUkTA+BULQqZ6ijnj6QMvi
 KW+XWEIkexR4hKClu9lOa1LaK0hWK9YCUoK9LYa7WUjxMMbW4KBfx2fkO/rryyT0Dkx8cz
 xm0l63y3TgDfQ68yJUf954IhOEfNWeg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-27k91yZRM_2NoXuBWNHqdg-1; Tue, 09 Nov 2021 02:12:21 -0500
X-MC-Unique: 27k91yZRM_2NoXuBWNHqdg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73F898799EB;
 Tue,  9 Nov 2021 07:12:20 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E21AB5F4F5;
 Tue,  9 Nov 2021 07:12:05 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/4] blk-mq: add one API for waiting until quiesce is done
Date: Tue,  9 Nov 2021 15:11:41 +0800
Message-Id: <20211109071144.181581-2-ming.lei@redhat.com>
In-Reply-To: <20211109071144.181581-1-ming.lei@redhat.com>
References: <20211109071144.181581-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211108_231228_520879_96792040 
X-CRM114-Status: GOOD (  18.91  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Some drivers(NVMe, SCSI) need to call quiesce and unquiesce in pair, but it
is hard to switch to this style, so these drivers need one atomic flag for
helping to balance quiesce and unquiesce.

When quiesce is in-progress, the driver still needs to wait until
the quiesce is done, so add API of blk_mq_wait_quiesce_done() for
these drivers.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 28 ++++++++++++++++++++--------
 include/linux/blk-mq.h |  1 +
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6358131cfc28..629cf421417f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -251,22 +251,18 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
 /**
- * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
+ * blk_mq_wait_quiesce_done() - wait until in-progress quiesce is done
  * @q: request queue.
  *
- * Note: this function does not prevent that the struct request end_io()
- * callback function is invoked. Once this function is returned, we make
- * sure no dispatch can happen until the queue is unquiesced via
- * blk_mq_unquiesce_queue().
+ * Note: it is driver's responsibility for making sure that quiesce has
+ * been started.
  */
-void blk_mq_quiesce_queue(struct request_queue *q)
+void blk_mq_wait_quiesce_done(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int i;
 	bool rcu = false;
 
-	blk_mq_quiesce_queue_nowait(q);
-
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->flags & BLK_MQ_F_BLOCKING)
 			synchronize_srcu(hctx->srcu);
@@ -276,6 +272,22 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 	if (rcu)
 		synchronize_rcu();
 }
+EXPORT_SYMBOL_GPL(blk_mq_wait_quiesce_done);
+
+/**
+ * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
+ * @q: request queue.
+ *
+ * Note: this function does not prevent that the struct request end_io()
+ * callback function is invoked. Once this function is returned, we make
+ * sure no dispatch can happen until the queue is unquiesced via
+ * blk_mq_unquiesce_queue().
+ */
+void blk_mq_quiesce_queue(struct request_queue *q)
+{
+	blk_mq_quiesce_queue_nowait(q);
+	blk_mq_wait_quiesce_done(q);
+}
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
 
 /*
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8682663e7368..2949d9ac7484 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -798,6 +798,7 @@ void blk_mq_start_hw_queues(struct request_queue *q);
 void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
 void blk_mq_quiesce_queue(struct request_queue *q);
+void blk_mq_wait_quiesce_done(struct request_queue *q);
 void blk_mq_unquiesce_queue(struct request_queue *q);
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
-- 
2.31.1


