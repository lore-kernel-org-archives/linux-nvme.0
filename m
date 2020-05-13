Return-Path: <SRS0=q3TM=63=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9C0C2D0F8
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 06:34:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7ACF206A5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 06:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kCtdVfXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7ACF206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3JVxj2GEfR1o6rXClm/KdBqzlnd3TnjpDYGkQ7q5Htg=; b=kCtdVfXhVswp85
	lfm6bmvPKkFhIlrEMfsPUlJV+2FFN90R3dHDNnb8xuCagkdD//ZLIy4FnqK6lVgNWiDohUKDwvoMr
	COfz+RYdDVY0tdZy++oGPuB1a82P6aIIEVkG+cDigMuwMg5+tXpPF/P1Wx0v4Xdw8PJKh/3hBqyad
	kY9LzZMImdGU3YePCPI3zBdIhUQxtIoyS+ZEaIibHZZHInEeqlKRtRz2EPoFZ+DRcuHaObWAOGHTb
	lJ7eiBSDQh30mjGVsN26IpB5CzLvLoMXIwa7QPeDULh3kXcYkKIYoZrTAGGCu76VltUKa9uVJJPy4
	fDXgaRa/qhXV2nUNe4eQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYkxs-0003y6-0N; Wed, 13 May 2020 06:34:00 +0000
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYksY-0005Ge-1j; Wed, 13 May 2020 06:28:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 32/33] sctp: add sctp_sock_get_primary_addr
Date: Wed, 13 May 2020 08:26:47 +0200
Message-Id: <20200513062649.2100053-33-hch@lst.de>
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

Add a helper to directly get the SCTP_PRIMARY_ADDR sockopt from kernel
space without going through a fake uaccess.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/dlm/lowcomms.c       | 11 +++-----
 include/net/sctp/sctp.h |  1 +
 net/sctp/socket.c       | 57 +++++++++++++++++++++++++----------------
 3 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 6fa45365666a8..46d2d71b62c57 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -855,10 +855,9 @@ static int tcp_accept_from_sock(struct connection *con)
 static int sctp_accept_from_sock(struct connection *con)
 {
 	/* Check that the new node is in the lockspace */
-	struct sctp_prim prim;
+	struct sctp_prim prim = { };
 	int nodeid;
-	int prim_len, ret;
-	int addr_len;
+	int addr_len, ret;
 	struct connection *newcon;
 	struct connection *addcon;
 	struct socket *newsock;
@@ -876,11 +875,7 @@ static int sctp_accept_from_sock(struct connection *con)
 	if (ret < 0)
 		goto accept_err;
 
-	memset(&prim, 0, sizeof(struct sctp_prim));
-	prim_len = sizeof(struct sctp_prim);
-
-	ret = kernel_getsockopt(newsock, IPPROTO_SCTP, SCTP_PRIMARY_ADDR,
-				(char *)&prim, &prim_len);
+	ret = sctp_sock_get_primary_addr(con->sock->sk, &prim);
 	if (ret < 0) {
 		log_print("getsockopt/sctp_primary_addr failed: %d", ret);
 		goto accept_err;
diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index b505fa082f254..c98b1d14db853 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -618,5 +618,6 @@ static inline bool sctp_newsk_ready(const struct sock *sk)
 int sctp_setsockopt_bindx(struct sock *sk, struct sockaddr *kaddrs,
 		int addrs_size, int op);
 void sctp_sock_set_nodelay(struct sock *sk, bool val);
+int sctp_sock_get_primary_addr(struct sock *sk, struct sctp_prim *prim);
 
 #endif /* __net_sctp_h__ */
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 64c395f7a86d5..39bf8090dbe1e 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -6411,6 +6411,35 @@ static int sctp_getsockopt_local_addrs(struct sock *sk, int len,
 	return err;
 }
 
+static int __sctp_sock_get_primary_addr(struct sock *sk, struct sctp_prim *prim)
+{
+	struct sctp_association *asoc;
+
+	asoc = sctp_id2assoc(sk, prim->ssp_assoc_id);
+	if (!asoc)
+		return -EINVAL;
+	if (!asoc->peer.primary_path)
+		return -ENOTCONN;
+
+	memcpy(&prim->ssp_addr, &asoc->peer.primary_path->ipaddr,
+		asoc->peer.primary_path->af_specific->sockaddr_len);
+
+	sctp_get_pf_specific(sk->sk_family)->addr_to_user(sctp_sk(sk),
+			(union sctp_addr *)&prim->ssp_addr);
+	return 0;
+}
+
+int sctp_sock_get_primary_addr(struct sock *sk, struct sctp_prim *prim)
+{
+	int ret;
+
+	lock_sock(sk);
+	ret = __sctp_sock_get_primary_addr(sk, prim);
+	release_sock(sk);
+	return ret;
+}
+EXPORT_SYMBOL(sctp_sock_get_primary_addr);
+
 /* 7.1.10 Set Primary Address (SCTP_PRIMARY_ADDR)
  *
  * Requests that the local SCTP stack use the enclosed peer address as
@@ -6421,35 +6450,19 @@ static int sctp_getsockopt_primary_addr(struct sock *sk, int len,
 					char __user *optval, int __user *optlen)
 {
 	struct sctp_prim prim;
-	struct sctp_association *asoc;
-	struct sctp_sock *sp = sctp_sk(sk);
+	int ret;
 
 	if (len < sizeof(struct sctp_prim))
 		return -EINVAL;
-
-	len = sizeof(struct sctp_prim);
-
-	if (copy_from_user(&prim, optval, len))
+	if (copy_from_user(&prim, optval, sizeof(struct sctp_prim)))
 		return -EFAULT;
 
-	asoc = sctp_id2assoc(sk, prim.ssp_assoc_id);
-	if (!asoc)
-		return -EINVAL;
-
-	if (!asoc->peer.primary_path)
-		return -ENOTCONN;
-
-	memcpy(&prim.ssp_addr, &asoc->peer.primary_path->ipaddr,
-		asoc->peer.primary_path->af_specific->sockaddr_len);
-
-	sctp_get_pf_specific(sk->sk_family)->addr_to_user(sp,
-			(union sctp_addr *)&prim.ssp_addr);
+	ret = __sctp_sock_get_primary_addr(sk, &prim);
+	if (ret)
+		return ret;
 
-	if (put_user(len, optlen))
+	if (put_user(len, optlen) || copy_to_user(optval, &prim, len))
 		return -EFAULT;
-	if (copy_to_user(optval, &prim, len))
-		return -EFAULT;
-
 	return 0;
 }
 
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
