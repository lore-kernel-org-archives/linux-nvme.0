Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E89C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 19:59:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C831207D8
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 19:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="III+NTlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C831207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f1HH7kF//dD9dCLDTg03uQBvdv6B+tz9vm9u1Kz5oaE=; b=III+NTlX0+GkEQ
	sF5SDKPbpmgvCowWSS1R749sLvSigAdPJ+X70iZYi/uYtlNbGQRD/4K2fOVhWpLjp5PK8QHDMexvt
	cnwqnbfltJZG4+qhIhWsFVYq7srzCu4L+SvNHh5yRMsuR4HS72S0tnAbnkijdM500axaExNabqzl/
	WrsicdjUbRpM9z+bbost921PGKSNnCzgF41rtdTJDQ5+4k81+Yf3/yDZiVC693L0oKwjmyoetb9m4
	42ZMhod1gYLSVbX+DYkF9YpgM3qHXw4x5G0mJUK+wRw2BWVAzsDYrLr1ju3tXhG2QOM50rOialZ0u
	9ISqjEP1XifzmWQXbOow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbUs5-0006Qv-2U; Wed, 20 May 2020 19:59:21 +0000
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbUp0-0002zZ-TE; Wed, 20 May 2020 19:56:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 21/33] ipv4: add ip_sock_set_freebind
Date: Wed, 20 May 2020 21:54:57 +0200
Message-Id: <20200520195509.2215098-22-hch@lst.de>
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

Add a helper to directly set the IP_FREEBIND sockopt from kernel space
without going through a fake uaccess.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/target/iscsi/iscsi_target_login.c | 13 +++----------
 include/net/ip.h                          |  1 +
 net/ipv4/ip_sockglue.c                    |  8 ++++++++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
index b561b07a869a0..85748e3388582 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -15,6 +15,7 @@
 #include <linux/sched/signal.h>
 #include <linux/idr.h>
 #include <linux/tcp.h>        /* TCP_NODELAY */
+#include <net/ip.h>
 #include <net/ipv6.h>         /* ipv6_addr_v4mapped() */
 #include <scsi/iscsi_proto.h>
 #include <target/target_core_base.h>
@@ -855,7 +856,7 @@ int iscsit_setup_np(
 	struct sockaddr_storage *sockaddr)
 {
 	struct socket *sock = NULL;
-	int backlog = ISCSIT_TCP_BACKLOG, ret, opt = 0, len;
+	int backlog = ISCSIT_TCP_BACKLOG, ret, len;
 
 	switch (np->np_network_transport) {
 	case ISCSI_TCP:
@@ -900,15 +901,7 @@ int iscsit_setup_np(
 	if (np->np_network_transport == ISCSI_TCP)
 		tcp_sock_set_nodelay(sock->sk);
 	sock_set_reuseaddr(sock->sk);
-
-	opt = 1;
-	ret = kernel_setsockopt(sock, IPPROTO_IP, IP_FREEBIND,
-			(char *)&opt, sizeof(opt));
-	if (ret < 0) {
-		pr_err("kernel_setsockopt() for IP_FREEBIND"
-			" failed\n");
-		goto fail;
-	}
+	ip_sock_set_freebind(sock->sk);
 
 	ret = kernel_bind(sock, (struct sockaddr *)&np->np_sockaddr, len);
 	if (ret < 0) {
diff --git a/include/net/ip.h b/include/net/ip.h
index 2fc52e26fa88b..5f5d8226b6abc 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -765,6 +765,7 @@ static inline bool inetdev_valid_mtu(unsigned int mtu)
 	return likely(mtu >= IPV4_MIN_MTU);
 }
 
+void ip_sock_set_freebind(struct sock *sk);
 void ip_sock_set_tos(struct sock *sk, int val);
 
 #endif	/* _IP_H */
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 1733ac78c21aa..62e642ab80126 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -581,6 +581,14 @@ void ip_sock_set_tos(struct sock *sk, int val)
 }
 EXPORT_SYMBOL(ip_sock_set_tos);
 
+void ip_sock_set_freebind(struct sock *sk)
+{
+	lock_sock(sk);
+	inet_sk(sk)->freebind = true;
+	release_sock(sk);
+}
+EXPORT_SYMBOL(ip_sock_set_freebind);
+
 /*
  *	Socket option code for IP. This is the end of the line after any
  *	TCP,UDP etc options on an IP socket.
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
