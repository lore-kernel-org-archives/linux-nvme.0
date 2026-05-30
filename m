Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F008CD6E4A
	for <linux-nvme@archiver.kernel.org>; Sat, 30 May 2026 05:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IIEMuAyTu2bseIGoT3MMXYYuUDkwYs+hCxhzaBv8v/8=; b=RAsHcQ5IMS04sHhuMwn/DEAkS9
	KNDkaYfWDTtw/iSYvYz7JBIiVzv87Y85MtfxywfcSnPj6pp9hXFo/QMyBRS70rGdnZ9JoAJBRFHqm
	Sui/ir5Z0ZoZjILwd2LYsNfu/Bq7Z9phGteitPpcSOQrHyHylbQUNSrLFF0118BiZ5TofTmIsg9HO
	b2Z/i0JTs0xmrI3R1YTKFeKmZLlifNHR2kl0TfR8L1FLXStp5T/y0DIOAzaC+u1yvA50pqhMTxh3Q
	kTHkDFM++WZquu/UThcd5ABe+B7i7TnIeaUmUfL9N632mzBL3OK0PSQoJ8HjczzAeK/OjHvvMfbsC
	sSem76Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTC8h-00000008SYD-05WI;
	Sat, 30 May 2026 05:21:39 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTC8Y-00000008SWX-3WWP
	for linux-nvme@lists.infradead.org;
	Sat, 30 May 2026 05:21:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1780118490; x=1811654490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fB9EA+qcZIZAtB1BTl/ZzrJUGTiMAWAplf/TG9h0D9k=;
  b=APSBWRbghJKHBTfQwpQMMADvBrhZpVMjG816AeGmVPYpRA8Yk2vRvl2X
   n/rt7TedjHFSYlHNyTZfjM55O6dg2fJ5WhCQKXocV7cfTsLyPeuNXBtZZ
   KIHsIG2+dzvguU0MZ/9D0JerRouEPfU/9yanEKAL4a4nna/MvX9/10ckj
   5udgk+ceKqVo9ifWEP0X+4iq0+K01/NDdFXhIFuP+bJoAvRfjy0NDYBJH
   V3KMtM+7iIumCoWDbhzu28s6EW7/r04c0D2xA99IdfS6XDEQ179HveuFO
   hhU5Ux1O94CCGSSeFcFMwqGek6k984fIm6FSa5AKrFbk23VaOKpwX0PFc
   Q==;
X-CSE-ConnectionGUID: c6UI63MVS5GdBLzfhUNfZg==
X-CSE-MsgGUID: 6Fcdaai/TiWlyhR9p9d5Eg==
X-IronPort-AV: E=Sophos;i="6.24,176,1774281600"; 
   d="scan'208";a="148919914"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2026 13:21:27 +0800
X-CSE-ConnectionGUID: a6Hsc7kdSFqOhvDJbJiQIg==
X-CSE-MsgGUID: 9eoPsyMrSD2OhMB1GQ4zVg==
IronPort-SDR: 6a1a73b1_pFDymEeggreG6yF/WPa4EpkciPz4Cl5BNzbDJd/o+OnQETS
 a+wGFQL7pcN+PmAW67kE3X3t6m++7yFSA39PR4Q==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 May 2026 22:20:48 -0700
X-CSE-ConnectionGUID: T1tFEwngTaOHE42i0Q0CPw==
X-CSE-MsgGUID: uUOf/k15QrCOG+Ywtd8DUQ==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 29 May 2026 22:20:49 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 2/2] nvme-tcp: lockdep: use dynamic lockdep keys per socket instance
Date: Sat, 30 May 2026 14:20:45 +0900
Message-ID: <20260530052045.296749-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260530052045.296749-1-shinichiro.kawasaki@wdc.com>
References: <20260530052045.296749-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260529_222130_940883_F1F2EE15 
X-CRM114-Status: GOOD (  16.04  )
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
tracking. Change the arguement of nvme_tcp_reclassify_socket() from
'struct socket *' to 'struct nvme_tcp_queue *' to pass both the socket
and the keys.

Link: https://lore.kernel.org/linux-nvme/afB5syZbUrppgsDQ@shinmob/
Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/host/tcp.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0e5764f09f31..51d496f414a1 100644
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
@@ -176,12 +181,12 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
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
+
+	lockdep_register_key(&queue->nvme_tcp_sk_key);
+	lockdep_register_key(&queue->nvme_tcp_slock_key);
 
 	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
 		return;
@@ -189,22 +194,22 @@ static void nvme_tcp_reclassify_socket(struct socket *sock)
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
 #else
-static void nvme_tcp_reclassify_socket(struct socket *sock) { }
+static void nvme_tcp_reclassify_socket(struct nvme_tcp_queue *queue) { }
 #endif
 
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
@@ -1468,6 +1473,11 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
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
@@ -1813,7 +1823,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	}
 
 	sk_net_refcnt_upgrade(queue->sock->sk);
-	nvme_tcp_reclassify_socket(queue->sock);
+	nvme_tcp_reclassify_socket(queue);
 
 	/* Single syn retry */
 	tcp_sock_set_syncnt(queue->sock->sk, 1);
-- 
2.54.0


