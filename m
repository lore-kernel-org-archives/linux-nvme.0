Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C9AC88E50
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 07:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NLVJSLTLyVnlA/1EausSSohiCqcHLqKUZHVEjX3mNB8=; b=g7nDdfWuOesyOtllY8lBzq6plw
	Jt6c5o9yKzqeVwFBaFM+JXlvr2sOC6dgPfhcazUgKiSfgflq7OHZN0twaybzW9k/L6GMk0gulJTw4
	2kyMKQnOfIqPhaoUCGNY7X+BpAMlG4e8AlywastS1oUXoKKJBvDyU8ImE1HXAEUxqKQaJys8VHWmw
	/tYInrS15s4M2MMYA8qm/hmR+jlC/9oJ76fCsN2Er29pVJfIMK2nk9MamOS4NXruxlhLPED1GTbul
	udxdz5k78bdEYfsVVrWFFCOI6e5t6TuIJQENQgAfqMSaKOBsrco/qJbctyhVz4FolTvUO2GOMzCZV
	y/iF5dTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x61RC-00000002cPu-2Vw7;
	Mon, 14 Sep 2026 07:49:14 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x61R9-00000002cOC-2pYB
	for linux-nvme@lists.infradead.org;
	Mon, 14 Sep 2026 07:49:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1789372151; x=1820908151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZifPlbKOv4Ok/pkqDv8vqexq3Tf/srYp48sg2vlUc+I=;
  b=ag+gxcAkVXk62b1dVOTRGzl4/8xTR//mRsDzHYFYILH/I8li+1QFsM37
   bRI4jmZ8MlB3ipFfGQfcGgZS6H/hWRDPo28JmF/a7DQ3l1XXzqCSe4eSk
   Eahy+SKPHPe9T98nWsRHNnoHrTKa5/Ku225w4WruV2PFXH2D36d08d31I
   hZ/MzqoaBuh4VbNL+jpJYHFvzlgCLRJ7CEyuybVqHqqvlXnQbdMMplllA
   pKLYS8p0PFe1G4PuCbUce6YaFIrOPQJmkMjYuPvQCMmOT/knFVHdOJ4+x
   C2v21wpSR5p76MBEWrf+MUP5V0EdpFGaTlUCauMwwHPQ107DGtmEvwLoy
   g==;
X-CSE-ConnectionGUID: oW2IL795Qn+PhUlgT/dCFw==
X-CSE-MsgGUID: 3PtmvhIVSzag2i2FG3qPzg==
X-IronPort-AV: E=Sophos;i="6.27,102,1786982400"; 
   d="scan'208";a="154022890"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2026 15:49:08 +0800
X-CSE-ConnectionGUID: vovuS9JWQka8E5a6rWtlRw==
X-CSE-MsgGUID: zWG6z5SDQO+WSSGI6fZdSQ==
IronPort-SDR: 6aa7a6e9_XFTV8lVWSYaTxECb6yt2EplxFp0SKQ0oDHYKiS4XRqJVymm
 h4AvI3lAP/yZmU4h8Ar8/iDKWwBwiD0ImzGF6gw==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2026 00:48:57 -0700
X-CSE-ConnectionGUID: ZzxKbc3MSZaIIKEevr5U0A==
X-CSE-MsgGUID: +bYv20T2Q3GllJLw/C0Atw==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 14 Sep 2026 00:48:56 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@opensource.wdc.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Eric Dumazet <edumazet@google.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 1/2] Revert "nvme-tcp: lockdep: use dynamic lockdep keys per socket instance"
Date: Mon, 14 Sep 2026 16:48:52 +0900
Message-ID: <20260914074853.3990397-2-shinichiro.kawasaki@opensource.wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260914074853.3990397-1-shinichiro.kawasaki@opensource.wdc.com>
References: <20260914074853.3990397-1-shinichiro.kawasaki@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_004911_744723_83AB4389 
X-CRM114-Status: GOOD (  16.41  )
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

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

This reverts commit 19bdb70c77d3b24239a453291299b64040bdba86.

