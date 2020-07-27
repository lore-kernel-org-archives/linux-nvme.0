Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44600C433EA
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 23:10:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EDAE20729
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 23:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DB6GWF0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDAE20729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cSpVr6ooooHFWH2h5cQuA8RIbuGw/ECr5DWZPLMGeXg=; b=DB6GWF0zdHxjU3jpL5NgaEBXG
	ub7qU78J8ISux2nCB7cvxkFJrsZIsgmVvtQyxUJDc004m+fJex2TBpfGQeZIjFx+bQ6AbY7g0yb9S
	9gXOq3OvSFtqLXJY+nlYaUiNsm/fWjfz4UgD/HJMS05JRPo42oJR91Yzfq/ab5cU4oWkI0dvHyLoO
	odPvqoZJjbgcdSesyGp3Q24uXnsTMqX3o+cSTQHzZ+S8h9PpCkwX9RZcY5BUqXlveOL4zmccHAdVH
	oXXlQCjOjfUc9AOF7uM+VHs/S4tyZYfoiGstN21opAs8M3yBI+wUtb178n6RP+jNTvtEBb7Rxy77n
	Hmt53Q/ow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0CGO-0006Dw-Fs; Mon, 27 Jul 2020 23:10:32 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0CGL-0006CW-Hi
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 23:10:30 +0000
Received: by mail-pg1-f195.google.com with SMTP id m22so10806400pgv.9
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 16:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iEeJiYVMz8307W48t2xUueHZmcNrA0fy9az4IJZSXYM=;
 b=oQSI238RcgNbC3nQMsOct4rFhkQj56y/P1VhB1POk1eAYlRIdjzgKfBYikOpjOKWlE
 6oI7mRsfRvwn2J/menirFcBWoKUDA+Lgfq3Lnn4PhkogTf0OewCXTwQCZljH5zvhPpu7
 HL/QlRs9hIPRJUJkhpPKBOC7MEBfEJRqtyPtixNtFduACTvvvlncp34vR2Rt+N2tS4ic
 mAKxY5PdltAnmIlTFrQVDqrc/vnfRbDE1FzglA3yJm1ENpNQVvFpyqST5f14pFiGXEYk
 tGhSmG6BlC/HHgP5L64+m1vHm4Ly6xg37Oc3jDEF6k2JVFiv9hRpMDVWFeHxXEEFxBvp
 tr3A==
X-Gm-Message-State: AOAM531/q2pdYAbD6zNedj6r6Z2ylWg0rpp8tark6V9Urf1umzEx/0pZ
 ifQWAyKaf2pW9obz0iL+dLfYi0bM
X-Google-Smtp-Source: ABdhPJz6qd0y1knZ/xbgn9QiQOsWezpqzf2TDrmqmLe7C+87nDuyXUCGxEo7DCMS51C2to1/arC4/A==
X-Received: by 2002:aa7:9422:: with SMTP id y2mr22663850pfo.211.1595891426976; 
 Mon, 27 Jul 2020 16:10:26 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id z190sm7407171pfz.67.2020.07.27.16.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 16:10:26 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Date: Mon, 27 Jul 2020 16:10:21 -0700
Message-Id: <20200727231022.307602-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727231022.307602-1-sagi@grimberg.me>
References: <20200727231022.307602-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_191029_689615_53A24903 
X-CRM114-Status: GOOD (  19.47  )
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

drivers that have shared tagsets may need to quiesce potentially a lot
of request queues that all share a single tagset (e.g. nvme). Add an interface
to quiesce all the queues on a given tagset. This interface is useful because
it can speedup the quiesce by doing it in parallel.

For tagsets that have BLK_MQ_F_BLOCKING set, we use call_srcu to all hctxs
in parallel such that all of them wait for the same rcu elapsed period with
a per-hctx heap allocated rcu_synchronize. for tagsets that don't have
BLK_MQ_F_BLOCKING set, we simply call a single synchronize_rcu as this is
sufficient.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-mq.c         | 66 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  4 +++
 2 files changed, 70 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index abcf590f6238..c37e37354330 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -209,6 +209,42 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
+static void blk_mq_quiesce_blocking_queue_async(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	blk_mq_quiesce_queue_nowait(q);
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
+		hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), GFP_KERNEL);
+		if (!hctx->rcu_sync)
+			continue;
+
+		init_completion(&hctx->rcu_sync->completion);
+		init_rcu_head(&hctx->rcu_sync->head);
+		call_srcu(hctx->srcu, &hctx->rcu_sync->head,
+				wakeme_after_rcu);
+	}
+}
+
+static void blk_mq_quiesce_blocking_queue_async_wait(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
+		if (!hctx->rcu_sync) {
+			synchronize_srcu(hctx->srcu);
+			continue;
+		}
+		wait_for_completion(&hctx->rcu_sync->completion);
+		destroy_rcu_head(&hctx->rcu_sync->head);
+	}
+}
+
 /**
  * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
  * @q: request queue.
@@ -2884,6 +2920,36 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
 	}
 }
 
+void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+
+	mutex_lock(&set->tag_list_lock);
+	if (set->flags & BLK_MQ_F_BLOCKING) {
+		list_for_each_entry(q, &set->tag_list, tag_set_list)
+			blk_mq_quiesce_blocking_queue_async(q);
+		list_for_each_entry(q, &set->tag_list, tag_set_list)
+			blk_mq_quiesce_blocking_queue_async_wait(q);
+	} else {
+		list_for_each_entry(q, &set->tag_list, tag_set_list)
+			blk_mq_quiesce_queue_nowait(q);
+		synchronize_rcu();
+	}
+	mutex_unlock(&set->tag_list_lock);
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_tagset);
+
+void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+
+	mutex_lock(&set->tag_list_lock);
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_unquiesce_queue(q);
+	mutex_unlock(&set->tag_list_lock);
+}
+EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
+
 static void blk_mq_update_tag_set_depth(struct blk_mq_tag_set *set,
 					bool shared)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 23230c1d031e..a85f2dedc947 100644
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
+void blk_mq_quiesce_tagset(struct request_queue *q);
+void blk_mq_unquiesce_tagset(struct request_queue *q);
 
 unsigned int blk_mq_rq_cpu(struct request *rq);
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
