Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942ADC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 16:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Cc:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lwqt2W8OioGiM7MpbGJRYrFKH56iVszK+R0QKFIFN3c=; b=MgRppS4VbheD9OjQtZ/pLG/3ct
	e/oICwLcGAShZ9omksQZV6VS0Kg6LZX/8DwPXo/HNrwMIHUgo5d4xL6oRngK8MyZ//Mj9IwiHIaxQ
	tnC2bkm5kXhdvJHgEyHhwaA6rPmq/l+ii/0ZpVrG2DwF09MF4lRiS+g8qg8pOUczH/9IRphkrkVfX
	CZri6mmZYMW2y2S+gZorhbT9Zz+SfZEuo4R+mAqvpj7n7MnVjww6UJKuFRkR4ItGLSc+GKgwYNn29
	SUtUK9S+1knGAWnM1eXEG1UAbr3+nXEqRF2aey4lmBtYBKGQ9kCS3oVMM8exkUaZOxo8Je5ELSAI4
	5+dVeM4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngUcE-0008sk-9M; Mon, 18 Apr 2022 16:52:42 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngUb3-0008JO-EB
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 16:51:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EFFD661309;
 Mon, 18 Apr 2022 16:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8E0C385AB;
 Mon, 18 Apr 2022 16:51:28 +0000 (UTC)
Subject: [PATCH RFC 03/15] SUNRPC: Capture cmsg metadata on client-side receive
From: Chuck Lever <chuck.lever@oracle.com>
To: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: ak@tempesta-tech.com, borisp@nvidia.com, simo@redhat.com
Date: Mon, 18 Apr 2022 12:51:27 -0400
Message-ID: <165030068714.5246.3782745125073050750.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <165030062272.5246.16956092606399079004.stgit@oracle-102.nfsv4.dev>
References: <165030062272.5246.16956092606399079004.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_095129_642932_2408BD8E 
X-CRM114-Status: GOOD (  16.06  )
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

kTLS sockets use cmsg to report decryption errors and the need
for session re-keying. An "application data" message contains a ULP
payload, and that is passed along to the RPC client. An "alert"
message triggers connection reset. Everything else is discarded.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/net/tls.h             |    2 ++
 include/trace/events/sunrpc.h |   40 +++++++++++++++++++++++++++++++++
 net/sunrpc/xprtsock.c         |   49 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 6b1bf46daa34..54bccb2e4014 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -71,6 +71,8 @@ static inline struct tlsh_sock *tlsh_sk(struct sock *sk)
 
 #define TLS_CRYPTO_INFO_READY(info)	((info)->cipher_type)
 
+#define TLS_RECORD_TYPE_ALERT		0x15
+#define TLS_RECORD_TYPE_HANDSHAKE	0x16
 #define TLS_RECORD_TYPE_DATA		0x17
 
 #define TLS_AAD_SPACE_SIZE		13
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index a66aa1f59ed8..49b748c03610 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1286,6 +1286,46 @@ TRACE_EVENT(xs_data_ready,
 	TP_printk("peer=[%s]:%s", __get_str(addr), __get_str(port))
 );
 
+/*
+ * From https://www.iana.org/assignments/tls-parameters/tls-parameters.xhtml
+ *
+ * Captured March 2022. Other values are unassigned or reserved.
+ */
+#define rpc_show_tls_content_type(type) \
+	__print_symbolic(type, \
+		{ 20,		"change cipher spec" }, \
+		{ 21,		"alert" }, \
+		{ 22,		"handshake" }, \
+		{ 23,		"application data" }, \
+		{ 24,		"heartbeat" }, \
+		{ 25,		"tls12_cid" }, \
+		{ 26,		"ACK" })
+
+TRACE_EVENT(xs_tls_contenttype,
+	TP_PROTO(
+		const struct rpc_xprt *xprt,
+		unsigned char ctype
+	),
+
+	TP_ARGS(xprt, ctype),
+
+	TP_STRUCT__entry(
+		__string(addr, xprt->address_strings[RPC_DISPLAY_ADDR])
+		__string(port, xprt->address_strings[RPC_DISPLAY_PORT])
+		__field(unsigned long, ctype)
+	),
+
+	TP_fast_assign(
+		__assign_str(addr, xprt->address_strings[RPC_DISPLAY_ADDR]);
+		__assign_str(port, xprt->address_strings[RPC_DISPLAY_PORT]);
+		__entry->ctype = ctype;
+	),
+
+	TP_printk("peer=[%s]:%s: %s", __get_str(addr), __get_str(port),
+		rpc_show_tls_content_type(__entry->ctype)
+	)
+);
+
 TRACE_EVENT(xs_stream_read_data,
 	TP_PROTO(struct rpc_xprt *xprt, ssize_t err, size_t total),
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index b5bc03c52b9b..e42ae84d7359 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -47,6 +47,8 @@
 #include <net/checksum.h>
 #include <net/udp.h>
 #include <net/tcp.h>
+#include <net/tls.h>
+
 #include <linux/bvec.h>
 #include <linux/highmem.h>
 #include <linux/uio.h>
@@ -350,13 +352,56 @@ xs_alloc_sparse_pages(struct xdr_buf *buf, size_t want, gfp_t gfp)
 	return want;
 }
 
+static int
+xs_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
+		     struct cmsghdr *cmsg, int ret)
+{
+	if (cmsg->cmsg_level == SOL_TLS &&
+	    cmsg->cmsg_type == TLS_GET_RECORD_TYPE) {
+		u8 content_type = *((u8 *)CMSG_DATA(cmsg));
+
+		trace_xs_tls_contenttype(xprt_from_sock(sock->sk), content_type);
+		switch (content_type) {
+		case TLS_RECORD_TYPE_DATA:
+			/* TLS sets EOR at the end of each application data
+			 * record, even though there might be more frames
+			 * waiting to be decrypted. */
+			msg->msg_flags &= ~MSG_EOR;
+			break;
+		case TLS_RECORD_TYPE_ALERT:
+			ret = -ENOTCONN;
+			break;
+		default:
+			ret = -EAGAIN;
+		}
+	}
+	return ret;
+}
+
+static int
+xs_sock_recv_cmsg(struct socket *sock, struct msghdr *msg, int flags)
+{
+	union {
+		struct cmsghdr	cmsg;
+		u8		buf[CMSG_SPACE(sizeof(u8))];
+	} u;
+	int ret;
+
+	msg->msg_control = &u;
+	msg->msg_controllen = sizeof(u);
+	ret = sock_recvmsg(sock, msg, flags);
+	if (msg->msg_controllen != sizeof(u))
+		ret = xs_sock_process_cmsg(sock, msg, &u.cmsg, ret);
+	return ret;
+}
+
 static ssize_t
 xs_sock_recvmsg(struct socket *sock, struct msghdr *msg, int flags, size_t seek)
 {
 	ssize_t ret;
 	if (seek != 0)
 		iov_iter_advance(&msg->msg_iter, seek);
-	ret = sock_recvmsg(sock, msg, flags);
+	ret = xs_sock_recv_cmsg(sock, msg, flags);
 	return ret > 0 ? ret + seek : ret;
 }
 
@@ -382,7 +427,7 @@ xs_read_discard(struct socket *sock, struct msghdr *msg, int flags,
 		size_t count)
 {
 	iov_iter_discard(&msg->msg_iter, READ, count);
-	return sock_recvmsg(sock, msg, flags);
+	return xs_sock_recv_cmsg(sock, msg, flags);
 }
 
 #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE



