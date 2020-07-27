Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234ADC433EA
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 22:07:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4FEB2072E
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 22:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GBu6Ed+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FEB2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zZeMa5qxZckZoywK3tYBV/nfg4PVIZoNhYbCIrQVzz8=; b=GBu6Ed+XwDXyu2PKlYgGktqtF
	RvbtXPCQhYsGOU7HeET4XCyX/kfogZS+neMExYXo0RNiD+gflC9/aomxnu39xCjVpvJYqrv9h3Gwl
	klL4d9UMjragYpYTqPDVgpr8Uer2W5c8neAFpYSWjHVGnyh6utey8emDQeplFY1Xl0dHg7NISnDU4
	V28qG9FDylM+CMALISCyfTlgtCSICU+W+r/XoCCc38Rnh8/VboOPxvxi9+xu801jO1pp9BY6kLa3M
	EbBYgzbWnvzUXcnhPN0S3dIIrk5BiYJw2gFUES7C4qVGYeMsBA7cIpnM2hxBTXfymKZnPNd+BEPfT
	YTRlg6lpQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0BHJ-0005Yy-Ia; Mon, 27 Jul 2020 22:07:25 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0BHG-0005Xv-JG
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 22:07:23 +0000
Received: by mail-pf1-f194.google.com with SMTP id s26so9843057pfm.4
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 15:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KRnnbyunnUYJdQAMA5PZpcygTLScjixLg9gs4Fc8mvw=;
 b=gO3zOMjvKk2yb0GABnpzCJnqQCnSiEQA9Th1aQ3BKc8GueteUjjWNDkpTI5TwmPQ6L
 GXvcv1I49xCoKiSXOJOyc4r4TcguznvglL5w7D66/T4xHbvfVUgJ7vfsbMK4qZh9Wuud
 sYmgp59hM4HXvfteWWKRRhWcEl/CuQwFydKGd8qyRR+1VIMWn6ebqqO7zclmxW3+7Ita
 GS5/RUhQDyLdX4zvCYjIkon6I4UzKtBdbIGvCYFD/S/+amQVg+e5lB2IPheAsRJlvXlU
 tSDrdjmVqQdK7fyyNNLmKKcFEG+pRE2khCwdcci0JaWySDqBScB3sX9T1SougoZNij96
 r/SQ==
X-Gm-Message-State: AOAM5308gsknHFJnCYSSsfw3oLKlWY9picKafM37p4MBP8A6a2sXGDCt
 aE4Nz1ZMdq3NeDb0gfnhI4zbPQwG
X-Google-Smtp-Source: ABdhPJx/0PHG/gaghPBGYo0zHRdVVbnEgP5ONLFNVKT/KxpPSy+7whwwLIC4SWqEnzoD1v+uYfUttg==
X-Received: by 2002:a63:e24d:: with SMTP id y13mr22035091pgj.248.1595887641032; 
 Mon, 27 Jul 2020 15:07:21 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id s4sm2309519pfh.128.2020.07.27.15.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 15:07:20 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 1/2] blk-mq: add async quiesce interface
Date: Mon, 27 Jul 2020 15:07:16 -0700
Message-Id: <20200727220717.278116-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727220717.278116-1-sagi@grimberg.me>
References: <20200727220717.278116-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_180722_663704_BD100F0A 
X-CRM114-Status: GOOD (  18.32  )
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
Cc: linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>,
 Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Drivers that may have to quiesce a large amount of request queues at once
(e.g. controller or adapter reset). These drivers would benefit from an
async quiesce interface such that the can trigger quiesce asynchronously
and wait for all in parallel.

This leaves the synchronization responsibility to the driver, but adds
a convenient interface to quiesce async and wait in a single pass.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-mq.c         | 46 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  4 ++++
 2 files changed, 50 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index abcf590f6238..d913924117d2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -209,6 +209,52 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
+void blk_mq_quiesce_queue_async(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+	int rcu = false;
+
+	blk_mq_quiesce_queue_nowait(q);
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), GFP_KERNEL);
+		if (!hctx->rcu_sync) {
+			/* fallback to serial rcu sync */
+			if (hctx->flags & BLK_MQ_F_BLOCKING)
+				synchronize_srcu(hctx->srcu);
+			else
+				rcu = true;
+		} else {
+			init_completion(&hctx->rcu_sync->completion);
+			init_rcu_head(&hctx->rcu_sync->head);
+			if (hctx->flags & BLK_MQ_F_BLOCKING)
+				call_srcu(hctx->srcu, &hctx->rcu_sync->head,
+					wakeme_after_rcu);
+			else
+				call_rcu(&hctx->rcu_sync->head,
+					wakeme_after_rcu);
+		}
+	}
+	if (rcu)
+		synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
+
+void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		if (!hctx->rcu_sync)
+			continue;
+		wait_for_completion(&hctx->rcu_sync->completion);
+		destroy_rcu_head(&hctx->rcu_sync->head);
+	}
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async_wait);
+
 /**
  * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
  * @q: request queue.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 23230c1d031e..7213ce56bb31 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -5,6 +5,7 @@
 #include <linux/blkdev.h>
 #include <linux/sbitmap.h>
 #include <linux/srcu.h>
+#include <linux/rcupdate_wait.h>
 
 struct blk_mq_tags;
 struct blk_flush_queue;
@@ -170,6 +171,7 @@ struct blk_mq_hw_ctx {
 	 */
 	struct list_head	hctx_list;
 
+	struct rcu_synchronize	*rcu_sync;
 	/**
 	 * @srcu: Sleepable RCU. Use as lock when type of the hardware queue is
 	 * blocking (BLK_MQ_F_BLOCKING). Must be the last member - see also
@@ -532,6 +534,8 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
+void blk_mq_quiesce_queue_async(struct request_queue *q);
+void blk_mq_quiesce_queue_async_wait(struct request_queue *q);
 
 unsigned int blk_mq_rq_cpu(struct request *rq);
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
