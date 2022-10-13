Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291F1C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Oct 2022 09:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nExp95nLe2br7WGTfvrA/rzip3tpItcy59R4JQdDBZ4=; b=ioYxPCfB0sBhVs8f9VChG9JPqZ
	2u9DY3Xeix/P46dKwPT+NFtPocvcenvDA7LDqZuusfe8Zsig4D+zD5WGHqTUuEUe2YT7chjr//aoU
	WlvNbbCa+s6jfkqW46/AHBTexblp1ecg+MtUdu1P8Z+FraNLaM73sk3Qhls23gYzMvOePewvrl8aT
	WlU4c3BHC2upXvLgCETMX3GLtoIAA6DM9gEvHn9xX/cP8DROHhfh9GcswO9M2GiyoL7Bb82DeA6iv
	iIRF8PnqwXWruWiuZDqmELgHhUW6/VAL63KHRSdYoMgGVat///vJXIbkscRFvqmkdnHlQjzg7DtyM
	BNE0Xg2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oium8-00BKWU-CJ; Thu, 13 Oct 2022 09:45:12 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiulw-00BKR2-VU
	for linux-nvme@lists.infradead.org; Thu, 13 Oct 2022 09:45:03 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mp4J021yFzmVB6;
	Thu, 13 Oct 2022 17:40:16 +0800 (CST)
Received: from huawei.com (10.29.88.127) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 13 Oct
 2022 17:44:51 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
	<lengchao@huawei.com>, <ming.lei@redhat.com>, <axboe@kernel.dk>
Subject: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Date: Thu, 13 Oct 2022 17:44:49 +0800
Message-ID: <20221013094450.5947-2-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20221013094450.5947-1-lengchao@huawei.com>
References: <20221013094450.5947-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221013_024501_376052_51EEFA99 
X-CRM114-Status: GOOD (  18.14  )
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

Drivers that have shared tagsets may need to quiesce potentially a lot
of request queues that all share a single tagset (e.g. nvme). Add an interface
to quiesce all the queues on a given tagset. This interface is useful because
it can speedup the quiesce by doing it in parallel.

For tagsets that have BLK_MQ_F_BLOCKING set, we use call_srcu to all hctxs
in parallel such that all of them wait for the same rcu elapsed period with
a per-hctx heap allocated rcu_synchronize. for tagsets that don't have
BLK_MQ_F_BLOCKING set, we simply call a single synchronize_rcu as this is
sufficient.

Because some queues never need to be quiesced(e.g. nvme connect_q).
So introduce QUEUE_FLAG_NOQUIESCED to tagset quiesce interface to
skip the queue.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 block/blk-mq.c         | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 include/linux/blkdev.h |  2 ++
 3 files changed, 79 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8070b6c10e8d..ebe25da08156 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -29,6 +29,7 @@
 #include <linux/prefetch.h>
 #include <linux/blk-crypto.h>
 #include <linux/part_stat.h>
+#include <linux/rcupdate_wait.h>
 
 #include <trace/events/block.h>
 
@@ -311,6 +312,80 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 
+static void blk_mq_quiesce_blocking_tagset(struct blk_mq_tag_set *set)
+{
+	int i = 0;
+	int count = 0;
+	struct request_queue *q;
+	struct rcu_synchronize *rcu;
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		if (blk_queue_noquiesced(q))
+			continue;
+
+		blk_mq_quiesce_queue_nowait(q);
+		count++;
+	}
+
+	rcu = kvmalloc(count * sizeof(*rcu), GFP_KERNEL);
+	if (rcu) {
+		list_for_each_entry(q, &set->tag_list, tag_set_list) {
+			if (blk_queue_noquiesced(q))
+				continue;
+
+			init_rcu_head(&rcu[i].head);
+			init_completion(&rcu[i].completion);
+			call_srcu(q->srcu, &rcu[i].head, wakeme_after_rcu);
+			i++;
+		}
+
+		for (i = 0; i < count; i++) {
+			wait_for_completion(&rcu[i].completion);
+			destroy_rcu_head(&rcu[i].head);
+		}
+		kvfree(rcu);
+	} else {
+		list_for_each_entry(q, &set->tag_list, tag_set_list)
+			synchronize_srcu(q->srcu);
+	}
+}
+
+static void blk_mq_quiesce_nonblocking_tagset(struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		if (blk_queue_noquiesced(q))
+			continue;
+
+		blk_mq_quiesce_queue_nowait(q);
+	}
+	synchronize_rcu();
+}
+
+void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
+{
+	mutex_lock(&set->tag_list_lock);
+	if (set->flags & BLK_MQ_F_BLOCKING)
+		blk_mq_quiesce_blocking_tagset(set);
+	else
+		blk_mq_quiesce_nonblocking_tagset(set);
+
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
 void blk_mq_wake_waiters(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ba18e9bdb799..1df47606d0a7 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -877,6 +877,8 @@ void blk_mq_start_hw_queues(struct request_queue *q);
 void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
 void blk_mq_quiesce_queue(struct request_queue *q);
+void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set);
+void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set);
 void blk_mq_wait_quiesce_done(struct request_queue *q);
 void blk_mq_unquiesce_queue(struct request_queue *q);
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50e358a19d98..f15544299a67 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -579,6 +579,7 @@ struct request_queue {
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
 #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
+#define QUEUE_FLAG_NOQUIESCED	31	/* queue is never quiesced */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
 				 (1UL << QUEUE_FLAG_SAME_COMP) |	\
@@ -619,6 +620,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
+#define blk_queue_noquiesced(q)	test_bit(QUEUE_FLAG_NOQUIESCED, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.16.4


