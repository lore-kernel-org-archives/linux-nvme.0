Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06759EB64DC
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jun 2023 06:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NpRWGbmz/yN1drfKU5jCsneQpHSkIVFuKRaBbQbXDQM=; b=vcbtVn0JcQ5QY9v3WEuZlMOpJC
	cRUzAfDiLl0tcnA2ktm54webGpc0zymNqb2ZwBhcD3btOGLw9P5x0HAAEbe9/1p5KzTkiz2HLuIWv
	Nq/jYcz7FFGHIyzsV5R68QspHW7iWivzIAY6m6ClKYC11ZPr7L6GWqNBp7tpEppb/m13AHdLR0dXc
	sjjCXSRxFwubWyrpER1aNF0ORWwEWnRsck1qVBmjevtLlfkk6JrR66+b9RNoMNwTIY+u5v/nHx+/+
	eo9bvNZLMB3wpzDSbxsQpHaDLe2PhfdYfMBMeyiDr8Tx8iWPusX5Wr8jSltQEJ7FMEaFDxjgg9+fV
	VzE0EwJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Jtl-00APkO-0i;
	Wed, 14 Jun 2023 06:22:29 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Jtf-00APgn-29
	for linux-nvme@lists.infradead.org;
	Wed, 14 Jun 2023 06:22:26 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 854E91FDE5;
	Wed, 14 Jun 2023 06:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686723740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpRWGbmz/yN1drfKU5jCsneQpHSkIVFuKRaBbQbXDQM=;
	b=Y5+FDAwYUWnnDRaEPa/OHlvIlNqPG5w91CT9IvIU2lYGBoHYNW58Y5ngCt/0iPlVJK3tHv
	TDv1A40ESiYRgktA+tVLg5/YZZH/vRoFQ7UZcQiByTTp99v7UCTQn2vVcMG4aqH9s0EJHr
	lZN29ute/IZ+c/FX8Wkqriq2Cc7SN6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686723740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpRWGbmz/yN1drfKU5jCsneQpHSkIVFuKRaBbQbXDQM=;
	b=qArZ5g5/cZVLJ4zyDiYNpt4mAOwZMooOtxRL+9F8iPKgLXMHEfFk/S586NeDP8j4nMovRQ
	0kPGn2YxjVis9gBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 6FD882C146;
	Wed, 14 Jun 2023 06:22:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 62BB451C4DDF; Wed, 14 Jun 2023 08:22:20 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Boris Pismenny <boris.pismenny@gmail.com>
Subject: [PATCH 4/4] net/tls: implement ->read_sock()
Date: Wed, 14 Jun 2023 08:22:12 +0200
Message-Id: <20230614062212.73288-5-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230614062212.73288-1-hare@suse.de>
References: <20230614062212.73288-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_232223_887178_12AE3F7C 
X-CRM114-Status: GOOD (  15.55  )
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
 net/tls/tls_sw.c   | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index d002c3af1966..ba55cd5c4913 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -114,6 +114,8 @@ bool tls_sw_sock_is_readable(struct sock *sk);
 ssize_t tls_sw_splice_read(struct socket *sock, loff_t *ppos,
 			   struct pipe_inode_info *pipe,
 			   size_t len, unsigned int flags);
+int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
+		     sk_read_actor_t read_actor);
 
 int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 void tls_device_splice_eof(struct socket *sock);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 7b9c83dd7de2..1a062a8c6d33 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -963,10 +963,12 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
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
index 47eeff4d7d10..f0e0a0afb8c9 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2231,6 +2231,77 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
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


