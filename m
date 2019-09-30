Return-Path: <SRS0=mwZ5=XZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D942C32792
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Sep 2019 19:44:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C495224F2
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Sep 2019 19:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G7xVngIJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt0WJfeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C495224F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=skEa3dVrEWIhC5rTqkVehfMRQA7gFsGNpSNWgcl8awg=; b=G7xVngIJsCyYYU
	QiQufOvig4bPqO4ewolpzUkgD6eIugATn4IZGZb6Eqpb/dDdEZYJgFELGdWTXzkf6i4Jp3Fr4tIjD
	eH9GKZC4R0CU5iDR5AxlljOMr5OdodInAAdgvqi5SvgJTJxeViZuRmF2O9aWJdNeFrhIUj3KUw4FN
	hWTpisYKruBYq1szXHgx05U5/g2V4QbEb2rutSCGhppYjpuU6rzdAlQxM9W5gf/RqHcr8ruk2B5wV
	ZRT0ATXboeehWdJOvRHfS/oHmiQNIL3odpLh2mZSpU5BQXyO3d9bW52Hgkeck57V/7LZYNhomVgJw
	dy1d30yFH0E+fSDk7VKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iF1aj-0003Mj-HD; Mon, 30 Sep 2019 19:44:17 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iF1af-0003M5-Tr
 for linux-nvme@lists.infradead.org; Mon, 30 Sep 2019 19:44:15 +0000
Received: by mail-wr1-x444.google.com with SMTP id n14so12676910wrw.9
 for <linux-nvme@lists.infradead.org>; Mon, 30 Sep 2019 12:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+VdRyKsID9b2v30YDDuKBXdqqdZfrmc+wnK0aA6ys2s=;
 b=Nt0WJfeOzXeW00wOzqbE+37Jg4Z4xucKbjfUVUAhXWZFy88hrG2dOwq2+XU2p3IyS8
 3behcucPb6/fK42LtBhVmTuR7AZp0i1gp2Zn+Oy4+neURUlhUNekDf76G/gT1YFZi2Wd
 pNfdKEXQajhy4sjIeXYczs6gYUIfSAdU7rzRfFRy72cYfbWG7fdtSBKhC/37yaSq5PGA
 EfWzSHJCc6K1bgugKoRYNruqb1Zm5IERRdWRUJ487i7P66eNnQ/KVLkpy1Er5NKWXZ2J
 bDCBCDb7t+FOqMTcyLbIn4Klb8vhTynVKyfJ9JkVyJPD0cyysnZDbmEIpWhRjaVsLl0S
 bqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+VdRyKsID9b2v30YDDuKBXdqqdZfrmc+wnK0aA6ys2s=;
 b=D0VUoWkdAtUhpYLMt9IAUfYXfNq1FLNvLA2UjvHwot97X2s6BWE/gwIK7/lLTBAJuS
 o8ujtE/g3JCCv6cSvMMSJR0TKLSO1TsyEyf8NPPeBWUekEWn0XZERGvx7AVTUalp8GJe
 NjFiLgynwwnwrc0WsVPBLIhKAeQzKW8Unf+ACjaM+gi72PCVVGQd0A5gR4FhzKcYP6s1
 iAaZ6DtoFICH+TkOTNBDJemn3E8Opl1KpGvJ6T60sZEgDkTcgRuDBw7yyjrmGsDhvkUE
 v6M7EPxeZB7X9xRfOIUU85v+7VJLR0e/+YG9i0bFuOA+mMdCM81ikjaxD3UnmANbt6uP
 77eg==
X-Gm-Message-State: APjAAAWUeakZ5wvWtXG0D8qmNtXaTiZZOQQnR4woDAQaRCuXbX82gobm
 HODyL3BMgyLJiSD6HlPxQx8=
X-Google-Smtp-Source: APXvYqxnSW+xX+bFR+TsEjN44345akbJBvfZC247YdZWjvCSTXUV3EN6thNmA7xDhTC9EABPNaS0Cw==
X-Received: by 2002:adf:f5cc:: with SMTP id k12mr14142976wrp.278.1569872650658; 
 Mon, 30 Sep 2019 12:44:10 -0700 (PDT)
Received: from localhost.localdomain ([109.126.142.9])
 by smtp.gmail.com with ESMTPSA id r28sm14022113wrr.94.2019.09.30.12.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 12:44:09 -0700 (PDT)
