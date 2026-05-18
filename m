Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B66CD4F4A
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 18:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lTkbWOfvTijE5Sce00qhlQwRcPTokky7i9OeoXPYIao=; b=WaIOrmIhCnEMaLtHsCuioil1q9
	DTDcqL/bSC6q2a8OllBH6xeSEXrepNaNtnOkPEfJxn8bPGXa3YEthkYJxfXLsuy4PC0u9b09tzGwu
	dl0P1Vob20BvVGCpoBQi/zBeYbgYaOiU+Gl3d0HH0TnxTHWZzKl2htjcoWH+TkHmue4d/XwCzCswk
	MoKj3QzGmbntbtotD6dZ6Fuocd9k2D+xZL4qwx56BAd7BThuRRf5snKSrehFIEDeVLD9O201M9YKz
	Opm/r6PrHNXKCDWMvORX7zGQsSiaSqdnhFM9tkI6UZcky74epyR2r8yUYkNv2R7Ozk9Fnn1xxXQw2
	r5xYA5+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP2eB-0000000GYVk-1PoQ;
	Mon, 18 May 2026 18:24:59 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP2e9-0000000GYUg-0rw4
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 18:24:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A77A060123;
	Mon, 18 May 2026 18:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DCFC2BCC6;
	Mon, 18 May 2026 18:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779128696;
	bh=n9SuNozrSOzZhLDAOVkimbEDTCJ3gQowyLTYOZKeHSw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hJoAkiEn6GExcXDvdbcsElB5jR96pLT6Yb8xj/fQQqNhDzE82HO/4YIum2mz7MyjA
	 NK/Uxw5JCe8wCVcxCos0mezSVy+lYL2vYH0UMCT6JG6LYBgO85HTXQskKFv6FItuRb
	 yef0/whpVL/isvUxGyJwavWhcZpV9aAvrV7hgAw46rXW/FjXA6B6fEtCHyvINcERtN
	 8Rsz5x1Ys0jDPfnbCxjr4Z0Qv0hymjxg/Nb4VZTtoksHmDhuOlvzk2X6Wy6fsb2Dn4
	 ppbBZb2rs6sZvLci4B+GtoRDFz6FKX9B9SgmYDt6M7X7A99kkfjJwHZMKwcvbVMdhm
	 yuFhTJc2X5R2g==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 18 May 2026 14:24:29 -0400
Subject: [PATCH net 2/7] nvme-tcp: store negative errno in queue->tls_err
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-handshake-file-pin-v1-2-4bbcb7e62fda@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
In-Reply-To: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=x/9vqzlpF3pMsoHvTNGwDspyw8WZEQKJLSCQI6ALpEw=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqC1l076OEac041r0mxI+Z5S2sJEJZC22dodIZA
 QMmHspv5aCJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagtZdAAKCRAzarMzb2Z/
 l5wWD/4n0zVSZMdZiMdNLyXMCfqW62f32YzVIVpoKZxkxkVYbaNThbabaytjejyEc/pbv7MqVeD
 9kTAuzUgG1Znh/3Lnwa8YFX9JL8XyB1R/lEvTAe5ca3RPb3Gwv2PvrvOsUkRki4XjNm9M2amv93
 f7ie1VnZUPTar1DxT1VImOAJTLeBbioehA8YWm5J9VepZFkD4vWKk3PGY8p4kt/6UAfisPlaEqv
 vC9EMVz4xVwnNlOHXZaEXCwO1leedR8rf6LiISDjSosuotjOtqUleKJ/B1Ezf1wadP+6tHRJNs+
 I7TrSiwyvgkAxaHAKLvVMtTzko6bfCgxJjfonUGK1hG9ClWs+jZKpN0RKXJGsPMVLzLRasDhDQF
 VgT7D0zxxiEXmgIxj4pQm47vEYFUcCLz1U20Hz93Hsu2dBVb0erkJAcCZ4E9/GyNg3ExuVDh3y6
 ASkOmvhRfoWsffaTs95luC/bHWRqqkT6j9sCSrm0OV+kVSCHoCRWxl+5hTOxaxTIdj8NXu4Yoqc
 UsdhcN+RFmzfe/atC88XE/U7x+zU7lGAEBWnVF12djTRtbU6cRqIYV0Gvv5IuLtu40qEBbHNPP4
 VXhC0zaY1JpF4kj6rPAiccI4rfOoFw4cpWpmsvqgJ6yf37nrpcb2ItPGs8PpxD8drJ/MyJCTHdz
 NJIWLt657qfVJLg==
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


