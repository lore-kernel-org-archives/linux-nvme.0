Return-Path: <SRS0=q3TM=63=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2427C2D0F9
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 06:29:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5BEE206A5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 06:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A9rKE5n9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BEE206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jP4XWUEteai7Le24xsGf6rAnrYU5WYStESrD+MDnqs0=; b=A9rKE5n9i+wZ1G
	R7C0+zXiiarBhqpzf4ewWrD8flS+Udj8f6uONKqxHztk67Bxz4rhhuAsKP1TdVF+UlJVSDiJaz6IJ
	DPG7yjgQYf4eYg0HfQUJQYQBMsgBme2I2oKHDbqtYqBpxucifVjuRFljwJRv2VHt+3MrPxcC3LTfG
	jpe29EsAFYtGQsGN497HrhdmPVvEfqQB/rxz95TilxVvlqp7Rv4yT99cJLtE6upcOpHa+MupdtTgP
	bA9BZseumdVnWOOhXPQ0g2jzYGTIMlA4CtIStNOUWoWM1sLWuszv2g2StHaoXfuv49XHkePXuqmT+
	QOSYvJ8ANJRufcW9445Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYktc-0006H8-F8; Wed, 13 May 2020 06:29:36 +0000
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYkrX-0004Hq-2R; Wed, 13 May 2020 06:27:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 12/33] tcp: add tcp_sock_set_quickack
Date: Wed, 13 May 2020 08:26:27 +0200
Message-Id: <20200513062649.2100053-13-hch@lst.de>
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

Add a helper to directly set the TCP_QUICKACK sockopt from kernel space
without going through a fake uaccess.  Cleanup the callers to avoid
pointless wrappers now that this is a simple function call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_int.h      |  7 ------
 drivers/block/drbd/drbd_receiver.c |  5 ++--
 include/linux/tcp.h                |  1 +
 net/ipv4/tcp.c                     | 39 ++++++++++++++++++++----------
 4 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index e24bba87c8e02..14345a87c7cc5 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1570,13 +1570,6 @@ extern void drbd_set_recv_tcq(struct drbd_device *device, int tcq_enabled);
 extern void _drbd_clear_done_ee(struct drbd_device *device, struct list_head *to_be_freed);
 extern int drbd_connected(struct drbd_peer_device *);
 
-static inline void drbd_tcp_quickack(struct socket *sock)
-{
-	int val = 2;
-	(void) kernel_setsockopt(sock, SOL_TCP, TCP_QUICKACK,
-			(char*)&val, sizeof(val));
-}
-
 /* sets the number of 512 byte sectors of our virtual device */
 void drbd_set_my_capacity(struct drbd_device *device, sector_t size);
 
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index da5a9ee896a43..cdd317ae97021 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1223,7 +1223,7 @@ static int drbd_recv_header_maybe_unplug(struct drbd_connection *connection, str
 		 * quickly as possible, and let remote TCP know what we have
 		 * received so far. */
 		if (err == -EAGAIN) {
-			drbd_tcp_quickack(connection->data.socket);
+			tcp_sock_set_quickack(connection->data.socket->sk, 2);
 			drbd_unplug_all_devices(connection);
 		}
 		if (err > 0) {
@@ -4959,8 +4959,7 @@ static int receive_UnplugRemote(struct drbd_connection *connection, struct packe
 {
 	/* Make sure we've acked all the TCP data associated
 	 * with the data requests being unplugged */
-	drbd_tcp_quickack(connection->data.socket);
-
+	tcp_sock_set_quickack(connection->data.socket->sk, 2);
 	return 0;
 }
 
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 533610b6ae420..e7ab6da5111b5 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -496,5 +496,6 @@ int tcp_skb_shift(struct sk_buff *to, struct sk_buff *from, int pcount,
 
 void tcp_sock_set_cork(struct sock *sk, bool on);
 void tcp_sock_set_nodelay(struct sock *sk, bool on);
+void tcp_sock_set_quickack(struct sock *sk, int val);
 
 #endif	/* _LINUX_TCP_H */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 300ce622607d8..c681f43f0bb85 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2845,6 +2845,31 @@ void tcp_sock_set_nodelay(struct sock *sk, bool on)
 }
 EXPORT_SYMBOL(tcp_sock_set_nodelay);
 
+static void __tcp_sock_set_quickack(struct sock *sk, int val)
+{
+	if (!val) {
+		inet_csk_enter_pingpong_mode(sk);
+		return;
+	}
+
+	inet_csk_exit_pingpong_mode(sk);
+	if ((1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT) &&
+	    inet_csk_ack_scheduled(sk)) {
+		inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_PUSHED;
+		tcp_cleanup_rbuf(sk, 1);
+		if (!(val & 1))
+			inet_csk_enter_pingpong_mode(sk);
+	}
+}
+
+void tcp_sock_set_quickack(struct sock *sk, int val)
+{
+	lock_sock(sk);
+	__tcp_sock_set_quickack(sk, val);
+	release_sock(sk);
+}
+EXPORT_SYMBOL(tcp_sock_set_quickack);
+
 /*
  *	Socket option code for TCP.
  */
@@ -3085,19 +3110,7 @@ static int do_tcp_setsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_QUICKACK:
-		if (!val) {
-			inet_csk_enter_pingpong_mode(sk);
-		} else {
-			inet_csk_exit_pingpong_mode(sk);
-			if ((1 << sk->sk_state) &
-			    (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT) &&
-			    inet_csk_ack_scheduled(sk)) {
-				icsk->icsk_ack.pending |= ICSK_ACK_PUSHED;
-				tcp_cleanup_rbuf(sk, 1);
-				if (!(val & 1))
-					inet_csk_enter_pingpong_mode(sk);
-			}
-		}
+		__tcp_sock_set_quickack(sk, val);
 		break;
 
 #ifdef CONFIG_TCP_MD5SIG
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
