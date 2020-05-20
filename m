Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD72CC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 19:56:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F82207E8
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 19:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ERnbmnJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F82207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fZkUl8++LCkoYn5DYZmqnywzJsgi5BLNTjfK7IKJ2vw=; b=ERnbmnJr2Iwxui
	JydIFhlQYuGw4/wmElkBfe2+304Z+Ngx0H0xq+vb5lxcQ3G6H1whzuqfpiOQnjCOuXnMq5lSuti/p
	pVeKqYPdRg5ashbczK0ZTZUgn53ZOm/8lhm4DZ5B8JrNniiI0Mdr5yUqQioRvnAYGo5W6F3MEyvBd
	NKdxg6mX3xFcd42heecWPOO+jFsHQhqHp+aYZh6am577wLv4kogWdgmWBvBlngZiixG6omYpsj9A0
	aiGsSxpsZ3QtLngvFEp3yVS/1te/EhveBS2sd2cCLDgjUFh0ct1fzPICXWujcfRqvJWwDmUeYJEk2
	YfLWVP+C+qJfUwY7m9HA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbUpP-0003Sp-0I; Wed, 20 May 2020 19:56:47 +0000
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbUoJ-00028h-FL; Wed, 20 May 2020 19:55:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 06/33] net: add sock_set_sndtimeo
Date: Wed, 20 May 2020 21:54:42 +0200
Message-Id: <20200520195509.2215098-7-hch@lst.de>
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

Add a helper to directly set the SO_SNDTIMEO_NEW sockopt from kernel
space without going through a fake uaccess.  The interface is
simplified to only pass the seconds value, as that is the only
thing needed at the moment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/dlm/lowcomms.c  |  8 ++------
 include/net/sock.h |  1 +
 net/core/sock.c    | 11 +++++++++++
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 88f2574ca63ad..b79711d0aac72 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -918,7 +918,6 @@ static void sctp_connect_to_sock(struct connection *con)
 	int result;
 	int addr_len;
 	struct socket *sock;
-	struct __kernel_sock_timeval tv = { .tv_sec = 5, .tv_usec = 0 };
 
 	if (con->nodeid == 0) {
 		log_print("attempt to connect sock 0 foiled");
@@ -970,13 +969,10 @@ static void sctp_connect_to_sock(struct connection *con)
 	 * since O_NONBLOCK argument in connect() function does not work here,
 	 * then, we should restore the default value of this attribute.
 	 */
-	kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_NEW, (char *)&tv,
-			  sizeof(tv));
+	sock_set_sndtimeo(sock->sk, 5);
 	result = sock->ops->connect(sock, (struct sockaddr *)&daddr, addr_len,
 				   0);
-	memset(&tv, 0, sizeof(tv));
-	kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_NEW, (char *)&tv,
-			  sizeof(tv));
+	sock_set_sndtimeo(sock->sk, 0);
 
 	if (result == -EINPROGRESS)
 		result = 0;
diff --git a/include/net/sock.h b/include/net/sock.h
index a3a43141a4be2..9a7b9e98685ac 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2691,5 +2691,6 @@ void sock_def_readable(struct sock *sk);
 void sock_no_linger(struct sock *sk);
 void sock_set_priority(struct sock *sk, u32 priority);
 void sock_set_reuseaddr(struct sock *sk);
+void sock_set_sndtimeo(struct sock *sk, s64 secs);
 
 #endif	/* _SOCK_H */
diff --git a/net/core/sock.c b/net/core/sock.c
index ceda1a9248b3e..d3b1d61e4f768 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -737,6 +737,17 @@ void sock_set_priority(struct sock *sk, u32 priority)
 }
 EXPORT_SYMBOL(sock_set_priority);
 
+void sock_set_sndtimeo(struct sock *sk, s64 secs)
+{
+	lock_sock(sk);
+	if (secs && secs < MAX_SCHEDULE_TIMEOUT / HZ - 1)
+		sk->sk_sndtimeo = secs * HZ;
+	else
+		sk->sk_sndtimeo = MAX_SCHEDULE_TIMEOUT;
+	release_sock(sk);
+}
+EXPORT_SYMBOL(sock_set_sndtimeo);
+
 /*
  *	This is meant for all protocols to use and covers goings on
  *	at the socket level. Everything here is generic.
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
