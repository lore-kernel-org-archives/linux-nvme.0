Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E17C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 09:06:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12FC12177B
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 09:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K/X2TF90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FC12177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CjBf5jLe6lcXT8BKQB3bEbOLRm2UTQftX9tLkOwCYvU=; b=K/X2TF90NtOGvUooRzH9RPw2M0
	oBMn3FUX+Wm39LYTE3etVHFKzqHmT2vk9oNYvJJalbaCtLHr8lbj5qvJZZrOPIMQV7ZbLlW3nY7Tk
	9uBriqo9ktI6X1fwFuL4OXRvg5j53idWWby5uJXnr1+Y1+qvF1/s4gwNzmPbV7FJRLCHP4EXMuRXO
	QCFx1FXWi6dl+vzFe0PqK3clLx/wnH6dzvEkL9MCyLU7hqWcWx5JsGEPjyTaa+jJC75GMjcmoYkh/
	Rtbnh+ed0oV9jw3ypdGIvbO4zFqW3484vzbH87C5NZtgFv82BK+xw5QesuthpA2FHeJ9xcz1w7wQr
	xpFE+5Zw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3yKg-0008N1-MM; Fri, 07 Aug 2020 09:06:34 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3yKe-0008Lp-7b
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 09:06:33 +0000
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 014544670811174E059E;
 Fri,  7 Aug 2020 17:06:29 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Fri, 7 Aug 2020
 17:06:21 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
Subject: [PATCH v2 1/3] rcu: introduce async mechanism for sync SRCU
Date: Fri, 7 Aug 2020 17:06:21 +0800
Message-ID: <20200807090621.29639-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_050632_544678_DD88148B 
X-CRM114-Status: GOOD (  14.14  )
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

In some scenarios we need sync lots of SRCUs together, if sync one by
one, may need long time.
Introduce async mechanism for sync SRCU: sync SRCUs together but no wait,
and then wait until all SRCUs read-side critical-section complete.
Thus reduce serial wait time.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 include/linux/rcupdate_wait.h |  6 ++++++
 include/linux/srcu.h          |  1 +
 include/linux/srcutiny.h      |  2 ++
 include/linux/srcutree.h      |  2 ++
 kernel/rcu/srcutiny.c         | 15 +++++++++++++++
 kernel/rcu/srcutree.c         | 26 ++++++++++++++++++++++++++
 kernel/rcu/update.c           | 11 +++++++++++
 7 files changed, 63 insertions(+)

diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index 699b938358bf..c8af1b8916f5 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -16,7 +16,13 @@ struct rcu_synchronize {
 	struct rcu_head head;
 	struct completion completion;
 };
+struct rcu_synchronize_async {
+	struct rcu_head head;
+	atomic_t *count;
+};
+
 void wakeme_after_rcu(struct rcu_head *head);
+void wakeme_after_rcu_async(struct rcu_head *head);
 
 void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 		   struct rcu_synchronize *rs_array);
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index e432cc92c73d..f657ce9f73b0 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -60,6 +60,7 @@ void cleanup_srcu_struct(struct srcu_struct *ssp);
 int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
 void synchronize_srcu(struct srcu_struct *ssp);
+void synchronize_srcu_async(struct srcu_struct *ssp, atomic_t *count);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 5a5a1941ca15..54b257bc0ee5 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -11,6 +11,7 @@
 #ifndef _LINUX_SRCU_TINY_H
 #define _LINUX_SRCU_TINY_H
 
+#include <linux/rcupdate_wait.h>
 #include <linux/swait.h>
 
 struct srcu_struct {
@@ -23,6 +24,7 @@ struct srcu_struct {
 	struct rcu_head *srcu_cb_head;	/* Pending callbacks: Head. */
 	struct rcu_head **srcu_cb_tail;	/* Pending callbacks: Tail. */
 	struct work_struct srcu_work;	/* For driving grace periods. */
+	struct rcu_synchronize_async srcu_async;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 9cfcc8a756ae..81ec38002e49 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -11,6 +11,7 @@
 #ifndef _LINUX_SRCU_TREE_H
 #define _LINUX_SRCU_TREE_H
 
+#include <linux/rcupdate_wait.h>
 #include <linux/rcu_node_tree.h>
 #include <linux/completion.h>
 
@@ -82,6 +83,7 @@ struct srcu_struct {
 						/*  callback for the barrier */
 						/*  operation. */
 	struct delayed_work work;
+	struct rcu_synchronize_async srcu_async;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 6208c1dae5c9..96bea76b78b8 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -190,6 +190,21 @@ void synchronize_srcu(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(synchronize_srcu);
 
+/*
+ * synchronize_srcu_async - do not wait until prior SRCU read-side
+ * critical-section completion, used for sync lots of SRCUs together
+ * to reduce wait time.
+ * Caution: do not support concurrent.
+ */
+void synchronize_srcu_async(struct srcu_struct *ssp, atomic_t *count)
+{
+	init_rcu_head(&ssp->srcu_async.head);
+	atomic_inc(count);
+	ssp->srcu_async.count = count;
+	call_srcu(ssp, &ssp->srcu_async.head, wakeme_after_rcu_async);
+}
+EXPORT_SYMBOL_GPL(synchronize_srcu_async);
+
 /* Lockdep diagnostics.  */
 void __init rcu_scheduler_starting(void)
 {
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6d3ef700fb0e..b4045cc0d7f2 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1014,6 +1014,32 @@ void synchronize_srcu(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(synchronize_srcu);
 
+/*
+ * synchronize_srcu_async - do not wait until prior SRCU read-side
+ * critical-section completion, used for sync lots of SRCUs together
+ * to reduce wait time.
+ * Caution: do not support concurrent.
+ */
+void synchronize_srcu_async(struct srcu_struct *ssp, atomic_t *count)
+{
+	RCU_LOCKDEP_WARN(lock_is_held(&ssp->dep_map) ||
+		lock_is_held(&rcu_bh_lock_map) ||
+		lock_is_held(&rcu_lock_map) ||
+		lock_is_held(&rcu_sched_lock_map),
+		"Illegal synchronize_srcu() in same-type SRCU (or in RCU) read-side critical section");
+	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
+		return;
+
+	might_sleep();
+	check_init_srcu_struct(ssp);
+	init_rcu_head(&ssp->srcu_async.head);
+
+	atomic_inc(count);
+	ssp->srcu_async.count = count;
+	call_srcu(ssp, &ssp->srcu_async.head, wakeme_after_rcu_async);
+}
+EXPORT_SYMBOL_GPL(synchronize_srcu_async);
+
 /*
  * Callback function for srcu_barrier() use.
  */
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 84843adfd939..6433ae9c54cf 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -377,6 +377,17 @@ void wakeme_after_rcu(struct rcu_head *head)
 }
 EXPORT_SYMBOL_GPL(wakeme_after_rcu);
 
+void wakeme_after_rcu_async(struct rcu_head *head)
+{
+	struct rcu_synchronize_async *rcu_asnc;
+
+	rcu_asnc = container_of(head, struct rcu_synchronize_async, head);
+
+	atomic_dec(rcu_asnc->count);
+	destroy_rcu_head_on_stack(&rcu_asnc->head);
+}
+EXPORT_SYMBOL_GPL(wakeme_after_rcu_async);
+
 void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 		   struct rcu_synchronize *rs_array)
 {
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
