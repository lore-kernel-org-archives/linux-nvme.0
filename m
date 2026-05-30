Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C693CD5BD0
	for <linux-nvme@archiver.kernel.org>; Sat, 30 May 2026 05:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qa4DZ0ENYf/mmVpiKpwVatmukpMA/KoaxKEapwPcAXY=; b=qgMU3pmgGxHI2qd3RVgd6wa/TC
	loD8GDPeRMqtNk/SxBm7NaWUd7GvekG5aFusFX28uXw0tOOK1dJsIKt7ZlvRVOxTPrhbOhGcgKs4c
	ArF3n7WU5bYMyLO5egsmz6KlQ/ZvUIjDK1AY7J9OhMbBUVcyV3Y03Jr0gEOX7gU14rPS6KP1v4yVG
	9k6ztu/t9XTEn8pMt91y6afoSuAzc1pXiLDzCXC8zT1H6WCsx13X/vWFm3awDJG1PEaclJoi6TS9R
	BPXXKv2JEZmxHt7GY4d+PpfCtt6+EG87mJ/NakbC17fCjn6eqPdYbavskSg0N3RWzylKiprnWH7jo
	3MrvShlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTC8g-00000008SY7-3t4j;
	Sat, 30 May 2026 05:21:38 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTC8Y-00000008SW5-2ahB
	for linux-nvme@lists.infradead.org;
	Sat, 30 May 2026 05:21:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1780118490; x=1811654490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z5sP1DN7zUCf/OdJQqaNk7SB3bRip4gZLJzrz/MEz3c=;
  b=pqfsdYN4a3I0nkfQ6tmVffjTx8zi8mfO0yHkif5xsV6e6XbJi84sunB3
   YX3P6ILNraWgO/0MVxXZuMc2HX8n0MphHsRj+EOqqDycbaXV6682PNoXz
   KHwANq6jQ+alrysaAZE84UQXSRBCE0xwKvYJJGmJSvLcvaE8ubg9iwF/D
   pmBLseuXYf+Fb8KPMGqup37H1gxzGvnU0uQT1qj5n+g4lbEZhF8Xch8MC
   81dLmFUSTZBKFlvflLqKqjByeIsXhlmpI+y8TfX6xA2wCqm8Vwk2xaUO+
   oYTvvF5IXUk+/5Sj2SW2cbi7RyFk/ABPTDqF1s4nLGI7ty2U0fGfzEcNP
   g==;
X-CSE-ConnectionGUID: 5SJxik9RTM+nOc+HW+bLPQ==
X-CSE-MsgGUID: xUs1WlvgRBKb41O9pTHrnw==
X-IronPort-AV: E=Sophos;i="6.24,176,1774281600"; 
   d="scan'208";a="148919912"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2026 13:21:27 +0800
X-CSE-ConnectionGUID: 5vVQByxeRCSkT31U0Lmr4Q==
X-CSE-MsgGUID: DSDTbYvpRRyEUB+itp1Gpw==
IronPort-SDR: 6a1a73b0_HT7CvnadihkL3PJ4/cLp81vHSZu2dyjhIiW6dSW6FrTIED8
 MKI+gpjIRgK8mv5vrKMCVJGzltna+SGNIr4e+Fg==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 May 2026 22:20:47 -0700
X-CSE-ConnectionGUID: eGMdSBCYQ4upQRroCr5UZg==
X-CSE-MsgGUID: DLxLvc6BTI2m2Gyt3LxcOw==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 29 May 2026 22:20:48 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 1/2] nvme-tcp: move nvme_tcp_reclassify_socket()
Date: Sat, 30 May 2026 14:20:44 +0900
Message-ID: <20260530052045.296749-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260530052045.296749-1-shinichiro.kawasaki@wdc.com>
References: <20260530052045.296749-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260529_222130_715569_958D9B7F 
X-CRM114-Status: GOOD (  16.52  )
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

Move nvme_tcp_reclassify_socket() in tcp.c after the struct
nvme_tcp_queue definition. This is preparation for adding a reference
to struct nvme_tcp_queue in the function, which would otherwise cause a
compile failure due to the struct being defined after the function.

Move the entire CONFIG_DEBUG_LOCK_ALLOC block along with the function
to maintain the code organization.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/host/tcp.c | 76 ++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 15d36d6a728e..0e5764f09f31 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -56,44 +56,6 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 
 static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-/* lockdep can detect a circular dependency of the form
- *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
- * because dependencies are tracked for both nvme-tcp and user contexts. Using
- * a separate class prevents lockdep from conflating nvme-tcp socket use with
- * user-space socket API use.
- */
-static struct lock_class_key nvme_tcp_sk_key[2];
-static struct lock_class_key nvme_tcp_slock_key[2];
-
-static void nvme_tcp_reclassify_socket(struct socket *sock)
-{
-	struct sock *sk = sock->sk;
-
-	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
-		return;
-
-	switch (sk->sk_family) {
-	case AF_INET:
-		sock_lock_init_class_and_name(sk, "slock-AF_INET-NVME",
-					      &nvme_tcp_slock_key[0],
-					      "sk_lock-AF_INET-NVME",
-					      &nvme_tcp_sk_key[0]);
-		break;
-	case AF_INET6:
-		sock_lock_init_class_and_name(sk, "slock-AF_INET6-NVME",
-					      &nvme_tcp_slock_key[1],
-					      "sk_lock-AF_INET6-NVME",
-					      &nvme_tcp_sk_key[1]);
-		break;
-	default:
-		WARN_ON_ONCE(1);
-	}
-}
-#else
-static void nvme_tcp_reclassify_socket(struct socket *sock) { }
-#endif
-
 enum nvme_tcp_send_state {
 	NVME_TCP_SEND_CMD_PDU = 0,
 	NVME_TCP_SEND_H2C_PDU,
@@ -207,6 +169,44 @@ static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+/* lockdep can detect a circular dependency of the form
+ *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
+ * because dependencies are tracked for both nvme-tcp and user contexts. Using
+ * a separate class prevents lockdep from conflating nvme-tcp socket use with
+ * user-space socket API use.
+ */
+static struct lock_class_key nvme_tcp_sk_key[2];
+static struct lock_class_key nvme_tcp_slock_key[2];
+
+static void nvme_tcp_reclassify_socket(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+
+	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
+		return;
+
+	switch (sk->sk_family) {
+	case AF_INET:
+		sock_lock_init_class_and_name(sk, "slock-AF_INET-NVME",
+					      &nvme_tcp_slock_key[0],
+					      "sk_lock-AF_INET-NVME",
+					      &nvme_tcp_sk_key[0]);
+		break;
+	case AF_INET6:
+		sock_lock_init_class_and_name(sk, "slock-AF_INET6-NVME",
+					      &nvme_tcp_slock_key[1],
+					      "sk_lock-AF_INET6-NVME",
+					      &nvme_tcp_sk_key[1]);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+}
+#else
+static void nvme_tcp_reclassify_socket(struct socket *sock) { }
+#endif
+
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
 {
 	return container_of(ctrl, struct nvme_tcp_ctrl, ctrl);
-- 
2.54.0


