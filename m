Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74684CD6E55
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2026 02:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OHpT4hRGp7KrSsxBTpqUO9+NbYzB2gPukERS4KS47G8=; b=KedrtF4CYftBOGUdok6vnqMHlQ
	QTwF8mobX11+gLxMY49I4DzKlb/A+lIjmh/w7JN0vt2YU7jBY4IWMxS++YSlagup1BRqgCTpISxAO
	bq1qglxb3CNpcoPcEGU7dW+wOSh+3GLj6u+xSZVLUnWqq5U8TPhlaVrwbvv1IjIxbt/DXHfGszI6v
	sSSFCROU31L78FeMhBxRATb91EWrgb3ZAy8TAMUG1lKJhSoSTsCxzWXdBHpgj75bq2BiO8xvryUUB
	N5oCYbdfyVWHiJw/ClDj9B/CQ9FLHV2HTSXZLYBKHPr9agaKT9/vIJAuw6lOBguhwLMV74US6m5vN
	JdOUm62A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUxsx-0000000G31I-27CG;
	Thu, 04 Jun 2026 02:32:43 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUxsv-0000000G30j-162r
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jun 2026 02:32:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1780540361; x=1812076361;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j1idBLlhYGWi2hqyKTS+iIyisEdcsa7zyupSshvu5Rw=;
  b=fOBao2JTk80qjhkGC+28oadJriOErG0tUHctyy0QvoURpnDf92pY3RPc
   plGNbRP83SVtUR5NDfAqBJ6D90uQGEDtast28Jm382HmQqkorCfHauBfK
   WyK/LTMWmbSBMLBamDfQuuF0fh0fIwpoGil5dG7gIE1m/nOgE04dpeybK
   OYfjWlIM+mB7JiySft2GCSjWXWmPf5l7HQd+4ta9FnZ/UCP4stzcE+F3C
   igHFsc6pA7a7Ym8soAYPOyOS6o0TQcID99SKIDRRBG7UL788CHCfKcUhF
   M5L+080/ShRU9JIg14L3t+FufSferalGrp1U38INIE1oFqCcMmPk6Utx1
   w==;
X-CSE-ConnectionGUID: FjIs2m1DRPq4NAGjh+wlug==
X-CSE-MsgGUID: t7nH+IisTfOXmIoyCmJs7w==
X-IronPort-AV: E=Sophos;i="6.24,186,1774281600"; 
   d="scan'208";a="148028851"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2026 10:32:40 +0800
X-CSE-ConnectionGUID: tmNKz+NYSuKzWmAJhk9HWA==
X-CSE-MsgGUID: Z1zUGM56Sm2jLUNzjmbFlg==
IronPort-SDR: 6a20e3aa_GhS+ROSEjWWYHp/PxEqwana2F40jectEYWMC4tlgIuUWRde
 KK9nOcLWDySRB0qWtWk/1Y/3JiheiNb9o1uDL7w==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2026 19:32:10 -0700
X-CSE-ConnectionGUID: C01ssG3ZSE67PbSi7XlZHA==
X-CSE-MsgGUID: 9i0yNCGHRKqQ+NntraIiuQ==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 03 Jun 2026 19:32:10 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v3] nvme-tcp: lockdep: use dynamic lockdep keys per socket instance
Date: Thu,  4 Jun 2026 11:32:08 +0900
Message-ID: <20260604023208.388157-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_193241_310738_BB67262F 
X-CRM114-Status: GOOD (  16.62  )
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

When NVMe-TCP controller setup and teardown are repeated with lockdep
enabled, lockdep reports false positives WARN for the following locks:

  1) &q->elevator_lock        : IO scheduler change context
  2) &q->q_usage_counter(io)  : SCSI disk probe context
  3) fs_reclaim               : CPU hotplug bring-up context
  4) cpu_hotplug_lock         : socket establishment context
  5) sk_lock-AF_INET-NVME     : MQ sched dispatch context for the socket
  6) set->srcu                : NVMe controller delete context

The lockdep WARN was observed by running blktests test case nvme/005 for
tcp transport on v7.1-rc1 kernel with a patch. Refer to the Link tag for
the details of the WARN.

This is a false positive because lockdep confuses lock 4) (socket
establishment) with lock 5) (socket in use) for different socket
instances. The locks belong to different sockets, but lockdep treats
them as the same due to shared static lockdep keys.

