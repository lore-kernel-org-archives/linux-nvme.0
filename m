Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094F6C001DF
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 19:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6j8St0mqpj/4YNSM4Bra0NsJcodhAVb5gyxj6MKUhdk=; b=L3yRQj00eSbnnghMhXwh5z68kt
	94ayqD73nyVSLFeoMfvoPCJsNtGUVYi2Jlllsbzlu4oXY5JHNlf7n7IjKTH8XWgCOFoiC+QQG1nTI
	3rUoBu02SZrRW8A4KtixfwY7yXhjyrlOhyPm2MfV5sZMXyX7CvMGWZ8BePHkkD1QmKijWkmxfUDHp
	SnNaMie7JYy9NVA014ypZYT3cp5MhCjh0edbM0Eh0qeFwTXaMhARNFFJHT8L7qhe+WtM9uHTmYsS5
	xVJ0dtVgJZn1K0PWcwVh2DmxNBjVFqOhslI9L8fbpWvv1Nicl7dsAzZw9yJMDlVCTDZzLe2tWXWpt
	1OHQHkfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOjzh-00BMCT-2l;
	Wed, 26 Jul 2023 19:16:21 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOjzW-00BM6p-34
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 19:16:14 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 3307221CAB;
	Wed, 26 Jul 2023 19:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690398967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6j8St0mqpj/4YNSM4Bra0NsJcodhAVb5gyxj6MKUhdk=;
	b=zXWi4E8qyms6+JfNssIwU8YQ+vdDbLl51GaS2tKZnM6kQUO9wflPajRS34Ro7ARyVFq8/C
	fDHbKbbm/0LxcycEBWzEUIH+Zm1iq6IJbSVCwHwI6VLI/X8nG1FXk+XUX5ylf88v9cWWWN
	LvXqziFwuaF3hSUm+VZUHfGVJqQTTsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690398967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6j8St0mqpj/4YNSM4Bra0NsJcodhAVb5gyxj6MKUhdk=;
	b=VxA96baqyrSx0Th7wF9VVaXJWqbTx1sxVsdjs+NPqeZMfRwqN4AKt2l5riUzo12mooDWJF
	DRMoFhe1u7DDqyAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 17F0B2C14E;
	Wed, 26 Jul 2023 19:16:07 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 413E751CA339; Wed, 26 Jul 2023 21:16:06 +0200 (CEST)
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
Date: Wed, 26 Jul 2023 21:15:56 +0200
Message-Id: <20230726191556.41714-7-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230726191556.41714-1-hare@suse.de>
References: <20230726191556.41714-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_121611_334353_A6AC9185 
X-CRM114-Status: GOOD (  16.14  )
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
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Cc: Boris Pismenny <boris.pismenny@gmail.com>
---
 net/tls/tls.h      |  2 +
 net/tls/tls_main.c |  2 +
 net/tls/tls_sw.c   | 99 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)

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
index d0636ea13009..9c1f13541708 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2202,6 +2202,105 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	goto splice_read_end;
 }
 
+int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
+		     sk_read_actor_t read_actor)
+{
+	struct tls_context *tls_ctx = tls_get_ctx(sk);
+	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
+	struct tls_prot_info *prot = &tls_ctx->prot_info;
+	struct strp_msg *rxm = NULL;
+	struct sk_buff *skb = NULL;
+	struct sk_psock *psock;
+	size_t flushed_at = 0;
+	bool released = true;
+	struct tls_msg *tlm;
+	ssize_t copied = 0;
+	ssize_t decrypted;
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
+	decrypted = 0;
+	do {
+		if (!skb_queue_empty(&ctx->rx_list)) {
+			skb = __skb_dequeue(&ctx->rx_list);
+			rxm = strp_msg(skb);
+			tlm = tls_msg(skb);
+		} else {
+			struct tls_decrypt_arg darg;
+			int to_decrypt;
+
+			err = tls_rx_rec_wait(sk, NULL, true, released);
+			if (err <= 0)
+				goto read_sock_end;
+
+			memset(&darg.inargs, 0, sizeof(darg.inargs));
+
+			rxm = strp_msg(tls_strp_msg(ctx));
+			tlm = tls_msg(tls_strp_msg(ctx));
+
+			to_decrypt = rxm->full_len - prot->overhead_size;
+
+			err = tls_rx_one_record(sk, NULL, &darg);
+			if (err < 0) {
+				tls_err_abort(sk, -EBADMSG);
+				goto read_sock_end;
+			}
+
+			released = tls_read_flush_backlog(sk, prot, rxm->full_len, to_decrypt,
+							  decrypted, &flushed_at);
+			skb = darg.skb;
+			decrypted += rxm->full_len;
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


