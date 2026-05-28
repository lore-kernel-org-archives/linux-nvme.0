Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DAACD5BD0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 03:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1F+n6ooRADX4UcHNc88FEQmlqLp1hzczA9EGmgpkhas=; b=0nywinx2OsLbMadm5/ORl63hUv
	Niwu64mV1d160Hxm+iWaE9RKvrKXvwn70xivlwYlr+kzXZlDiSph93wh7XW5TYiStLiwAbMeDhp99
	DqvZ3H61dbyz2ISsay/TBfr851jNdjRY24xvkUN7ZItBK6cASiULBWZqmOKQob1EFCkPeY81Gkw1L
	y9N2MLfRFVS4k2ER9Tk8XICXI8CnVjrt7WjlzSKFYvaVJLbLaF1QSsKJEJAeuGD5EhqMjo+XyR93c
	9ZIrHBvI5Gnn61C4nloiWUC9RzBIxW66ZLipi7VFDet318pTG92bn4jB7tIZ8g3nlU1LkRs44kobO
	c+rbOuUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSRAD-000000052Qv-1APv;
	Thu, 28 May 2026 03:12:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSRAA-000000052PN-0gEC
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 03:12:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BD86944397;
	Thu, 28 May 2026 03:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C321F000E9;
	Thu, 28 May 2026 03:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779937921;
	bh=1F+n6ooRADX4UcHNc88FEQmlqLp1hzczA9EGmgpkhas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RyXvSfqjQR3yaBYapgKPN2MlrEdRFvbzjZz0Gs+qCb155kgDneU/17hSVst4mdyzU
	 INjV7ejl9VLE7WNENyB/l3j8DkcWm0t5sEabaPH+caic2Jdg3h5GMay5/+7jlwm5oA
	 PpfBcynj/NNQp/qRH46JNCKJtUgA0ZQVUIbvBAtW+lNb+Onx3ddTrHFH6svpNewvsR
	 Ot+reu2pdSqPo6udjEeclcj3BBPBhOGwKsOAT44RcLvnS33qLpQhR76/1mAjOMn8ks
	 lgKmBj3WHdLQeYXX34o1PofWdbJEnxZnnAGEE+k3+r3CMD9x1KSZeKvRx0KLWdSR96
	 duEIpCVg4ftlQ==
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
Subject: [PATCH 05/11] nvmet-tcp: implement mptcp listen socket ops
Date: Thu, 28 May 2026 11:10:39 +0800
Message-ID: <94d8286242b894e8bc9a9a3391c4d3db778f96c0.1779934709.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779934709.git.tanggeliang@kylinos.cn>
References: <cover.1779934709.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_201202_266428_48CFED37 
X-CRM114-Status: GOOD (  15.62  )
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

An MPTCP-specific version of struct nvmet_tcp_proto_ops is implemented
for listen sockets. It is assigned to port->proto_ops when the transport
type is MPTCP.

Dedicated MPTCP helpers are introduced for setting listen socket options.
The set_nodelay and set_priority helpers set the values on all existing
subflows using mptcp_for_each_subflow(). The set_reuseaddr helper only
applies to the first subflow. The values are then synchronized to other
newly created subflows in sync_socket_options().

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
 drivers/nvme/target/tcp.c | 13 ++++++++++++
 include/net/mptcp.h       |  8 ++++++++
 net/mptcp/sockopt.c       | 42 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index e2f3de364c2b..8c2dc4bcbcd3 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2101,6 +2101,15 @@ static const struct nvmet_tcp_proto_ops nvmet_tcp_proto_ops = {
 	.set_priority	= sock_set_priority,
 };
 
+#ifdef CONFIG_MPTCP
+static const struct nvmet_tcp_proto_ops nvmet_mptcp_proto_ops = {
+	.protocol	= IPPROTO_MPTCP,
+	.set_reuseaddr	= mptcp_sock_set_reuseaddr,
+	.set_nodelay	= mptcp_sock_set_nodelay,
+	.set_priority	= mptcp_sock_set_priority,
+};
+#endif
+
 static int nvmet_tcp_add_port(struct nvmet_port *nport)
 {
 	const struct nvmet_tcp_proto_ops *ops;
@@ -2128,6 +2137,10 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 
 	if (nport->disc_addr.trtype == NVMF_TRTYPE_TCP) {
 		ops = &nvmet_tcp_proto_ops;
+#ifdef CONFIG_MPTCP
+	} else if (nport->disc_addr.trtype == NVMF_TRTYPE_MPTCP) {
+		ops = &nvmet_mptcp_proto_ops;
+#endif
 	} else {
 		ret = -EINVAL;
 		goto err_port;
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index bf74dedc578d..b8ab214a7890 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -239,6 +239,10 @@ void mptcp_sock_no_linger(struct sock *sk);
 void mptcp_sock_set_priority(struct sock *sk, u32 priority);
 
 void mptcp_sock_set_tos(struct sock *sk);
+
+void mptcp_sock_set_reuseaddr(struct sock *sk);
+
+void mptcp_sock_set_nodelay(struct sock *sk);
 #else
 
 static inline void mptcp_init(void)
@@ -331,6 +335,10 @@ static inline void mptcp_sock_no_linger(struct sock *sk) { }
 static inline void mptcp_sock_set_priority(struct sock *sk, u32 priority) { }
 
 static inline void mptcp_sock_set_tos(struct sock *sk) { }
+
+static inline void mptcp_sock_set_reuseaddr(struct sock *sk) { }
+
+static inline void mptcp_sock_set_nodelay(struct sock *sk) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 359b1eb2d0a9..0adbbe568f6e 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1596,6 +1596,8 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
 	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
+
+	ssk->sk_reuse = sk->sk_reuse;
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
@@ -1741,3 +1743,43 @@ void mptcp_sock_set_tos(struct sock *sk)
 		__mptcp_sock_set_tos(sk, val);
 }
 EXPORT_SYMBOL(mptcp_sock_set_tos);
+
+void mptcp_sock_set_reuseaddr(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	sk->sk_reuse = SK_CAN_REUSE;
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk))
+		goto unlock;
+	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	ssk->sk_reuse = SK_CAN_REUSE;
+	release_sock(ssk);
+unlock:
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_set_reuseaddr);
+
+void mptcp_sock_set_nodelay(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	msk->nodelay = true;
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		if (ssk) {
+			lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+			__tcp_sock_set_nodelay(ssk, true);
+			release_sock(ssk);
+		}
+	}
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_set_nodelay);
-- 
2.53.0


