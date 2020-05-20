Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99E8C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 21:15:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D340207E8
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 21:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y3Uurcy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D340207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qV10Uk+ecOV8ndB5k2YzJ8dJa+PuIVN2Tq0DnrCCYrw=; b=Y3Uurcy23l3ZZ2
	Suy8u0tHFA57yrCBOhmN6fmhPg3M4WfhXvhor01+/sQF4S5nbkGmz4jT8oqo0DzXa45xf/vDCrq69
	WuVTzxgQl/91gATt+a+7tEq+QeM0SqtFtgpNxbIfB7xO/OqaDxNnUV4EYTdjIH3xdmuJef2nYLgGp
	v5089hjyi/jJl943jhpGssGWFB+JzHQxQRioO0wFSJ+/cw5Y4Zrrzfh3kRagvKJkWqiWw/a+frMMQ
	6ZvlZl1UDQTuVIM+TPwMYGmtkk+hjYoq+zA2+p3kZhfqlUUfZ4KZbjNmA0F+D+23/TFQR0NG6YtT4
	CKDrPvaM1+CHecxReUaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbW44-0000c3-Ni; Wed, 20 May 2020 21:15:48 +0000
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbUpQ-0003Tx-Ac; Wed, 20 May 2020 19:56:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 30/33] tipc: call tsk_set_importance from
 tipc_topsrv_create_listener
Date: Wed, 20 May 2020 21:55:06 +0200
Message-Id: <20200520195509.2215098-31-hch@lst.de>
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

Avoid using kernel_setsockopt for the TIPC_IMPORTANCE option when we can
just use the internal helper.  The only change needed is to pass a struct
sock instead of tipc_sock, which is private to socket.c

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/tipc/socket.c | 18 +++++++++---------
 net/tipc/socket.h |  2 ++
 net/tipc/topsrv.c |  6 +++---
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index e370ad0edd768..28c57d4544c53 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -191,17 +191,17 @@ static int tsk_importance(struct tipc_sock *tsk)
 	return msg_importance(&tsk->phdr);
 }
 
-static int tsk_set_importance(struct tipc_sock *tsk, int imp)
+static struct tipc_sock *tipc_sk(const struct sock *sk)
 {
-	if (imp > TIPC_CRITICAL_IMPORTANCE)
-		return -EINVAL;
-	msg_set_importance(&tsk->phdr, (u32)imp);
-	return 0;
+	return container_of(sk, struct tipc_sock, sk);
 }
 
-static struct tipc_sock *tipc_sk(const struct sock *sk)
+int tsk_set_importance(struct sock *sk, int imp)
 {
-	return container_of(sk, struct tipc_sock, sk);
+	if (imp > TIPC_CRITICAL_IMPORTANCE)
+		return -EINVAL;
+	msg_set_importance(&tipc_sk(sk)->phdr, (u32)imp);
+	return 0;
 }
 
 static bool tsk_conn_cong(struct tipc_sock *tsk)
@@ -2681,7 +2681,7 @@ static int tipc_accept(struct socket *sock, struct socket *new_sock, int flags,
 	/* Connect new socket to it's peer */
 	tipc_sk_finish_conn(new_tsock, msg_origport(msg), msg_orignode(msg));
 
-	tsk_set_importance(new_tsock, msg_importance(msg));
+	tsk_set_importance(new_sk, msg_importance(msg));
 	if (msg_named(msg)) {
 		new_tsock->conn_type = msg_nametype(msg);
 		new_tsock->conn_instance = msg_nameinst(msg);
@@ -3099,7 +3099,7 @@ static int tipc_setsockopt(struct socket *sock, int lvl, int opt,
 
 	switch (opt) {
 	case TIPC_IMPORTANCE:
-		res = tsk_set_importance(tsk, value);
+		res = tsk_set_importance(sk, value);
 		break;
 	case TIPC_SRC_DROPPABLE:
 		if (sock->type != SOCK_STREAM)
diff --git a/net/tipc/socket.h b/net/tipc/socket.h
index 235b9679acee4..b11575afc66fe 100644
--- a/net/tipc/socket.h
+++ b/net/tipc/socket.h
@@ -75,4 +75,6 @@ u32 tipc_sock_get_portid(struct sock *sk);
 bool tipc_sk_overlimit1(struct sock *sk, struct sk_buff *skb);
 bool tipc_sk_overlimit2(struct sock *sk, struct sk_buff *skb);
 
+int tsk_set_importance(struct sock *sk, int imp);
+
 #endif
diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 446af7bbd13e6..1489cfb941d8e 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -497,7 +497,6 @@ static void tipc_topsrv_listener_data_ready(struct sock *sk)
 
 static int tipc_topsrv_create_listener(struct tipc_topsrv *srv)
 {
-	int imp = TIPC_CRITICAL_IMPORTANCE;
 	struct socket *lsock = NULL;
 	struct sockaddr_tipc saddr;
 	struct sock *sk;
@@ -514,8 +513,9 @@ static int tipc_topsrv_create_listener(struct tipc_topsrv *srv)
 	sk->sk_user_data = srv;
 	write_unlock_bh(&sk->sk_callback_lock);
 
-	rc = kernel_setsockopt(lsock, SOL_TIPC, TIPC_IMPORTANCE,
-			       (char *)&imp, sizeof(imp));
+	lock_sock(sk);
+	rc = tsk_set_importance(sk, TIPC_CRITICAL_IMPORTANCE);
+	release_sock(sk);
 	if (rc < 0)
 		goto err;
 
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
