Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F3EC98302
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 13:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pg18Pbgc69cV/gMwftuCBy3l3rv1TNxDzsc3uJalHFU=; b=EsewgC+O4Eg/qODgBx7N7uYXzf
	NNcGE75whl59eGXTMG5neydpoS34nGItRvjXQDu8HE7ddNUUYZpaXREUTuxiO3KHTiP0aJPy68ndm
	55fL4AGmW82xVWirGcgNtS+kQP0DVP8xkUO+stu4+l66UJ4yMuRRLzYQzwpnC/iOsz2qAOR97eBoX
	H0ckCBHuU+cAh1Q5Tk36Dy/wDcpErKVO9MDZP9ZxEmkkbSdjxG5yyvQaAmMQpVYgxcigg43iLrs4d
	EqU0ZRV7GubsajccpTNgyzCFalTndKBnz7h5uzwmgXUNtPpZcwcwzWEQ33N0zhN0ekx0hOvnxu/q9
	zgrehmug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90gY-00000005YBM-0jyN;
	Tue, 22 Sep 2026 13:37:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90gW-00000005YAV-2yXO
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 13:37:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 291A860E07;
	Tue, 22 Sep 2026 13:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2E01F0089A;
	Tue, 22 Sep 2026 13:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084243;
	bh=Pg18Pbgc69cV/gMwftuCBy3l3rv1TNxDzsc3uJalHFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HobNQjy0ovN9pu/OlHwLLFLYVz4krXttMJRS75AuUrHuQmdYFg5X1zi6n2FiLkfSX
	 lkF9iPH+ih2GG4NUwO6eTrqXOq3vRqFqqmNmd8YkpkxhnLr0ebJuElVXj2ZATb5U3S
	 1JdlZNud9snmXFhj0WwairRVttOasKOSWkmsQDpDchkVehB5ycnjRlhes+6cbG2I0O
	 yqphrj0tr5c1s6kPGeWTEd04GQGMb/Y/lKIIchK3U1XsnhDJ1zhURu+m2V8cRI/uqM
	 XwDPJRqeJ2GyV3gdeRDhFPuEfiJQXFfhtyX+NfG8rEUSpdfdVAwc4WO6oAzledQCRx
	 x5LYq/kBJCe6w==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org,
	Martin Belanger <martin.belanger@dell.com>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/2] tls: return a distinct error for control records from read_sock
Date: Tue, 22 Sep 2026 15:37:08 +0200
Message-ID: <20260922133708.84522-3-hare@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260922133708.84522-1-hare@kernel.org>
References: <20260922133708.84522-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Martin Belanger <martin.belanger@dell.com>

tls_sw_read_sock() leaves a non-data record on the receive list and
returns -EINVAL. The same function returns -EINVAL when an sk_psock is
attached, and an actor may return it for other reasons, so callers
cannot determine whether a control record is waiting.

Return -EPROTO instead. The record can then be read with recvmsg()
and a control buffer, which reports its type.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 net/tls/tls_sw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d1ad31986cf2..7ac606900ff8 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2044,7 +2044,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 
 	/* splice does not support reading control messages */
 	if (tlm->control != TLS_RECORD_TYPE_DATA) {
-		err = -EINVAL;
+		err = -EPROTO;
 		goto splice_requeue;
 	}
 
@@ -2132,7 +2132,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 
 		/* read_sock does not support reading control messages */
 		if (tlm->control != TLS_RECORD_TYPE_DATA) {
-			err = -EINVAL;
+			err = -EPROTO;
 			goto read_sock_requeue;
 		}
 
-- 
2.51.0


