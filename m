Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BEAC87FCC
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Jul 2025 18:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j3IMlRLwAFtF12zLNMWvpT+3MnfpTZ0F/2N2UD+Uq8g=; b=GjLY4sY3EeF/u7fyN5isLiWZw+
	wkGe1KC2QOu01BTfPpYHrPFJLpoSnfYipulOOPE7wd/fgUUYz7csrKoQ8CqDmwaUVlf/UzNz7NYlz
	Q8ZxzNQ1JIFG8yzHhrBiVJrAwJs5cRy54eoFan+lHqAvsDwO2gz9KjPizeKaPMovoGQ9F8wUrCERv
	TPC8X6PRQy2OLue5YUHpRWaIsknn7MGgYRLHkGUUYRjXBwcz6XwYqZ3Vgv1HhE3Q8lr53Nkhfv07y
	a/AkQkRgZlNx+IBTdbtpuV/g88wRySxBI0ymyTRNFqKBJXySxANDV8lJmS+IKbmpHJKMJFH+/uToh
	eY9YIfLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhXau-00000004DXZ-3EfU;
	Thu, 31 Jul 2025 18:01:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhXas-00000004DVj-31EP
	for linux-nvme@lists.infradead.org;
	Thu, 31 Jul 2025 18:01:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753984889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3IMlRLwAFtF12zLNMWvpT+3MnfpTZ0F/2N2UD+Uq8g=;
	b=jRAOX18WoGw89e4uUMQWLOtguA7jXdcSAKU7o0e/CXlQ9H0e/o+GRMxYxMNGYzN3bAqIdl
	XUxaQON4DRlBCNgY9aMM5rj2OtSqTgSAYTC5NNC/E8Bdl21EGxk+wH3HrZoZqcuKiaKOBk
	E18McGT+XqogsrHROzklwUuBQgXfXYs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-zFPmQR8OP6uYCq6jTQV7MA-1; Thu,
 31 Jul 2025 14:01:26 -0400
X-MC-Unique: zFPmQR8OP6uYCq6jTQV7MA-1
X-Mimecast-MFC-AGG-ID: zFPmQR8OP6uYCq6jTQV7MA_1753984883
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 547FD1954B18;
	Thu, 31 Jul 2025 18:01:23 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.82.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 648143000199;
	Thu, 31 Jul 2025 18:01:19 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	trondmy@hammerspace.com,
	anna.schumaker@oracle.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	hare@suse.de,
	horms@kernel.org,
	kbusch@kernel.org
Subject: [PATCH v2 4/4] net/handshake: change tls_alert_recv to receive a kvec
Date: Thu, 31 Jul 2025 14:00:58 -0400
Message-Id: <20250731180058.4669-5-okorniev@redhat.com>
In-Reply-To: <20250731180058.4669-1-okorniev@redhat.com>
References: <20250731180058.4669-1-okorniev@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250731_110130_842723_73D7E2E3 
X-CRM114-Status: GOOD (  17.43  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Instead of trying to read the data from the msg iterator,
callers to tls_alert_recv() need to pass in a kvec directly.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 drivers/nvme/target/tcp.c | 13 +++++--------
 include/net/handshake.h   |  2 +-
 net/handshake/alert.c     |  6 +++---
 net/sunrpc/svcsock.c      | 17 ++++++++---------
 net/sunrpc/xprtsock.c     | 19 +++++++++----------
 5 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 98cee10de713..7ea8644de622 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1106,7 +1106,7 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
 }
 
 static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
