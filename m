Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B528C001DF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jul 2023 14:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zahPHGI1ZW5txV91l7nD+PrJJ0yE7ITzdx0EMFzva+k=; b=QC6+b5FXZ6mjl1eSdj9PlV1D0R
	pVs3Uvv9Tz3PmSJBdrtNI2+hpmovHl3pNkD6Kn0i/CtJzui8iZ3n+DIG9CW3iY9puxjEPgLdp8D+a
	WZhrVwYPTWnaQ+NGKyGM2aOy/QFAVe81XqS+2GKKDl4WBqCHkrFXFdG589eL7WhgxxvLp6A+eXDDm
	s/nqwZfrW5ntCOz97uC6rd11iTmJ4FrTRKRSXH3Bq9dpzMbeAhB8+azbOD/BSxBqpCxG9wrVNXIuu
	enOAj5FmwnhZOBhSecoKOk9YXCl2kflKBuTOa6fCjctJYlw2O3oG+6QdnqITRTHgu4z2j92qsKdZa
	JXvsterw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMrEP-00EIWu-1A;
	Fri, 21 Jul 2023 14:35:45 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMrEL-00EISu-0R
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jul 2023 14:35:42 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 69306218B1;
	Fri, 21 Jul 2023 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689950136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zahPHGI1ZW5txV91l7nD+PrJJ0yE7ITzdx0EMFzva+k=;
	b=BWs1Fb5AWASptVc66rNlYofnGNGolyGz+lBr2S3m6sYrOuiTxZAJ74qy2nvboV8W4cGTxF
	Rw4QY/YiyuyBgfzXMQjmvlnIhuy+WI1Tygjbis9CTIIi5mV9E1TcK9uK/RoyQNr7I2TiSG
	BU9aF56QYBTmugI3OKcR2hKr0zVwMpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689950136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zahPHGI1ZW5txV91l7nD+PrJJ0yE7ITzdx0EMFzva+k=;
	b=gTagaxVSrgylEq7ZH53p2u9Z6HitsgnhfocL5F7s43pG7JHNeBrsHc9ZfkB8VWxxV8UUwG
	S8K6Vb+librellDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 502702C149;
	Fri, 21 Jul 2023 14:35:36 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 3E43451CA022; Fri, 21 Jul 2023 16:35:36 +0200 (CEST)
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
Date: Fri, 21 Jul 2023 16:35:21 +0200
Message-Id: <20230721143523.56906-5-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230721143523.56906-1-hare@suse.de>
References: <20230721143523.56906-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230721_073541_355960_41FDD4B1 
X-CRM114-Status: GOOD (  12.70  )
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
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


