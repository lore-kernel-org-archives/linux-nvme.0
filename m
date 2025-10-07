Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FA6CAC5B8
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Oct 2025 00:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2UxzPjq4bfBAqt8odMbxV/jMDGXYJds2ek2mqe8HYOw=; b=XOCN/a6P3i5qiOOpNvjkJGA9ZD
	XmqyVXj6BcL29G+FpIRpkrE5HcSYurxxfxPvFJHSHcNQ053P/MeUtHmSRRnJa1GDLOlCWBjm/iBFZ
	Y7C4yWpZfXIvkHfoF09G15kmDVubjfrAy/ehsI8TSr3VGYvFaNd8SpGj4VEePo3WePrt/gPSzsZSl
	2wg5LQlrCGc9M4CmEugaOuPxCUmMwdrUGyR/QV6ueFRDGnoz3dCeDFtZiqt/adUemCsTYT0bl47q8
	FZ5RIQKSePybmorp5FJlqS4nwg600Vx96q7Ft5QX9R+Dc34zVROWTaUm1BnJSxy68PaKOAIjDdM2E
	cXblhJIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5vrt-000000014el-3s1p;
	Tue, 07 Oct 2025 00:47:53 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5vrr-000000014eQ-1aGk
	for linux-nvme@lists.infradead.org;
	Tue, 07 Oct 2025 00:47:52 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-78af743c232so4604296b3a.1
        for <linux-nvme@lists.infradead.org>; Mon, 06 Oct 2025 17:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759798070; x=1760402870; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2UxzPjq4bfBAqt8odMbxV/jMDGXYJds2ek2mqe8HYOw=;
        b=R+O6XNcGCRLdCbuwKbizZSLeBVxmAIfe5zIgjO0uwhCjhvTGGfWUv6qC+HAa8nUA1q
         VG7qPhbtnbExlRUF2aZwIJmHu9gLyBoL3KnlQuOsxfAvlRHPibOC+Rds+nGBM+jHk4Ka
         60yi5YhNptduvMU4fIN04dYzL0O5i5POSCL1aUgsVi2vH4SAF5QGC/9hS/7AxQFzpWsJ
         gfVYnq5qiS2imsca30GJVRwVzwvKNSV7lmPI7TY1dDLJV1vbHiIpi5Fcr06spTc1/rmf
         bWTVeBoaCIBfTp1bgnQARXujFBbo6N9UWGhOuiEB3QyL61rMzRHMewhUvMyehXYanWoJ
         jHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759798070; x=1760402870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UxzPjq4bfBAqt8odMbxV/jMDGXYJds2ek2mqe8HYOw=;
        b=Z9EV/lo2KYylxTr3LH9pnApczv4GspGjm/w5Wy4MteUhYC5TNLQm6qulJap6Cz2WFQ
         xmZgJkWhilSQ9N4N25I4kVRvRNuaBM972wPiSfMKkJlwHgXfucBUsERX/yQ1I4yyOBQm
         SY1L57ATOTPNZ8kOrig7EuKQboAA9R++D5wjD7BUsmenpqpA/dpq8kB3XvhLmfn1kVyy
         QtJx/AkQsPavnpvVHC3eqfRsKxP0j/UG5yhRwlQz0ZYUyoYqIZaf5jK/Tf3s1VSBsred
         wSKR9i0AKE6nfu51YyP75a741dp9Uo6K53VmjWm4EztJFgZ1AEnvmoyoxQS8K5MJ7BvZ
         TxfQ==
X-Gm-Message-State: AOJu0YwIc6B0y7F6ddykDBUMEGDtOr9dQ1rvAJuyNOY+HI4cKFCxiIuL
	xDSH/hP6s73BKONXYVBRkSJcfWORNjDT4+XF0xxPZ30AXSiCrM7S0vlKhAJkFupB
