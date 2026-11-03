Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC9160A2616
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JtYsTzFp;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bz//JEQ5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=e1CCK7unGIRtnCbMWuI23FUplQt/eU5eAAIgHQYDe50=; b=JtYsTzFpS7F0W8
	qhuLWnu3Y+E+xFkuc44Pcd9foA76/hfYPJ06GtAlMnLFbjPd2JCnNmwS+S1XeJhDgbk4l1OKAnNmx
	DXdxzlm1cowSuJI7heJRzcMu9aOjX2dL5OlYvOesSr8BjS1TK10DL4iAeIFfLojFEyzlQ+3ijnrNB
	ViQygdWCPRDWXxdVtjx1rZ8M3fEgCIrzXlNGHQl5aqQUAwbd3EI2IXqKbDY9w0MpOmo0x/PVHTvKM
	UiszVb4Y/F8Nv39dF8ooI1mPU2+fen8CmGkjG40cCarkQb3kpdkUCBO+8lbqQKxqxEQAhOuTPh4rG
	LUOEe7s021nCALIzHjrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOMHz-00000003kup-0XEb;
	Tue, 03 Nov 2026 21:43:31 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOMHy-00000003ku6-0TgA
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 21:43:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D90E842E3B;
	Tue,  3 Nov 2026 21:43:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793742209;
	b=f9ysyGqqPgCRyRGsb+UQLWnVToOu23wi0zMM1xOucsFD+crI0w5krDVf9Ip3BayyCiBs
	 ajGnftj65P4TVAO7eW6l1N1+YLEf6pLCtfC3H6eNU9e6g6RMyA10XN9C3whiS9iVrxhMQ
	 MWYnxpp2GyJpMzQqYJn9xVAiT9MZMKtpfNq6fly0LYco7Ci58XqroZC42zu1+ryRw0LKC
	 Y8eexyKsQINisQLKx7Nw6pF9TJsvJjOGkcY5ss2HJt3j572Njg+E2FAAWv/tiiW1U1Tg+
	 blwmNmOUdvHI75HXfRpEkHuBme4omQ8WJ3TfJJdXWgsURjLuwM2bp6tEFYlJJBaGMMw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793742209;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=e1CCK7unGIRtnCbMWuI23FUplQt/eU5eAAIgHQYDe50=;
	b=YT366nc4NIXbcoj8JE0ieUsnNX4QtJtEP+SiZwaTjEcDA++X/dqBkng638AUtDW9I+EN
	 mDSMRuY5eH/y1uVu0WKA7wBY9NsUlxzbQ1/b9S/qbb0jHiFUspOt8qYSq5FDV9/dJQPwO
	 OHRqXJtHw28wTYopwLckEWTqHUhRBXfR3XDG2COXBRskjualBL5W092rLdtpglVt7OPcy
	 tW2Q9kJYyi49U7CkEPJizRmZoHdSejbHtZekpgVK+DFQxWYeG0KE+V9WvQLasMHDbxNBR
	 1JsvV2Kr3CwFVhvxXLq2RTW3yx+mLi678gXlM3IEwgD9wVuTjMRYth4yIMtzJVntR8w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E51ED1F00A25;
	Tue,  3 Nov 2026 21:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793742209;
	bh=e1CCK7unGIRtnCbMWuI23FUplQt/eU5eAAIgHQYDe50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bz//JEQ5jdwJ3PmBFA9l3N8jSFuD3kkdN7fiYHhuXztVGAvwLyCEPs/NrMIJYA1qU
	 sHI68tBszshC7RqpKyDj7uTX0UA6KpH9IPTAuMhn9EZUfg+sqB9UyqxIp+FKI+fkS9
	 jTU14KktvsCV1Ug0DG/gL6Pbkm9kxHE4ZwIiTPIscGsFn0VX25jQQeLz7i9Xt92yvp
	 OYKGkz1KJIFarl1hEu5lFvkJ/FpOVjOQIBb1QQpVyO0EMDhqqQibmhX7UYso0iBEeU
	 VOwLhgvIFlrZx2aRhbO3g0AjxB9D2OBv8Qmd07e8p+ABB179Z/sViy35dkFpK9o+vO
	 UN9hMTMzzvY6A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7718A46B4B;
	Tue,  3 Nov 2026 21:43:27 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Tue, 03 Nov 2026 16:43:27 -0500
Subject: [PATCH net-next v5 3/6] tls: loop in tls_sw_splice_read() until it
 has a record
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-keyupdate-rfc-v5-3-de1ab90a88d5@gmail.com>
References: <20261103-keyupdate-rfc-v5-0-de1ab90a88d5@gmail.com>
In-Reply-To: <20261103-keyupdate-rfc-v5-0-de1ab90a88d5@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793742206; l=1065;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=/WbOdXhJxwSkTgLlxCEfzCgk2vhZiq7sYxpEON0IUc8=;
 b=R9ZTOPQ1hNkNwqFmlciP3K0RbgwKbdFE1QYYA+v+aZEbFEWhm8e4ddCo+R8AhU1/5jpU78hro
 /ar8y6IeKiBBXKdX0PTjmeHkb/Eapyx/qaQJHjqpxTcYHn/GDPVavGe
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



