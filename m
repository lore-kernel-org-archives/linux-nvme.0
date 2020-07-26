Return-Path: <SRS0=KTc9=BF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD01C433E5
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 00:23:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39671206D7
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 00:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wZRFMIGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39671206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9+TYC1gf0rCbB2rpRYRdnpOulLGbYC4lnvRf8n/FVNE=; b=wZRFMIGlG2sXhDTRwuOX7ixTz
	HSNDqQpebs1cYgguVZT3+LNwAa8KUnZm4sY8CZCauNPfkV57gCQGBRU5J7RlfSJocyFhYFyp/gAuD
	4Zoq0E4weACc/WCu0BLwLSCkhTjy26F/os6lMe9Di7BuNE+5glAbenQ7FJCiRav85Hm6gZWbsWqEe
	d9qljZ3vtuTyRGU4d6x6lrVRlM4uP956DDggu1uDD4bg46hc8g9Fv02Xk0/Vr4JMKKAOxl932yuGn
	Do/Y91pG3YNkiF1v10uv/rlo7NxsobYDtZMukgWguJzTWFdJqVb3J1C/HyUQYWVDHwEB55gzeqOWJ
	2mAlK4ZUg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzURb-0007x7-H7; Sun, 26 Jul 2020 00:23:11 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzURY-0007vb-3c
 for linux-nvme@lists.infradead.org; Sun, 26 Jul 2020 00:23:08 +0000
Received: by mail-pl1-f195.google.com with SMTP id m16so6328961pls.5
 for <linux-nvme@lists.infradead.org>; Sat, 25 Jul 2020 17:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w0EepSRNlenjv5tADlT5X1AQfZpXiJRu0WwPL9UNMkQ=;
 b=SXI3MQcev1cgElr89OAPcF+rHgv2A6wii0jtHMffccaLVmYcLLuK8axT66bRPUuRUw
 pJzQ8Vznut3t4TByREKEy21ExcnnPLzrAg1Z/RoVRk8pQTOmI5MGxS9EDfE8HmW6aHiD
 r33jNNv/1DOeY5lVPOIKJL5NHmmAhgbDd0es7Sqwip8ertoZMJw9wM5p3coyLS9YdkbL
 TNb2jyjV2dt49M4JtOtUP3la2ZefzIVCscgs1qInzu0JPlaR1gEAqkOVYm96E+5YfVNy
 qOK5c59r4ppPW8EGtw8/XOxx7cI1JDY2t0RpQ2ioTlGO/GcDQj2k6Xsm8isz/lPlnysL
 SWxA==
X-Gm-Message-State: AOAM5320HJ+pRjtwE3cIaawFbqu3a79RcLKjebsT5k8xXYBEdGnQ86X5
 aPRRhO4gHci0kSmwwLawM2Mie5Ew
X-Google-Smtp-Source: ABdhPJyY1H3XUwh7A70dLeGsqWcPlhb9xbHUynZGCza/hLlr1fi9sK1k3W9EwFz2C8Rt6t6Xc4D3Hg==
X-Received: by 2002:a17:90a:30c2:: with SMTP id
 h60mr11508704pjb.23.1595722986432; 
 Sat, 25 Jul 2020 17:23:06 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:c428:8d39:30dd:38a5])
 by smtp.gmail.com with ESMTPSA id z62sm10185620pfb.47.2020.07.25.17.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2020 17:23:05 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 1/2] blk-mq: add async quiesce interface
Date: Sat, 25 Jul 2020 17:23:00 -0700
Message-Id: <20200726002301.145627-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200726002301.145627-1-sagi@grimberg.me>
References: <20200726002301.145627-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200725_202308_204275_20844745 
X-CRM114-Status: GOOD (  13.54  )
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
Cc: linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>
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
 block/blk-mq.c         | 32 ++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  4 ++++
 2 files changed, 36 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index abcf590f6238..60d137265bd9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -209,6 +209,38 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
+void blk_mq_quiesce_queue_async(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	blk_mq_quiesce_queue_nowait(q);
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		init_completion(&hctx->rcu_sync.completion);
+		init_rcu_head(&hctx->rcu_sync.head);
+		if (hctx->flags & BLK_MQ_F_BLOCKING)
+			call_srcu(hctx->srcu, &hctx->rcu_sync.head,
+				wakeme_after_rcu);
+		else
+			call_rcu(&hctx->rcu_sync.head,
+				wakeme_after_rcu);
+	}
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
+
+void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		wait_for_completion(&hctx->rcu_sync.completion);
+		destroy_rcu_head(&hctx->rcu_sync.head);
+	}
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async_wait);
+
 /**
  * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
  * @q: request queue.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 23230c1d031e..5536e434311a 100644
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
 
+	struct rcu_synchronize	rcu_sync;
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
