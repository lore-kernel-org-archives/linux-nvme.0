Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE9ECD6E56
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2026 11:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Y6W4aFPGcqzc6g6Z5EYI+ZJTbl4uoT/p++KsxeP1pQg=; b=wmXyHXCzfTaZItXP88PjXAN8Do
	12DTCqNWQj6wTqs6IlXrpy8pSspEWOYD4c1avGCVrvGPADoyFzKYyICP3rHfBpYR71gFiUYQP6Nl8
	1g7n2yRJhTFyA5ImpqrIYqoDxIQt81atFrCCfbqXunyTl/nF1Gyeqsx9g92nFf5QRuAN+ToWELYyZ
	fTaUZkR4HOhQdoU5XDXgXCy9LyhglmE7+x+Tm2KdjDbw/GPyyKH5P45yxIfPqJdEldqIrzy8qnpPG
	7o5nSEkKQaPOHTq9lIl1CEBHt69YLrh7/pi4ZFs58i7tq3hlpfGtA2i2574AywyzABA2GDtI58zTr
	MxW5TMSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUjjS-0000000EwI6-0ak4;
	Wed, 03 Jun 2026 11:25:58 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUjjP-0000000EwHG-2OIM
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jun 2026 11:25:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1780485956; x=1812021956;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q1mpUorkDqWAhhwh5OSt4MZz0+ub/MOet3spJNvvzU4=;
  b=qd3MtIbn5G9QHWyjWHG5WiWQK5P/w148czk4/9vub67TKH57m++lTFR8
   V1/MliRMvxV0ceLU8LLFXjwH2YcMuPB4NuWGZ5WqMN9CZ0k/2pPsqet9u
   8YTvHt7devpwv2hYfQuDks1MDNhFMG+rs0g4PJQqE/VKqD/toq9Ihymj4
   ppsTFrZNj00bgCXAjVn49sI6ZB8HXyIzN8iztNuT8be+tSa+Y0JOtYTL5
   qK74+JeVAJKrX9MDuaPtB/BBwukwAWDvp0WOk/qXM4xBOLBtpkdSTz052
   d4WUcicbJG6VKB6cXT3RA9pVF6ls0m5Ws9UlFzDMTS7DmuHNkZLd5iQSj
   g==;
X-CSE-ConnectionGUID: R3Lhlj9GRSm+Go6cRZjGwA==
X-CSE-MsgGUID: pEeajfjgRW6u8YCtt/KrYA==
X-IronPort-AV: E=Sophos;i="6.24,185,1774281600"; 
   d="scan'208";a="147372119"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2026 19:25:55 +0800
X-CSE-ConnectionGUID: 2Ok/nW1hQX+zJDgrlvsLbQ==
X-CSE-MsgGUID: HQf3BvFNRU+8fm6gwnDUig==
IronPort-SDR: 6a200f2e_d3uK8H+HUmrHJFrHTQFM+M6XLJPwnXRs5LkpOQZowt7ViIJ
 qtz9SFEPfxt7uHDO2qxVrUVYAXa9KkhIA5HmjMA==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2026 04:25:34 -0700
X-CSE-ConnectionGUID: miHVj6AhQ8Wtn+ZTlxF3VQ==
X-CSE-MsgGUID: zlnEbYZnR9mHnAf/upr7og==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 03 Jun 2026 04:25:34 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] nvme-tcp: lockdep: use dynamic lockdep keys per socket instance
Date: Wed,  3 Jun 2026 20:25:33 +0900
Message-ID: <20260603112533.375925-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_042555_621552_01DE63BF 
X-CRM114-Status: GOOD (  16.66  )
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
* Changes from v1:
- Removed the 1st patch from the series that was already applied
- Added lockdep_unregsiter_key() calls in nvme_tcp_alloc_queue() failure path
- Moved lockdep_regsiter_key() calls from nvme_tcp_reclassify_socket() to
  nvme_tcp_alloc_queue()
- Link to v1: https://lore.kernel.org/linux-nvme/20260530052045.296749-1-shinichiro.kawasaki@wdc.com/

 drivers/nvme/host/tcp.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2b4ab6a3a109..70374918a9f1 100644
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
@@ -1921,6 +1931,11 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
+	lockdep_unregister_key(&queue->nvme_tcp_slock_key);
+#endif
 	return ret;
 }
 
-- 
2.54.0