-		struct msghdr *msg, char *cbuf)
+		struct kvec *iov, char *cbuf)
 {
 	struct cmsghdr *cmsg = (struct cmsghdr *)cbuf;
 	u8 ctype, level, description;
@@ -1119,7 +1119,7 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 	case TLS_RECORD_TYPE_DATA:
 		break;
 	case TLS_RECORD_TYPE_ALERT:
-		tls_alert_recv(queue->sock->sk, msg, &level, &description);
+		tls_alert_recv(queue->sock->sk, iov, &level, &description);
 		if (level == TLS_ALERT_LEVEL_FATAL) {
 			pr_err("queue %d: TLS Alert desc %u\n",
 			       queue->idx, description);
@@ -1160,8 +1160,7 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 	if (unlikely(len < 0))
 		return len;
 	if (queue->tls_pskid) {
-		iov_iter_revert(&msg.msg_iter, len);
-		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
+		ret = nvmet_tcp_tls_record_ok(queue, &iov, cbuf);
 		if (ret < 0)
 			return ret;
 	}
@@ -1276,8 +1275,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 	if (unlikely(len < 0))
 		return len;
 	if (queue->tls_pskid) {
-		iov_iter_revert(&msg.msg_iter, len);
-		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
+		ret = nvmet_tcp_tls_record_ok(queue, &iov, cbuf);
 		if (ret < 0)
 			return ret;
 	}
@@ -1742,8 +1740,7 @@ static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue)
 		return len;
 	}
 
-	iov_iter_revert(&msg.msg_iter, len);
-	ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
+	ret = nvmet_tcp_tls_record_ok(queue, &iov, cbuf);
 	if (ret < 0)
 		return ret;
 
diff --git a/include/net/handshake.h b/include/net/handshake.h
index 8ebd4f9ed26e..33ffc8e88923 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -43,7 +43,7 @@ bool tls_handshake_cancel(struct sock *sk);
 void tls_handshake_close(struct socket *sock);
 
 u8 tls_get_record_type(const struct sock *sk, const struct cmsghdr *msg);
