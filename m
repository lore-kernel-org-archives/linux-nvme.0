Return-Path: <SRS0=DxE/=PW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0821BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 03:44:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B572660E05
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 03:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B572660E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a/Iu+Awx4uD/ZmNVkIS8P/nfTnq6b7jgA3CD5E++qsk=; b=QWzAMG1GTnusVvJ3pbNrMy7KnX
	zPjIEEb40/aLytojt99s66cs3xn60crFC0OrZZ9sL3MLjooqreQXN40H4FU2OynyZKu3nJ1pJJ2+p
	pscXNIkH00jweYGD8MPlyP8erATUVWzMTqb4G3e3sSCeYSizBQm3TeOR9rXowaC5WfOMqXsiKowGm
	Wmert3GRANOuIKuj5DCACdIW5bi51nxwaWX+LifitboAhvtlWv2FOu/LwShYXneTvQZEazvn6GtCD
	FOeIIjFgiuT4w5qsTFBg3oXMPCPQEZbQw4FgBCuLGCrFlNpDKoW11Ffv+mU3X/U3qjC3xtKUO8gRs
	AyfZHEuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mi7C0-003yot-Ux; Wed, 03 Nov 2021 03:44:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mi7Bx-003ynm-9f
 for linux-nvme@lists.infradead.org; Wed, 03 Nov 2021 03:44:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635911040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/Iu+Awx4uD/ZmNVkIS8P/nfTnq6b7jgA3CD5E++qsk=;
 b=O6Uo/NT7s+ySiVTGA2mLFLOS1WvDDrydXYtQO9Ipyaoz9oSzkZlzkvOKRGSF/146zIcAWf
 OPTy9QPSwEcqmJ+9rc0E9mcgmWjFcXikf+ptbcj8UCzKXS25F8zrcErOtzWA84Klgm3BAt
 Jp9ho/XhtsOE9cgaLHmvpTO7GdElkXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-DEHvRVNJOIunX7HtINWl7w-1; Tue, 02 Nov 2021 23:43:59 -0400
X-MC-Unique: DEHvRVNJOIunX7HtINWl7w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C790871805;
 Wed,  3 Nov 2021 03:43:58 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 076445BAFB;
 Wed,  3 Nov 2021 03:43:42 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/4] blk-mq: add one API for waiting until quiesce is done
Date: Wed,  3 Nov 2021 11:43:02 +0800
Message-Id: <20211103034305.3691555-2-ming.lei@redhat.com>
In-Reply-To: <20211103034305.3691555-1-ming.lei@redhat.com>
References: <20211103034305.3691555-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211102_204401_433691_8B130A97 
X-CRM114-Status: GOOD (  18.94  )
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
index 2a2c57c98bbd..9fe0677f03a2 100644
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


