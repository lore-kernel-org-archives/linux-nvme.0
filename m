Return-Path: <SRS0=0R6w=7K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BDAC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 05:18:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5326C20C56
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 05:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="azkcsnKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5326C20C56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vsjxyW/l6iZVDPuvP49aZLCBlU05syeO/1/cUxUCLkQ=; b=azkcsnKia+pXGn
	Scl2z9DtvFxfLDi9LTKh78g79/CJR2Yy5Is7HAQtyCipbZ60ocLOpZOHqXRTcoVOdTK10lv0uV8Zz
	/7g24SbcFu/nt39YO4Misbaqrz/5e2Gjg5gfpwABCgxj+gKnqdVzeUJlwF057Qi22nhZdRZfoiJX0
	oPRc4a5bMzR7c+toMWKLPoBvV0P4IrjnjWdgZo73svlZoRL/sjjO3vVza+KtnZu1av/t+N0NXne/K
	Dy2qdHZc2JvRGmuvmIMQmCRFhSPjNYVGiH7ZtRqtdt4Pis55LRcMUdb7k7IntbcX7EbfsnHqNrl5q
	Hk8QPh+g6sOGuDyOkgCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeAw8-0000Gd-1q; Thu, 28 May 2020 05:18:36 +0000
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1jeArb-0002VB-At; Thu, 28 May 2020 05:13:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 23/28] ipv6: add ip6_sock_set_v6only
Date: Thu, 28 May 2020 07:12:31 +0200
Message-Id: <20200528051236.620353-24-hch@lst.de>
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

Add a helper to directly set the IPV6_V6ONLY sockopt from kernel space
without going through a fake uaccess.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/ipv6.h        | 11 +++++++++++
 net/ipv6/ip6_udp_tunnel.c |  5 +----
 net/sunrpc/svcsock.c      |  6 +-----
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 39a00d3ef5e22..9b91188c9a74c 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1177,4 +1177,15 @@ int ipv6_sock_mc_join_ssm(struct sock *sk, int ifindex,
 			  const struct in6_addr *addr, unsigned int mode);
 int ipv6_sock_mc_drop(struct sock *sk, int ifindex,
 		      const struct in6_addr *addr);
+
+static inline int ip6_sock_set_v6only(struct sock *sk)
+{
+	if (inet_sk(sk)->inet_num)
+		return -EINVAL;
+	lock_sock(sk);
+	sk->sk_ipv6only = true;
+	release_sock(sk);
+	return 0;
+}
+
 #endif /* _NET_IPV6_H */
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 6523609516d25..2e0ad1bc84a83 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -25,10 +25,7 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 		goto error;
 
 	if (cfg->ipv6_v6only) {
-		int val = 1;
-
-		err = kernel_setsockopt(sock, IPPROTO_IPV6, IPV6_V6ONLY,
-					(char *) &val, sizeof(val));
+		err = ip6_sock_set_v6only(sock->sk);
 		if (err < 0)
 			goto error;
 	}
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 7a805d165689c..a391892977cd2 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1328,7 +1328,6 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 	struct sockaddr *newsin = (struct sockaddr *)&addr;
 	int		newlen;
 	int		family;
-	int		val;
 	RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
 
 	dprintk("svc: svc_create_socket(%s, %d, %s)\n",
@@ -1364,11 +1363,8 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 	 * getting requests from IPv4 remotes.  Those should
 	 * be shunted to a PF_INET listener via rpcbind.
 	 */
-	val = 1;
 	if (family == PF_INET6)
-		kernel_setsockopt(sock, SOL_IPV6, IPV6_V6ONLY,
-					(char *)&val, sizeof(val));
-
+		ip6_sock_set_v6only(sock->sk);
 	if (type == SOCK_STREAM)
 		sock->sk->sk_reuse = SK_CAN_REUSE; /* allow address reuse */
 	error = kernel_bind(sock, sin, len);
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
