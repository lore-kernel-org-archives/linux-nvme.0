Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05B1C433E3
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 09:06:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954FE2177B
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 09:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cqsmhZnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954FE2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XWI/q5d92EXBIlrHLSq5rKT+RV24qQzJrJxwouLfZf8=; b=cqsmhZnYTiLXz+Ivx8DHnsn4YK
	qnvR6clEZ0vkahq7vIdutjC7aRdqytYwaAsKuxUL2BzkGJYL6ZypRb0MRxA3XxZqqtzwW5cqkf8rd
	H1hpLfNuuvkE+iQ1xCAkr7IJhg6r/rng2+SmwCYSXlO7NlWjcZpip1yY6H89IcDMhXZyjY9UeQOz0
	dPhCdoLmo3Kmgy13cSOjBJ9leN1ZaVk1v+EB+IupoJ1hShUaUTg2UfiZlkZ4RmWfPro3lw+SANkkd
	8QbzXkSEVY6iJTON0rYOVFvztxgs2P45hHPJhGJnwsjO/U3ej3Q7E8YOovBmLt8PLS/Ip336iyrLO
	z7bdLhmA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3yKs-0008PF-0A; Fri, 07 Aug 2020 09:06:46 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3yKp-0008OL-1B
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 09:06:44 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 2538E3DAAE3A2F39DFD7;
 Fri,  7 Aug 2020 17:06:39 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Fri, 7 Aug 2020
 17:06:31 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
Subject: [PATCH v2 2/3] blk-mq: introduce async mechanism for quiesce queue
Date: Fri, 7 Aug 2020 17:06:30 +0800
Message-ID: <20200807090630.29693-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_050643_865713_59642AF1 
X-CRM114-Status: UNSURE (   9.45  )
X-CRM114-Notice: Please train this message.
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, lengchao@huawei.com,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In some scenarios we need quiesce lots of queues together, if quiesce
one by one, may need long time.
Introduce async mechanism for quiesce queue: quiesce queues together
but no wait, and then wait until all queues ongoing dispatches complete.
Thus reduce serial wait time.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 block/blk-mq.c         | 28 ++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a9aa6d1e44cf..2fc2fd666bda 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -235,6 +235,34 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
 
+/*
+ * blk_mq_quiesce_queue_async - do not wait until all ongoing dispatches
+ * completed, used for sync lots of queues together to reduce wait time.
+ * Must be used together with blk_mq_quiesce_queue_async_wait.
+ * Caution: do not support concurrent.
+ */
+void blk_mq_quiesce_queue_async(struct request_queue *q, atomic_t *count)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	blk_mq_quiesce_queue_nowait(q);
+	queue_for_each_hw_ctx(q, hctx, i) {
+		if (hctx->flags & BLK_MQ_F_BLOCKING)
+			synchronize_srcu_async(hctx->srcu, count);
+	}
+
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
+
+void blk_mq_quiesce_queue_async_wait(atomic_t *count)
+{
+	synchronize_rcu();
+	while (atomic_read(count))
+		schedule();
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async_wait);
+
 /*
  * blk_mq_unquiesce_queue() - counterpart of blk_mq_quiesce_queue()
  * @q: request queue.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d6fcae17da5a..27a713ad73bb 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -515,6 +515,8 @@ void blk_mq_start_hw_queues(struct request_queue *q);
 void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
 void blk_mq_quiesce_queue(struct request_queue *q);
+void blk_mq_quiesce_queue_async(struct request_queue *q, atomic_t *count);
+void blk_mq_quiesce_queue_async_wait(atomic_t *count);
 void blk_mq_unquiesce_queue(struct request_queue *q);
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
