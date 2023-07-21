Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9892C001E0
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jul 2023 14:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UNha7B/ZrBOMwPiE1Jjt9TZ3cfFptFxhGhTsINGDGF4=; b=K93iqRS2DIxJcE4nV9GESRkt41
	X+/5HXcnciZuc7NZ3Xs7N3S6uIrD5B3wU+3Lm/bNyKDD/x+L6q9gvo2EajL7yovZepsr7oEBZ4Ebg
	NbVvui1lcxkkBu2AP8B7qm+B90T9ZT5o3tMlKUKQ2hQozZ+Mg8q0G/nNwETijz+sg3d3CgI+NHWmj
	bHe66Ptv/SW8dPngxlVaswq+/N9Sq72bHOKkQtEKEWjdww5o39qMZi4BTHwd/3VNiZCJQbAAj0onN
	+mOdYA+pcGSOPLKsEfZCmvsN2eQf5cVFkO4OC0rEzvndmNnicDQIvOdyplDexmFfkekNT5hde/8BU
	ogP+Oe0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMrEQ-00EIXz-2s;
	Fri, 21 Jul 2023 14:35:46 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMrEL-00EISv-0R
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jul 2023 14:35:43 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 70E9C218E1;
	Fri, 21 Jul 2023 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689950136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNha7B/ZrBOMwPiE1Jjt9TZ3cfFptFxhGhTsINGDGF4=;
	b=PgRYwy1zdVXgsShp4Md+ylULHoZOLL2eGdrfUG7zF/lh9dmWIqL2DSx7jICiS7ZI2esWGf
	SWFBaofWTyvS5VrI2vldw55nMU60HQFBA8WGVSZZRbZsaiShilkxgRsQ35ZpiH9Th8aTcG
	1v52kR3WHF3aSUe2wHvKRyJoiP3SESk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689950136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNha7B/ZrBOMwPiE1Jjt9TZ3cfFptFxhGhTsINGDGF4=;
	b=jhStNKab5dddmLKnLCZ7idYvBQL2sDddTAlUlOSl98e0qz9qiooHaPW8WG3oofQjNtkWDu
	1vl29BzKYvStabDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 5915C2C14B;
	Fri, 21 Jul 2023 14:35:36 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 4DBB451CA026; Fri, 21 Jul 2023 16:35:36 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Boris Pismenny <boris.pismenny@gmail.com>
Subject: [PATCH 6/6] net/tls: implement ->read_sock()
Date: Fri, 21 Jul 2023 16:35:23 +0200
Message-Id: <20230721143523.56906-7-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230721143523.56906-1-hare@suse.de>
References: <20230721143523.56906-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230721_073541_357442_185C5873 
X-CRM114-Status: GOOD (  16.05  )
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

Implement ->read_sock() function for use with nvme-tcp.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Cc: Boris Pismenny <boris.pismenny@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
---
 net/tls/tls.h      |  2 ++
 net/tls/tls_main.c |  2 ++
 net/tls/tls_sw.c   | 89 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 86cef1c68e03..7e4d45537deb 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -110,6 +110,8 @@ bool tls_sw_sock_is_readable(struct sock *sk);
 ssize_t tls_sw_splice_read(struct socket *sock, loff_t *ppos,
 			   struct pipe_inode_info *pipe,
 			   size_t len, unsigned int flags);
+int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
+		     sk_read_actor_t read_actor);
 
 int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 void tls_device_splice_eof(struct socket *sock);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index b6896126bb92..7dbb8cd8f809 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -962,10 +962,12 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
 	ops[TLS_BASE][TLS_SW  ] = ops[TLS_BASE][TLS_BASE];
 	ops[TLS_BASE][TLS_SW  ].splice_read	= tls_sw_splice_read;
 	ops[TLS_BASE][TLS_SW  ].poll		= tls_sk_poll;
+	ops[TLS_BASE][TLS_SW  ].read_sock	= tls_sw_read_sock;
 
 	ops[TLS_SW  ][TLS_SW  ] = ops[TLS_SW  ][TLS_BASE];
 	ops[TLS_SW  ][TLS_SW  ].splice_read	= tls_sw_splice_read;
 	ops[TLS_SW  ][TLS_SW  ].poll		= tls_sk_poll;
+	ops[TLS_SW  ][TLS_SW  ].read_sock	= tls_sw_read_sock;
 
 #ifdef CONFIG_TLS_DEVICE
 	ops[TLS_HW  ][TLS_BASE] = ops[TLS_BASE][TLS_BASE];
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d0636ea13009..f7ffbe7620cb 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2202,6 +2202,95 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	goto splice_read_end;
 }
 
+int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
+		     sk_read_actor_t read_actor)
+{
+	struct tls_context *tls_ctx = tls_get_ctx(sk);
+	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
+	struct strp_msg *rxm = NULL;
+	struct sk_buff *skb = NULL;
+	struct sk_psock *psock;
+	struct tls_msg *tlm;
+	ssize_t copied = 0;
+	int err, used;
+
+	psock = sk_psock_get(sk);
+	if (psock) {
+		sk_psock_put(sk, psock);
+		return -EINVAL;
+	}
+	err = tls_rx_reader_acquire(sk, ctx, true);
+	if (err < 0)
+		return err;
+
+	/* If crypto failed the connection is broken */
+	err = ctx->async_wait.err;
+	if (err)
+		goto read_sock_end;
+
+	do {
+		if (!skb_queue_empty(&ctx->rx_list)) {
+			skb = __skb_dequeue(&ctx->rx_list);
+			rxm = strp_msg(skb);
+			tlm = tls_msg(skb);
+		} else {
+			struct tls_decrypt_arg darg;
+
+			err = tls_rx_rec_wait(sk, NULL, true, true);
+			if (err <= 0)
+				goto read_sock_end;
+
+			memset(&darg.inargs, 0, sizeof(darg.inargs));
+
+			rxm = strp_msg(tls_strp_msg(ctx));
+			tlm = tls_msg(tls_strp_msg(ctx));
+
+			err = tls_rx_one_record(sk, NULL, &darg);
+			if (err < 0) {
+				tls_err_abort(sk, -EBADMSG);
+				goto read_sock_end;
+			}
+
+			sk_flush_backlog(sk);
+			skb = darg.skb;
+
+			tls_rx_rec_done(ctx);
+		}
+
+		/* read_sock does not support reading control messages */
+		if (tlm->control != TLS_RECORD_TYPE_DATA) {
+			err = -EINVAL;
+			goto read_sock_requeue;
+		}
+
+		used = read_actor(desc, skb, rxm->offset, rxm->full_len);
+		if (used <= 0) {
+			if (!copied)
+				err = used;
+			goto read_sock_requeue;
+		}
+		copied += used;
+		if (used < rxm->full_len) {
+			rxm->offset += used;
+			rxm->full_len -= used;
+			if (!desc->count)
+				goto read_sock_requeue;
+		} else {
+			consume_skb(skb);
+			if (!desc->count)
+				skb = NULL;
+		}
+	} while (skb);
+
+read_sock_end:
+	tls_rx_reader_release(sk, ctx);
+	return copied ? : err;
+
+read_sock_requeue:
+	__skb_queue_head(&ctx->rx_list, skb);
+	goto read_sock_end;
+}
+
 bool tls_sw_sock_is_readable(struct sock *sk)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
-- 
2.35.3


