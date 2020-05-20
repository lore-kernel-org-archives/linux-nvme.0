Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0576EC433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 19:57:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C9220874
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 19:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t/fLSel5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C9220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=opUes8OSdyU7YEMCEB7tU5SGGUIXIhA5U2d8NwiJtds=; b=t/fLSel5Hu+nzm
	T3yXJpmHeMdY5z2Xa6FyqofKxmPKL8QIq5Ekau4+YDsv4ELX5TzrlipHzvlynlxmKyyr5DBmFxQ7e
	Jpd+P9XePOyElYRZhaF9HZ912kHdOeMzciJeX1lU0dP/VmAeyTcIxZiviAAV4WIMZMVfbVONn5+ev
	77fi5vw4OtJOtPb3mSRSUQEH1IKgv7l2R95yGo9N1GIYr+qfszmckdBKbpV3FX7rT2xsPKv2RjbuS
	H6hBRB7Ob6VAzn+5S0hpU/gKxswjs8s/G7sjUmGgxoY4/JLrqtrKctJ62ZAevH+7mr47eslh4KHFm
	YdFI9CqZdER96+INKyBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbUpk-0003hA-F9; Wed, 20 May 2020 19:56:56 +0000
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbUoM-0002DS-V4; Wed, 20 May 2020 19:55:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 07/33] net: add sock_bindtoindex
Date: Wed, 20 May 2020 21:54:43 +0200
Message-Id: <20200520195509.2215098-8-hch@lst.de>
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

Add a helper to directly set the SO_BINDTOIFINDEX sockopt from kernel
space without going through a fake uaccess.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/sock.h        |  1 +
 net/core/sock.c           | 21 +++++++++++++++------
 net/ipv4/udp_tunnel.c     |  4 +---
 net/ipv6/ip6_udp_tunnel.c |  4 +---
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 9a7b9e98685ac..cdec7bc055d5b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2688,6 +2688,7 @@ static inline bool sk_dev_equal_l3scope(struct sock *sk, int dif)
 
 void sock_def_readable(struct sock *sk);
 
+int sock_bindtoindex(struct sock *sk, int ifindex);
 void sock_no_linger(struct sock *sk);
 void sock_set_priority(struct sock *sk, u32 priority);
 void sock_set_reuseaddr(struct sock *sk);
diff --git a/net/core/sock.c b/net/core/sock.c
index d3b1d61e4f768..23f80880fbb2c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -566,7 +566,7 @@ struct dst_entry *sk_dst_check(struct sock *sk, u32 cookie)
 }
 EXPORT_SYMBOL(sk_dst_check);
 
-static int sock_setbindtodevice_locked(struct sock *sk, int ifindex)
+static int sock_bindtoindex_locked(struct sock *sk, int ifindex)
 {
 	int ret = -ENOPROTOOPT;
 #ifdef CONFIG_NETDEVICES
@@ -594,6 +594,18 @@ static int sock_setbindtodevice_locked(struct sock *sk, int ifindex)
 	return ret;
 }
 
+int sock_bindtoindex(struct sock *sk, int ifindex)
+{
+	int ret;
+
+	lock_sock(sk);
+	ret = sock_bindtoindex_locked(sk, ifindex);
+	release_sock(sk);
+
+	return ret;
+}
+EXPORT_SYMBOL(sock_bindtoindex);
+
 static int sock_setbindtodevice(struct sock *sk, char __user *optval,
 				int optlen)
 {
@@ -634,10 +646,7 @@ static int sock_setbindtodevice(struct sock *sk, char __user *optval,
 			goto out;
 	}
 
-	lock_sock(sk);
-	ret = sock_setbindtodevice_locked(sk, index);
-	release_sock(sk);
-
+	return sock_bindtoindex(sk, index);
 out:
 #endif
 
@@ -1216,7 +1225,7 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_BINDTOIFINDEX:
-		ret = sock_setbindtodevice_locked(sk, val);
+		ret = sock_bindtoindex_locked(sk, val);
 		break;
 
 	default:
diff --git a/net/ipv4/udp_tunnel.c b/net/ipv4/udp_tunnel.c
index 150e6f0fdbf59..2158e8bddf41c 100644
--- a/net/ipv4/udp_tunnel.c
+++ b/net/ipv4/udp_tunnel.c
@@ -22,9 +22,7 @@ int udp_sock_create4(struct net *net, struct udp_port_cfg *cfg,
 		goto error;
 
 	if (cfg->bind_ifindex) {
-		err = kernel_setsockopt(sock, SOL_SOCKET, SO_BINDTOIFINDEX,
-					(void *)&cfg->bind_ifindex,
-					sizeof(cfg->bind_ifindex));
+		err = sock_bindtoindex(sock->sk, cfg->bind_ifindex);
 		if (err < 0)
 			goto error;
 	}
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 58956a6b66a21..6523609516d25 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -33,9 +33,7 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 			goto error;
 	}
 	if (cfg->bind_ifindex) {
-		err = kernel_setsockopt(sock, SOL_SOCKET, SO_BINDTOIFINDEX,
-					(void *)&cfg->bind_ifindex,
-					sizeof(cfg->bind_ifindex));
+		err = sock_bindtoindex(sock->sk, cfg->bind_ifindex);
 		if (err < 0)
 			goto error;
 	}
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
