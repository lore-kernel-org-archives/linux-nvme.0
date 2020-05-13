Return-Path: <SRS0=q3TM=63=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECCEC2D0F8
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 06:32:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E65206A5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 06:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rxR72i+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E65206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IUQjPBbTqhP/STBLj58qY/QJDosqb+kIKb5RzoSqdbs=; b=rxR72i+yA06kso
	Zj07xdEUZtchKmYuF6XwSFMV0n+TMvkMKjelWrIDY/Q3FBRgoLngeWoOoIe00aIdnGxR3YphJ5YQB
	3sO9iyVr1DaiapDTywoB/G2lDLRuM3XFx9uc41j14YPnwtehb23PEC0TahgDToNUyj+hL9T//1SDM
	kMEf/lxqhzD++ulrIfGLkn0AyuC03HkslQ9xPfLyovHhrglJyse1AaZ2wyO5hK0YVC3aiR3pZCLN1
	0Fzen7x2AtUVXqI3JBhFWUtHjZotP0a0UVwE6WeF60ylOG4HnOUdE9sIsYiDc0RFIndUHraA9q6/H
	QS9RxtY8586J9UL+Gw6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYkwc-0002rY-Ln; Wed, 13 May 2020 06:32:42 +0000
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYksF-0004z4-Gi; Wed, 13 May 2020 06:28:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 26/33] sctp: lift copying in addrs into sctp_setsockopt
Date: Wed, 13 May 2020 08:26:41 +0200
Message-Id: <20200513062649.2100053-27-hch@lst.de>
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

Prepare for additional kernel-space callers of sctp_setsockopt_bindx.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/sctp/socket.c | 71 ++++++++++++++++++-----------------------------
 1 file changed, 27 insertions(+), 44 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 827a9903ee288..1c96b52c4aa28 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -972,18 +972,16 @@ int sctp_asconf_mgmt(struct sctp_sock *sp, struct sctp_sockaddr_entry *addrw)
  * it.
  *
  * sk        The sk of the socket
- * addrs     The pointer to the addresses in user land
+ * addrs     The pointer to the addresses
  * addrssize Size of the addrs buffer
  * op        Operation to perform (add or remove, see the flags of
  *           sctp_bindx)
  *
  * Returns 0 if ok, <0 errno code on error.
  */
