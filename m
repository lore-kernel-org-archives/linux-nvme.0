Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD6AC77B70
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 13:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5U2ei33Qqrqwo8D3zBww5MKZ3KjDzaLWsClwJZg22Ms=; b=LPYFntA/NZqJGPlW5HrnmvM/eM
	tvSCBLUnT5XRJLt5te5v8SZNwHYZ/F5biTW/JSHLefPN7ryofIpELZo34JA4wbjNB4TKYUfF4X9X1
	Wp3wYN/2Us960p6mz1Lv9YZVUWWbRP7upPd3UneDqO8VYljjr1WcAHuSGP4GPY8fH3aJJmE0o9dI4
	50hH0njgYKzY4jji+gkU35cE0/xnFaJswq3HCOQ6/p5BhRNNqEFcaECBllKfpdw2xh+767ppaIEli
	bYL9xy0EQM/3dcnuNFVOtyrMncJzeF4H/li44P7e53Ik8F0VDrvDnUl9KrMOGGszDHenlL2gHZgmx
	Qct+STCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poOVy-00GI4w-05;
	Mon, 17 Apr 2023 13:03:26 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poOVi-00GHpp-0N
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 13:03:18 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 332AC1FE0E;
	Mon, 17 Apr 2023 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681736584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5U2ei33Qqrqwo8D3zBww5MKZ3KjDzaLWsClwJZg22Ms=;
	b=TNicPOUqGNpATAvYd7LF5w7Gcc2rSCmQ2IHKJzHjwHhhdlDDkWn4Z6xNCOEhir2nNaVUJQ
	tiGn4zCDiS8LWucegQeYIEBzI8qMBYe0K/Q+xZePwqkzy5bgyRAnXglU+EnoBPiu6WYpr+
	h79DZAX1WfLj+sw38yrO3oz3eit/B+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681736584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5U2ei33Qqrqwo8D3zBww5MKZ3KjDzaLWsClwJZg22Ms=;
	b=93XlQbelW1T+kXo2DEnYMG7+bvfdT6j+5zRpFi0OTCqwud/dl59AwAATPEYJXFUnoKCfHd
	P/Ywhv5JWf6tADCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 20BF42C14F;
	Mon, 17 Apr 2023 13:03:04 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 192FA51C25A8; Mon, 17 Apr 2023 15:03:04 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/18] net/tls: sanitize MSG_EOR handling
Date: Mon, 17 Apr 2023 15:02:51 +0200
Message-Id: <20230417130302.86274-8-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230417130302.86274-1-hare@suse.de>
References: <20230417130302.86274-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_060310_323359_A5C69676 
X-CRM114-Status: GOOD (  13.96  )
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

The TLS stack is using MSG_EOR internally, so the flag cannot be
set for sendmsg()/sendpage(). But to avoid having the caller to
check whether TLS is active modify the code to clear the MSG_EOR
flag. And blank out MSG_MORE / MSG_SENDPAGE_NOTLAST, too, as they
conflict with MSG_EOR anyway.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 net/tls/tls_device.c | 10 ++++++++++
 net/tls/tls_sw.c     | 21 +++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index a7cc4f9faac2..38e44e216865 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -576,6 +576,10 @@ int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	mutex_lock(&tls_ctx->tx_lock);
 	lock_sock(sk);
 
+	/* MSG_EOR conflicts with MSG_MORE, so clear both */
+	if (msg->msg_flags & MSG_EOR)
+		msg->msg_flags &= ~(MSG_EOR | MSG_MORE);
+
 	if (unlikely(msg->msg_controllen)) {
 		rc = tls_process_cmsg(sk, msg, &record_type);
 		if (rc)
@@ -604,6 +608,12 @@ int tls_device_sendpage(struct sock *sk, struct page *page,
 	if (flags & MSG_SENDPAGE_NOTLAST)
 		flags |= MSG_MORE;
 
+	/*
+	 * MSG_EOR conflicts with MSG_MORE/MSG_SENDPAGE_NOTLAST,
+	 * so clear all of them */
+	if (flags & MSG_EOR)
+		flags &= ~(MSG_EOR | MSG_SENDPAGE_NOTLAST | MSG_MORE);
+
 	mutex_lock(&tls_ctx->tx_lock);
 	lock_sock(sk);
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 827292e29f99..d0e6b7a04176 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -952,6 +952,11 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	int ret = 0;
 	int pending;
 
+	if (msg->msg_flags & MSG_EOR) {
+		eor = true;
+		/* MSG_EOR conflicts with MSG_MORE, so clear both */
+		msg->msg_flags &= ~(MSG_EOR | MSG_MORE);
+	}
 	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
 			       MSG_CMSG_COMPAT))
 		return -EOPNOTSUPP;
@@ -1274,6 +1279,14 @@ static int tls_sw_do_sendpage(struct sock *sk, struct page *page,
 int tls_sw_sendpage_locked(struct sock *sk, struct page *page,
 			   int offset, size_t size, int flags)
 {
+	/*
+	 * MSG_EOR is invalid for TLS, and conflicts
+	 * with MSG_MORE / MSG_SENDPAGE_NOTLAST.
+	 * So clear all of them.
+	 */
+	if (flags & MSG_EOR)
+		flags &= ~(MSG_MORE | MSG_SENDPAGE_NOTLAST | MSG_EOR);
+
 	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
 		      MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY |
 		      MSG_NO_SHARED_FRAGS))
@@ -1288,6 +1301,14 @@ int tls_sw_sendpage(struct sock *sk, struct page *page,
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	int ret;
 
+	/*
+	 * MSG_EOR is invalid for TLS, and conflicts
+	 * with MSG_MORE / MSG_SENDPAGE_NOTLAST.
+	 * So clear all of them.
+	 */
+	if (flags & MSG_EOR)
+		flags &= ~(MSG_MORE | MSG_SENDPAGE_NOTLAST | MSG_EOR);
+
 	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
 		      MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY))
 		return -EOPNOTSUPP;
-- 
2.35.3


