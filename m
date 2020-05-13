Return-Path: <SRS0=q3TM=63=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ED7C2D0F8
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 06:27:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D3D2312B
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 06:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nOmu4ayM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D3D2312B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PCavy9BEJashcF1T7vubFP5jfsQP9F1/4iGspLNNMA8=; b=nOmu4ayMuc/BQT
	5ShYIyYUpXA63cePB0KjUNC2Pf1LjdT8LdQrwO69QvKSUgg3Z3UsZ/BlmCIT6aAxtYpwphnDdo1Zz
	o8lsYfxxMPXnQodn0EOQYixJKos5H6TcbHzKpKdo3BiXHOgSnx2OvNj7xvlTopoGGpi4MjIEeK1ZU
	t18RKbfs8PWlHzCJiXkMpq2IbgdjZFaXSuZifuDOXPnSw64MqOWEpzHXzdBxVIkri/p5KZQ0c1BF3
	iaxV0BvJwoYpS01X+WdcSl6n8sc+csg/ifogPsAEm9jKb76lZ2Lh/SYY02RimUmOs7iKq753TIIVn
	fB2M3PdZ3a3UeTdDkd3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYkr6-0003qv-Hf; Wed, 13 May 2020 06:27:00 +0000
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYkr0-0003lx-3E; Wed, 13 May 2020 06:26:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 01/33] net: add sock_set_reuseaddr
Date: Wed, 13 May 2020 08:26:16 +0200
Message-Id: <20200513062649.2100053-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513062649.2100053-1-hch@lst.de>
References: <20200513062649.2100053-1-hch@lst.de>
MIME-Version: 1.0
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
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Eric Dumazet <edumazet@google.com>, linux-nvme@lists.infradead.org,
 linux-sctp@vger.kernel.org, target-devel@vger.kernel.org,
 linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
 linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-rdma@vger.kernel.org, cluster-devel@redhat.com,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-block@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Neil Horman <nhorman@tuxdriver.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, linux-kernel@vger.kernel.org,
 Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
 ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a helper to directly set the SO_REUSEADDR sockopt from kernel space
without going through a fake uaccess.