-static int sctp_setsockopt_bindx(struct sock *sk,
-				 struct sockaddr __user *addrs,
+static int sctp_setsockopt_bindx(struct sock *sk, struct sockaddr *kaddrs,
 				 int addrs_size, int op)
 {
-	struct sockaddr *kaddrs;
 	int err;
 	int addrcnt = 0;
 	int walk_size = 0;
@@ -991,23 +989,13 @@ static int sctp_setsockopt_bindx(struct sock *sk,
 	void *addr_buf;
 	struct sctp_af *af;
 
-	pr_debug("%s: sk:%p addrs:%p addrs_size:%d opt:%d\n",
-		 __func__, sk, addrs, addrs_size, op);
-
-	if (unlikely(addrs_size <= 0))
-		return -EINVAL;
+	pr_debug("%s: sk:%p kaddrs:%p addrs_size:%d opt:%d\n",
+		 __func__, sk, kaddrs, addrs_size, op);
 
-	kaddrs = memdup_user(addrs, addrs_size);
-	if (IS_ERR(kaddrs))
-		return PTR_ERR(kaddrs);
-
-	/* Walk through the addrs buffer and count the number of addresses. */
 	addr_buf = kaddrs;
 	while (walk_size < addrs_size) {
-		if (walk_size + sizeof(sa_family_t) > addrs_size) {
-			kfree(kaddrs);
+		if (walk_size + sizeof(sa_family_t) > addrs_size)
 			return -EINVAL;
-		}
 
 		sa_addr = addr_buf;
 		af = sctp_get_af_specific(sa_addr->sa_family);
@@ -1015,10 +1003,8 @@ static int sctp_setsockopt_bindx(struct sock *sk,
 		/* If the address family is not supported or if this address
 		 * causes the address buffer to overflow return EINVAL.
 		 */
-		if (!af || (walk_size + af->sockaddr_len) > addrs_size) {
-			kfree(kaddrs);
+		if (!af || (walk_size + af->sockaddr_len) > addrs_size)
 			return -EINVAL;
-		}
 		addrcnt++;
 		addr_buf += af->sockaddr_len;
 		walk_size += af->sockaddr_len;
@@ -1032,29 +1018,19 @@ static int sctp_setsockopt_bindx(struct sock *sk,
 						 (struct sockaddr *)kaddrs,
 						 addrs_size);
 		if (err)
-			goto out;
+			return err;
 		err = sctp_bindx_add(sk, kaddrs, addrcnt);
 		if (err)
-			goto out;
-		err = sctp_send_asconf_add_ip(sk, kaddrs, addrcnt);
-		break;
-
+			return err;
+		return sctp_send_asconf_add_ip(sk, kaddrs, addrcnt);
 	case SCTP_BINDX_REM_ADDR:
 		err = sctp_bindx_rem(sk, kaddrs, addrcnt);
 		if (err)
-			goto out;
-		err = sctp_send_asconf_del_ip(sk, kaddrs, addrcnt);
-		break;
-
+			return err;
+		return sctp_send_asconf_del_ip(sk, kaddrs, addrcnt);
 	default:
-		err = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-
-out:
-	kfree(kaddrs);
-
-	return err;
 }
 
 static int sctp_connect_new_asoc(struct sctp_endpoint *ep,
@@ -4670,6 +4646,7 @@ static int sctp_setsockopt_pf_expose(struct sock *sk,
 static int sctp_setsockopt(struct sock *sk, int level, int optname,
 			   char __user *optval, unsigned int optlen)
 {
+	struct sockaddr *kaddrs;
 	int retval = 0;
 
 	pr_debug("%s: sk:%p, optname:%d\n", __func__, sk, optname);
@@ -4682,30 +4659,37 @@ static int sctp_setsockopt(struct sock *sk, int level, int optname,
 	 */
 	if (level != SOL_SCTP) {
 		struct sctp_af *af = sctp_sk(sk)->pf->af;
-		retval = af->setsockopt(sk, level, optname, optval, optlen);
-		goto out_nounlock;
+		return af->setsockopt(sk, level, optname, optval, optlen);
 	}
 
+	if (unlikely(optlen <= 0))
+		return -EINVAL;
+
+	kaddrs = memdup_user(optval, optlen);
+	if (IS_ERR(kaddrs))
+		return PTR_ERR(kaddrs);
+
+	/* Walk through the addrs buffer and count the number of addresses. */
+
 	lock_sock(sk);
 
 	switch (optname) {
 	case SCTP_SOCKOPT_BINDX_ADD:
 		/* 'optlen' is the size of the addresses buffer. */
-		retval = sctp_setsockopt_bindx(sk, (struct sockaddr __user *)optval,
+		retval = sctp_setsockopt_bindx(sk, (struct sockaddr *)optval,
 					       optlen, SCTP_BINDX_ADD_ADDR);
 		break;
 
 	case SCTP_SOCKOPT_BINDX_REM:
 		/* 'optlen' is the size of the addresses buffer. */
-		retval = sctp_setsockopt_bindx(sk, (struct sockaddr __user *)optval,
+		retval = sctp_setsockopt_bindx(sk, (struct sockaddr *)optval,
 					       optlen, SCTP_BINDX_REM_ADDR);
 		break;
 
 	case SCTP_SOCKOPT_CONNECTX_OLD:
 		/* 'optlen' is the size of the addresses buffer. */
 		retval = sctp_setsockopt_connectx_old(sk,
-					    (struct sockaddr __user *)optval,
-					    optlen);
+					    (struct sockaddr *)optval, optlen);
 		break;
 
 	case SCTP_SOCKOPT_CONNECTX:
@@ -4871,8 +4855,7 @@ static int sctp_setsockopt(struct sock *sk, int level, int optname,
 	}
 
 	release_sock(sk);
-
-out_nounlock:
+	kfree(kaddrs);
 	return retval;
 }
 
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
