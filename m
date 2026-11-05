Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F707606EEBD
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ANlD43LN;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXG4R/+J
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=uHeW0L5fyg8Btj14m4d28bKJ0EVxCTJiTa5I2SS1ptY=; b=ANlD43LNXGq+yi
	aQ4rc0fIdDes/o4OI14F1FWjPNDd182dtdAcICSHuPFNjvqKi4f6fW8YuYqKpQczqsBDho9kUVbUq
	rmKfPtVN8gqVvB98cy0uQjf9teBCWKbrKkSgjMoXY8KFx19fBYxPr0Y/Ulz7Y/LdN8gwodF+ItGee
	ifYyIa4sRvUYZf7dL6fEkGwsDlWK1sDPBaeevsXCnIVwr6fKmehqN2L39m+qfZHipsRoC17qmNV0J
	RwRDPCbHLLSTy1Qrh/adx3tUImkgCWhEQgtqpgGng8RjxpZdijJrJux7tkRuwEAzCbvjq59mu78m6
	y9BMtES6LHbl3NhuWalA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0MT-00000009c95-3sG1;
	Thu, 05 Nov 2026 16:30:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0ML-00000009c5c-2w1Y
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 16:30:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6FAA443DB6;
	Thu,  5 Nov 2026 16:30:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793896241;
	b=KoLUwHmMTCF1R/Douvc9ZEF51HUHREaOuTLskhy3D6/p0pnAamAAp/GX/txyL/B1Z3py
	 cEx6+ftIDiHZR/4inn5252U8+EquEPdTsQZnavzMeq3Nmt/rNZxtudOIgHkv2y1Jp7RP9
	 Wlf5Dt5GZwTjJmlTRm8PRL7WPxzIYq0s8xRrWZdvtD7OH4BFZuKXpEFKA3R+NxA17BkjB
	 Tr8RYWyvisH9t8MVNbKe/RxgNhgbxRKsbMk1J7kpVxNSPABnhmu7a4iKTxHjYmtdTNQqu
	 MRlvyaguB4/PrjBfJ2WH5GE2t9ZM9TKHZe2SzyG13dO94aaM+cJGlumQInHozNUXW4Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793896241;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=uHeW0L5fyg8Btj14m4d28bKJ0EVxCTJiTa5I2SS1ptY=;
	b=O9HM2O3wuQ5Zed2zWm3mzwQMSDth6Eo9Bhobyca6Nmm83EixU7tu/kZY+5drYRqvegKA
	 sbaidaQsxdLcoYcqT+7ASvmhxk7gGejq0JHHLKOUZLZTaj2Bs0Sf7RC7aeo++yfXJEe5v
	 /eIwQD49UmP0p55fXBACL8MCVCgdccZZV6rkDfso1pzNg2FYqkf9U75j8n+m3BW7tbQIo
	 /Sli7Sm3eOfmZB52gP5GNegjlHn95pxJ/Pm7fyhpONnG5pK+w8YoeIoTMkoLMKbt2/2sA
	 30mdOdGcZep+ZdTPPvtMApR0RIpiXH/mcVPadRRgYFdRn+ftfHgWupcqd6Y45jrazPw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0532F1F00A02;
	Thu,  5 Nov 2026 16:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896241;
	bh=uHeW0L5fyg8Btj14m4d28bKJ0EVxCTJiTa5I2SS1ptY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bXG4R/+JqmAjTVr6r4iG+IpBmjAj7c/3gdabgTv7223FXmMCuvm/jx2V3q/lqRhcA
	 wyT80NDFw2A65hGn1kXOwiJ3SxqWQLMABp60S+sHchKw+lKJ+gr+mUy6TdKjgD4Xe6
	 IDGKFBBMRpcDLZqjQeJDf7AKzsUtX0NZSLH/lektl27MHcwq+F5CaZdvmRDBVysKOg
	 dDAGwAt+vmg/lDuGCuxpZJVCXbg2uHaCfnIYWdz9H/sbze2BY18hl5003PRlGS8kuX
	 yYDTUDNPTpzr6ZZ9esOVU6UX4QDd79YhJCyFcWyQ0MGnHZmuAXa98ID5WI2eBjom36
	 0z+b7u+FQFLVg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 88CFF47328;
	Thu,  5 Nov 2026 16:30:39 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Thu, 05 Nov 2026 11:30:39 -0500
Subject: [PATCH net-next v6 3/6] tls: loop in tls_sw_splice_read() until it
 has a record
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-keyupdate-rfc-v6-3-99b695f9eb4f@gmail.com>
References: <20261105-keyupdate-rfc-v6-0-99b695f9eb4f@gmail.com>
In-Reply-To: <20261105-keyupdate-rfc-v6-0-99b695f9eb4f@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>, Chuck Lever <cel@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Martin Belanger <martin.nvme.dev@gmail.com>, 
 Martin Belanger <martin.belanger@dell.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793896238; l=1113;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=4C9Djt7aw5YpZqtOVbGgX+iA/6jCePYUHtfq0NJMnQc=;
 b=PUpT2o6XdjPzvShA6vVJWrZJeFssowmSFYNxIaJU+36VTv3EDdUhyKVVAOwGi2GHxA9geOAOb
 1Q5+oi1I8AaAMbR7m67cNCDQkXhNk5BAcAOSP9ddLnk7QFgx0XlRKnP
X-Developer-Key: i=martin.nvme.dev@gmail.com; a=ed25519;
 pk=4K+XXetGK35w2LzRRddd/bbHawZU222BN+YZRuSpN+k=
X-Endpoint-Received: by B4 Relay for martin.nvme.dev@gmail.com/20261014
 with auth_id=1176
X-Original-From: Martin Belanger <martin.nvme.dev@gmail.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: martin.nvme.dev@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Martin Belanger <martin.belanger@dell.com>

tls_sw_splice_read() passes one record to the pipe. It takes the
record from rx_list or decrypts the next record from the socket.

The next patch lets the kernel consume a KeyUpdate record. splice()
then has no record to pass on and must decrypt the next one. Make the
decrypt step a loop that runs until splice() has a record.

No functional change: the loop sets skb on its first pass.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 net/tls/tls_sw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 771e02bff519..7f7a2f70b02a 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2023,9 +2023,8 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	if (err)
 		goto splice_read_end;
 
-	if (!skb_queue_empty(&ctx->rx_list)) {
-		skb = __skb_dequeue(&ctx->rx_list);
-	} else {
+	skb = __skb_dequeue(&ctx->rx_list);
+	while (!skb) {
 		struct tls_decrypt_arg darg;
 
 		err = tls_rx_rec_wait(sk, nonblock, true, false);

-- 
2.53.0



