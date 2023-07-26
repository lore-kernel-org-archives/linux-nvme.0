Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD55AC001DF
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 19:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tETkjaWgXVuTvk58wCoIZ9udC/W2IHj1ashGLgXQA1w=; b=LrBEhwbVCViIJE9XT7Xhn0movc
	jzyv1/DExU4YU8c3S5Q0t7ERgaqyiz/0955CO2XFCtpF/OC6sYrHKjx40HSD01TWK8b1/5bpTQOZf
	PtHn3PyFRASArJz9dIMS6D0pL2fKOk+Hv2eOqe2CnxPYTh1SfT2Dx3p3ltpf+q2l46at33PClnl3s
	PDEB9o7c/ZeKYcKWp8Coxce/jKNCgRDMNHXnw0bAA8AKc2YIcoUZWdSVO8TWhNmHOUihKiZgWfAhf
	S2ErZQN71GpXvI3EudE018nbPC7QrHROOiKb9hiuD56UJzbc7vvsfpwSFyfBcp+E8n3uhbMdFKiak
	UM+43gLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOjzZ-00BM9Z-3D;
	Wed, 26 Jul 2023 19:16:14 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOjzW-00BM6q-34
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 19:16:12 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 203621F74A;
	Wed, 26 Jul 2023 19:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690398967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tETkjaWgXVuTvk58wCoIZ9udC/W2IHj1ashGLgXQA1w=;
	b=NsuZHpGCRv0tFPuKLuTNtvMvxtJfgst/H9Cp74aFnN+gAe3qp6c32eixAcLKNltPpWNAlU
	/4+8hfpKm7r46y4QIHFG7ezj2NiADnu5WkMh2x3NL9SJf2+bwcwTOsuw18fa5L7IFZZeLK
	PaAgA+/B9iMgqbiQFf16WsJNlakihL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690398967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tETkjaWgXVuTvk58wCoIZ9udC/W2IHj1ashGLgXQA1w=;
	b=rfOMgD/7HSTT4iVwZ8ynNq8OQ6UdYjVVgFoTsoT6tVnMGL/vgan+AuwTm+KzLZ01FQVO+o
	JnPK7z33VYt42fBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 425D52C149;
	Wed, 26 Jul 2023 19:16:06 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 2D52651CA335; Wed, 26 Jul 2023 21:16:06 +0200 (CEST)
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
Subject: [PATCH 4/6] net/tls: Use tcp_read_sock() instead of ops->read_sock()
Date: Wed, 26 Jul 2023 21:15:54 +0200
Message-Id: <20230726191556.41714-5-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230726191556.41714-1-hare@suse.de>
References: <20230726191556.41714-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_121611_189682_CE00F4BC 
X-CRM114-Status: GOOD (  12.76  )
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

TLS resets the protocol operations, so the read_sock() callback might
be changed, too.
In this case using sock->ops->readsock() in tls_strp_read_copyin() will
enter an infinite recursion if the read_sock() callback is calling
tls_rx_rec_wait() which will call into sock->ops->readsock() via
tls_strp_read_copyin().
But as tls_strp_read_copyin() is supposed to produce data from the
consumed socket and that socket is always a TCP socket we can call
tcp_read_sock() directly without having to deal with callbacks.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 net/tls/tls_strp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index f37f4a0fcd3c..ca1e0e198ceb 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -369,7 +369,6 @@ static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
 
 static int tls_strp_read_copyin(struct tls_strparser *strp)
 {
-	struct socket *sock = strp->sk->sk_socket;
 	read_descriptor_t desc;
 
 	desc.arg.data = strp;
@@ -377,7 +376,7 @@ static int tls_strp_read_copyin(struct tls_strparser *strp)
 	desc.count = 1; /* give more than one skb per call */
 
 	/* sk should be locked here, so okay to do read_sock */
-	sock->ops->read_sock(strp->sk, &desc, tls_strp_copyin);
+	tcp_read_sock(strp->sk, &desc, tls_strp_copyin);
 
 	return desc.error;
 }
-- 
2.35.3


