Return-Path: <SRS0=0R6w=7K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22909C433E2
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 05:16:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B06A120721
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 05:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kySWqXFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06A120721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jw5l49WwO1jLGK6sv6rQ/JQxYBgTaM6mSYN7MhllhcM=; b=kySWqXFmeWKYQD
	jyi6MXas+mjYJaA055u2n5oTYkXH6E8fxe36Low2Pn1odK5VOqiPLiaKZrNMd1vRuPEuC4XxrgqSt
	WNEVtYRzJZ/ndu3o+mmzEen2/t2zD31L1hyYzytbYa0LXYA9H+cGrkjrTUCUvptYohjZnUN622zQw
	EI9rHVm60arG1fr3R2ZRDeHKGQHaO2oojuYO5zIY6LVQBTAgWVLjbM5o6dUzfc7nd9ijyHWjuO10k
	IJU/5eohKdSZe9os7GIUUD2jUhA2uX84KYDdqUKzDqGY/5soh0v0fE4c7nO3Sea0NSJlbaZVGrlwa
	sWflXKCe+yhAkOXBxxeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeAto-0006fG-Ph; Thu, 28 May 2020 05:16:12 +0000
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1jeAr5-0001za-Kz; Thu, 28 May 2020 05:13:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 13/28] tcp: add tcp_sock_set_syncnt
Date: Thu, 28 May 2020 07:12:21 +0200
Message-Id: <20200528051236.620353-14-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528051236.620353-1-hch@lst.de>
References: <20200528051236.620353-1-hch@lst.de>
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
Cc: linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
 cluster-devel@redhat.com, Sagi Grimberg <sagi@grimberg.me>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jon Maloy <jmaloy@redhat.com>, linux-rdma@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 Ying Xue <ying.xue@windriver.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
 ocfs2-devel@oss.oracle.com, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a helper to directly set the TCP_SYNCNT sockopt from kernel space
without going through a fake uaccess.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c |  9 +--------
 include/linux/tcp.h     |  1 +
 net/ipv4/tcp.c          | 12 ++++++++++++
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4e4a750ecdb97..2872584f52f63 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1336,14 +1336,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	}
 
 	/* Single syn retry */
-	opt = 1;
-	ret = kernel_setsockopt(queue->sock, IPPROTO_TCP, TCP_SYNCNT,
-			(char *)&opt, sizeof(opt));
-	if (ret) {
-		dev_err(nctrl->device,
-			"failed to set TCP_SYNCNT sock opt %d\n", ret);
-		goto err_sock;
-	}
+	tcp_sock_set_syncnt(queue->sock->sk, 1);
 
 	/* Set TCP no delay */
 	tcp_sock_set_nodelay(queue->sock->sk);
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 2eaf8320b9db0..6aa4ae5ebf3d5 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -500,5 +500,6 @@ int tcp_skb_shift(struct sk_buff *to, struct sk_buff *from, int pcount,
 void tcp_sock_set_cork(struct sock *sk, bool on);
 void tcp_sock_set_nodelay(struct sock *sk);
 void tcp_sock_set_quickack(struct sock *sk, int val);
+int tcp_sock_set_syncnt(struct sock *sk, int val);
 
 #endif	/* _LINUX_TCP_H */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 27b5e7a4e2ef9..d2c67ae1da07a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2881,6 +2881,18 @@ void tcp_sock_set_quickack(struct sock *sk, int val)
 }
 EXPORT_SYMBOL(tcp_sock_set_quickack);
 
+int tcp_sock_set_syncnt(struct sock *sk, int val)
+{
+	if (val < 1 || val > MAX_TCP_SYNCNT)
+		return -EINVAL;
+
+	lock_sock(sk);
+	inet_csk(sk)->icsk_syn_retries = val;
+	release_sock(sk);
+	return 0;
+}
+EXPORT_SYMBOL(tcp_sock_set_syncnt);
+
 /*
  *	Socket option code for TCP.
  */
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
