Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E920C7EE2E
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jun 2023 14:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f9oYVc4XO+eOnTquQ7Q2MUiLwi75qroXHuCY9Y83BfA=; b=rHvL4FMj/RZSKEcgfHRmz9ZC3Q
	YT+hYMRPbj5LFMTB6lAp/YrpoL6GlyiYGobJCgJAtNpHriTAMTsIcrPPumAa/xWDskRw4v66n+Ibk
	l0SEk9nMhc+uSV8HTqcrDceKMKdk8N1+vDjPQTP8qhpSg1EEbq8/eRKerANP5eVY6rxo8I2HwYvXy
	5Coai8k+RpznuVL3AA8o5N/R0j57EtJgLftvo2geBkClSG9hvPh2FoGekiWTLLICDLBe3fXRjdi+X
	5oBu3sJTBN1uu8HebiazzCivgkd+D+NQ3RRFD2l1Dhami1YqjODGf+NLxqRNlgV8WzLNTiAJ9YtCs
	dqi94vyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8igu-004KIT-0U;
	Mon, 12 Jun 2023 14:38:44 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8igr-004KGQ-2P
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jun 2023 14:38:43 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 2440E2030A;
	Mon, 12 Jun 2023 14:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686580720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9oYVc4XO+eOnTquQ7Q2MUiLwi75qroXHuCY9Y83BfA=;
	b=rutazyaLNhOfHyOcKhk9Ze3T2wVwjQRHCADiNZujxdnQGPEUdkr29e5XKhxi9MgJYG4lMz
	ft4aZ2b4x8FK12R4GRP41lHaqk+4ZwOkuY32CQ8gh3xlSTFpbAk9Mg1JecAGKsXeGetnDA
	1seCLGBCSMXt6eucha0pCt5U9lgd/Xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686580720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9oYVc4XO+eOnTquQ7Q2MUiLwi75qroXHuCY9Y83BfA=;
	b=i7otktR21DVakGrIk9OMaOlziTbzmf4ByzvkUGuR57TG+6gjAMCZkcYu4pvdXpEiR20F2W
	3Xl1/KXwvdvFzUBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id DCDF02C141;
	Mon, 12 Jun 2023 14:38:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id CE47951C4CBB; Mon, 12 Jun 2023 16:38:39 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/4] net/tls: handle MSG_EOR for tls_device TX flow
Date: Mon, 12 Jun 2023 16:38:31 +0200
Message-Id: <20230612143833.70805-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230612143833.70805-1-hare@suse.de>
References: <20230612143833.70805-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_073841_930967_C0285807 
X-CRM114-Status: GOOD (  13.28  )
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

tls_push_data() MSG_MORE / MSG_SENDPAGE_NOTLAST, but bails
out on MSG_EOR.
But seeing that MSG_EOR is basically the opposite of
MSG_MORE / MSG_SENDPAGE_NOTLAST this patch adds handling
MSG_EOR by treating it as the absence of MSG_MORE.
Consequently we should return an error when both are set.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 net/tls/tls_device.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index a7cc4f9faac2..0024febd40de 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -448,10 +448,6 @@ static int tls_push_data(struct sock *sk,
 	int copy, rc = 0;
 	long timeo;
 
-	if (flags &
-	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SENDPAGE_NOTLAST))
-		return -EOPNOTSUPP;
-
 	if (unlikely(sk->sk_err))
 		return -sk->sk_err;
 
@@ -529,6 +525,10 @@ static int tls_push_data(struct sock *sk,
 				more = true;
 				break;
 			}
+			if (flags & MSG_EOR) {
+				more = false;
+				break;
+			}
 
 			done = true;
 		}
@@ -573,6 +573,14 @@ int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	union tls_iter_offset iter;
 	int rc;
 
+	if (msg->msg_flags &
+	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_EOR))
+		return -EOPNOTSUPP;
+
+	if ((msg->msg_flags & MSG_MORE) &&
+	    (msg->msg_flags & MSG_EOR))
+		return -EOPNOTSUPP;
+
 	mutex_lock(&tls_ctx->tx_lock);
 	lock_sock(sk);
 
@@ -601,9 +609,17 @@ int tls_device_sendpage(struct sock *sk, struct page *page,
 	struct kvec iov;
 	int rc;
 
+	if (flags &
+	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SENDPAGE_NOTLAST | MSG_EOR))
+		return -EOPNOTSUPP;
+
 	if (flags & MSG_SENDPAGE_NOTLAST)
 		flags |= MSG_MORE;
 
+	if ((flags & MSG_MORE) &&
+	    (flags & MSG_EOR))
+		return -EOPNOTSUPP;
+
 	mutex_lock(&tls_ctx->tx_lock);
 	lock_sock(sk);
 
-- 
2.35.3


