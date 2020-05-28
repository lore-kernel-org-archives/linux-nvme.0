Return-Path: <SRS0=0R6w=7K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F80C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 05:16:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E6920721
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 05:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LiVW7yGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E6920721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SIVKwqWdSslqXS0EIPqZTHxI89GykhZZnPY/teTvcXU=; b=LiVW7yGZ6wI2QA
	NUIHw/SMZaBPP0duTcctdMWOyFh6RUm22aUrf8yCGi5YY9B6YRjevd2sbqsKKsLOyTL1y2EQ7/U3P
	9/BGwDnR/ElZfSqPrjlipntfwZicJdIszMvOqkFN/N8xvuGJcL2pVz9On7Y09LMhN3NZ0btCkHJK9
	hPdYwW3bw3Nz0c66s8hDj+/S7oQsJ4LQ05VsjjuG9KrmMtNj6JZ1xsY6TfWOM18Q9tNbsI7LDaKTm
	LIwKIfOSVFtiq2aF7pB+wuMKeysz4a/nHG1pYwHQFp5ngWEoeHy501fzJx8DyCHSxyA0QJ6fpd3sY
	9IkSHaUnu4+VsCNjRl4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeAuN-0007Ce-Hu; Thu, 28 May 2020 05:16:47 +0000
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1jeArF-00027k-1K; Thu, 28 May 2020 05:13:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 16/28] tcp: add tcp_sock_set_keepintvl
Date: Thu, 28 May 2020 07:12:24 +0200
Message-Id: <20200528051236.620353-17-hch@lst.de>
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
 cluster-devel@redhat.com, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jon Maloy <jmaloy@redhat.com>,
 linux-rdma@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, Ying Xue <ying.xue@windriver.com>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, ceph-devel@vger.kernel.org,
 linux-afs@lists.infradead.org, ocfs2-devel@oss.oracle.com,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a helper to directly set the TCP_KEEPINTVL sockopt from kernel space
without going through a fake uaccess.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/tcp.h   |  1 +
 net/ipv4/tcp.c        | 12 ++++++++++++
 net/rds/tcp_listen.c  |  4 +---
 net/sunrpc/xprtsock.c |  3 +--
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 5724dd84a85ed..1f9bada00faab 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -499,6 +499,7 @@ int tcp_skb_shift(struct sk_buff *to, struct sk_buff *from, int pcount,
 
 void tcp_sock_set_cork(struct sock *sk, bool on);
 int tcp_sock_set_keepidle(struct sock *sk, int val);
+int tcp_sock_set_keepintvl(struct sock *sk, int val);
 void tcp_sock_set_nodelay(struct sock *sk);
 void tcp_sock_set_quickack(struct sock *sk, int val);
 int tcp_sock_set_syncnt(struct sock *sk, int val);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index bdf0ff9333514..7eb083e09786a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2934,6 +2934,18 @@ int tcp_sock_set_keepidle(struct sock *sk, int val)
 }
 EXPORT_SYMBOL(tcp_sock_set_keepidle);
 
+int tcp_sock_set_keepintvl(struct sock *sk, int val)
+{
+	if (val < 1 || val > MAX_TCP_KEEPINTVL)
+		return -EINVAL;
+
+	lock_sock(sk);
+	tcp_sk(sk)->keepalive_intvl = val * HZ;
+	release_sock(sk);
+	return 0;
+}
+EXPORT_SYMBOL(tcp_sock_set_keepintvl);
+
 /*
  *	Socket option code for TCP.
  */
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 79f9adc008114..9ad555c48d15d 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -53,12 +53,10 @@ int rds_tcp_keepalive(struct socket *sock)
 		goto bail;
 
 	tcp_sock_set_keepidle(sock->sk, keepidle);
-
 	/* KEEPINTVL is the interval between successive probes. We follow
 	 * the model in xs_tcp_finish_connecting() and re-use keepidle.
 	 */
-	ret = kernel_setsockopt(sock, IPPROTO_TCP, TCP_KEEPINTVL,
-				(char *)&keepidle, sizeof(keepidle));
+	tcp_sock_set_keepintvl(sock->sk, keepidle);
 bail:
 	return ret;
 }
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 473290f7c5c0a..5ca64e12af0c5 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2108,8 +2108,7 @@ static void xs_tcp_set_socket_timeouts(struct rpc_xprt *xprt,
 	/* TCP Keepalive options */
 	sock_set_keepalive(sock->sk);
 	tcp_sock_set_keepidle(sock->sk, keepidle);
-	kernel_setsockopt(sock, SOL_TCP, TCP_KEEPINTVL,
-			(char *)&keepidle, sizeof(keepidle));
+	tcp_sock_set_keepintvl(sock->sk, keepidle);
 	kernel_setsockopt(sock, SOL_TCP, TCP_KEEPCNT,
 			(char *)&keepcnt, sizeof(keepcnt));
 
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
