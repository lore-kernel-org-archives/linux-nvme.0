Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7400CC8300C
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jun 2023 12:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UB5GBQFweZUWjgDcOnDYdTqCiqD9xyzydwjoRdzZYzw=; b=tZXsnzgwcsDvykA1YirwHYxzdf
	xTkvd9mB296kamEcU3QRm/Y0joLlLmPdk0aiI9O11F15UelgbyJJzO5UbZWg0dwcie2FDTWocEn8U
	6VfCZW9pcSTr0BeRXbGDFor1Z1ItpuQyXM4Mg6APjeFdXjANLOtolNzeITn1LRw2Go3PPLuRtMzev
	aUTWfE5ULia6yiaklUmMfc0aiyammGumBS4Wup7ikkkRRWLZUU90YOFmsqqJi0PqWEL+kR52V8ysz
	tnpm8DiQ3eijmxhT3uJ6CbAZYJbmdspmGdZPGME9qFVia+PL9Dx8PKSsbyM9WpaCew5FJFkk4M3tP
	IAu6i61Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7bb7-00D2LE-14;
	Fri, 09 Jun 2023 12:52:09 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7bb1-00D2HW-2w
	for linux-nvme@lists.infradead.org;
	Fri, 09 Jun 2023 12:52:05 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 7C92B1FDFA;
	Fri,  9 Jun 2023 12:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686315119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UB5GBQFweZUWjgDcOnDYdTqCiqD9xyzydwjoRdzZYzw=;
	b=ETqG1SRKeFjND8wMrIoD4+foJIr5OV1qVd7/tYn3uSJ8zQt7n5N2JGktWiTfzM1E5KaBKL
	+eOg9IddvipCwmMuVIZ9tTUj/oFmlHEtkovNATvD3rqVGyw9pFS97ZDHMm01CWUZMlZwqB
	tg6B0rtR6mYLJQ0fX1bxa+PYBOAj86Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686315119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UB5GBQFweZUWjgDcOnDYdTqCiqD9xyzydwjoRdzZYzw=;
	b=1r3Z42Zlhu+gmE1eDhFtB/kyk+hQiZ8NNgqA/+x4uDCLopYlhblg6K4OAAdIKyRLfjjqzo
	adIdK6EGLyxaOGCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 686502C145;
	Fri,  9 Jun 2023 12:51:59 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 5C9B051C48C3; Fri,  9 Jun 2023 14:51:59 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Boris Pismenny <boris.pismenny@gmail.com>
Subject: [PATCH 3/4] net/tls: implement ->read_sock()
Date: Fri,  9 Jun 2023 14:51:52 +0200
Message-Id: <20230609125153.3919-4-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230609125153.3919-1-hare@suse.de>
References: <20230609125153.3919-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_055204_095631_F56B2959 
X-CRM114-Status: GOOD (  14.91  )
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
Cc: Boris Pismenny <boris.pismenny@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
---
 net/tls/tls.h      |  2 ++
 net/tls/tls_main.c |  2 ++
 net/tls/tls_sw.c   | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 804c3880d028..a5bf3a9ce142 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -113,6 +113,8 @@ bool tls_sw_sock_is_readable(struct sock *sk);
 ssize_t tls_sw_splice_read(struct socket *sock, loff_t *ppos,
 			   struct pipe_inode_info *pipe,
 			   size_t len, unsigned int flags);
+int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
+		     sk_read_actor_t read_actor);
 
 int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 int tls_device_sendpage(struct sock *sk, struct page *page,
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index f2e7302a4d96..767297a029b9 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -922,9 +922,11 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
 
 	ops[TLS_BASE][TLS_SW  ] = ops[TLS_BASE][TLS_BASE];
 	ops[TLS_BASE][TLS_SW  ].splice_read	= tls_sw_splice_read;
+	ops[TLS_BASE][TLS_SW  ].read_sock	= tls_sw_read_sock;
 
 	ops[TLS_SW  ][TLS_SW  ] = ops[TLS_SW  ][TLS_BASE];
 	ops[TLS_SW  ][TLS_SW  ].splice_read	= tls_sw_splice_read;
+	ops[TLS_SW  ][TLS_SW  ].read_sock	= tls_sw_read_sock;
 
 #ifdef CONFIG_TLS_DEVICE
 	ops[TLS_HW  ][TLS_BASE] = ops[TLS_BASE][TLS_BASE];
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index be8e0459d403..9bee2dcd55bf 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2219,6 +2219,77 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	goto splice_read_end;
 }
 
+int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
+		     sk_read_actor_t read_actor)
+{
+	struct tls_context *tls_ctx = tls_get_ctx(sk);
+	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
+	struct strp_msg *rxm = NULL;
+	struct tls_msg *tlm;
+	struct sk_buff *skb;
+	ssize_t copied = 0;
+	int err, used;
+
+	if (!skb_queue_empty(&ctx->rx_list)) {
+		skb = __skb_dequeue(&ctx->rx_list);
+	} else {
+		struct tls_decrypt_arg darg;
+
+		err = tls_rx_rec_wait(sk, NULL, true, true);
+		if (err <= 0)
+			return err;
+
+		memset(&darg.inargs, 0, sizeof(darg.inargs));
+
+		err = tls_rx_one_record(sk, NULL, &darg);
+		if (err < 0) {
+			tls_err_abort(sk, -EBADMSG);
+			return err;
+		}
+
+		tls_rx_rec_done(ctx);
+		skb = darg.skb;
+	}
+
+	do {
+		rxm = strp_msg(skb);
+		tlm = tls_msg(skb);
+
+		/* read_sock does not support reading control messages */
+		if (tlm->control != TLS_RECORD_TYPE_DATA) {
+			err = -EINVAL;
+			goto read_sock_requeue;
+		}
+
+		used = read_actor(desc, skb, rxm->offset, rxm->full_len);
+		if (used <= 0) {
+			err = used;
+			goto read_sock_end;
+		}
+
+		copied += used;
+		if (used < rxm->full_len) {
+			rxm->offset += used;
+			rxm->full_len -= used;
+			if (!desc->count)
+				goto read_sock_requeue;
+		} else {
+			consume_skb(skb);
+			if (desc->count && !skb_queue_empty(&ctx->rx_list))
+				skb = __skb_dequeue(&ctx->rx_list);
+			else
+				skb = NULL;
+		}
+	} while (skb);
+
+read_sock_end:
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


