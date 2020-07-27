Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F02C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 03:34:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C90206D8
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 03:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0ItNswRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C90206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2Nct5B0uCOO5GD7OVZfJaOiDV7T6qesWAveS3daIhcA=; b=0ItNswRlAMcooIEZvc3yHKBeA
	2+Vlc/1faA/Gv1yFC+cSNysu6nD3z83LKond197pzqq1b5g8ymKAz45L9H6rplTKRU4rHzzFLjR6c
	rqC64iZXzKukkJjUvknYAVX40TSmS4nST0jY5gr1Z6bYLZNeLJPlX4r02BhOCN2CFlydF6VYj29Qc
	0It/y70ACCaRXmKIG6gu8wHJaO+x1MMbuN6I3a2oiI4G/xe3Rj6DftU3ZhHMBBJBJTG8oWmbGWoB2
	okOIF6cNye3G7Y/5EJbGzZ4g3vLnC+T5GHSNgJ1KIi+MKIwdC7KMje4iTcOEYt8RCymfdtnfZqniI
	DP42W8FKg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzttr-0005fy-Dk; Mon, 27 Jul 2020 03:34:03 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jztto-0005eq-IT
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 03:34:02 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B0F86CE653F6DD44F11F;
 Mon, 27 Jul 2020 11:33:47 +0800 (CST)
Received: from [10.27.125.30] (10.27.125.30) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0;
 Mon, 27 Jul 2020 11:33:44 +0800
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
To: Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me> <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <f9ed3baa-2a83-c483-6ba0-70a84d40f569@huawei.com>
Date: Mon, 27 Jul 2020 11:33:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200727020803.GC1129253@T590>
Content-Language: en-US
X-Originating-IP: [10.27.125.30]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200726_233400_914180_24D0B2F5 
X-CRM114-Status: GOOD (  17.58  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020/7/27 10:08, Ming Lei wrote:
>> It is at the end and contains exactly what is needed to synchronize. Not
> The sync is simply single global synchronize_rcu(), and why bother to add
> extra >=40bytes for each hctx.
> 
>> sure what you mean by reuse hctx->srcu?
> You already reuses hctx->srcu, but not see reason to add extra rcu_synchronize
> to each hctx for just simulating one single synchronize_rcu().

To sync srcu together, the extra bytes must be needed, seperate blocking
and non blocking queue to two hctx may be a not good choice.

There is two choice: the struct rcu_synchronize is added in hctx or in srcu.
Though add rcu_synchronize in srcu has a  weakness: the extra bytes is
not need if which do not need batch sync srcu, I still think it's better
for the SRCU to provide the batch synchronization interface.

We can add check ctrl->tagset->flags to provide same interface both for
blocking and non blocking queue. The code for TINY_SRCU:

---
  block/blk-mq.c           | 29 +++++++++++++++++++++++++++++
  drivers/nvme/host/core.c |  9 ++++++++-
  include/linux/blk-mq.h   |  2 ++
  include/linux/srcu.h     |  2 ++
  include/linux/srcutiny.h |  1 +
  kernel/rcu/srcutiny.c    | 16 ++++++++++++++++
  6 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4e0d173beaa3..3117fc3082ff 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -235,6 +235,35 @@ void blk_mq_quiesce_queue(struct request_queue *q)
  }
  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);

+void blk_mq_quiesce_queue_async(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	blk_mq_quiesce_queue_nowait(q);
+
+	queue_for_each_hw_ctx(q, hctx, i)
+		if (hctx->flags & BLK_MQ_F_BLOCKING)
+			synchronize_srcu_async(hctx->srcu);
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
+
+void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	if (q == NULL) {
+		synchronize_rcu();
+		return;
+	}
+
+	queue_for_each_hw_ctx(q, hctx, i)
+		if (hctx->flags & BLK_MQ_F_BLOCKING)
+			synchronize_srcu_async_wait(hctx->srcu);
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async_wait);
+
  /*
   * blk_mq_unquiesce_queue() - counterpart of blk_mq_quiesce_queue()
   * @q: request queue.
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a3b1157561f5..f13aa447ab64 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4322,7 +4322,14 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)

  	down_read(&ctrl->namespaces_rwsem);
  	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_quiesce_queue(ns->queue);
+		blk_mq_quiesce_queue_async(ns->queue);
+
+	if (ctrl->tagset->flags & BLK_MQ_F_BLOCKING) {
+		list_for_each_entry(ns, &ctrl->namespaces, list)
+			blk_mq_quiesce_queue_async_wait(ns->queue);
+	} else {
+		blk_mq_quiesce_queue_async_wait(NULL);
+	}
  	up_read(&ctrl->namespaces_rwsem);
  }
  EXPORT_SYMBOL_GPL(nvme_stop_queues);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d6fcae17da5a..092470c63558 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -515,6 +515,8 @@ void blk_mq_start_hw_queues(struct request_queue *q);
  void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
  void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
  void blk_mq_quiesce_queue(struct request_queue *q);
+void blk_mq_quiesce_queue_async(struct request_queue *q);
+void blk_mq_quiesce_queue_async_wait(struct request_queue *q);
  void blk_mq_unquiesce_queue(struct request_queue *q);
  void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
  void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index e432cc92c73d..7e006e51ccf9 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -60,6 +60,8 @@ void cleanup_srcu_struct(struct srcu_struct *ssp);
  int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
  void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
  void synchronize_srcu(struct srcu_struct *ssp);
+void synchronize_srcu_async(struct srcu_struct *ssp);
+void synchronize_srcu_async_wait(struct srcu_struct *ssp);

  #ifdef CONFIG_DEBUG_LOCK_ALLOC

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 5a5a1941ca15..3d7d871bef61 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -23,6 +23,7 @@ struct srcu_struct {
  	struct rcu_head *srcu_cb_head;	/* Pending callbacks: Head. */
  	struct rcu_head **srcu_cb_tail;	/* Pending callbacks: Tail. */
  	struct work_struct srcu_work;	/* For driving grace periods. */
+	struct rcu_synchronize rcu_sync;
  #ifdef CONFIG_DEBUG_LOCK_ALLOC
  	struct lockdep_map dep_map;
  #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 6208c1dae5c9..6e1468175a45 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -190,6 +190,22 @@ void synchronize_srcu(struct srcu_struct *ssp)
  }
  EXPORT_SYMBOL_GPL(synchronize_srcu);

+void synchronize_srcu_async(struct srcu_struct *ssp)
+{
+	init_rcu_head(&ssp->rcu_sync.head);
+	init_completion(&ssp->rcu_sync.completion);
+	call_srcu(ssp, &ssp->rcu_sync.head, wakeme_after_rcu_batch);
+
+}
+EXPORT_SYMBOL_GPL(synchronize_srcu_async);
+
+void synchronize_srcu_async_wait(struct srcu_struct *ssp)
+{
+	wait_for_completion(&ssp->rcu_sync.completion);
+	destroy_rcu_head(&ssp->rcu_sync.head);
+}
+EXPORT_SYMBOL_GPL(synchronize_srcu_async_wait);
+
  /* Lockdep diagnostics.  */
  void __init rcu_scheduler_starting(void)
  {
-- 
2.16.4

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
