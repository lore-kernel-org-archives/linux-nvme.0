Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC6DCD5BD0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 03:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6+8IEzoRehjjp8IjXCg+Lnt1AIJejqKg0hiZ67zNe3s=; b=UaDlvbI4Brk76/mUEE9Jj3Dh6X
	a/1uINtiO5Hg3E/hXd57mIr3xBU1jieQttiXItC96hB5tGHm9JY7E1uGtRCX6ovUoYSku3wqa+gEw
	dw8rurFOyr76pvSXYfAi3xIwdlmbUXRtz3Yff8G7G4+jTwQ7ajdyb3WSmEsed3ZbV5JMG3CTzEwqY
	5IWRyYomkGSivhEhaWMwwVjlJvEOpdf0AnIeEAV6I5yUN2y2WSPlrOwxXHaO5Wvf6sRxD/0WzolAo
	t5Pe//RkEmPNRxjndV4KJHT7HJGAWd/Ig6ZRioHWWPk5G66NvduragV7BTIMJDfw9CCc4+yx0Kj6u
	L9z5xLig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSR9q-000000052Gp-3HLM;
	Thu, 28 May 2026 03:11:42 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSR9o-000000052G3-3q47
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 03:11:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 16647605D3;
	Thu, 28 May 2026 03:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C4E1F00A3C;
	Thu, 28 May 2026 03:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779937899;
	bh=6+8IEzoRehjjp8IjXCg+Lnt1AIJejqKg0hiZ67zNe3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FIWn/mYDkjaJRU7bNOFKOv2WcJ6KtrWz08uijEIWCU/NMaxtn3tSMRmcOmQ18kAlX
	 kj16jDwA9JMfjlulFOCPPytGbM3uzx3sBlRao1z8vQmnUOzSndXpOMHAMdxfT5A+5L
	 0s+5qOt2DztUI0Vu2VV42fpc38Yy32uFnFXJHougFhLaRe673S/83mq+oLt/ryhas3
	 S9aCIvyhU5lg67UPy4fREjn9DI7wYsXP5lVKLZehZMP1XbUzCKFbWBs9tChi5Lx991
	 vzwkdOghWMX1XzhIBrA9iTYmFPvf5tbl5IT7eOWJtnb46Are25ZChchdMZmh+9LOal
	 zEeUkh/1kC75A==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH 02/11] nvmet-tcp: implement accept mptcp proto
Date: Thu, 28 May 2026 11:10:36 +0800
Message-ID: <a1fa5dd3ebb0cafe1bf7948bf2a96436e9452e19.1779934709.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779934709.git.tanggeliang@kylinos.cn>
References: <cover.1779934709.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Geliang Tang <tanggeliang@kylinos.cn>

An MPTCP-specific version of struct nvmet_tcp_proto is implemented for
accept sockets. It is assigned to queue->proto when the accepted socket
protocol is IPPROTO_MPTCP.

Dedicated MPTCP helpers are introduced for setting accept socket options.
These helpers (no_linger, set_priority, set_tos) set the values on all
existing subflows using mptcp_for_each_subflow(). The values are then
synchronized to other newly created subflows in sync_socket_options().

Cc: Hannes Reinecke <hare@suse.de>
Cc: John Meneghini <jmeneghi@redhat.com>
Cc: Randy Jennings <randyj@purestorage.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 16 ++++++++
 include/net/mptcp.h       | 12 ++++++
 net/mptcp/sockopt.c       | 79 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 01c23fb15b79..16f153a9772b 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -220,6 +220,9 @@ static DEFINE_MUTEX(nvmet_tcp_queue_mutex);
 
 static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
+#ifdef CONFIG_MPTCP
+static const struct nvmet_fabrics_ops nvmet_mptcp_ops;
+#endif
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
 
@@ -1928,6 +1931,15 @@ static const struct nvmet_tcp_proto nvmet_tcp_proto = {
 	.ops		= &nvmet_tcp_ops,
 };
 
+#ifdef CONFIG_MPTCP
+static const struct nvmet_tcp_proto nvmet_mptcp_proto = {
+	.no_linger	= mptcp_sock_no_linger,
+	.set_priority	= mptcp_sock_set_priority,
+	.set_tos	= mptcp_sock_set_tos,
+	.ops		= &nvmet_mptcp_ops,
+};
+#endif
+
 static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		struct socket *newsock)
 {
@@ -1947,6 +1959,10 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	queue->sock = newsock;
 	if (newsock->sk->sk_protocol == IPPROTO_TCP) {
 		queue->proto = &nvmet_tcp_proto;
+#ifdef CONFIG_MPTCP
+	} else if (newsock->sk->sk_protocol == IPPROTO_MPTCP) {
+		queue->proto = &nvmet_mptcp_proto;
+#endif
 	} else {
 		ret = -EINVAL;
 		goto out_free_queue;
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index aef2dbeb847b..bf74dedc578d 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -233,6 +233,12 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 }
 
 void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
+
+void mptcp_sock_no_linger(struct sock *sk);
+
+void mptcp_sock_set_priority(struct sock *sk, u32 priority);
+
+void mptcp_sock_set_tos(struct sock *sk);
 #else
 
 static inline void mptcp_init(void)
@@ -319,6 +325,12 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
+
+static inline void mptcp_sock_no_linger(struct sock *sk) { }
+
+static inline void mptcp_sock_set_priority(struct sock *sk, u32 priority) { }
+
+static inline void mptcp_sock_set_tos(struct sock *sk) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 87b5796d0135..359b1eb2d0a9 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1662,3 +1662,82 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
 	}
 	return 0;
 }
+
+void mptcp_sock_no_linger(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	WRITE_ONCE(sk->sk_lingertime, 0);
+	sock_set_flag(sk, SOCK_LINGER);
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		if (ssk) {
+			lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+			WRITE_ONCE(ssk->sk_lingertime, 0);
+			sock_set_flag(ssk, SOCK_LINGER);
+			release_sock(ssk);
+		}
+	}
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_no_linger);
+
+void mptcp_sock_set_priority(struct sock *sk, u32 priority)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	sock_set_priority(sk, priority);
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		if (ssk) {
+			lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+			sock_set_priority(ssk, priority);
+			release_sock(ssk);
+		}
+	}
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_set_priority);
+
+static void __mptcp_sock_set_tos(struct sock *sk, int val)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	__ip_sock_set_tos(sk, val);
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		if (ssk) {
+			lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+			__ip_sock_set_tos(ssk, val);
+			release_sock(ssk);
+		}
+	}
+	release_sock(sk);
+}
+
+void mptcp_sock_set_tos(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	int val = 0;
+
+	lock_sock(sk);
+	if (msk->first)
+		val = inet_sk(msk->first)->rcv_tos;
+	release_sock(sk);
+
+	if (val > 0)
+		__mptcp_sock_set_tos(sk, val);
+}
+EXPORT_SYMBOL(mptcp_sock_set_tos);
-- 
2.53.0