Fix this by using dynamically allocated lockdep keys per socket instance
instead of static keys nvme_tcp_sk_key[] and nvme_tcp_slock_key[]. Add
nvme_tcp_sk_key and nvme_tcp_slock_key fields to struct nvme_tcp_queue
and pass them to sock_lock_init_class_and_name() for proper lockdep
tracking. Change the argument of nvme_tcp_reclassify_socket() from
'struct socket *' to 'struct nvme_tcp_queue *' to pass both the socket
and the keys. Add CONFIG_DEBUG_LOCK_ALLOC guards to nvme_tcp_alloc_queue()
and nvme_tcp_free_queue() to register and unregister the dynamic keys.
Additionally, move nvme_tcp_reclassify_socket() inside these guards since
it's only needed when lockdep is enabled.

Link: https://lore.kernel.org/linux-nvme/afB5syZbUrppgsDQ@shinmob/
Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
* Changes from v2:
- Moved lockdep_unregsiter_key() calls in faliure path before err_destroy_mutex
- Link to v2: https://lore.kernel.org/linux-nvme/20260603112533.375925-1-shinichiro.kawasaki@wdc.com/

* Changes from v1:
- Removed the 1st patch from the series that was already applied
- Added lockdep_unregsiter_key() calls in nvme_tcp_alloc_queue() failure path
- Moved lockdep_regsiter_key() calls from nvme_tcp_reclassify_socket() to
  nvme_tcp_alloc_queue()
- Link to v1: https://lore.kernel.org/linux-nvme/20260530052045.296749-1-shinichiro.kawasaki@wdc.com/

 drivers/nvme/host/tcp.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2b4ab6a3a109..36a4615f3ad8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -142,6 +142,11 @@ struct nvme_tcp_queue {
 	void (*state_change)(struct sock *);
 	void (*data_ready)(struct sock *);
 	void (*write_space)(struct sock *);
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lock_class_key nvme_tcp_sk_key;
+	struct lock_class_key nvme_tcp_slock_key;
+#endif
 };
 
 struct nvme_tcp_ctrl {
@@ -176,12 +181,9 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
  * a separate class prevents lockdep from conflating nvme-tcp socket use with
  * user-space socket API use.
  */
-static struct lock_class_key nvme_tcp_sk_key[2];
-static struct lock_class_key nvme_tcp_slock_key[2];
-
-static void nvme_tcp_reclassify_socket(struct socket *sock)
+static void nvme_tcp_reclassify_socket(struct nvme_tcp_queue *queue)
 {
-	struct sock *sk = sock->sk;
+	struct sock *sk = queue->sock->sk;
 
 	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
 		return;
@@ -189,22 +191,20 @@ static void nvme_tcp_reclassify_socket(struct socket *sock)
 	switch (sk->sk_family) {
 	case AF_INET:
 		sock_lock_init_class_and_name(sk, "slock-AF_INET-NVME",
-					      &nvme_tcp_slock_key[0],
+					      &queue->nvme_tcp_slock_key,
 					      "sk_lock-AF_INET-NVME",
-					      &nvme_tcp_sk_key[0]);
+					      &queue->nvme_tcp_sk_key);
 		break;
 	case AF_INET6:
 		sock_lock_init_class_and_name(sk, "slock-AF_INET6-NVME",
-					      &nvme_tcp_slock_key[1],
+					      &queue->nvme_tcp_slock_key,
 					      "sk_lock-AF_INET6-NVME",
-					      &nvme_tcp_sk_key[1]);
+					      &queue->nvme_tcp_sk_key);
 		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
 }
-#else
-static void nvme_tcp_reclassify_socket(struct socket *sock) { }
 #endif
 
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
@@ -1468,6 +1468,11 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
+	lockdep_unregister_key(&queue->nvme_tcp_slock_key);
+#endif
 }
 
 static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
@@ -1813,7 +1818,12 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	}
 
 	sk_net_refcnt_upgrade(queue->sock->sk);
-	nvme_tcp_reclassify_socket(queue->sock);
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_register_key(&queue->nvme_tcp_sk_key);
+	lockdep_register_key(&queue->nvme_tcp_slock_key);
+	nvme_tcp_reclassify_socket(queue);
+#endif
 
 	/* Single syn retry */
 	tcp_sock_set_syncnt(queue->sock->sk, 1);
@@ -1918,6 +1928,10 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	/* Use sync variant - see nvme_tcp_free_queue() for explanation */
 	__fput_sync(queue->sock->file);
 	queue->sock = NULL;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
+	lockdep_unregister_key(&queue->nvme_tcp_slock_key);
+#endif
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
-- 
2.54.0


