Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED765CD5BCF
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 16:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jcBSvMmhKqByd6rTFVbp4/utBAQpEX6HqXoqYICylh0=; b=2pVecU7oEUt4/OSNU+bJpWyihI
	cEy3oedJE/m/p2FEGwplTDnXUtDQQGV9aV09qIEQyJkhbLLJJdBmNVJblXfpH47LIKvrK3oZadCgn
	9LsWdLqADZFpDhl6LVfq+uqygTTCA71t/1948Ae429Tut/Kk3yugkrBIrW2smpvE5R4m/cq9+GRSM
	P/e561x4q/9ls8aFER084tO7r2G5xeY6SyZdeuJKpDgSyZbtD+tDSHVYbz4qNzIj9K8xKSR0y0N+m
	HHW5eQQQkMPhg4Kumr4qAZOkYaHqB1OXKxScNm5RNl+goGmHUVR6ApfP3Y7jW1trIn4lT/74+Zx6R
	B1orKWXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYWe-0000000047o-21Gg;
	Mon, 25 May 2026 16:51:36 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYWc-0000000046h-2UP0
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 16:51:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0C6D3601E3;
	Mon, 25 May 2026 16:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDC41F00A3F;
	Mon, 25 May 2026 16:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779727893;
	bh=jcBSvMmhKqByd6rTFVbp4/utBAQpEX6HqXoqYICylh0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jvbozGS8zgDBIg7osI8+lmNpuX+nbgvwY1oAWcAfZWRsh8SVrkJV7TeXi2orGctt/
	 RsN2jx/9bqbShakdnTq6xGjn7swGHF9zR178W62bBYCXVI/+lyESGUSTsmoqoEakqW
	 Z+aa07ybhVILjdR/CH5plL2csgZAPtCo4B5NJv6VmmQNRHuhCfAbVA9CbSJStJ0+kR
	 xuUG5UFShOVu8hnLOZWjMdpMKdMecvCvVLZbj5e2lkABQwvMkjFVYgBY01HUjuv3qr
	 S7cCc+cYW+k+URQmbIpts0xcFMxe5ga4N417eTCuRhiNZ0u8DDXmES5ljBZQTlEzyO
	 E3dMkQYVq5FxA==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 25 May 2026 12:51:16 -0400
Subject: [PATCH net v3 2/8] nvme-tcp: store negative errno in
 queue->tls_err
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-handshake-file-pin-v3-2-66c616906ead@oracle.com>
References: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
In-Reply-To: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@kernel.org>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=JOW7aetVzePh6U/0P0auy5nRsOk/ShMS6Cie+5IgQes=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFH4R31Zg1ZZiLqNT/ykU5FL8tjtqZlsM4VzVu
 SsrO5fSBsmJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahR+EQAKCRAzarMzb2Z/
 lw4dD/9Bob7tKowIuYlyBVNUc6l/eLzx/tR+hC40bzWolgYfVBO4MEXMJP+/s8YdGV8w1bEseCy
 x3FtiHKo3vJEhKXI47UGW0VhTIbaY5FuPsrpNC2OMYtlrRKQM5S4hM7IK0sdlXM620mTUQJ5f4b
 fe5t4TCieypkudUQOqTrewueAoZf/8Od1g4e+WRQFMeJciaz7fgJTCLEhmnSQz0SSj+3PlmDzvw
 cmMracaH8Ks0jtpaUx1yjBWdUgwOyE0VJM/SzVo5ACRkcTFSC3Iqzj4h4/svFeX3UMYoCIJQ5JZ
 U8juJTAJ3hJQ+uBGt2gHLR0Rf91dPJAhXtOQYVoSR20yKBtMLY4UHek3x3oVV9XNMiReaqbNkdQ
 jqE7SSEoO/1tuk5AZelcRzd3fWPZGfsEXmVtI3JKquO9I51FWscANBK2a41EMzc+Kzn//vd4ptb
 Ck+9in5V+BAvF9M6/rXQISJAx0PYjAv7smNlAOxGQJaLpnDq3FE69SQHCcESfC4nQPhgcj0EMtR
 7y/0mJgqsAw3Ss98av9eNWLQOYNciwHpnNoGmeULrI+/SuWTWAgiY8c8pvt0CeRyXSk7tjReBF+
 csqyyrABTJEXvD+zuSx1jWZ/JLZIs/z75kI4L/NZEPOK4FLvNgadreN0muPETzpNG8amw7oMF6e
 vxYUDWUNsjCh7ww==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
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

From: Chuck Lever <chuck.lever@oracle.com>

nvme_tcp_tls_done() assigns queue->tls_err in three branches.  The
ENOKEY lookup failure and the EOPNOTSUPP initializer both store
negative errnos.  The third branch, reached when the handshake
layer reports a non-zero status, stores -status.

The handshake layer delivers status to the consumer callback as a
negative errno; the other in-tree consumers --
xs_tls_handshake_done() and the nvmet target callback -- treat
their status argument that way.  The extra negation in
nvme_tcp_tls_done() flips the sign, leaving tls_err as a positive
value (for instance, +EIO), which nvme_tcp_start_tls() then
returns to its caller.

Drop the extra negation so queue->tls_err uniformly carries a
negative errno on failure.

Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 15d36d6a728e..68a1d7640494 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1702,7 +1702,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
 		qid, pskid, status);
 
 	if (status) {
-		queue->tls_err = -status;
+		queue->tls_err = status;
 		goto out_complete;
 	}
 

-- 
2.54.0