-void tls_alert_recv(const struct sock *sk, const struct msghdr *msg,
+void tls_alert_recv(const struct sock *sk, const struct kvec *iov,
 		    u8 *level, u8 *description);
 
 #endif /* _NET_HANDSHAKE_H */
diff --git a/net/handshake/alert.c b/net/handshake/alert.c
index 329d91984683..4662a406b64a 100644
--- a/net/handshake/alert.c
+++ b/net/handshake/alert.c
@@ -94,13 +94,13 @@ EXPORT_SYMBOL(tls_get_record_type);
  * @description: OUT - TLS AlertDescription value
  *
  */
-void tls_alert_recv(const struct sock *sk, const struct msghdr *msg,
+void tls_alert_recv(const struct sock *sk, const struct kvec *iov,
 		    u8 *level, u8 *description)
 {
-	const struct kvec *iov;
 	u8 *data;
 
-	iov = msg->msg_iter.kvec;
+	if (!iov)
+		return;
 	data = iov->iov_base;
 	*level = data[0];
 	*description = data[1];
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index e2c5e0e626f9..8701abd7fff2 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -228,7 +228,7 @@ static int svc_one_sock_name(struct svc_sock *svsk, char *buf, int remaining)
 }
 
 static int
-svc_tcp_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
+svc_tcp_sock_process_cmsg(struct socket *sock, struct kvec *iov,
 			  struct cmsghdr *cmsg, int ret)
 {
 	u8 content_type = tls_get_record_type(sock->sk, cmsg);
@@ -238,14 +238,10 @@ svc_tcp_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
 	case 0:
 		break;
 	case TLS_RECORD_TYPE_DATA:
-		/* TLS sets EOR at the end of each application data
-		 * record, even though there might be more frames
-		 * waiting to be decrypted.
-		 */
-		msg->msg_flags &= ~MSG_EOR;
+		pr_warn("received TLS DATA; expected TLS control message\n");
 		break;
 	case TLS_RECORD_TYPE_ALERT:
-		tls_alert_recv(sock->sk, msg, &level, &description);
+		tls_alert_recv(sock->sk, iov, &level, &description);
 		ret = (level == TLS_ALERT_LEVEL_FATAL) ?
 			-ENOTCONN : -EAGAIN;
 		break;
@@ -280,8 +276,7 @@ svc_tcp_sock_recv_cmsg(struct socket *sock, unsigned int *msg_flags)
 	ret = sock_recvmsg(sock, &msg, MSG_DONTWAIT);
 	if (ret > 0 &&
 	    tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT) {
-		iov_iter_revert(&msg.msg_iter, ret);
-		ret = svc_tcp_sock_process_cmsg(sock, &msg, &u.cmsg, -EAGAIN);
+		ret = svc_tcp_sock_process_cmsg(sock, &alert_kvec, &u.cmsg, -EAGAIN);
 	}
 	return ret;
 }
@@ -294,6 +289,10 @@ svc_tcp_sock_recvmsg(struct svc_sock *svsk, struct msghdr *msg)
 
 	ret = sock_recvmsg(sock, msg, MSG_DONTWAIT);
 	if (msg->msg_flags & MSG_CTRUNC) {
+		/* TLS sets EOR at the end of each application data
+		 * record, even though there might be more frames
+		 * waiting to be decrypted.
+		 */
 		msg->msg_flags &= ~(MSG_CTRUNC | MSG_EOR);
 		if (ret == 0 || ret == -EIO)
 			ret = svc_tcp_sock_recv_cmsg(sock, &msg->msg_flags);
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index c5f7bbf5775f..005021773da1 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -357,7 +357,7 @@ xs_alloc_sparse_pages(struct xdr_buf *buf, size_t want, gfp_t gfp)
 }
 
 static int
-xs_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
+xs_sock_process_cmsg(struct socket *sock, struct kvec *iov,
 		     unsigned int *msg_flags, struct cmsghdr *cmsg, int ret)
 {
 	u8 content_type = tls_get_record_type(sock->sk, cmsg);
@@ -367,14 +367,10 @@ xs_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
 	case 0:
 		break;
 	case TLS_RECORD_TYPE_DATA:
-		/* TLS sets EOR at the end of each application data
-		 * record, even though there might be more frames
-		 * waiting to be decrypted.
-		 */
-		*msg_flags &= ~MSG_EOR;
+		pr_warn("received TLS DATA; expected TLS control message\n");
 		break;
 	case TLS_RECORD_TYPE_ALERT:
-		tls_alert_recv(sock->sk, msg, &level, &description);
+		tls_alert_recv(sock->sk, iov, &level, &description);
 		ret = (level == TLS_ALERT_LEVEL_FATAL) ?
 			-EACCES : -EAGAIN;
 		break;
@@ -409,9 +405,8 @@ xs_sock_recv_cmsg(struct socket *sock, unsigned int *msg_flags, int flags)
 	ret = sock_recvmsg(sock, &msg, flags);
 	if (ret > 0 &&
 	    tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT) {
-		iov_iter_revert(&msg.msg_iter, ret);
-		ret = xs_sock_process_cmsg(sock, &msg, msg_flags, &u.cmsg,
-					   -EAGAIN);
+		ret = xs_sock_process_cmsg(sock, &alert_kvec, msg_flags,
+					   &u.cmsg, -EAGAIN);
 	}
 	return ret;
 }
@@ -425,6 +420,10 @@ xs_sock_recvmsg(struct socket *sock, struct msghdr *msg, int flags, size_t seek)
 	ret = sock_recvmsg(sock, msg, flags);
 	/* Handle TLS inband control message lazily */
 	if (msg->msg_flags & MSG_CTRUNC) {
+		/* TLS sets EOR at the end of each application data
+		 * ecord, even though there might be more frames
+		 * waiting to be decrypted.
+		 */
 		msg->msg_flags &= ~(MSG_CTRUNC | MSG_EOR);
 		if (ret == 0 || ret == -EIO)
 			ret = xs_sock_recv_cmsg(sock, &msg->msg_flags, flags);
-- 
2.47.1


