Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D08DC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/pPKkXtT6Xrl9aqdgr4UGNl+ZJEtLSBkw/CIGk0Ps8Y=; b=LrbG9V2uvqv0vxNQ2IaIyo7QoC
	D6ScSeEJ36uVIKe561q4uNi0aW9hTauTHKgceo5CFRkfwXMqFCx9wbZ+ZgLH9VQKAyNrRtB/dqnV4
	M2NU7lZ6KuXhw69J+7kM/n+w9NmtVVytLk7y7xO2HZanABBZxvx87AcuwXpq4bZJ6qv3wqtKTIhC5
	wqY5PvOJFhFi4rq4zHMWWVO9FN+DRBCZU4NHTHmYLw2cODPBzVGQviT0MEV2kaboOFFc72DCFan4M
	ZuhIMPmj2NA94FTMiM64k5PqdXU7qPHnDhjM9Y2w3Sedahne9mDwgc8yEyydW5AEd2BmqkjFOyInp
	ff/EouHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxtH4-006TkX-S3; Thu, 16 Dec 2021 16:06:30 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxtGI-006TNf-13
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 16:05:44 +0000
Received: by mail-io1-xd2d.google.com with SMTP id m9so35918607iop.0
 for <linux-nvme@lists.infradead.org>; Thu, 16 Dec 2021 08:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/pPKkXtT6Xrl9aqdgr4UGNl+ZJEtLSBkw/CIGk0Ps8Y=;
 b=hrAibA8VCiRbTVdDg+0x+InGlOJ+7hx7X3m+HVrRE6NeGaojnjD2KfBEJAt57Bx4kM
 ACupiwLU2vUmauKIDN301FUJJ6n1BgnD02odN8w3JnW7LCGe5nmxQDPO273GM4btJjUX
 V1FopdaIX6h0oB3RIpJX+b7FoyBH4NuoiYCF5pdu9KIJKIsQAk4iCep/Q66gGjd76o2a
 UIihO0OWoyCB2n2zPJ1YKWbBZhvMd420Jj3btrYZtg9ZwebXjibml4Gj9S3+5e4tpSBT
 wpX/Q6ij0l9dTKlSmI1nrvWocgsVnUXDiKwRHT32LoOmXssog1YLnFfkefG6El7MMS0Q
 RzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/pPKkXtT6Xrl9aqdgr4UGNl+ZJEtLSBkw/CIGk0Ps8Y=;
 b=zlgbIfgKfw6bI8Q62/6Qox78bd9gDfwr+qWkoSt0ihTu2Lbu0ULlLgAJxVIQIe8A6C
 BiKimuI/P5oNVGJgFIyhr9b34+bOS/rPY0cyJ9vv2HqzMlbPzj8DZSgBG9QW3Cw1mJqN
 ltXU2Vq9Roc622j0KPXZ8hXoxpd8uHrlTiNvKMXcKwpSD0VGj4qr+ZiKcxjMYoA6b4f4
 6gji83VNF1BwLTyFu7Gt6Cf6BsUJv549v8+dg00Lzq/rq/SPDwXT4JWt/tvt6Xlbts05
 rPLcxAOsFktqjYu4U+upb3u6V1VG7TeGPevi7CJzBopQeH7GCoi8yRAasLW7XGp2Ajm6
 ySaw==
X-Gm-Message-State: AOAM531zlugTeI1oUVopGURkBrtaLzWlYAq36PDIoBbQt2FReTks4YjN
 pfcUHyejhPge9nUBH5DIrHFWIQ==
X-Google-Smtp-Source: ABdhPJyZvGZ7Csc3Ozp6Tn4H9lRpoYb6zejMLBe6rUw9wqFXCf+CxyyNi5MRqbS6MX2EEwjVvOZdiQ==
X-Received: by 2002:a05:6638:2055:: with SMTP id
 t21mr10015876jaj.90.1639670741326; 
 Thu, 16 Dec 2021 08:05:41 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id s9sm3237155ild.14.2021.12.16.08.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Dec 2021 08:05:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/4] block: add mq_ops->queue_rqs hook
Date: Thu, 16 Dec 2021 09:05:34 -0700
Message-Id: <20211216160537.73236-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216160537.73236-1-axboe@kernel.dk>
References: <20211216160537.73236-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_080542_101167_94FFC83F 
X-CRM114-Status: GOOD (  22.14  )
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

If we have a list of requests in our plug list, send it to the driver in
one go, if possible. The driver must set mq_ops->queue_rqs() to support
this, if not the usual one-by-one path is used.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         | 26 +++++++++++++++++++++++---
 include/linux/blk-mq.h |  8 ++++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 75154cc788db..51991232824a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2553,6 +2553,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	struct blk_mq_hw_ctx *this_hctx;
 	struct blk_mq_ctx *this_ctx;
+	struct request *rq;
 	unsigned int depth;
 	LIST_HEAD(list);
 
@@ -2561,7 +2562,28 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	plug->rq_count = 0;
 
 	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
-		struct request_queue *q = rq_list_peek(&plug->mq_list)->q;
+		struct request_queue *q;
+
+		rq = rq_list_peek(&plug->mq_list);
+		q = rq->q;
+
+		/*
+		 * Peek first request and see if we have a ->queue_rqs() hook.
+		 * If we do, we can dispatch the whole plug list in one go. We
+		 * already know at this point that all requests belong to the
+		 * same queue, caller must ensure that's the case.
+		 *
+		 * Since we pass off the full list to the driver at this point,
+		 * we do not increment the active request count for the queue.
+		 * Bypass shared tags for now because of that.
+		 */
+		if (q->mq_ops->queue_rqs &&
+		    !(rq->mq_hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
+			blk_mq_run_dispatch_ops(q,
+				q->mq_ops->queue_rqs(&plug->mq_list));
+			if (rq_list_empty(plug->mq_list))
+				return;
+		}
 
 		blk_mq_run_dispatch_ops(q,
 				blk_mq_plug_issue_direct(plug, false));
@@ -2573,8 +2595,6 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	this_ctx = NULL;
 	depth = 0;
 	do {
-		struct request *rq;
-
 		rq = rq_list_pop(&plug->mq_list);
 
 		if (!this_hctx) {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 772f8f921526..550996cf419c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -492,6 +492,14 @@ struct blk_mq_ops {
 	 */
 	void (*commit_rqs)(struct blk_mq_hw_ctx *);
 
+	/**
+	 * @queue_rqs: Queue a list of new requests. Driver is guaranteed
+	 * that each request belongs to the same queue. If the driver doesn't
+	 * empty the @rqlist completely, then the rest will be queued
+	 * individually by the block layer upon return.
+	 */
+	void (*queue_rqs)(struct request **rqlist);
+
 	/**
 	 * @get_budget: Reserve budget before queue request, once .queue_rq is
 	 * run, it is driver's responsibility to release the
-- 
2.34.1