The commit 19bdb70c77d3 ("nvme-tcp: lockdep: use dynamic lockdep keys
per socket instance") addressed the lockdep WARN caused by the circular
lock dependency among six locks:

  set->srcu -> sk_lock -> cpu_hotplug_lock -> fs_reclaim -> q_usage_counter -> elevator_lock -> set->srcu

As its title says, the commit cut the dependency by introducing the
dynamic lockdep keys per socket instance. However, as described in the
Link tag URL, the commit made a wrong assumption: it assumed that
__fput_sync(queue->sock->file) in nvme_tcp_free_queue() would
synchronously destroy the socket. This is wrong: when in-flight packets
cause delayed free of the socket, the prematurely freed lockdep key is
referred to and causes another WARN. The commit is an imperfect fix.
Hence revert it.

To address the circular dependency among the six locks, another solution
is required. It is provided by the commit 0ba6912f7e97 ("Revert "once:
don't use a work queue to reset sleepable static key""). It cuts the
dependency between sk_lock and cpu_hotplug_lock. This solution is
simpler, and reduces the complexity in nvme-tcp.

Link: https://lore.kernel.org/lkml/CANn89i+wnTLC==UnXCpjsS4YxvEfhe5oK0N7fttbqr1zKyqdug@mail.gmail.com/
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/host/tcp.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 921934028e0b..0666bb469c0a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -144,11 +144,6 @@ struct nvme_tcp_queue {
 	void (*state_change)(struct sock *);
 	void (*data_ready)(struct sock *);
 	void (*write_space)(struct sock *);
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lock_class_key nvme_tcp_sk_key;
-	struct lock_class_key nvme_tcp_slock_key;
-#endif
 };
 
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
@@ -185,9 +180,12 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
  * a separate class prevents lockdep from conflating nvme-tcp socket use with
  * user-space socket API use.
  */
-static void nvme_tcp_reclassify_socket(struct nvme_tcp_queue *queue)
+static struct lock_class_key nvme_tcp_sk_key[2];
+static struct lock_class_key nvme_tcp_slock_key[2];
+
+static void nvme_tcp_reclassify_socket(struct socket *sock)
 {
-	struct sock *sk = queue->sock->sk;
+	struct sock *sk = sock->sk;
 
 	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
 		return;
@@ -195,20 +193,22 @@ static void nvme_tcp_reclassify_socket(struct nvme_tcp_queue *queue)
 	switch (sk->sk_family) {
 	case AF_INET:
 		sock_lock_init_class_and_name(sk, "slock-AF_INET-NVME",
-					      &queue->nvme_tcp_slock_key,
+					      &nvme_tcp_slock_key[0],
 					      "sk_lock-AF_INET-NVME",
-					      &queue->nvme_tcp_sk_key);
+					      &nvme_tcp_sk_key[0]);
 		break;
 	case AF_INET6:
 		sock_lock_init_class_and_name(sk, "slock-AF_INET6-NVME",
-					      &queue->nvme_tcp_slock_key,
+					      &nvme_tcp_slock_key[1],
 					      "sk_lock-AF_INET6-NVME",
-					      &queue->nvme_tcp_sk_key);
+					      &nvme_tcp_sk_key[1]);
 		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
 }
+#else
+static void nvme_tcp_reclassify_socket(struct socket *sock) { }
 #endif
 
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
@@ -1523,11 +1523,6 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
 	mutex_destroy(&queue->pf_cache_lock);
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
-	lockdep_unregister_key(&queue->nvme_tcp_slock_key);
-#endif
 }
 
 static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
@@ -1874,12 +1869,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	}
 
 	sk_net_refcnt_upgrade(queue->sock->sk);
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	lockdep_register_key(&queue->nvme_tcp_sk_key);
-	lockdep_register_key(&queue->nvme_tcp_slock_key);
-	nvme_tcp_reclassify_socket(queue);
-#endif
+	nvme_tcp_reclassify_socket(queue->sock);
 
 	/* Single syn retry */
 	tcp_sock_set_syncnt(queue->sock->sk, 1);
@@ -1984,10 +1974,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	/* Use sync variant - see nvme_tcp_free_queue() for explanation */
 	__fput_sync(queue->sock->file);
 	queue->sock = NULL;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
-	lockdep_unregister_key(&queue->nvme_tcp_slock_key);
-#endif
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
-- 
2.54.0


