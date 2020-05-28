Return-Path: <SRS0=0R6w=7K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D3FC433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 05:15:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E8A2084C
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 05:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oFa9R7w1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E8A2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xBQdJnlBHCqmD5uGi+CcAHIsECmktFFVdfxh/MB5Dlc=; b=oFa9R7w1E6X2cL
	i1sjOZ4ak88UgmDyHHCkwGEwIHz7gO2FImRJyrLQm+uXejniTwr+xWM3G779ZPr9NjBvRayD6HHKT
	bu7pRX8PAb88X6tUxXTQjKVDQFMKLgLXIMdaPhvNka/WPSIdC9ac22BYaizLULEBrMJSEBAXBPYkg
	IC0egi9A3Q2tSPywMo4jtR0V7r9URfB4oDREI7LuXAJV2z7ArT2Lq0w+CLYRz0QWZs3jemNdtqpnF
	33oWAPkUlYp6tkG7ghESbxXtZTeWDOnB+xZMRTfDzI3zza+QpERdEHR9C8zpwV13Ywl/PiaCKCzO4
	lIUGgvCyNxWSYVDoT6BQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeAsa-0003Iu-K2; Thu, 28 May 2020 05:14:56 +0000
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1jeAqn-0001m6-SE; Thu, 28 May 2020 05:13:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 08/28] net: add sock_set_rcvbuf
Date: Thu, 28 May 2020 07:12:16 +0200
Message-Id: <20200528051236.620353-9-hch@lst.de>
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

Add a helper to directly set the SO_RCVBUFFORCE sockopt from kernel space
without going through a fake uaccess.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/dlm/lowcomms.c  |  7 +-----
 include/net/sock.h |  1 +
 net/core/sock.c    | 59 +++++++++++++++++++++++++---------------------
 3 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 138009c6a2ee1..45c37f572c9d2 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1297,7 +1297,6 @@ static int sctp_listen_for_all(void)
 	struct socket *sock = NULL;
 	int result = -EINVAL;
 	struct connection *con = nodeid2con(0, GFP_NOFS);
-	int bufsize = NEEDED_RMEM;
 	int one = 1;
 
 	if (!con)
@@ -1312,11 +1311,7 @@ static int sctp_listen_for_all(void)
 		goto out;
 	}
 
-	result = kernel_setsockopt(sock, SOL_SOCKET, SO_RCVBUFFORCE,
-				 (char *)&bufsize, sizeof(bufsize));
-	if (result)
-		log_print("Error increasing buffer space on socket %d", result);
-
+	sock_set_rcvbuf(sock->sk, NEEDED_RMEM);
 	result = kernel_setsockopt(sock, SOL_SCTP, SCTP_NODELAY, (char *)&one,
 				   sizeof(one));
 	if (result < 0)
diff --git a/include/net/sock.h b/include/net/sock.h
index dc08c176238fd..c997289aabbf9 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2693,6 +2693,7 @@ void sock_enable_timestamps(struct sock *sk);
 void sock_no_linger(struct sock *sk);
 void sock_set_keepalive(struct sock *sk);
 void sock_set_priority(struct sock *sk, u32 priority);
+void sock_set_rcvbuf(struct sock *sk, int val);
 void sock_set_reuseaddr(struct sock *sk);
 void sock_set_sndtimeo(struct sock *sk, s64 secs);
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 728f5fb156a0c..3c6ebf952e9ad 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -789,6 +789,35 @@ void sock_set_keepalive(struct sock *sk)
 }
 EXPORT_SYMBOL(sock_set_keepalive);
 
+static void __sock_set_rcvbuf(struct sock *sk, int val)
+{
+	/* Ensure val * 2 fits into an int, to prevent max_t() from treating it
+	 * as a negative value.
+	 */
+	val = min_t(int, val, INT_MAX / 2);
+	sk->sk_userlocks |= SOCK_RCVBUF_LOCK;
+
+	/* We double it on the way in to account for "struct sk_buff" etc.
+	 * overhead.   Applications assume that the SO_RCVBUF setting they make
+	 * will allow that much actual data to be received on that socket.
+	 *
+	 * Applications are unaware that "struct sk_buff" and other overheads
+	 * allocate from the receive buffer during socket buffer allocation.
+	 *
+	 * And after considering the possible alternatives, returning the value
+	 * we actually used in getsockopt is the most desirable behavior.
+	 */
+	WRITE_ONCE(sk->sk_rcvbuf, max_t(int, val * 2, SOCK_MIN_RCVBUF));
+}
+
+void sock_set_rcvbuf(struct sock *sk, int val)
+{
+	lock_sock(sk);
+	__sock_set_rcvbuf(sk, val);
+	release_sock(sk);
+}
+EXPORT_SYMBOL(sock_set_rcvbuf);
+
 /*
  *	This is meant for all protocols to use and covers goings on
  *	at the socket level. Everything here is generic.
@@ -885,30 +914,7 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		 * play 'guess the biggest size' games. RCVBUF/SNDBUF
 		 * are treated in BSD as hints
 		 */
-		val = min_t(u32, val, sysctl_rmem_max);
-set_rcvbuf:
-		/* Ensure val * 2 fits into an int, to prevent max_t()
-		 * from treating it as a negative value.
-		 */
-		val = min_t(int, val, INT_MAX / 2);
-		sk->sk_userlocks |= SOCK_RCVBUF_LOCK;
-		/*
-		 * We double it on the way in to account for
-		 * "struct sk_buff" etc. overhead.   Applications
-		 * assume that the SO_RCVBUF setting they make will
-		 * allow that much actual data to be received on that
-		 * socket.
-		 *
-		 * Applications are unaware that "struct sk_buff" and
-		 * other overheads allocate from the receive buffer
-		 * during socket buffer allocation.
-		 *
-		 * And after considering the possible alternatives,
-		 * returning the value we actually used in getsockopt
-		 * is the most desirable behavior.
-		 */
-		WRITE_ONCE(sk->sk_rcvbuf,
-			   max_t(int, val * 2, SOCK_MIN_RCVBUF));
+		__sock_set_rcvbuf(sk, min_t(u32, val, sysctl_rmem_max));
 		break;
 
 	case SO_RCVBUFFORCE:
@@ -920,9 +926,8 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		/* No negative values (to prevent underflow, as val will be
 		 * multiplied by 2).
 		 */
-		if (val < 0)
-			val = 0;
-		goto set_rcvbuf;
+		__sock_set_rcvbuf(sk, max(val, 0));
+		break;
 
 	case SO_KEEPALIVE:
 		if (sk->sk_prot->keepalive)
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
