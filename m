Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A90DC001DD
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 09:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=djN8SwxQulz4oKMfxPm2nBt1Dth7GiYF/LtvYP/fS40=; b=qVi7CIvajLbYSmtgi/AdU3DQJ4
	OiU7uz704Q0ExXrRUqY4/0ZKGJNE+RLwCYPDJa7ibcn4VdWZ2A5xKDYQFODJDMwECSkro74rt0w6x
	s9LaYOO5hQnI1jfCOKlb9pzcLatFRLdcgy5mHo/6boph17Xal+I4yT4OkiZ4XZgapd4f+n0YyPhGp
	j0uwY/aEG9BeGbZ/UgyFsA7O/s3+qYsv88vUul2RU/XboUVlHtPjK2w0Tm+0+Rviy6sW6Jce/k3Wq
	1066CZJK9MRGq2PfGcOV58jhcS9Z8tehXa+rbW9UKzFjG2f3oevb6fnTWDvWju9E5Qt/10SfgVDiM
	VCobfDxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGFUa-009qY5-0j;
	Mon, 03 Jul 2023 09:05:08 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGFUU-009qRw-00
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 09:05:05 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 50FF2218FA;
	Mon,  3 Jul 2023 09:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688375096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=djN8SwxQulz4oKMfxPm2nBt1Dth7GiYF/LtvYP/fS40=;
	b=bH1cpldGlVRJ6RxyDzVsyR8XDeU3A+EhTUix2w3sOCuZu3MgNvEkj5VaeACXJ/3Oog+OIG
	P9gRZmcbNhkyENrXne5wT+4GbMyZ89l0j6/QO7vrD5iKxe9uJG00Ap5Y8ywG43iqR1mRKa
	fhuFqDZlZkI6+1ASf8lDELdl2QQq+84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688375096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=djN8SwxQulz4oKMfxPm2nBt1Dth7GiYF/LtvYP/fS40=;
	b=OzjQYnx5h8dcejnYOmWRN2lOm+2Cat0c87RyjsXyHzTE6h1ODuylaQWby95BxsVew8eO0q
	EpuTl+Zht8cNqRBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 38B812C149;
	Mon,  3 Jul 2023 09:04:56 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 037BA51C5D8F; Mon,  3 Jul 2023 11:04:56 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Boris Pismenny <boris.pismenny@gmail.com>
Subject: [PATCH 5/5] net/tls: implement ->read_sock()
Date: Mon,  3 Jul 2023 11:04:44 +0200
Message-Id: <20230703090444.38734-6-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230703090444.38734-1-hare@suse.de>
References: <20230703090444.38734-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_020502_222355_934AC211 
X-CRM114-Status: GOOD (  15.38  )
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
 net/tls/tls_sw.c   | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

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
index d0636ea13009..dbf1c8a71f61 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2202,6 +2202,84 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
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
+	err = tls_rx_reader_acquire(sk, ctx, true);
+	if (err < 0)
+		return err;
+	if (!skb_queue_empty(&ctx->rx_list)) {
+		skb = __skb_dequeue(&ctx->rx_list);
+	} else {
+		struct tls_decrypt_arg darg;
+
+		err = tls_rx_rec_wait(sk, NULL, true, true);
+		if (err <= 0) {
+			tls_rx_reader_release(sk, ctx);
+			return err;
+		}
+
+		memset(&darg.inargs, 0, sizeof(darg.inargs));
+
+		err = tls_rx_one_record(sk, NULL, &darg);
+		if (err < 0) {
+			tls_err_abort(sk, -EBADMSG);
+			tls_rx_reader_release(sk, ctx);
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


