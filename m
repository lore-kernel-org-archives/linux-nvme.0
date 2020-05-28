Return-Path: <SRS0=0R6w=7K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D86C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 05:12:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DCF92084C
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 05:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oBznmedz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DCF92084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g+7bkpSjCvHWUTBbQXbr+HEzIeKU/xgSmhtm/cDQItc=; b=oBznmedzavkiu/
	ceH0l8DcrFmrrlJQnx6agY0fv6ZyJF4EItVaw8936AWdynxag+cZO5fHzTUIINxjwUpnXLJNrVEgL
	hflazhSAK+Oae75hrh7EJcIrLxCtv1uQb7jhC1RAVR+5iROJlqtwRgGgHkkP4Io5IpY2Fs8FE0KGT
	u/nsP8wigMp6SAVxMs5l9/iwVr7N0GdIcBQJHh3NlsWfRVUZ160Kl6POE62LYGS05ZOLxgcmIJ9yp
	ZlpE2f7MwYGMoO+KTUlA5PObc2WV3uPe6rzmlJXmMMrnbcXPJIqP1Zl3d7oGNsCnhkXlnp/SlEaBZ
	ppXvMUGU3Rp4P+DxCMIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeAqV-0001R5-FF; Thu, 28 May 2020 05:12:47 +0000
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1jeAqT-0001Qc-Mf; Thu, 28 May 2020 05:12:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 02/28] net: add sock_no_linger
Date: Thu, 28 May 2020 07:12:10 +0200
Message-Id: <20200528051236.620353-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528051236.620353-1-hch@lst.de>
References: <20200528051236.620353-1-hch@lst.de>
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
Cc: linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
 cluster-devel@redhat.com, Sagi Grimberg <sagi@grimberg.me>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jon Maloy <jmaloy@redhat.com>, linux-rdma@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 Ying Xue <ying.xue@windriver.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
 ocfs2-devel@oss.oracle.com, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a helper to directly set the SO_LINGER sockopt from kernel space
with onoff set to true and a linger time of 0 without going through a
fake uaccess.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c   |  9 +--------
 drivers/nvme/target/tcp.c |  6 +-----
 include/net/sock.h        |  1 +
 net/core/sock.c           |  9 +++++++++
 net/rds/tcp.h             |  1 -
 net/rds/tcp_connect.c     |  2 +-
 net/rds/tcp_listen.c      | 13 +------------
 net/sunrpc/svcsock.c      | 12 ++----------
 8 files changed, 16 insertions(+), 37 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c15a92163c1f7..e72d87482eb78 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1313,7 +1313,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
-	struct linger sol = { .l_onoff = 1, .l_linger = 0 };
 	int ret, opt, rcv_pdu_size;
 
 	queue->ctrl = ctrl;
@@ -1361,13 +1360,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	 * close. This is done to prevent stale data from being sent should
 	 * the network connection be restored before TCP times out.
 	 */
