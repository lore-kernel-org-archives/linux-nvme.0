Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78165EB64DD
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jul 2023 14:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9BruMRtCv5J+FKRrWpnRAAWmie13BS9ZHyzpdN0Mwhk=; b=mcNd7QLQRz5f4AJ+stTi85qzeB
	9TOC9L690HVi8JW+APqQBn1U1f2MVtU1WQqH94cOrkDPCVMujKCm1TBBVsX6N/9AmOGZdVvFCPU7u
	bXsogVc8mvjoglWpksWxY+XjyIaRquChuOEtX4THqxt024zkK9JVAQ8FSmdyWY7yQhwe3R4DQMNtW
	i6XhYdmm2T4oqWnt612mwLMw4yvYDNU7fcLsfyLi8w+Zkwt8gIOrC0ZtijCGGquFfU5NeIkacXRiC
	VlbzHk08H45O0JEpgPRpKupEXiXbKatxTIr2J+UCCzZMANd5lWzQxWIWmiZSd5njCGf2qlmYW05rl
	jc48A//g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMrEM-00EIVG-1i;
	Fri, 21 Jul 2023 14:35:42 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMrEI-00EISs-1s
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jul 2023 14:35:40 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 70590218DF;
	Fri, 21 Jul 2023 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689950136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9BruMRtCv5J+FKRrWpnRAAWmie13BS9ZHyzpdN0Mwhk=;
	b=sGFTpmlh6LmyBTxPGHwPitdk4uu+UMczXCNXFma4H/OWa24shKD1yXwqdCtNKEui/jWXte
	37/PYUI5udZcWsCSh03kLqrUa0wqmxv+C0DitopGu3yKfemw5Ot3bObCWZix6nbwpT/oKX
	8eDSZZN8MhXs273+PHebTI43QWBmLEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689950136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9BruMRtCv5J+FKRrWpnRAAWmie13BS9ZHyzpdN0Mwhk=;
	b=Auy5KrG/RycMaiI0OxVa5zLZfeljaZdyLKdFcjeKd+M5GHO4CtnK1DNqalEsySmMFaNV4C
	c7lueYAtDG19zyDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 597C32C14E;
	Fri, 21 Jul 2023 14:35:36 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 454DA51CA024; Fri, 21 Jul 2023 16:35:36 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 5/6] net/tls: split tls_rx_reader_lock
Date: Fri, 21 Jul 2023 16:35:22 +0200
Message-Id: <20230721143523.56906-6-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230721143523.56906-1-hare@suse.de>
References: <20230721143523.56906-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230721_073538_809292_3DA32076 
X-CRM114-Status: GOOD (  12.69  )
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

Split tls_rx_reader_{lock,unlock} into an 'acquire/release' and
the actual locking part.
With that we can use the tls_rx_reader_lock in situations where
the socket is already locked.

Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 net/tls/tls_sw.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9aef45e870a5..d0636ea13009 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1848,13 +1848,10 @@ tls_read_flush_backlog(struct sock *sk, struct tls_prot_info *prot,
 	return sk_flush_backlog(sk);
 }
 
-static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx *ctx,
-			      bool nonblock)
+static int tls_rx_reader_acquire(struct sock *sk, struct tls_sw_context_rx *ctx,
+				 bool nonblock)
 {
 	long timeo;
-	int err;
-
-	lock_sock(sk);
 
 	timeo = sock_rcvtimeo(sk, nonblock);
 
@@ -1868,26 +1865,30 @@ static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx *ctx,
 			      !READ_ONCE(ctx->reader_present), &wait);
 		remove_wait_queue(&ctx->wq, &wait);
 
-		if (timeo <= 0) {
-			err = -EAGAIN;
-			goto err_unlock;
-		}
-		if (signal_pending(current)) {
-			err = sock_intr_errno(timeo);
-			goto err_unlock;
-		}
+		if (timeo <= 0)
+			return -EAGAIN;
+		if (signal_pending(current))
+			return sock_intr_errno(timeo);
 	}
 
 	WRITE_ONCE(ctx->reader_present, 1);
 
 	return 0;
+}
 
-err_unlock:
-	release_sock(sk);
+static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx *ctx,
+			      bool nonblock)
+{
+	int err;
+
+	lock_sock(sk);
+	err = tls_rx_reader_acquire(sk, ctx, nonblock);
+	if (err)
+		release_sock(sk);
 	return err;
 }
 
-static void tls_rx_reader_unlock(struct sock *sk, struct tls_sw_context_rx *ctx)
+static void tls_rx_reader_release(struct sock *sk, struct tls_sw_context_rx *ctx)
 {
 	if (unlikely(ctx->reader_contended)) {
 		if (wq_has_sleeper(&ctx->wq))
@@ -1899,6 +1900,11 @@ static void tls_rx_reader_unlock(struct sock *sk, struct tls_sw_context_rx *ctx)
 	}
 
 	WRITE_ONCE(ctx->reader_present, 0);
+}
+
+static void tls_rx_reader_unlock(struct sock *sk, struct tls_sw_context_rx *ctx)
+{
+	tls_rx_reader_release(sk, ctx);
 	release_sock(sk);
 }
 
-- 
2.35.3


