Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B0FC5DF70
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 06:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7e86Qnm6H9Lggduhxe1ZAqQOUAeMCD6ncoq8Z1k+VhA=; b=lJrQeS65OQbnBoBf6oGqOGW8Uo
	Z5zip7yAlYI1gIShVYdK9tgFRnlQbtERQQHoPwM7fVgE0vyqpLGi6Qr6r/rs6uE+UbLs4WZC6j8I5
	6XdvZWacaXig0yqyNCd6Y3+FVKaPZ/yecNzwu3ekCgrVfRYWmLhsaX+KzwJm/9fLHDVFr0d8pbF9P
	cyrGYHT1M+10kxP1eBf7Kesgp9PnfMKOcZJBxKqf65bNhrzIPKuH+kI2/9bryrh7TbF5Jg7X855xD
	zAV8FrNK2sk80LthWiEvxgreV5/L6uQOcHqBP3bWr1sQ50bb+i55/JZq6jykkoiHh5yM7C9oojAKc
	Q8276J8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwCvE-00000007NFp-2CiI;
	Tue, 18 Aug 2026 06:03:40 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwCvD-00000007NFb-1A4Q
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 06:03:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B53EA600C8;
	Tue, 18 Aug 2026 06:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9A91F00A3D;
	Tue, 18 Aug 2026 06:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787033018;
	bh=7e86Qnm6H9Lggduhxe1ZAqQOUAeMCD6ncoq8Z1k+VhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YQvaLOa5c6oxVX8Pxnmnc1HtrWESrl48NVxshGoB0SIcZRdBB9I4jTfDm12HPRFrI
	 zD5SgOpN0Sm0+1uH16MG9WTcXlJIJkIFUuMWaVBdMOTDF8W5SgVlpV8+kJp9e6kHhG
	 TLffkfBScnLSk3gBjUSdFRQpuQbQ9n+HaHJ9T14HkVCSUg+2enysOsved6Agbb87IF
	 PVLqrgDciWnfsPPS1eYKKKkSMcx2VJP8C0m1+BbLGrReqr2bwbSqcPOcVE0xoRYw9S
	 b1UFQ8+iaMqAmXrd0rtnhnEX+xzEMksHEdGasugGoM+T1cnuhCF5SKvmGMflI36j1A
	 6rTS4wCfkLHww==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH v4 1/4] nvmet-tcp: unify sockopt with do_sock_setsockopt
Date: Tue, 18 Aug 2026 14:03:00 +0800
Message-ID: <010e6810cc4c10b30237c964b2bb9dfa7a3c740c.1786947923.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786947923.git.tanggeliang@kylinos.cn>
References: <cover.1786947923.git.tanggeliang@kylinos.cn>
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

This patch consolidates socket option settings in nvmet-tcp by utilizing
the generic do_sock_setsockopt() helper for options including SO_LINGER,
SO_PRIORITY, SO_REUSEADDR, TCP_NODELAY, and IP_TOS. This change eliminates
the need to export and use specialized helpers for each individual socket
option.

A key benefit of this refactoring is that it decouples the socket option
configuration from the underlying transport protocol. This makes it
easier to extend nvmet-tcp to support other protocols, such as MPTCP, in
the future, as do_sock_setsockopt() abstracts away protocol-specific
differences without requiring per-option protocol-specific wrappers.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 82 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 72 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 75a276d73be3..38b0c446ae89 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1696,10 +1696,50 @@ static void nvmet_tcp_state_change(struct sock *sk)
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
+static int nvmet_tcp_sock_no_linger(struct sock *sk)
+{
+	struct linger ling = { .l_onoff = 1, .l_linger = 0 };
+
+	return do_sock_setsockopt(sk->sk_socket, false, SOL_SOCKET, SO_LINGER,
+				  KERNEL_SOCKPTR(&ling), sizeof(ling));
+}
+
+static int nvmet_tcp_sock_set_priority(struct sock *sk, u32 priority)
+{
+	return do_sock_setsockopt(sk->sk_socket, false, SOL_SOCKET, SO_PRIORITY,
+				  KERNEL_SOCKPTR(&priority), sizeof(priority));
+}
+
+static int nvmet_tcp_sock_set_reuseaddr(struct sock *sk)
+{
+	int val = SK_CAN_REUSE;
+
+	return do_sock_setsockopt(sk->sk_socket, false, SOL_SOCKET,
+				  SO_REUSEADDR, KERNEL_SOCKPTR(&val),
+				  sizeof(val));
+}
+
+static int nvmet_tcp_sock_set_nodelay(struct sock *sk)
+{
+	int val = 1;
+
+	return do_sock_setsockopt(sk->sk_socket, false, SOL_TCP, TCP_NODELAY,
+				  KERNEL_SOCKPTR(&val), sizeof(val));
+}
+
+static int nvmet_tcp_sock_set_tos(struct sock *sk)
+{
+	int tos = inet_sk(sk)->rcv_tos;
+
+	if (tos > 0)
+		return do_sock_setsockopt(sk->sk_socket, false, SOL_IP, IP_TOS,
+					  KERNEL_SOCKPTR(&tos), sizeof(tos));
+	return 0;
+}
+
 static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
-	struct inet_sock *inet = inet_sk(sock->sk);
 	int ret;
 
 	ret = kernel_getsockname(sock,
@@ -1717,14 +1757,20 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	 * close. This is done to prevent stale data from being sent should
 	 * the network connection be restored before TCP times out.
 	 */
-	sock_no_linger(sock->sk);
+	ret = nvmet_tcp_sock_no_linger(sock->sk);
+	if (ret)
+		return ret;
 
-	if (so_priority > 0)
-		sock_set_priority(sock->sk, so_priority);
+	if (so_priority > 0) {
+		ret = nvmet_tcp_sock_set_priority(sock->sk, so_priority);
+		if (ret)
+			return ret;
+	}
 
 	/* Set socket type of service */
-	if (inet->rcv_tos > 0)
-		ip_sock_set_tos(sock->sk, inet->rcv_tos);
+	ret = nvmet_tcp_sock_set_tos(sock->sk);
+	if (ret)
+		return ret;
 
 	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
@@ -2098,10 +2144,26 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	port->sock->sk->sk_user_data = port;
 	port->data_ready = port->sock->sk->sk_data_ready;
 	port->sock->sk->sk_data_ready = nvmet_tcp_listen_data_ready;
-	sock_set_reuseaddr(port->sock->sk);
-	tcp_sock_set_nodelay(port->sock->sk);
-	if (so_priority > 0)
-		sock_set_priority(port->sock->sk, so_priority);
+	ret = nvmet_tcp_sock_set_reuseaddr(port->sock->sk);
+	if (ret) {
+		pr_err("failed to set SO_REUSEADDR on port socket %d\n", ret);
+		goto err_sock;
+	}
+
+	ret = nvmet_tcp_sock_set_nodelay(port->sock->sk);
+	if (ret) {
+		pr_err("failed to set TCP_NODELAY on port socket %d\n", ret);
+		goto err_sock;
+	}
+
+	if (so_priority > 0) {
+		ret = nvmet_tcp_sock_set_priority(port->sock->sk, so_priority);
+		if (ret) {
+			pr_err("failed to set SO_PRIORITY on port socket %d\n",
+			       ret);
+			goto err_sock;
+		}
+	}
 
 	ret = kernel_bind(port->sock, (struct sockaddr_unsized *)&port->addr,
 			sizeof(port->addr));
-- 
2.53.0


