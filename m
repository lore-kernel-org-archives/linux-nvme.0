Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372A7C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 22:13:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0A764F2A
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 22:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0A764F2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QDLHC8grU2ie/n4+qKNDpHVSHfFiOVXDnQP3jxajGag=; b=NH7/1NRjVEMXEx4QcicAVFS4Y
	6L0B2znIq/jJJFaXSAuCOlu/caIK3G+qL1SfBNMApqhmbXEgdJ0WarYlDdQeJwhzlp1+lh8Z8q5M1
	kyF5AvQLgV0o0lNb0b2NfAa9Leff4+YcxcqhqdmoV4GE3960Jn0EGVRw7uxMUBazn4QuMsFd8M1Gv
	SEr98OgB/9NGy2l+fXRiCn5S/+3xppqGbwkO+gLqI3HB/2igZ+3Iq2O3UJKP1DJ2C0mHhgS+sXiM/
	kbKk6cpumdaasrWVQstBnJBVXdOrs4eGMnJLzq7IavYvbYpEPVnM7yw171b2bZdIuVnfqSk41kk91
	Cz4uQ3W4g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMeP7-0040MG-QN; Wed, 17 Mar 2021 22:12:37 +0000
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMeND-00403g-7K
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 22:10:43 +0000
Received: by mail-il1-x130.google.com with SMTP id h1so3026008ilr.1
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 15:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QcIC9AJXtpThxMkHO6EHpl8vXTIqJ7UbjVf3Kn/bC7o=;
 b=pz9PXLINzEse5f48mEUswt2YeHFMy7zQw9f9ObmtPhY3P022fn8QSQ/+HUoVxdDdO0
 SsbMoDPHB2E/Nu68mzCgZotkmjNzw1Y4gS+6zmKXN563Sgg1mzkI7tekhnWe+cuOmAFt
 HkyR70fOmRng0SsAWc6aPIRlQsytQYwLg3UIi1HimjoJLONPbM6DsyHI5c7MnQGJzxHj
 am9sowvXT5Nir+w1ZDsN++6Bsl8eCjes2hZbAH54SkENRn9OLFGRGHOyVhHTDxIL8YiZ
 vp/GeiS+1XF1utw2rjvLTMsLw+HjTogkzoNE7sMXTTiC2+RkF+QI2gzEAW7h31GtgRaW
 HTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QcIC9AJXtpThxMkHO6EHpl8vXTIqJ7UbjVf3Kn/bC7o=;
 b=sL7x/qkK8/O4nElrFk1GZr15WxHbu2VdFM96c78sog6/jLzrFwlr09g6yn0eCFOe78
 xmnGABRbK0n41RwOR1p6OaoPIEAOH8h+YEwPMTeKxdr5gPIQMkYLBpfhPdmrVN5uFS/F
 cryJk9/oZnXdWsHUMPVkZI0ATenxEAyW70tQPiqU9FjrKe9XY+51kV+R+HoDRxT1T1qF
 MWjjdgnfVy6i8fYlm5vNe9WouvwHBm2Fakx5mvJWSobBDyHKGjsTUrzIfAM2jcUeP8vo
 mE6lVFUWsdUznSThL4BDKE8xcXXxf9c4LPgENd/dn1AMULpRUDNJFG7UQgQ/2GKipdvA
 k8VA==
X-Gm-Message-State: AOAM5320xbR7yejzUfZTGsUSl4KL64fb9tpv/bY6NmOOkW1Rs17N8FRN
 oX2zpchDTSrfF3E4/FpMfL38mg==
X-Google-Smtp-Source: ABdhPJyUPe18vW6d4l74brZYi4w3YGoKQOFCe4ikfiz2AzueqCCUYCh7yoEJeqkhNWVsK4cUSpT08Q==
X-Received: by 2002:a92:d352:: with SMTP id a18mr8790000ilh.33.1616019037985; 
 Wed, 17 Mar 2021 15:10:37 -0700 (PDT)
