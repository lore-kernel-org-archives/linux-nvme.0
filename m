Return-Path: <SRS0=q3TM=63=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EED2C2D0FE
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 06:28:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E399523127
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 06:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gD4CvZCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E399523127
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yC5mn/N3V/a6tNUlcAlbFtNjyRLIWZAPeggLZ8ewrZE=; b=gD4CvZCKpfAy10
	PF06DXdIyW9MrJrpmJCIPkB2BMjslBUo785WEnI2FOtgQ1jgoyw+xncrbELD3H1aheJg/pCJLdmFf
	pUr8hrthE1shPT2TtswkqZl4RF5lcAs0SIsKJUXxHQ4LgkLlxb23x3zoUe+TrpQZx5TgZd4ARLs8C
	/9q/rGnr5AzyZ2b/4gfUOuDizBYxEwjOqA1Q2CGZEsQlvm4hx/enue+MJdN1dc802fKTSVOewNgrQ
	jvudpHeXFucLaxySgyTo/zwv4lU5rEu7ytLZZ6/XjUCyctCRgyZP0rhDJeDJba6tjW5YEV7j4sgLO
	fQ34hOmpGl+YKFO1WJVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYksu-0005gy-HG; Wed, 13 May 2020 06:28:52 +0000
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYkrO-0004A8-Gx; Wed, 13 May 2020 06:27:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 09/33] net: add sock_set_reuseport
Date: Wed, 13 May 2020 08:26:24 +0200
Message-Id: <20200513062649.2100053-10-hch@lst.de>
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

Add a helper to directly set the SO_REUSEPORT sockopt from kernel space
without going through a fake uaccess.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/sock.h    |  1 +
 net/core/sock.c       |  8 ++++++++
 net/sunrpc/xprtsock.c | 17 +----------------
 3 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index e1ed40ff01312..6b8e06947b243 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2688,6 +2688,7 @@ static inline bool sk_dev_equal_l3scope(struct sock *sk, int dif)
 
 void sock_def_readable(struct sock *sk);
 void sock_set_reuseaddr(struct sock *sk, unsigned char reuse);
+void sock_set_reuseport(struct sock *sk, bool reuseport);
 void sock_set_linger(struct sock *sk, bool onoff, unsigned int linger);
 void sock_set_priority(struct sock *sk, u32 priority);
 void sock_set_sndtimeo(struct sock *sk, unsigned int secs);
diff --git a/net/core/sock.c b/net/core/sock.c
index 6af01b757cf24..7f0baf1ccde17 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -729,6 +729,14 @@ void sock_set_reuseaddr(struct sock *sk, unsigned char reuse)
 }
 EXPORT_SYMBOL(sock_set_reuseaddr);
 
+void sock_set_reuseport(struct sock *sk, bool reuseport)
+{
+	lock_sock(sk);
+	sk->sk_reuseport = reuseport;
+	release_sock(sk);
+}
+EXPORT_SYMBOL(sock_set_reuseport);
+
 static void __sock_set_linger(struct sock *sk, bool onoff, unsigned int linger)
 {
 	if (!onoff) {
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index bb61d3758be2b..3dc2d52371a0e 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1594,21 +1594,6 @@ static int xs_get_random_port(void)
 	return rand + min;
 }
 
-/**
- * xs_set_reuseaddr_port - set the socket's port and address reuse options
- * @sock: socket
- *
- * Note that this function has to be called on all sockets that share the
- * same port, and it must be called before binding.
- */
-static void xs_sock_set_reuseport(struct socket *sock)
-{
-	int opt = 1;
-
-	kernel_setsockopt(sock, SOL_SOCKET, SO_REUSEPORT,
-			(char *)&opt, sizeof(opt));
-}
-
 static unsigned short xs_sock_getport(struct socket *sock)
 {
 	struct sockaddr_storage buf;
@@ -1801,7 +1786,7 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
 	xs_reclassify_socket(family, sock);
 
 	if (reuseport)
-		xs_sock_set_reuseport(sock);
+		sock_set_reuseport(sock->sk, true);
 
 	err = xs_bind(transport, sock);
 	if (err) {
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
