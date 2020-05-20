Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66631C433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 19:57:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03CDB207D8
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 19:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H1DUbkop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CDB207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nf3iNlBLPp8FycqOvQ+AfvBv3nzj9q/w8ZuS4PGJTVs=; b=H1DUbkopznOiit
	AHl1uoynbxdYyt9n52wz5RpK1+s5jnWbZnU/+Epww/HwC1d5cAgXTBHR+XY1oc1jy/JitLyEWQrfw
	0u5SP9tpvA+x4plMm4+byePonlO8E8J9gpltAGuAgFV/RgIC1eyEeV1xJSbPoNNGtCg+hCz2D9HFA
	dJpb0QZ3SWj9x2+EE7QMezB870KQq2f2E47hfpdov2lyrjFTd0QRVbB6vyhG63gIAh5cGtj8kR1PG
	geHhJjTaR3JogQbt6Q1poTFUJUmw/31GygDZxZczudz1q4t77I5q2EWLhvMuHddCYyMX8aDYm/L0V
	/ol3L8SqH05oCV61TULg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbUq1-00047L-He; Wed, 20 May 2020 19:57:13 +0000
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbUoS-0002L3-E8; Wed, 20 May 2020 19:55:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 09/33] net: add sock_set_keepalive
Date: Wed, 20 May 2020 21:54:45 +0200
Message-Id: <20200520195509.2215098-10-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520195509.2215098-1-hch@lst.de>
References: <20200520195509.2215098-1-hch@lst.de>
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
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, ceph-devel@vger.kernel.org,
 linux-nfs@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, linux-kernel@vger.kernel.org,
 Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
 ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a helper to directly set the SO_KEEPALIVE sockopt from kernel space
without going through a fake uaccess.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/dlm/lowcomms.c     |  6 +-----
 include/net/sock.h    |  1 +
 net/core/sock.c       | 10 ++++++++++
 net/rds/tcp_listen.c  |  6 +-----
 net/sunrpc/xprtsock.c |  4 +---
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index b79711d0aac72..b6e6dba281547 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1142,11 +1142,7 @@ static struct socket *tcp_create_listen_sock(struct connection *con,
 		con->sock = NULL;
 		goto create_out;
 	}
-	result = kernel_setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
-				 (char *)&one, sizeof(one));
-	if (result < 0) {
-		log_print("Set keepalive failed: %d", result);
-	}
+	sock_set_keepalive(sock->sk);
 
 	result = sock->ops->listen(sock, 5);
 	if (result < 0) {
diff --git a/include/net/sock.h b/include/net/sock.h
index 99ef43508d2b5..dc08c176238fd 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2691,6 +2691,7 @@ void sock_def_readable(struct sock *sk);
 int sock_bindtoindex(struct sock *sk, int ifindex);
 void sock_enable_timestamps(struct sock *sk);
 void sock_no_linger(struct sock *sk);
+void sock_set_keepalive(struct sock *sk);
 void sock_set_priority(struct sock *sk, u32 priority);
 void sock_set_reuseaddr(struct sock *sk);
 void sock_set_sndtimeo(struct sock *sk, s64 secs);
diff --git a/net/core/sock.c b/net/core/sock.c
index e4a4dd2b3d8b3..728f5fb156a0c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -779,6 +779,16 @@ void sock_enable_timestamps(struct sock *sk)
 }
 EXPORT_SYMBOL(sock_enable_timestamps);
 
+void sock_set_keepalive(struct sock *sk)
+{
+	lock_sock(sk);
+	if (sk->sk_prot->keepalive)
+		sk->sk_prot->keepalive(sk, true);
+	sock_valbool_flag(sk, SOCK_KEEPOPEN, true);
+	release_sock(sk);
+}
+EXPORT_SYMBOL(sock_set_keepalive);
+
 /*
  *	This is meant for all protocols to use and covers goings on
  *	at the socket level. Everything here is generic.
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index bbb31b9c0b391..d8bd132769594 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -43,13 +43,9 @@ int rds_tcp_keepalive(struct socket *sock)
 	/* values below based on xs_udp_default_timeout */
 	int keepidle = 5; /* send a probe 'keepidle' secs after last data */
 	int keepcnt = 5; /* number of unack'ed probes before declaring dead */
-	int keepalive = 1;
 	int ret = 0;
 
-	ret = kernel_setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
-				(char *)&keepalive, sizeof(keepalive));
-	if (ret < 0)
-		goto bail;
+	sock_set_keepalive(sock->sk);
 
 	ret = kernel_setsockopt(sock, IPPROTO_TCP, TCP_KEEPCNT,
 				(char *)&keepcnt, sizeof(keepcnt));
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 845d0be805ece..30082cd039960 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2110,7 +2110,6 @@ static void xs_tcp_set_socket_timeouts(struct rpc_xprt *xprt,
 	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
 	unsigned int keepidle;
 	unsigned int keepcnt;
-	unsigned int opt_on = 1;
 	unsigned int timeo;
 
 	spin_lock(&xprt->transport_lock);
@@ -2122,8 +2121,7 @@ static void xs_tcp_set_socket_timeouts(struct rpc_xprt *xprt,
 	spin_unlock(&xprt->transport_lock);
 
 	/* TCP Keepalive options */
-	kernel_setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
-			(char *)&opt_on, sizeof(opt_on));
+	sock_set_keepalive(sock->sk);
 	kernel_setsockopt(sock, SOL_TCP, TCP_KEEPIDLE,
 			(char *)&keepidle, sizeof(keepidle));
 	kernel_setsockopt(sock, SOL_TCP, TCP_KEEPINTVL,
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
