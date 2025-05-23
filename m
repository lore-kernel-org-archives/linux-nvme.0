Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDC6C54ED0
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 18:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NqDy5UPNcvwSJ+ktcHnTmTft8+/hWNC40l+bLvuZvUo=; b=VpiOABGNPyQD9qncaUyL4cAb5t
	xkj0t4AO6LtdhUHyzx2eCnV5HhmkQoKh2PKXgkhdddtQmhLzAJj/tKiL7oEY3V/JPRbTACN3lExnj
	jk8EVXwZ2BBEvmflrJd1Q03T5dGNwvZVc6R7FrKe+S+dO1ch3kL4IVgiSj5YzkEVYlyNR4LK+x8wU
	d2zLy4qU/0RkqwmiGVwzs86pCDfLb+EZazb+FM8eG8GvmSOz5ooLa0PxHQidAIF7u6LUmt5Chlw+v
	+wSBCgOGHQzrujh27Rw+bidFjdmfGwU7eoDihN0HMH3L9G4ejYCS4riPgaUQu1zQZwaQtP6j2W/sb
	vL43JmZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIX3s-00000004fWe-0AOl;
	Fri, 23 May 2025 18:24:04 +0000
Received: from smtp-fw-9102.amazon.com ([207.171.184.29])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIX3i-00000004fRz-3RxG
	for linux-nvme@lists.infradead.org;
	Fri, 23 May 2025 18:23:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1748024635; x=1779560635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NqDy5UPNcvwSJ+ktcHnTmTft8+/hWNC40l+bLvuZvUo=;
  b=Udz168OEB3t7kU/GxJzr4DfBM6N5mTLTt5O8mAA5D0JwGEnOwkhubw7l
   ySInigKJ4EnD3GZN6SPID4iGUwIJUuRu3Bxb+oT/KbQPwRuNusRmfqhcR
   pj34G7FtpVNR5zOuMd3Vxxkiy300VGmR0INoeCdxZ362fn1DPuYqKG6uR
   SF01H3QaCIZoEPS63VQn8ad/DrQr3XyFTQ9hBjJ13AgBXL5HiF+1CtP+X
   r1wzAjthmwBvdwNo/gt+oT6HJZsmYxC1EaT59LHiAhw07DYxl3ag/wY1K
   7IXr8BXPKDU9CcDAQFurt4az1pT+eCrdVLrrkrXFnK1zIe43ZDaYTpxsk
   g==;
X-IronPort-AV: E=Sophos;i="6.15,309,1739836800"; 
   d="scan'208";a="523766238"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 18:23:55 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:27507]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.185:2525] with esmtp (Farcaster)
 id 49269a6c-743c-4409-b3a4-5e9f901e244e; Fri, 23 May 2025 18:23:53 +0000 (UTC)
X-Farcaster-Flow-ID: 49269a6c-743c-4409-b3a4-5e9f901e244e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:23:53 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.204.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:23:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
	"Keith Busch" <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher
	<jaka@linux.ibm.com>, Steve French <sfrench@samba.org>,
	<netdev@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<linux-nfs@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>
Subject: [PATCH v2 net-next 5/7] socket: Remove kernel socket conversion except for net/rds/.
Date: Fri, 23 May 2025 11:21:11 -0700
Message-ID: <20250523182128.59346-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523182128.59346-1-kuniyu@amazon.com>
References: <20250523182128.59346-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.142.204.12]
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250523_112354_905284_649CC067 
X-CRM114-Status: GOOD (  19.25  )
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

Since commit 26abe14379f8 ("net: Modify sk_alloc to not reference
count the netns of kernel sockets."), TCP kernel socket has caused
many UAF.

We have converted such sockets to hold netns refcnt, and we have
the same pattern in cifs, mptcp, nvme, rds, smc, and sunrpc.

  __sock_create_kern(..., &sock);
  sk_net_refcnt_upgrade(sock->sk);

Let's drop the conversion and use sock_create_kern() instead.

The changes for cifs, mptcp, nvme, and smc are straightforward.

For sunrpc, we call sk_net_refcnt_upgrade() for IPPROTO_TCP only
so we use sock_create_kern() for TCP and use __sock_create_kern()
for others.

For rds, we cannot drop sk_net_refcnt_upgrade() for accept()ed
sockets.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>  # net/mptcp
Acked-by: Chuck Lever <chuck.lever@oracle.com>
---
v2: Drop unnecessary change for sunrpc and updated changelog for sunrpc
---
 drivers/nvme/host/tcp.c |  7 +++----
 fs/smb/client/connect.c | 12 ++----------
 net/mptcp/subflow.c     |  7 +------
 net/smc/af_smc.c        | 18 ++----------------
 net/sunrpc/svcsock.c    |  6 ++++--
 net/sunrpc/xprtsock.c   |  8 ++++----
 6 files changed, 16 insertions(+), 42 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3d3bdc5e280f..fabb1cc02564 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1756,9 +1756,9 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		queue->cmnd_capsule_len = sizeof(struct nvme_command) +
 						NVME_TCP_ADMIN_CCSZ;
 
-	ret = __sock_create_kern(current->nsproxy->net_ns,
-				 ctrl->addr.ss_family, SOCK_STREAM,
-				 IPPROTO_TCP, &queue->sock);
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			       ctrl->addr.ss_family, SOCK_STREAM,
+			       IPPROTO_TCP, &queue->sock);
 	if (ret) {
 		dev_err(nctrl->device,
 			"failed to create socket: %d\n", ret);
@@ -1771,7 +1771,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		goto err_destroy_mutex;
 	}
 
