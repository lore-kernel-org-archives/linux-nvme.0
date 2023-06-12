Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AB6C88CB8
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jun 2023 14:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yK9buUVM0czdcP7/5ZxGguslmta3D7Y6EmCnHL4RSAo=; b=cwUobjCY7Yvrf9nmj99tArGT6T
	nHVsox6gx5czJePbpo0QYXdRIBwV1eHDZfpywnz5+rr7cBBWFprzeyFMuUuDpC57S7gmOtLArnSkS
	bqymMQPU2wUWl+PIohCJD2325M7+t4JcCpUZG0zSq37mNwZKB4cufxTkctWNEyJ+KnLj9ykVPKF1Q
	b3DhfKgmlCmXkZ0ZPx6IY8VMoNN2iS0Jdr22VpXXWNqg7zlbLMWzk3+RSN9RfIa8eZ1MBrkC1pDHJ
	AV/RO9kgtxfUBBrV/gV6/ySURQwMoDcZHu+fP37My1CswVHQfMGK7Y3RIKF3qUWBANzPYZ8tA4GYq
	BMUYl3xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8igx-004KKR-37;
	Mon, 12 Jun 2023 14:38:47 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8igs-004KGL-2T
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jun 2023 14:38:44 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 257AA22786;
	Mon, 12 Jun 2023 14:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686580720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yK9buUVM0czdcP7/5ZxGguslmta3D7Y6EmCnHL4RSAo=;
	b=azwZ1kervQPmbo3MslkMs71wPbhewxxyqXX3rDTqp34nUVvxOeJklG5PANOH7X2XKj1NN/
	CO1eBv/Wi2ODC17jX/y9HEuv8MA6baDNwYTMgtsdxIDPtuFAbKuEeJPby/11ditwbWujDJ
	LfCIQSxC59ImH8EGNXWzEcjq37KILvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686580720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yK9buUVM0czdcP7/5ZxGguslmta3D7Y6EmCnHL4RSAo=;
	b=jBEq+yohQ/Q613JjR2cTlV+R1KCrggRGVF/9WZRrm9wYr7xf8P3huSKrG9pIiOcIG42VRI
	J0qG+/6Ttp0jZiBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id DCF302C142;
	Mon, 12 Jun 2023 14:38:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id C5C9F51C4CB9; Mon, 12 Jun 2023 16:38:39 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/4] net/tls: handle MSG_EOR for tls_sw TX flow
Date: Mon, 12 Jun 2023 16:38:30 +0200
Message-Id: <20230612143833.70805-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230612143833.70805-1-hare@suse.de>
References: <20230612143833.70805-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_073842_991736_A4B5D3AC 
X-CRM114-Status: GOOD (  11.96  )
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

tls_sw_sendmsg() / tls_do_sw_sendpage() already handles
MSG_MORE / MSG_SENDPAGE_NOTLAST, but bails out on MSG_EOR.
But seeing that MSG_EOR is basically the opposite of
MSG_MORE / MSG_SENDPAGE_NOTLAST this patch adds handling
MSG_EOR by treating it as the negation of MSG_MORE.
And erroring out if MSG_EOR is specified with either
MSG_MORE or MSG_SENDPAGE_NOTLAST.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 net/tls/tls_sw.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 635b8bf6b937..16eae0c5c819 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -953,7 +953,10 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	int pending;
 
 	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
-			       MSG_CMSG_COMPAT))
+			       MSG_EOR | MSG_CMSG_COMPAT))
+		return -EOPNOTSUPP;
+
+	if (!eor && msg->msg_flags & MSG_EOR)
 		return -EOPNOTSUPP;
 
 	ret = mutex_lock_interruptible(&tls_ctx->tx_lock);
@@ -1274,11 +1277,15 @@ static int tls_sw_do_sendpage(struct sock *sk, struct page *page,
 int tls_sw_sendpage_locked(struct sock *sk, struct page *page,
 			   int offset, size_t size, int flags)
 {
-	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
+	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_EOR |
 		      MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY |
 		      MSG_NO_SHARED_FRAGS))
 		return -EOPNOTSUPP;
 
+	if ((flags & (MSG_MORE | MSG_SENDPAGE_NOTLAST)) &&
+	    (flags & MSG_EOR))
+		return -EINVAL;
+
 	return tls_sw_do_sendpage(sk, page, offset, size, flags);
 }
 
@@ -1288,10 +1295,14 @@ int tls_sw_sendpage(struct sock *sk, struct page *page,
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	int ret;
 
-	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
+	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_EOR |
 		      MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY))
 		return -EOPNOTSUPP;
 
+	if ((flags & (MSG_MORE | MSG_SENDPAGE_NOTLAST)) &&
+	    (flags & MSG_EOR))
+		return -EOPNOTSUPP;
+
 	ret = mutex_lock_interruptible(&tls_ctx->tx_lock);
 	if (ret)
 		return ret;
-- 
2.35.3


