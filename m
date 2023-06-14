Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC894EB64DB
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jun 2023 06:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T918lJ4pe3lcEkph+FxYYA6LurkHM2prd62WZyXU2AU=; b=FR3p/LLGWhAJLW4XsVrrTZh6Vs
	FjP/MkX7NdbMXOBnw6G4F3IG4DSaJ143k9ObDG1Y4dcnznmYbt3XSPiJ0LGFIlVh+wm1W7SPlvdcP
	qNP0ErKNK8f+DUXXCWaqoVI3cebRwcCDULkhryeTez7g26Ca4h7CUfls5omhb5UfL/XdX3q/zdJb9
	LPejDDHsSv/W2AbJ3IC/kj5dB27SeFH4VzlX5rR8AqLmw33cO0iJ45zOH1jdgoJVei1PX9KGMGS2B
	PHczNHWNaZ6KPSsppm038m8e6LsR0jBlxupBPP1pHM0zaL6NdcLcEZlzcsAa+ZvTGxOcCnMgl7QYQ
	aYPiODrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Jti-00APjO-35;
	Wed, 14 Jun 2023 06:22:26 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Jtf-00APgk-1R
	for linux-nvme@lists.infradead.org;
	Wed, 14 Jun 2023 06:22:24 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 7C4631FDE3;
	Wed, 14 Jun 2023 06:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686723740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T918lJ4pe3lcEkph+FxYYA6LurkHM2prd62WZyXU2AU=;
	b=QfD4PjsCgF76xTyyVv37gUpmF4iqdhlGLd4g8mqmj9XHiONe2f7pDWXz2lzr3oE2U8SSoE
	qUO5QJ8u+RMGdpFT+I5ae4ZUNqVtIcRp4XcpT71SFK2He5H8EiE9pY1EUgUFeUtn70rgxJ
	0n7Aqq8v5Wy+KhNca6L9bfyrgPWr1qY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686723740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T918lJ4pe3lcEkph+FxYYA6LurkHM2prd62WZyXU2AU=;
	b=rmzjnlosgAcExS2zTgLABEXuOPJALQh30nAki4XIgYzxwIzn+tVgU/7njg/jZpxiSwxmDj
	N9iipf0vkW+qxqBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 5E0252C143;
	Wed, 14 Jun 2023 06:22:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 52F9F51C4DDB; Wed, 14 Jun 2023 08:22:20 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/4] net/tls: handle MSG_EOR for tls_device TX flow
Date: Wed, 14 Jun 2023 08:22:10 +0200
Message-Id: <20230614062212.73288-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230614062212.73288-1-hare@suse.de>
References: <20230614062212.73288-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_232223_631764_53676517 
X-CRM114-Status: GOOD (  14.26  )
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
 net/tls/tls_device.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index b4864d55900f..2103d8b7b316 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -440,11 +440,6 @@ static int tls_push_data(struct sock *sk,
 	int copy, rc = 0;
 	long timeo;
 
-	if (flags &
-	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SENDPAGE_NOTLAST |
-	      MSG_SPLICE_PAGES))
-		return -EOPNOTSUPP;
-
 	if (unlikely(sk->sk_err))
 		return -sk->sk_err;
 
@@ -536,6 +531,10 @@ static int tls_push_data(struct sock *sk,
 				more = true;
 				break;
 			}
+			if (flags & MSG_EOR) {
+				more = false;
+				break;
+			}
 
 			done = true;
 		}
@@ -582,6 +581,14 @@ int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	if (!tls_ctx->zerocopy_sendfile)
 		msg->msg_flags &= ~MSG_SPLICE_PAGES;
 
+	if (msg->msg_flags &
+	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SENDPAGE_NOTLAST |
+	      MSG_SPLICE_PAGES | MSG_EOR))
+		return -EOPNOTSUPP;
+
+	if ((msg->msg_flags & (MSG_MORE | MSG_EOR)) == (MSG_MORE | MSG_EOR))
+		return -EOPNOTSUPP;
+
 	mutex_lock(&tls_ctx->tx_lock);
 	lock_sock(sk);
 
@@ -627,9 +634,17 @@ int tls_device_sendpage(struct sock *sk, struct page *page,
 	struct bio_vec bvec;
 	struct msghdr msg = { .msg_flags = flags | MSG_SPLICE_PAGES, };
 
+	if (flags &
+	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SENDPAGE_NOTLAST |
+	      MSG_SPLICE_PAGES | MSG_EOR))
+		return -EOPNOTSUPP;
+
 	if (flags & MSG_SENDPAGE_NOTLAST)
 		msg.msg_flags |= MSG_MORE;
 
+	if ((msg.msg_flags & (MSG_MORE | MSG_EOR)) == (MSG_MORE | MSG_EOR))
+		return -EINVAL;
+
 	if (flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
-- 
2.35.3