X-Gm-Gg: ASbGnctijmwkIiHHeGwRhYRHOgF9eME3r0NaMFypThay4wuUfja+ZoCsejJhsqwd4eO
	sSRIF1KvkLxZeMSMRA/m9j04s8F1906sBMKVRUFoJ+DPs1ASbdXZZIWUAPUjnuivXFucnhqkgZX
	pA8fwCwhs+guT6zKiGPet6L5+SPnRlOgiZ605asnMzhadTheZRThZoPXd0B3GFjX2IQ3B7SnFKi
	C1tiDym/fUiGSZ4D6PjdwxtcMfz4Ad+lNaLvNT33JDD13FuJE1pE1JRX+y7EKheE2HxOW99bftt
	5zZGCED+0QJBoXBQse/03HeYb66dE1uKYZ2Iv2neYCOi0hoh4TV0kUW+SjRq5KFvtktyKwADs/F
	5igLCzwdSJIod7T2fRGG2hNVfk9uRiV8pVHuDQohTwRKuMKvY5lPfYfY=
X-Google-Smtp-Source: AGHT+IFMHyFATUeNe+Fl/tyGv+NYdpmbcD1fdDtkwTi3zmOMHIkIEROkuXuqnLBQ4I7USPiqifZxCg==
X-Received: by 2002:a17:902:f54e:b0:24b:1625:5fa5 with SMTP id d9443c01a7336-28e9a54ed9dmr169316955ad.11.1759798070010;
        Mon, 06 Oct 2025 17:47:50 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1ba19asm146468945ad.64.2025.10.06.17.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 17:47:49 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH] nvme/tcp: handle tls partially sent records in write_space()
Date: Tue,  7 Oct 2025 10:46:35 +1000
Message-ID: <20251007004634.38716-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251006_174751_423412_D1D15F9B 
X-CRM114-Status: GOOD (  17.62  )
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

With TLS enabled, records that are encrypted and appended to TLS TX
list can fail to see a retry if the underlying TCP socket is busy, for
example, hitting an EAGAIN from tcp_sendmsg_locked(). This is not known
to the NVMe TCP driver, as the TLS layer successfully generated a record.

Typically, the TLS write_space() callback would ensure such records are
retried, but in the NVMe TCP Host driver, write_space() invokes
nvme_tcp_write_space(). This causes a partially sent record in the TLS TX
list to timeout after not being retried.

This patch aims to address the above by first publically exposing
tls_is_partially_sent_record(), then, using this in the NVMe TCP host
driver to invoke the TLS write_space() handler where appropriate.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
---
 drivers/nvme/host/tcp.c | 8 ++++++++
 include/net/tls.h       | 5 +++++
 net/tls/tls.h           | 5 -----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1413788ca7d5..e3d02c33243b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1076,11 +1076,18 @@ static void nvme_tcp_data_ready(struct sock *sk)
 static void nvme_tcp_write_space(struct sock *sk)
 {
 	struct nvme_tcp_queue *queue;
+	struct tls_context *ctx = tls_get_ctx(sk);
 
 	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
+
 	if (likely(queue && sk_stream_is_writeable(sk))) {
 		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		/* Ensure pending TLS partial records are retried */
+		if (nvme_tcp_queue_tls(queue) &&
+		    tls_is_partially_sent_record(ctx))
+			queue->write_space(sk);
+
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
@@ -1306,6 +1313,7 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_request *req;
+	struct tls_context *ctx = tls_get_ctx(queue->sock->sk);
 	unsigned int noreclaim_flag;
 	int ret = 1;
 
diff --git a/include/net/tls.h b/include/net/tls.h
index 857340338b69..9c61a2de44bf 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -373,6 +373,11 @@ static inline struct tls_context *tls_get_ctx(const struct sock *sk)
 	return (__force void *)icsk->icsk_ulp_data;
 }
 
+static inline bool tls_is_partially_sent_record(struct tls_context *ctx)
+{
+	return !!ctx->partially_sent_record;
+}
+
 static inline struct tls_sw_context_rx *tls_sw_ctx_rx(
 		const struct tls_context *tls_ctx)
 {
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 2f86baeb71fc..7839a2effe31 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -271,11 +271,6 @@ int tls_push_partial_record(struct sock *sk, struct tls_context *ctx,
 			    int flags);
 void tls_free_partial_record(struct sock *sk, struct tls_context *ctx);
 
-static inline bool tls_is_partially_sent_record(struct tls_context *ctx)
-{
-	return !!ctx->partially_sent_record;
-}
-
 static inline bool tls_is_pending_open_record(struct tls_context *tls_ctx)
 {
 	return tls_ctx->pending_open_record_frags;
-- 
2.51.0


