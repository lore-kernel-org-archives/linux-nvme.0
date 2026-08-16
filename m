Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B544EC5DF67
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Aug 2026 01:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7YtFNhH3aq+pBVyobarzrZt+vKIeq8cSqiWKG06sDFw=; b=f43qDOlYfmrh/JIGkjU2hotSQn
	pPQ/IzaylmhLVJEmOn/AoWJxMRx3/yKdVvOiV6ANP+Iw0NthJAtScvicHEewvJxf91Jhd7WHFBDAy
	w887xV1QtngtVksZzAc4asb0o6JOACZsUZcayaxrdlW1eUSdz4pXv7bBzQmo8U/dpMLMuLGXqufxs
	+ynmRd4pC18GpCPUqWUewYgOK225RJJKwrUOBqlGUM++3ReA4qkWZ1Vw7TNUerGSoNJxyVjy4TZMn
	eAMEhIUn2mCgGnq3HfsGxcmw2mqWNCmPmsXn8XjARIBGuTS5Ov9IqvEzaogCiagDhRLxaziwPIMeZ
	sv33tX3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvPFK-00000004MQO-0LC9;
	Sun, 16 Aug 2026 01:01:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvPFJ-00000004MQ7-10xi
	for linux-nvme@lists.infradead.org;
	Sun, 16 Aug 2026 01:01:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ABD636001A;
	Sun, 16 Aug 2026 01:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3815D1F000E9;
	Sun, 16 Aug 2026 01:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786842064;
	bh=7YtFNhH3aq+pBVyobarzrZt+vKIeq8cSqiWKG06sDFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bSM5fBhbA/EbbP2ity52Efrpr6QVWt92jSJ6knuJvwAeNPIGJ5pPMgfR35B8YgcRa
	 cxJ2G68InMgUgFs5CF9tM0Y/Iqu/J3v/UNpoHzcYYiOV+SgoSY4uWo/oACJkBs3x7G
	 eyvGkcmKf8pSjARwJG/Lkaj67YZz2yjffhbs+QX46s38B1QjD8S93s1A4qRS26dmdn
	 Z+ucTsOC0iLoSgVMO8pF18/2OLb3V1Vyga9WWntJr4FZCZlyHNuEIzoBWF4pDQebch
	 P6yh/SL/N4cI8Y0aQSn/3r4j9159mP7QnpwdJt6lgncwtVkrzFuIz2MiKY7rgW/ihu
	 uIIGMPKnPoKFQ==
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
Subject: [PATCH v3 2/4] nvme-tcp: unify sockopt with do_sock_setsockopt
Date: Sun, 16 Aug 2026 08:59:58 +0800
Message-ID: <97e667df6c3755d1f9e2e709dfa1dc64903317e1.1786841319.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786841319.git.tanggeliang@kylinos.cn>
References: <cover.1786841319.git.tanggeliang@kylinos.cn>
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

This patch consolidates socket option settings in nvme-tcp by utilizing
the generic do_sock_setsockopt() helper for options including SO_LINGER,
SO_PRIORITY, TCP_NODELAY, IP_TOS, SO_BINDTODEVICE, and TCP_SYNCNT.

Compared to the target-side implementation, this patch additionally
converts SO_BINDTODEVICE and TCP_SYNCNT to use the same unified mechanism.
This change eliminates the need to export and use specialized helpers for
each individual socket option.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 55 +++++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..89a82e8248d2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1774,6 +1774,47 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	return ret;
 }
 
+static void nvme_tcp_sock_no_linger(struct sock *sk)
+{
+	struct linger ling = { .l_onoff = 1, .l_linger = 0 };
+
+	do_sock_setsockopt(sk->sk_socket, false, SOL_SOCKET, SO_LINGER,
+			   KERNEL_SOCKPTR(&ling), sizeof(ling));
+}
+
+static void nvme_tcp_sock_set_priority(struct sock *sk, u32 priority)
+{
+	do_sock_setsockopt(sk->sk_socket, false, SOL_SOCKET, SO_PRIORITY,
+			   KERNEL_SOCKPTR(&priority), sizeof(priority));
+}
+
+static int nvme_tcp_sock_set_bindtodevice(struct sock *sk, char *iface)
+{
+	return do_sock_setsockopt(sk->sk_socket, false, SOL_SOCKET,
+				  SO_BINDTODEVICE, KERNEL_SOCKPTR(iface),
+				  strlen(iface));
+}
+
+static void nvme_tcp_sock_set_nodelay(struct sock *sk)
+{
+	int val = 1;
+
+	do_sock_setsockopt(sk->sk_socket, false, SOL_TCP, TCP_NODELAY,
+			   KERNEL_SOCKPTR(&val), sizeof(val));
+}
+
+static int nvme_tcp_sock_set_syncnt(struct sock *sk, int val)
+{
+	return do_sock_setsockopt(sk->sk_socket, false, SOL_TCP, TCP_SYNCNT,
+				  KERNEL_SOCKPTR(&val), sizeof(val));
+}
+
+static void nvme_tcp_sock_set_tos(struct sock *sk, int tos)
+{
+	do_sock_setsockopt(sk->sk_socket, false, SOL_IP, IP_TOS,
+			   KERNEL_SOCKPTR(&tos), sizeof(tos));
+}
+
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 				key_serial_t pskid)
 {
@@ -1819,24 +1860,24 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 #endif
 
 	/* Single syn retry */
-	tcp_sock_set_syncnt(queue->sock->sk, 1);
+	nvme_tcp_sock_set_syncnt(queue->sock->sk, 1);
 
 	/* Set TCP no delay */
-	tcp_sock_set_nodelay(queue->sock->sk);
+	nvme_tcp_sock_set_nodelay(queue->sock->sk);
 
 	/*
 	 * Cleanup whatever is sitting in the TCP transmit queue on socket
 	 * close. This is done to prevent stale data from being sent should
 	 * the network connection be restored before TCP times out.
 	 */
-	sock_no_linger(queue->sock->sk);
+	nvme_tcp_sock_no_linger(queue->sock->sk);
 
 	if (so_priority > 0)
-		sock_set_priority(queue->sock->sk, so_priority);
+		nvme_tcp_sock_set_priority(queue->sock->sk, so_priority);
 
 	/* Set socket type of service */
 	if (nctrl->opts->tos >= 0)
-		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
+		nvme_tcp_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
 
 	/* Set 10 seconds timeout for icresp recvmsg */
 	queue->sock->sk->sk_rcvtimeo = 10 * HZ;
@@ -1864,10 +1905,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	if (nctrl->opts->mask & NVMF_OPT_HOST_IFACE) {
 		char *iface = nctrl->opts->host_iface;
-		sockptr_t optval = KERNEL_SOCKPTR(iface);
 
-		ret = sock_setsockopt(queue->sock, SOL_SOCKET, SO_BINDTODEVICE,
-				      optval, strlen(iface));
+		ret = nvme_tcp_sock_set_bindtodevice(queue->sock->sk, iface);
 		if (ret) {
 			dev_err(nctrl->device,
 			  "failed to bind to interface %s queue %d err %d\n",
-- 
2.53.0