-	sk_net_refcnt_upgrade(queue->sock->sk);
 	nvme_tcp_reclassify_socket(queue->sock);
 
 	/* Single syn retry */
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index afac23a5a3ec..c7b4f5a7cca1 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3348,22 +3348,14 @@ generic_ip_connect(struct TCP_Server_Info *server)
 		socket = server->ssocket;
 	} else {
 		struct net *net = cifs_net_ns(server);
-		struct sock *sk;
 
-		rc = __sock_create_kern(net, sfamily, SOCK_STREAM,
-					IPPROTO_TCP, &server->ssocket);
+		rc = sock_create_kern(net, sfamily, SOCK_STREAM,
+				      IPPROTO_TCP, &server->ssocket);
 		if (rc < 0) {
 			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
 			return rc;
 		}
 
-		sk = server->ssocket->sk;
-		__netns_tracker_free(net, &sk->ns_tracker, false);
-		net_passive_dec(net);
-		sk->sk_net_refcnt = 1;
-		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
-		sock_inuse_add(net, 1);
-
 		/* BB other socket options to set KEEPALIVE, NODELAY? */
 		cifs_dbg(FYI, "Socket created\n");
 		socket = server->ssocket;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 602e689e991f..00e5cecb7683 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1757,7 +1757,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	if (unlikely(!sk->sk_socket))
 		return -EINVAL;
 
-	err = __sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
+	err = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
 	if (err)
 		return err;
 
@@ -1770,11 +1770,6 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	/* the newly created socket has to be in the same cgroup as its parent */
 	mptcp_attach_cgroup(sk, sf->sk);
 
-	/* kernel sockets do not by default acquire net ref, but TCP timer
-	 * needs it.
-	 * Update ns_tracker to current stack trace and refcounted tracker.
-	 */
-	sk_net_refcnt_upgrade(sf->sk);
 	err = tcp_set_ulp(sf->sk, "mptcp");
 	if (err)
 		goto err_free;
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index d998ffed1712..6140a9e386d0 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3328,22 +3328,8 @@ static const struct proto_ops smc_sock_ops = {
 
 int smc_create_clcsk(struct net *net, struct sock *sk, int family)
 {
-	struct smc_sock *smc = smc_sk(sk);
-	int rc;
-
-	rc = __sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
-				&smc->clcsock);
-	if (rc)
-		return rc;
-
-	/* smc_clcsock_release() does not wait smc->clcsock->sk's
-	 * destruction;  its sk_state might not be TCP_CLOSE after
-	 * smc->sk is close()d, and TCP timers can be fired later,
-	 * which need net ref.
-	 */
-	sk = smc->clcsock->sk;
-	sk_net_refcnt_upgrade(sk);
-	return 0;
+	return sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
+				&smc_sk(sk)->clcsock);
 }
 
 static int __smc_create(struct net *net, struct socket *sock, int protocol,
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index adacfd03153a..10d83a03ccfa 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1516,7 +1516,10 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 		return ERR_PTR(-EINVAL);
 	}
 
-	error = __sock_create_kern(net, family, type, protocol, &sock);
+	if (protocol == IPPROTO_TCP)
+		error = sock_create_kern(net, family, type, protocol, &sock);
+	else
+		error = __sock_create_kern(net, family, type, protocol, &sock);
 	if (error < 0)
 		return ERR_PTR(error);
 
@@ -1541,7 +1544,6 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 	newlen = error;
 
 	if (protocol == IPPROTO_TCP) {
-		sk_net_refcnt_upgrade(sock->sk);
 		if ((error = kernel_listen(sock, 64)) < 0)
 			goto bummer;
 	}
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 6fb921ce6cf2..f9576bd8f9c5 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1924,7 +1924,10 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
 	struct socket *sock;
 	int err;
 
-	err = __sock_create_kern(xprt->xprt_net, family, type, protocol, &sock);
+	if (protocol == IPPROTO_TCP)
+		err = sock_create_kern(xprt->xprt_net, family, type, protocol, &sock);
+	else
+		err = __sock_create_kern(xprt->xprt_net, family, type, protocol, &sock);
 	if (err < 0) {
 		dprintk("RPC:       can't create %d transport socket (%d).\n",
 				protocol, -err);
@@ -1941,9 +1944,6 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
 		goto out;
 	}
 
-	if (protocol == IPPROTO_TCP)
-		sk_net_refcnt_upgrade(sock->sk);
-
 	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
 	if (IS_ERR(filp))
 		return ERR_CAST(filp);
-- 
2.49.0


