Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BD6C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 19:55:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27610207D8
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 19:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s4r/ttuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27610207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xy5bhV7UqSIO2QWujwpgYrOAyiQM6VwxD5Wk5Ue5z7g=; b=s4r/ttuIdRn2HD
	0RJMTzi3JUoK0DSE+DMQ/F7vqR7H2H0pSWPKlObJ/f0h7iJqTdwQfBMWwPaPGQ93cNnQdtk28jyaW
	CpTFpR21LvboVLCReBH0apgFBVzXZMZXoJYbBWLgMAEwOTVRbDjdCz640TeBNKkJc5Tcnjfr6sAnO
	VZCLsg/LA6a7+Len/XqCMyVJ699AZ52a4LniXQauwEbZjQJapui8bg+iqNP7vopGToJjv3c9nwteD
	7ATQofW1KigFoW5T4PQOmL7Oj1N+HaVsWjqtjJdpyc0KjUMMptXtx7Q6yJjQ8nnVsr61gUs0LraeJ
	ruEY6mo3fpSTEjkkELTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbUoQ-0002JD-8i; Wed, 20 May 2020 19:55:34 +0000
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbUo8-0001ss-Fg; Wed, 20 May 2020 19:55:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 02/33] net: remove kernel_getsockopt
Date: Wed, 20 May 2020 21:54:38 +0200
Message-Id: <20200520195509.2215098-3-hch@lst.de>
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

No users left.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/net.h |  2 --
 net/socket.c        | 34 ----------------------------------
 2 files changed, 36 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 6451425e828f5..74ef5d7315f70 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -303,8 +303,6 @@ int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
 		   int flags);
 int kernel_getsockname(struct socket *sock, struct sockaddr *addr);
 int kernel_getpeername(struct socket *sock, struct sockaddr *addr);
-int kernel_getsockopt(struct socket *sock, int level, int optname, char *optval,
-		      int *optlen);
 int kernel_setsockopt(struct socket *sock, int level, int optname, char *optval,
 		      unsigned int optlen);
 int kernel_sendpage(struct socket *sock, struct page *page, int offset,
diff --git a/net/socket.c b/net/socket.c
index 80422fc3c836e..81a98b6cbd087 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3624,40 +3624,6 @@ int kernel_getpeername(struct socket *sock, struct sockaddr *addr)
 }
 EXPORT_SYMBOL(kernel_getpeername);
 
-/**
- *	kernel_getsockopt - get a socket option (kernel space)
- *	@sock: socket
- *	@level: API level (SOL_SOCKET, ...)
- *	@optname: option tag
- *	@optval: option value
- *	@optlen: option length
- *
- *	Assigns the option length to @optlen.
- *	Returns 0 or an error.
- */
-
-int kernel_getsockopt(struct socket *sock, int level, int optname,
-			char *optval, int *optlen)
-{
-	mm_segment_t oldfs = get_fs();
-	char __user *uoptval;
-	int __user *uoptlen;
-	int err;
-
-	uoptval = (char __user __force *) optval;
-	uoptlen = (int __user __force *) optlen;
-
-	set_fs(KERNEL_DS);
-	if (level == SOL_SOCKET)
-		err = sock_getsockopt(sock, level, optname, uoptval, uoptlen);
-	else
-		err = sock->ops->getsockopt(sock, level, optname, uoptval,
-					    uoptlen);
-	set_fs(oldfs);
-	return err;
-}
-EXPORT_SYMBOL(kernel_getsockopt);
-
 /**
  *	kernel_setsockopt - set a socket option (kernel space)
  *	@sock: socket
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