Received: from p1.localdomain ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id r3sm160700ilq.42.2021.03.17.15.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Mar 2021 15:10:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: joshi.k@samsung.com, hch@lst.de, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, metze@samba.org,
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/8] net: wire up support for file_operations->uring_cmd()
Date: Wed, 17 Mar 2021 16:10:26 -0600
Message-Id: <20210317221027.366780-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210317221027.366780-1-axboe@kernel.dk>
References: <20210317221027.366780-1-axboe@kernel.dk>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_221039_608072_C815ABC5 
X-CRM114-Status: GOOD (  17.77  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Pass it through the proto_ops->uring_cmd() handler, so we can plumb it
through all the way to the proto->uring_cmd() handler.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/net.h  |  2 ++
 include/net/sock.h   |  6 ++++++
 net/core/sock.c      | 17 +++++++++++++++--
 net/dccp/ipv4.c      |  1 +
 net/ipv4/af_inet.c   |  3 +++
 net/l2tp/l2tp_ip.c   |  1 +
 net/mptcp/protocol.c |  1 +
 net/sctp/protocol.c  |  1 +
 net/socket.c         | 13 +++++++++++++
 9 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index ba736b457a06..b61c6cfefc15 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -159,6 +159,8 @@ struct proto_ops {
 	int	 	(*compat_ioctl) (struct socket *sock, unsigned int cmd,
 				      unsigned long arg);
 #endif
+	int		(*uring_cmd)(struct socket *sock, struct io_uring_cmd *cmd,
+					enum io_uring_cmd_flags issue_flags);
 	int		(*gettstamp) (struct socket *sock, void __user *userstamp,
 				      bool timeval, bool time32);
 	int		(*listen)    (struct socket *sock, int len);
diff --git a/include/net/sock.h b/include/net/sock.h
index 636810ddcd9b..9c2921f4357a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -110,6 +110,7 @@ typedef struct {
 struct sock;
 struct proto;
 struct net;
+struct io_uring_cmd;
 
 typedef __u32 __bitwise __portpair;
 typedef __u64 __bitwise __addrpair;
@@ -1146,6 +1147,9 @@ struct proto {
 
 	int			(*ioctl)(struct sock *sk, int cmd,
 					 unsigned long arg);
+	int			(*uring_cmd)(struct sock *sk,
+					struct io_uring_cmd *cmd,
+					enum io_uring_cmd_flags issue_flags);
 	int			(*init)(struct sock *sk);
 	void			(*destroy)(struct sock *sk);
 	void			(*shutdown)(struct sock *sk, int how);
@@ -1761,6 +1765,8 @@ int sock_common_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 			int flags);
 int sock_common_setsockopt(struct socket *sock, int level, int optname,
 			   sockptr_t optval, unsigned int optlen);
+int sock_common_uring_cmd(struct socket *sock, struct io_uring_cmd *cmd,
+				enum io_uring_cmd_flags issue_flags);
 
 void sk_common_release(struct sock *sk);
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 0ed98f20448a..e3c1bd68fdfd 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3264,6 +3264,18 @@ int sock_common_setsockopt(struct socket *sock, int level, int optname,
 }
 EXPORT_SYMBOL(sock_common_setsockopt);
 
+int sock_common_uring_cmd(struct socket *sock, struct io_uring_cmd *cmd,
+				enum io_uring_cmd_flags issue_flags)
+{
+	struct sock *sk = sock->sk;
+
+	if (!sk->sk_prot || !sk->sk_prot->uring_cmd)
+		return -EOPNOTSUPP;
+
+	return sk->sk_prot->uring_cmd(sk, cmd, issue_flags);
+}
+EXPORT_SYMBOL(sock_common_uring_cmd);
+
 void sk_common_release(struct sock *sk)
 {
 	if (sk->sk_prot->destroy)
@@ -3615,7 +3627,7 @@ static void proto_seq_printf(struct seq_file *seq, struct proto *proto)
 {
 
 	seq_printf(seq, "%-9s %4u %6d  %6ld   %-3s %6u   %-3s  %-10s "
-			"%2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c\n",
+			"%2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c\n",
 		   proto->name,
 		   proto->obj_size,
 		   sock_prot_inuse_get(seq_file_net(seq), proto),
@@ -3629,6 +3641,7 @@ static void proto_seq_printf(struct seq_file *seq, struct proto *proto)
 		   proto_method_implemented(proto->disconnect),
 		   proto_method_implemented(proto->accept),
 		   proto_method_implemented(proto->ioctl),
+		   proto_method_implemented(proto->uring_cmd),
 		   proto_method_implemented(proto->init),
 		   proto_method_implemented(proto->destroy),
 		   proto_method_implemented(proto->shutdown),
@@ -3657,7 +3670,7 @@ static int proto_seq_show(struct seq_file *seq, void *v)
 			   "maxhdr",
 			   "slab",
 			   "module",
-			   "cl co di ac io in de sh ss gs se re sp bi br ha uh gp em\n");
+			   "cl co di ac io ur in de sh ss gs se re sp bi br ha uh gp em\n");
 	else
 		proto_seq_printf(seq, list_entry(v, struct proto, node));
 	return 0;
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 2455b0c0e486..8ba02865ae98 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -983,6 +983,7 @@ static const struct proto_ops inet_dccp_ops = {
 	/* FIXME: work on tcp_poll to rename it to inet_csk_poll */
 	.poll		   = dccp_poll,
 	.ioctl		   = inet_ioctl,
+	.uring_cmd	   = sock_common_uring_cmd,
 	.gettstamp	   = sock_gettstamp,
 	/* FIXME: work on inet_listen to rename it to sock_common_listen */
 	.listen		   = inet_dccp_listen,
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 1355e6c0d567..7dc4d399b2ef 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1030,6 +1030,7 @@ const struct proto_ops inet_stream_ops = {
 	.getname	   = inet_getname,
 	.poll		   = tcp_poll,
 	.ioctl		   = inet_ioctl,
+	.uring_cmd	   = sock_common_uring_cmd,
 	.gettstamp	   = sock_gettstamp,
 	.listen		   = inet_listen,
 	.shutdown	   = inet_shutdown,
@@ -1064,6 +1065,7 @@ const struct proto_ops inet_dgram_ops = {
 	.getname	   = inet_getname,
 	.poll		   = udp_poll,
 	.ioctl		   = inet_ioctl,
+	.uring_cmd	   = sock_common_uring_cmd,
 	.gettstamp	   = sock_gettstamp,
 	.listen		   = sock_no_listen,
 	.shutdown	   = inet_shutdown,
@@ -1095,6 +1097,7 @@ static const struct proto_ops inet_sockraw_ops = {
 	.getname	   = inet_getname,
 	.poll		   = datagram_poll,
 	.ioctl		   = inet_ioctl,
+	.uring_cmd	   = sock_common_uring_cmd,
 	.gettstamp	   = sock_gettstamp,
 	.listen		   = sock_no_listen,
 	.shutdown	   = inet_shutdown,
diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index 97ae1255fcb6..9b5a4b3b5acb 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -615,6 +615,7 @@ static const struct proto_ops l2tp_ip_ops = {
 	.getname	   = l2tp_ip_getname,
 	.poll		   = datagram_poll,
 	.ioctl		   = inet_ioctl,
+	.uring_cmd	   = sock_common_uring_cmd,
 	.gettstamp	   = sock_gettstamp,
 	.listen		   = sock_no_listen,
 	.shutdown	   = inet_shutdown,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 76958570ae7f..7f61fb783f50 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3454,6 +3454,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.getname	   = inet_getname,
 	.poll		   = mptcp_poll,
 	.ioctl		   = inet_ioctl,
+	.uring_cmd	   = sock_common_uring_cmd,
 	.gettstamp	   = sock_gettstamp,
 	.listen		   = mptcp_listen,
 	.shutdown	   = inet_shutdown,
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 6f2bbfeec3a4..fdb960e752b3 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1133,6 +1133,7 @@ static const struct proto_ops inet_seqpacket_ops = {
 	.getname	   = inet_getname,	/* Semantics are different.  */
 	.poll		   = sctp_poll,
 	.ioctl		   = inet_ioctl,
+	.uring_cmd	   = sock_common_uring_cmd,
 	.gettstamp	   = sock_gettstamp,
 	.listen		   = sctp_inet_listen,
 	.shutdown	   = inet_shutdown,	/* Looks harmless.  */
diff --git a/net/socket.c b/net/socket.c
index 84a8049c2b09..19ab0986af9d 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -86,6 +86,7 @@
 #include <linux/xattr.h>
 #include <linux/nospec.h>
 #include <linux/indirect_call_wrapper.h>
+#include <linux/io_uring.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -113,6 +114,7 @@ unsigned int sysctl_net_busy_poll __read_mostly;
 static ssize_t sock_read_iter(struct kiocb *iocb, struct iov_iter *to);
 static ssize_t sock_write_iter(struct kiocb *iocb, struct iov_iter *from);
 static int sock_mmap(struct file *file, struct vm_area_struct *vma);
+static int sock_uring_cmd(struct io_uring_cmd *cmd, enum io_uring_cmd_flags issue_flags);
 
 static int sock_close(struct inode *inode, struct file *file);
 static __poll_t sock_poll(struct file *file,
@@ -156,6 +158,7 @@ static const struct file_operations socket_file_ops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = compat_sock_ioctl,
 #endif
+	.uring_cmd =	sock_uring_cmd,
 	.mmap =		sock_mmap,
 	.release =	sock_close,
 	.fasync =	sock_fasync,
@@ -1182,6 +1185,16 @@ static long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	return err;
 }
 
+static int sock_uring_cmd(struct io_uring_cmd *cmd, enum io_uring_cmd_flags issue_flags)
+{
+	struct socket *sock = cmd->file->private_data;
+
+	if (!sock->ops || !sock->ops->uring_cmd)
+		return -EOPNOTSUPP;
+
+	return sock->ops->uring_cmd(sock, cmd, issue_flags);
+}
+
 /**
  *	sock_create_lite - creates a socket
  *	@family: protocol family (AF_INET, ...)
-- 
2.31.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
