Return-Path: <SRS0=q3TM=63=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79675C2D0F9
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 06:31:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 176E6206A5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 06:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KROGQdmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176E6206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bMo8sxWUaoqjWVDQqrKy8jSqh58vLgOStLqUlbz4d0I=; b=KROGQdmFIvj8xn
	5f6UiCpumriBrABmIFIHkBBTbg1W/fXTHY1l66xHgK8y8ED5M6WjI9eqjmPlfUM1G9pb3LBOqbEMY
	eC57LGuI3Sx2aXhCo0l8mGWcIcRiTEijsAJ0hMoo0+Vf4Hk4QNx15jOm+pKHDTHHWVImCl/jXF+77
	jP5rLQ+AiEMFitqW360YMwJ69g7O0eqzIvX1Gn78izQeucma/K12JWHygIKY+OeEwhpjs4WzMIRaB
	aVBpa9VO+ACA5Kx9ssBaKm5/0mUeNMACPH9UdWKLL6CDlZXmh4DRVyaiJpMWHWoyYL8YixMl7ZGIt
	hpP+oXtLOYg3Bwz7Wu9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYkvS-0001oj-G1; Wed, 13 May 2020 06:31:30 +0000
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYkrw-0004ea-1N; Wed, 13 May 2020 06:27:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 20/33] ipv4: add ip_sock_set_recverr
Date: Wed, 13 May 2020 08:26:35 +0200
Message-Id: <20200513062649.2100053-21-hch@lst.de>
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

Add a helper to directly set the IP_RECVERR sockopt from kernel space
without going through a fake uaccess.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/ip.h         |  1 +
 net/ipv4/ip_sockglue.c   | 10 ++++++++++
 net/rxrpc/local_object.c |  8 +-------
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 1e2feca8630d0..7ab8140b54429 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -767,5 +767,6 @@ static inline bool inetdev_valid_mtu(unsigned int mtu)
 
 void ip_sock_set_tos(struct sock *sk, int val);
 void ip_sock_set_freebind(struct sock *sk, bool val);
+void ip_sock_set_recverr(struct sock *sk, bool val);
 
 #endif	/* _IP_H */
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 0c40887a817f8..9abecc3195520 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -589,6 +589,16 @@ void ip_sock_set_freebind(struct sock *sk, bool val)
 }
 EXPORT_SYMBOL(ip_sock_set_freebind);
 
+void ip_sock_set_recverr(struct sock *sk, bool val)
+{
+	lock_sock(sk);
+	inet_sk(sk)->recverr = val;
+	if (!val)
+		skb_queue_purge(&sk->sk_error_queue);
+	release_sock(sk);
+}
+EXPORT_SYMBOL(ip_sock_set_recverr);
+
 /*
  *	Socket option code for IP. This is the end of the line after any
  *	TCP,UDP etc options on an IP socket.
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 562ea36c96b0f..1b87b8a9ff725 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -171,13 +171,7 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 		/* Fall through */
 	case AF_INET:
 		/* we want to receive ICMP errors */
-		opt = 1;
-		ret = kernel_setsockopt(local->socket, SOL_IP, IP_RECVERR,
-					(char *) &opt, sizeof(opt));
-		if (ret < 0) {
-			_debug("setsockopt failed");
-			goto error;
-		}
+		ip_sock_set_recverr(local->socket->sk, true);
 
 		/* we want to set the don't fragment bit */
 		opt = IP_PMTUDISC_DO;
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
