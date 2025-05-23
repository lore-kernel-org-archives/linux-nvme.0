Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC4BC54ED1
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 18:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dFwPDfIzlH6tGV/bxIu9QKq8iVcQQ5JJd5NsWTivNLU=; b=28PgNqSVAvwqSxI3u/7POSqB3J
	aJLDXKF4fmTy/r4ohn6KZ7oOdPIfrR+80xxM1CgamlseWH2KTvMRP8GhZVjBP5tf0CFINNfbNF7mR
	WU4VpKBPGloOvDmhMUfJRfuw/Vn8Cz78Wh4EeGBRk02XC3BTcljRBhF38AnDL1bmUL54f2WGtcNOh
	8tcmjjYuTvDq9BKk1GROKB2XHyNQ9XFa5PnPE8779daTxP2gYSHN4dvW0YRcXdGGGac0n3cwEYL3o
	x4P5tnxrsF7G9gp/6WZCZTAfJ8gIuOSOQDW0tOfJEUGuQlq1fRVwrxWiRU35DnwIRG7HOA3vwbXaL
	e2/1+e0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIX4d-00000004g3m-0gMV;
	Fri, 23 May 2025 18:24:51 +0000
Received: from smtp-fw-52003.amazon.com ([52.119.213.152])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIX4a-00000004g1r-1Ild
	for linux-nvme@lists.infradead.org;
	Fri, 23 May 2025 18:24:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1748024688; x=1779560688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dFwPDfIzlH6tGV/bxIu9QKq8iVcQQ5JJd5NsWTivNLU=;
  b=ok1iFqS9b5+Cd6wL+QFFGXwkTtmKn3cOQrrXwR71ackg9rVlZvF6E4Lg
   dr995swBmuUYeJ8PrE6fhIuBfdBn4LdO6zQ1Fg5c3QhkSaAWauJqVqScf
   tFLn/PiBoqNtKo5z24bMbHqGpJsJRuaPpohdY0tnUmEjDfF4krI+th3O3
   UYmLCnlgMk/gO7TMCo18e0Y6GJfkwn08M8aoLHlFIgrUD9dyORuK/CAz6
   hr/fQYxUdFVUu16rIQEOFPhrzfzW6lVe8SAhKc4AsyaumzhS7vw4NftjJ
   FfkzucArBWQ+vtUfCyHEV7um2PMTctoF+0Zl0C4y4qvw0K7FloMt7pbaG
   g==;
X-IronPort-AV: E=Sophos;i="6.15,309,1739836800"; 
   d="scan'208";a="96733226"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 18:24:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:5360]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.185:2525] with esmtp (Farcaster)
 id 0c05805c-7ef1-4828-9116-14573788f047; Fri, 23 May 2025 18:24:45 +0000 (UTC)
X-Farcaster-Flow-ID: 0c05805c-7ef1-4828-9116-14573788f047
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:24:45 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.204.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:24:41 +0000
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
Subject: [PATCH v2 net-next 7/7] socket: Clean up kdoc for sock_create() and sock_create_lite().
Date: Fri, 23 May 2025 11:21:13 -0700
Message-ID: <20250523182128.59346-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523182128.59346-1-kuniyu@amazon.com>
References: <20250523182128.59346-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.142.204.12]
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250523_112448_668925_CC0EB1F6 
X-CRM114-Status: GOOD (  14.65  )
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

__sock_create() is now static and the same doc exists on sock_create()
and sock_create_kern().

Also, __sock_create() says "On failure @res is set to %NULL.", but
this is always false.

In addition, the old style kdoc is a bit corrupted and we can't see the
DESCRIPTION section:

  $ scripts/kernel-doc -man net/socket.c | scripts/split-man.pl /tmp/man
  $ man /tmp/man/sock_create.9

Let's clean them up.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/socket.c | 58 ++++++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 9ad352183fae..e4e9f5cc5d70 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1315,18 +1315,20 @@ static long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 }
 
 /**
- *	sock_create_lite - creates a socket
- *	@family: protocol family (AF_INET, ...)
- *	@type: communication type (SOCK_STREAM, ...)
- *	@protocol: protocol (0, ...)
- *	@res: new socket
+ * sock_create_lite - creates a socket
  *
- *	Creates a new socket and assigns it to @res, passing through LSM.
- *	The new socket initialization is not complete, see kernel_accept().
- *	Returns 0 or an error. On failure @res is set to %NULL.
- *	This function internally uses GFP_KERNEL.
+ * @family: protocol family (AF_INET, ...)
+ * @type: communication type (SOCK_STREAM, ...)
+ * @protocol: protocol (0, ...)
+ * @res: new socket
+ *
+ * Creates a new socket and assigns it to @res, passing through LSM.
+ *
+ * The new socket initialization is not complete, see kernel_accept().
+ *
+ * Context: Process context. This function internally uses GFP_KERNEL.
+ * Return: 0 or an error. On failure @res is set to %NULL.
  */
-
 int sock_create_lite(int family, int type, int protocol, struct socket **res)
 {
 	int err;
@@ -1452,21 +1454,6 @@ int sock_wake_async(struct socket_wq *wq, int how, int band)
 }
 EXPORT_SYMBOL(sock_wake_async);
 
-/**
- *	__sock_create - creates a socket
- *	@net: net namespace
- *	@family: protocol family (AF_INET, ...)
- *	@type: communication type (SOCK_STREAM, ...)
- *	@protocol: protocol (0, ...)
- *	@res: new socket
- *	@kern: boolean for kernel space sockets
- *
- *	Creates a new socket and assigns it to @res, passing through LSM.
- *	Returns 0 or an error. On failure @res is set to %NULL. @kern must
- *	be set to true if the socket resides in kernel space.
- *	This function internally uses GFP_KERNEL.
- */
-
 static int __sock_create(struct net *net, int family, int type, int protocol,
 			 struct socket **res, int kern)
 {
@@ -1583,16 +1570,21 @@ static int __sock_create(struct net *net, int family, int type, int protocol,
 }
 
 /**
- *	sock_create - creates a socket
- *	@family: protocol family (AF_INET, ...)
- *	@type: communication type (SOCK_STREAM, ...)
- *	@protocol: protocol (0, ...)
- *	@res: new socket
+ * sock_create - creates a socket for userspace
+ *
+ * @family: protocol family (AF_INET, ...)
+ * @type: communication type (SOCK_STREAM, ...)
+ * @protocol: protocol (0, ...)
+ * @res: new socket
  *
- *	A wrapper around __sock_create().
- *	Returns 0 or an error. This function internally uses GFP_KERNEL.
+ * Creates a new socket and assigns it to @res, passing through LSM.
+ *
+ * The socket is for userspace and should be exposed via a file
+ * descriptor and BPF hooks (see inet_create(), inet_release(), etc).
+ *
+ * Context: Process context. This function internally uses GFP_KERNEL.
+ * Return: 0 or an error.
  */
-
 int sock_create(int family, int type, int protocol, struct socket **res)
 {
 	return __sock_create(current->nsproxy->net_ns, family, type, protocol, res, 0);
-- 
2.49.0


