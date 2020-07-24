Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBA5C433E3
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 23:06:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A518206C1
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 23:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zeSdRYuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A518206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jEOEM0wagLBA6joAhvOpQqXvfpE84flWukMTCjkfWSM=; b=zeSdRYuICRi/Yt9JqCbKaQ1DR
	hRuofQrfUGweXyRrmfEhvGPOSwAxJ5cgNqUJNXoicAqb3OYrzsxCsiPrfLNXiv47QKsxl+eePALrL
	8rIUGp69oqfKjF6MVFL2O2KcWOUHyD6NT3gKe8zmEtgrI/PbzSy4CKnEFCR4v13xbWWYXc8kIiZw4
	s8+vFIL5+o9Qh8Ccfq/b5IMB8GZAJGIO/QtcHZ2Jz15fXD7VEphty8gvdlSMwsXtH2rR08BMozJZS
	wpOUf3Bl0ea95QdSWyWwQRbHev06K0nNGF0uk5GQmEHS68mmUAHqo+beJOp/exvq9V5Q5d+9Y22yj
	LlNmzkTQA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz6lY-0002hz-SF; Fri, 24 Jul 2020 23:06:12 +0000
Received: from mail-pj1-f65.google.com ([209.85.216.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz6lW-0002gm-Cw
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 23:06:11 +0000
Received: by mail-pj1-f65.google.com with SMTP id gc9so6213234pjb.2
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jul 2020 16:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TSrwdwo22++8+L8WBbIt0XvSdbbRDGl/LBklH/oQcr4=;
 b=FmWRdQGyV2H/RATfvxjQnnIoy9b1IhwfhTJKUpoZgKeJDJopsSuEfM6oz5xxPCmcPE
 BA73hpnVodG1+u1pat1bqvWlJ31OOAwBWjFXrCUqrbmpYUs2uIB+awGVLP/GZ0gWbzZJ
 YEA7rue3dWq6V1l1dwpLy86Eg1ThtNKU1apRAllkwyU1WfbgkO2ikkR+tdwBtUXhCjft
 +643KW7nuU+z/E9lo+TdIK+gKSP7s3NzBCL5TL6gmBTVJ6GTYVRhXTPg5j6ubZuyS2Gf
 AhNZxNgQs+glhglWeDsV9t7yVkOqUaqsFM2dQsWr6OhpY+GOCPO5r2FFXbczJKmvBgpL
 bw/A==
X-Gm-Message-State: AOAM532tf3VUt5ZiRos/3rH7MbVJw6eREavpkgQmWE3dVZeC8shpPw+V
 u+XCRsikO2gXdMiWGUeAStRMpUyc
X-Google-Smtp-Source: ABdhPJxMnWhpUjFbbEGjhDYnRh6iz8py0uazSGBztgDu+NIHT7CS38NdIkSgJqi4I6xTd3WkvPCwhw==
X-Received: by 2002:a17:90a:14a5:: with SMTP id
 k34mr7928338pja.37.1595631968749; 
 Fri, 24 Jul 2020 16:06:08 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:ac47:9fc4:b59:66fa])
 by smtp.gmail.com with ESMTPSA id 129sm7552379pfv.161.2020.07.24.16.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 16:06:08 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH rfc v2 1/4] blk-mq: add async quiesce interface for blocking
 hw queues
Date: Fri, 24 Jul 2020 16:06:01 -0700
Message-Id: <20200724230604.34625-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724230604.34625-1-sagi@grimberg.me>
References: <20200724230604.34625-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_190610_493828_28BB2FCD 
X-CRM114-Status: GOOD (  12.97  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Drivers that use blocking hw queues may have to quiesce a large amount
of request queues at once (e.g. controller or adapter reset). These
drivers would benefit from an async quiesce interface such that
the can trigger quiesce asynchronously and wait for all in parallel.

This leaves the synchronization responsibility to the driver, but adds
a convenient interface to quiesce async and wait in a single pass.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-mq.c         | 31 +++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  4 ++++
 2 files changed, 35 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index abcf590f6238..7326709ed2d1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -209,6 +209,37 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
+void blk_mq_quiesce_blocking_queue_async(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	blk_mq_quiesce_queue_nowait(q);
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		if (!(hctx->flags & BLK_MQ_F_BLOCKING))
+			continue;
+		init_completion(&hctx->rcu_sync.completion);
+		init_rcu_head(&hctx->rcu_sync.head);
+		call_srcu(hctx->srcu, &hctx->rcu_sync.head, wakeme_after_rcu);
+	}
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_blocking_queue_async);
+
+void blk_mq_quiesce_blocking_queue_async_wait(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		if (!(hctx->flags & BLK_MQ_F_BLOCKING))
+			continue;
+		wait_for_completion(&hctx->rcu_sync.completion);
+		destroy_rcu_head(&hctx->rcu_sync.head);
+	}
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_blocking_queue_async_wait);
+
 /**
  * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
  * @q: request queue.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 23230c1d031e..863b372d32aa 100644
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
+void blk_mq_quiesce_blocking_queue_async(struct request_queue *q);
+void blk_mq_quiesce_blocking_queue_async_wait(struct request_queue *q);
 
 unsigned int blk_mq_rq_cpu(struct request *rq);
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