From: "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, nbd@other.debian.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH v2 1/1] blk-mq: Inline request status checkers
Date: Mon, 30 Sep 2019 22:43:57 +0300
Message-Id: <e6fc239412811140c83de906b75689530661f65d.1569872122.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <1cd320dad54bd78cb6721f7fe8dd2e197b9fbfa2.1569830796.git.asml.silence@gmail.com>
References: <1cd320dad54bd78cb6721f7fe8dd2e197b9fbfa2.1569830796.git.asml.silence@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190930_124413_992090_4DEE2A8C 
X-CRM114-Status: GOOD (  14.48  )
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
Cc: Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Pavel Begunkov <asml.silence@gmail.com>

blk_mq_request_completed() and blk_mq_request_started() are
short, inline it.

v2: by Christoph suggestion inline them by hand

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq-tag.c       |  4 ++--
 block/blk-mq.c           | 14 +-------------
 block/blk-mq.h           |  9 ---------
 drivers/block/nbd.c      |  2 +-
 drivers/nvme/host/core.c |  2 +-
 include/linux/blk-mq.h   | 10 ++++++++--
 6 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 008388e82b5c..32d63b607391 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -282,7 +282,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	 * test and set the bit before assining ->rqs[].
 	 */
 	rq = tags->rqs[bitnr];
-	if (rq && blk_mq_request_started(rq))
+	if (rq && blk_mq_rq_state(rq) != MQ_RQ_IDLE)
 		return iter_data->fn(rq, iter_data->data, reserved);
 
 	return true;
@@ -360,7 +360,7 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
 {
 	unsigned *count = data;
 
-	if (blk_mq_request_completed(rq))
+	if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
 		(*count)++;
 	return true;
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 29275f5a996f..a30f108d96be 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -663,18 +663,6 @@ bool blk_mq_complete_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
-int blk_mq_request_started(struct request *rq)
-{
-	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
-}
-EXPORT_SYMBOL_GPL(blk_mq_request_started);
-
-int blk_mq_request_completed(struct request *rq)
-{
-	return blk_mq_rq_state(rq) == MQ_RQ_COMPLETE;
-}
-EXPORT_SYMBOL_GPL(blk_mq_request_completed);
-
 void blk_mq_start_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
@@ -718,7 +706,7 @@ static void __blk_mq_requeue_request(struct request *rq)
 	trace_block_rq_requeue(q, rq);
 	rq_qos_requeue(q, rq);
 
-	if (blk_mq_request_started(rq)) {
+	if (blk_mq_rq_state(rq) != MQ_RQ_IDLE) {
 		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 		rq->rq_flags &= ~RQF_TIMED_OUT;
 		if (q->dma_drain_size && blk_rq_bytes(rq))
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 32c62c64e6c2..eaaca8fc1c28 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -128,15 +128,6 @@ extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_release(struct request_queue *q);
 
-/**
- * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
- * @rq: target request.
- */
-static inline enum mq_rq_state blk_mq_rq_state(struct request *rq)
-{
-	return READ_ONCE(rq->state);
-}
-
 static inline struct blk_mq_ctx *__blk_mq_get_ctx(struct request_queue *q,
 					   unsigned int cpu)
 {
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ac07e8c94c79..71a13a65c9d1 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -696,7 +696,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 	if (hwq < nbd->tag_set.nr_hw_queues)
 		req = blk_mq_tag_to_rq(nbd->tag_set.tags[hwq],
 				       blk_mq_unique_tag_to_tag(tag));
-	if (!req || !blk_mq_request_started(req)) {
+	if (!req || !blk_mq_rq_state(req) != MQ_RQ_IDLE) {
 		dev_err(disk_to_dev(nbd->disk), "Unexpected reply (%d) %p\n",
 			tag, req);
 		return ERR_PTR(-ENOENT);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 108f60b46804..3a54677dc5ad 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -292,7 +292,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 				"Cancelling I/O %d", req->tag);
 
 	/* don't abort one completed request */
-	if (blk_mq_request_completed(req))
+	if (blk_mq_rq_state(req) == MQ_RQ_COMPLETE)
 		return true;
 
 	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0bf056de5cc3..e993ce19a8ec 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -301,9 +301,15 @@ static inline u16 blk_mq_unique_tag_to_tag(u32 unique_tag)
 	return unique_tag & BLK_MQ_UNIQUE_TAG_MASK;
 }
 
+/**
+ * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
+ * @rq: target request.
+ */
+static inline enum mq_rq_state blk_mq_rq_state(struct request *rq)
+{
+	return READ_ONCE(rq->state);
+}
 
-int blk_mq_request_started(struct request *rq);
-int blk_mq_request_completed(struct request *rq);
 void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, blk_status_t error);
 void __blk_mq_end_request(struct request *rq, blk_status_t error);
-- 
2.23.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
