Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69697C54EDA
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 18:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IVv00rElFcQlgyf5ZIGQk3aMx2dIRPcRXeEVzmqzmBU=; b=bO0FF4iDY2FtKrjWbuXgCSoSSy
	QwVo6uECwHaXuyHJHtforBZ/5Rvzo87RSrd5SBzfXLJl7wBEmwxsqS3osiQk/G7loOtY3ab7lPCp+
	wfxMvr1kclU4KZcX7DZL352o/O9tEHvuWrvPsTU3EbQS81GSv5AQlcNqTRsyjT4bbdswnxNHemIOc
	6h++D1nG45fhe5ZYjx7o7K6PvFwCrCtNjHqO9IIKcHQth0MEk6C6wKZMj4llL7OiCJbWafDBB9BZ8
	s95cy2LOibYMYsXZGwXgj+C2cwyZXrDLd0msSlK1oZc30kKehK+BgR6bLvcZqS5+4rQMAI9Qguc7m
	H2UZ5EMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIX3q-00000004fVL-34av;
	Fri, 23 May 2025 18:24:02 +0000
Received: from smtp-fw-9102.amazon.com ([207.171.184.29])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIX2y-00000004fKj-3qlo
	for linux-nvme@lists.infradead.org;
	Fri, 23 May 2025 18:23:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1748024589; x=1779560589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IVv00rElFcQlgyf5ZIGQk3aMx2dIRPcRXeEVzmqzmBU=;
  b=XAtF7zbJ1xLkwWkInozOTH7+R32+2mw8yrrZQ/KV/fHcJk7Ri3Jd6zi+
   tXVJ0av9jonrW25PD+gfuRfgtxbWNgNOKmHbP8wKo6yHvjOmCu6b8r2FI
   LaoNA1OV44ISq+kuqdLArSQWak0IQRzG/hne5zJeEfx4um7iD4/5UvqBx
   X5Gu36S7F6nU7PCgSsJ7xxub55D4ZlESP8YB+eo58eP3+lhCtxTASYzow
   9c6sQshFuLz3jP8zZoLtdu6ATe/0K+kOVMTJL8YoEM59G8Sb/qcDIxBCA
   X5MgvW7DnsJPwYGiSZ0u1VKbczykNIFgAOqCo3SCly9jlXnzDydyqGv/8
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,309,1739836800"; 
   d="scan'208";a="523766039"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 18:23:02 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:18801]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.213:2525] with esmtp (Farcaster)
 id 363f85c8-889b-4702-93ed-d1b434c006f5; Fri, 23 May 2025 18:23:01 +0000 (UTC)
X-Farcaster-Flow-ID: 363f85c8-889b-4702-93ed-d1b434c006f5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:23:01 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.204.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:22:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
	"Keith Busch" <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher
	<jaka@linux.ibm.com>, Steve French <sfrench@samba.org>,
	<netdev@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<linux-nfs@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>
Subject: [PATCH v2 net-next 3/7] socket: Restore sock_create_kern().
Date: Fri, 23 May 2025 11:21:09 -0700
Message-ID: <20250523182128.59346-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523182128.59346-1-kuniyu@amazon.com>
References: <20250523182128.59346-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.142.204.12]
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250523_112308_997070_DBD8459F 
X-CRM114-Status: GOOD (  16.66  )
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

Let's restore sock_create_kern() that holds a netns reference.

Now, it's the same as the version before commit 26abe14379f8 ("net:
Modify sk_alloc to not reference count the netns of kernel sockets.").

Back then, after creating a socket in init_net, we used sk_change_net()
to drop the netns ref and switch to another netns, but now we can
simply use __sock_create_kern() instead.

  $ git blame -L:sk_change_net include/net/sock.h 26abe14379f8~

DEBUG_NET_WARN_ON_ONCE() is to catch a path calling sock_create_kern()
from __net_init functions, since doing so would leak the netns as
__net_exit functions cannot run until the socket is removed.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2: s/ret/err/ in sock_create_kern() for clarity
---
 include/linux/net.h |  2 ++
 net/socket.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/linux/net.h b/include/linux/net.h
index 12180e00f882..b60e3afab344 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -254,6 +254,8 @@ bool sock_is_registered(int family);
 int sock_create(int family, int type, int proto, struct socket **res);
 int __sock_create_kern(struct net *net, int family, int type, int proto,
 		       struct socket **res);
+int sock_create_kern(struct net *net, int family, int type, int proto,
+		     struct socket **res);
 int sock_create_lite(int family, int type, int proto, struct socket **res);
 struct socket *sock_alloc(void);
 void sock_release(struct socket *sock);
diff --git a/net/socket.c b/net/socket.c
index 7c4474c966c0..9ad352183fae 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1632,6 +1632,48 @@ int __sock_create_kern(struct net *net, int family, int type, int protocol, stru
 }
 EXPORT_SYMBOL(__sock_create_kern);
 
+/**
+ * sock_create_kern - creates a socket for kernel space
+ *
+ * @net: net namespace
+ * @family: protocol family (AF_INET, ...)
+ * @type: communication type (SOCK_STREAM, ...)
+ * @protocol: protocol (0, ...)
+ * @res: new socket
+ *
+ * Creates a new socket and assigns it to @res.
+ *
+ * The socket is for kernel space and should not be exposed to
+ * userspace via a file descriptor nor BPF hooks except for LSM
+ * (see inet_create(), inet_release(), etc).
+ *
+ * The socket bypasses some LSMs that take care of @kern in
+ * security_socket_create() and security_socket_post_create().
+ *
+ * The socket holds a reference count of @net so that the caller
+ * does not need to care about @net's lifetime.
+ *
+ * This MUST NOT be called from the __net_init path and @net MUST
+ * be alive as of calling sock_create_kern().
+ *
+ * Context: Process context. This function internally uses GFP_KERNEL.
+ * Return: 0 or an error.
+ */
+int sock_create_kern(struct net *net, int family, int type, int protocol,
+		     struct socket **res)
+{
+	int err;
+
+	DEBUG_NET_WARN_ON_ONCE(!net_initialized(net));
+
+	err = __sock_create(net, family, type, protocol, res, 1);
+	if (!err)
+		sk_net_refcnt_upgrade((*res)->sk);
+
+	return err;
+}
+EXPORT_SYMBOL(sock_create_kern);
+
 static struct socket *__sys_socket_create(int family, int type, int protocol)
 {
 	struct socket *sock;
-- 
2.49.0