For this the iscsi target now has to formally depend on inet to avoid
a mostly theoretical compile failure.  For actual operation it already
did depend on having ipv4 or ipv6 support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/sw/siw/siw_cm.c        | 18 +++++-------------
 drivers/nvme/target/tcp.c                 |  8 +-------
 drivers/target/iscsi/Kconfig              |  2 +-
 drivers/target/iscsi/iscsi_target_login.c |  9 +--------
 fs/dlm/lowcomms.c                         |  6 +-----
 include/net/sock.h                        |  1 +
 net/core/sock.c                           |  8 ++++++++
 7 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 559e5fd3bad8b..6d7c8c933736c 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1312,17 +1312,14 @@ static void siw_cm_llp_state_change(struct sock *sk)
 static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
 			      struct sockaddr *raddr)
 {
-	int rv, flags = 0, s_val = 1;
+	int rv, flags = 0;
 	size_t size = laddr->sa_family == AF_INET ?
 		sizeof(struct sockaddr_in) : sizeof(struct sockaddr_in6);
 
 	/*
 	 * Make address available again asap.
 	 */
-	rv = kernel_setsockopt(s, SOL_SOCKET, SO_REUSEADDR, (char *)&s_val,
-			       sizeof(s_val));
-	if (rv < 0)
-		return rv;
+	sock_set_reuseaddr(s->sk, SK_CAN_REUSE);
 
 	rv = s->ops->bind(s, laddr, size);
 	if (rv < 0)
@@ -1781,7 +1778,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 	struct siw_cep *cep = NULL;
 	struct siw_device *sdev = to_siw_dev(id->device);
 	int addr_family = id->local_addr.ss_family;
-	int rv = 0, s_val;
+	int rv = 0;
 
 	if (addr_family != AF_INET && addr_family != AF_INET6)
 		return -EAFNOSUPPORT;
@@ -1793,13 +1790,8 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 	/*
 	 * Allow binding local port when still in TIME_WAIT from last close.
 	 */
-	s_val = 1;
-	rv = kernel_setsockopt(s, SOL_SOCKET, SO_REUSEADDR, (char *)&s_val,
-			       sizeof(s_val));
-	if (rv) {
-		siw_dbg(id->device, "setsockopt error: %d\n", rv);
-		goto error;
-	}
+	sock_set_reuseaddr(s->sk, SK_CAN_REUSE);
+
 	if (addr_family == AF_INET) {
 		struct sockaddr_in *laddr = &to_sockaddr_in(id->local_addr);
 
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index f0da04e960f40..791aa32beeb98 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1632,6 +1632,7 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	port->sock->sk->sk_user_data = port;
 	port->data_ready = port->sock->sk->sk_data_ready;
 	port->sock->sk->sk_data_ready = nvmet_tcp_listen_data_ready;
+	sock_set_reuseaddr(port->sock->sk, SK_CAN_REUSE);
 
 	opt = 1;
 	ret = kernel_setsockopt(port->sock, IPPROTO_TCP,
@@ -1641,13 +1642,6 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		goto err_sock;
 	}
 
-	ret = kernel_setsockopt(port->sock, SOL_SOCKET, SO_REUSEADDR,
-			(char *)&opt, sizeof(opt));
-	if (ret) {
-		pr_err("failed to set SO_REUSEADDR sock opt %d\n", ret);
-		goto err_sock;
-	}
-
 	if (so_priority > 0) {
 		ret = kernel_setsockopt(port->sock, SOL_SOCKET, SO_PRIORITY,
 				(char *)&so_priority, sizeof(so_priority));
diff --git a/drivers/target/iscsi/Kconfig b/drivers/target/iscsi/Kconfig
index 1f93ea3813536..922484ea4e304 100644
--- a/drivers/target/iscsi/Kconfig
+++ b/drivers/target/iscsi/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config ISCSI_TARGET
 	tristate "Linux-iSCSI.org iSCSI Target Mode Stack"
-	depends on NET
+	depends on INET
 	select CRYPTO
 	select CRYPTO_CRC32C
 	select CRYPTO_CRC32C_INTEL if X86
diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
index 731ee67fe914b..7da59ece3eb99 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -909,14 +909,7 @@ int iscsit_setup_np(
 		}
 	}
 
-	/* FIXME: Someone please explain why this is endian-safe */
-	ret = kernel_setsockopt(sock, SOL_SOCKET, SO_REUSEADDR,
-			(char *)&opt, sizeof(opt));
-	if (ret < 0) {
-		pr_err("kernel_setsockopt() for SO_REUSEADDR"
-			" failed\n");
-		goto fail;
-	}
+	sock_set_reuseaddr(sock->sk, SK_CAN_REUSE);
 
 	ret = kernel_setsockopt(sock, IPPROTO_IP, IP_FREEBIND,
 			(char *)&opt, sizeof(opt));
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index cdfaf4f0e11a0..48e7ba796c6fb 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1244,12 +1244,8 @@ static struct socket *tcp_create_listen_sock(struct connection *con,
 	kernel_setsockopt(sock, SOL_TCP, TCP_NODELAY, (char *)&one,
 			  sizeof(one));
 
-	result = kernel_setsockopt(sock, SOL_SOCKET, SO_REUSEADDR,
-				   (char *)&one, sizeof(one));
+	sock_set_reuseaddr(sock->sk, SK_CAN_REUSE);
 
-	if (result < 0) {
-		log_print("Failed to set SO_REUSEADDR on socket: %d", result);
-	}
 	write_lock_bh(&sock->sk->sk_callback_lock);
 	sock->sk->sk_user_data = con;
 	save_listen_callbacks(sock);
diff --git a/include/net/sock.h b/include/net/sock.h
index 3e8c6d4b4b59f..e801a147ad746 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2687,5 +2687,6 @@ static inline bool sk_dev_equal_l3scope(struct sock *sk, int dif)
 }
 
 void sock_def_readable(struct sock *sk);
+void sock_set_reuseaddr(struct sock *sk, unsigned char reuse);
 
 #endif	/* _SOCK_H */
diff --git a/net/core/sock.c b/net/core/sock.c
index fd85e651ce284..ff4faa3e68ac4 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -712,6 +712,14 @@ bool sk_mc_loop(struct sock *sk)
 }
 EXPORT_SYMBOL(sk_mc_loop);
 
+void sock_set_reuseaddr(struct sock *sk, unsigned char reuse)
+{
+	lock_sock(sk);
+	sk->sk_reuse = reuse;
+	release_sock(sk);
+}
+EXPORT_SYMBOL(sock_set_reuseaddr);
+
 /*
  *	This is meant for all protocols to use and covers goings on
  *	at the socket level. Everything here is generic.
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