-	ret = kernel_setsockopt(queue->sock, SOL_SOCKET, SO_LINGER,
-			(char *)&sol, sizeof(sol));
-	if (ret) {
-		dev_err(nctrl->device,
-			"failed to set SO_LINGER sock opt %d\n", ret);
-		goto err_sock;
-	}
+	sock_no_linger(queue->sock->sk);
 
 	if (so_priority > 0) {
 		ret = kernel_setsockopt(queue->sock, SOL_SOCKET, SO_PRIORITY,
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 40757a63f4553..e0801494b097f 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1429,7 +1429,6 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
 	struct inet_sock *inet = inet_sk(sock->sk);
-	struct linger sol = { .l_onoff = 1, .l_linger = 0 };
 	int ret;
 
 	ret = kernel_getsockname(sock,
@@ -1447,10 +1446,7 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	 * close. This is done to prevent stale data from being sent should
 	 * the network connection be restored before TCP times out.
 	 */
-	ret = kernel_setsockopt(sock, SOL_SOCKET, SO_LINGER,
-			(char *)&sol, sizeof(sol));
-	if (ret)
-		return ret;
+	sock_no_linger(sock->sk);
 
 	if (so_priority > 0) {
 		ret = kernel_setsockopt(sock, SOL_SOCKET, SO_PRIORITY,
diff --git a/include/net/sock.h b/include/net/sock.h
index 2ec085044790c..6ed00bf009bbe 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2688,6 +2688,7 @@ static inline bool sk_dev_equal_l3scope(struct sock *sk, int dif)
 
 void sock_def_readable(struct sock *sk);
 
+void sock_no_linger(struct sock *sk);
 void sock_set_reuseaddr(struct sock *sk);
 
 #endif	/* _SOCK_H */
diff --git a/net/core/sock.c b/net/core/sock.c
index 18eb84fdf5fbe..f0f09524911c8 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -720,6 +720,15 @@ void sock_set_reuseaddr(struct sock *sk)
 }
 EXPORT_SYMBOL(sock_set_reuseaddr);
 
+void sock_no_linger(struct sock *sk)
+{
+	lock_sock(sk);
+	sk->sk_lingertime = 0;
+	sock_set_flag(sk, SOCK_LINGER);
+	release_sock(sk);
+}
+EXPORT_SYMBOL(sock_no_linger);
+
 /*
  *	This is meant for all protocols to use and covers goings on
  *	at the socket level. Everything here is generic.
diff --git a/net/rds/tcp.h b/net/rds/tcp.h
index 3c69361d21c73..d640e210b97b6 100644
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -73,7 +73,6 @@ void rds_tcp_listen_data_ready(struct sock *sk);
 int rds_tcp_accept_one(struct socket *sock);
 int rds_tcp_keepalive(struct socket *sock);
 void *rds_tcp_listen_sock_def_readable(struct net *net);
-void rds_tcp_set_linger(struct socket *sock);
 
 /* tcp_recv.c */
 int rds_tcp_recv_init(void);
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index 008f50fb25dd2..4e64598176b05 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -207,7 +207,7 @@ void rds_tcp_conn_path_shutdown(struct rds_conn_path *cp)
 
 	if (sock) {
 		if (rds_destroy_pending(cp->cp_conn))
-			rds_tcp_set_linger(sock);
+			sock_no_linger(sock->sk);
 		sock->ops->shutdown(sock, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		lock_sock(sock->sk);
 		rds_tcp_restore_callbacks(sock, tc); /* tc->tc_sock = NULL */
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 810a3a49e9474..bbb31b9c0b391 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -111,17 +111,6 @@ struct rds_tcp_connection *rds_tcp_accept_one_path(struct rds_connection *conn)
 	return NULL;
 }
 
-void rds_tcp_set_linger(struct socket *sock)
-{
-	struct linger no_linger = {
-		.l_onoff = 1,
-		.l_linger = 0,
-	};
-
-	kernel_setsockopt(sock, SOL_SOCKET, SO_LINGER,
-			  (char *)&no_linger, sizeof(no_linger));
-}
-
 int rds_tcp_accept_one(struct socket *sock)
 {
 	struct socket *new_sock = NULL;
@@ -241,7 +230,7 @@ int rds_tcp_accept_one(struct socket *sock)
 	 * be pending on it. By setting linger, we achieve the side-effect
 	 * of avoiding TIME_WAIT state on new_sock.
 	 */
-	rds_tcp_set_linger(new_sock);
+	sock_no_linger(new_sock->sk);
 	kernel_sock_shutdown(new_sock, SHUT_RDWR);
 	ret = 0;
 out:
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 023514e392b31..6773dacc64d8e 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -323,17 +323,9 @@ static int svc_tcp_has_wspace(struct svc_xprt *xprt)
 
 static void svc_tcp_kill_temp_xprt(struct svc_xprt *xprt)
 {
-	struct svc_sock *svsk;
-	struct socket *sock;
-	struct linger no_linger = {
-		.l_onoff = 1,
-		.l_linger = 0,
-	};
+	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
 
-	svsk = container_of(xprt, struct svc_sock, sk_xprt);
-	sock = svsk->sk_sock;
-	kernel_setsockopt(sock, SOL_SOCKET, SO_LINGER,
-			  (char *)&no_linger, sizeof(no_linger));
+	sock_no_linger(svsk->sk_sock->sk);
 }
 
 /*
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
