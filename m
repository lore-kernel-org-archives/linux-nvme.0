Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69A2CD484E
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 23:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TG+H+8qFC3dm8ucOx8pPoSNzGyrnN/mGIjQnEFRQdw8=; b=3hFTcLS+9qVv6J/EuU2Sh3vAG0
	jOMK9va2gXg7OcL1rApoo9GKSjZ7zhWt3ye+pmEXHR/YJao6zTqfMPZLMQWbXrO7f8WL4/k8luWFa
	2vAhFL0M+fAfbNxIYkbgsLTBuV9c426wQiP/eZg/lIHCyAw/1BGH8A3AtUgbdbKHo/NllrrcgvYau
	KG9MQEMMZpalQdC2x3qh8yQaqBEhHXqhqMD07WshDzcJVjFI4IG6gPt7vDeqtTkDohahCAwd9/D3q
	57tiuzkpo1K6swM106u+YWUI8b44bQd5mLGCd1bj1b5ljbB/NaqdBEdfbLCqre0xji8uO37Doj3Y4
	EQDP6Klg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMaMe-0000000F2V5-44be;
	Mon, 11 May 2026 23:48:44 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMaMa-0000000F2UL-14QV
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 23:48:43 +0000
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-c8025aecc40so2277513a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 11 May 2026 16:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778543318; x=1779148118; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TG+H+8qFC3dm8ucOx8pPoSNzGyrnN/mGIjQnEFRQdw8=;
        b=j7mMA5SoV9ndrLcNJfO1iF9cECG5/hkvukJTV5lBGQZe1ckJXxY7E5sdlGsg/LJb/J
         VGmiUtCIx+G2WGWO6kGGEwvkuQZ7e6soRFksZChnHd6/BgZmpxVSshHONcmXCQ/oMzkl
         CpqJWW03Q3lrWEDZ+h3eSUZD5WPIjn5MVqzlcAswq1VXEQk2FSZ/N0+8bkJE3uY1PTeY
         pd117YEPeQvFt6jZKQHrO4kE6AcDhi94K4qLXs+KYDiKdQb2o58UPZ62KFnpqfJ10UG9
         pHPwEQ06SkmFgH2pQTCwiPpIxo2pQ/G4l2s8gDROqD/X6UP+yR29O/CZkQgY5gTz7KYL
         n1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778543318; x=1779148118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG+H+8qFC3dm8ucOx8pPoSNzGyrnN/mGIjQnEFRQdw8=;
        b=c55XvefSAW3dOyE7PyKgTAyTyulzTZ//liwRG029MmQ1RLVv6oCfk9lhDE6XIZryfb
         fGFRUtDWxKZJjoLjDeIQ5VIiucvGH++3arYEv/5PHGBc4EeHhg2KQLtltFtyJDaIimYU
         kX/W4QbtVqz+MxXGKYNU3BqfVlwQ8tJdtNVUXS8oUeuS8j5AIL2gaoX9Ukz3yTso3QCm
         ZtgaXs/jGab4PhLRvZcP0eMGlWm99WP6xi77PAWKpAu6Ed7ECLGd5u39cB8AQsG/LBIP
         bQdGIOidJpK9QEVV4ao3ye/5Z9eDsJC7HzvPVgELsCPGjgFpOhK+h0UIOZHwGzM0ltea
         +nCA==
X-Gm-Message-State: AOJu0YyUyUUozmzIQRra9mARAahZunT6CwVq9idkYG644T+duKRMjOOx
	lIDJMeMDZPVPa2qf3BN+Ix2Fis+qIqiBT0FdHHbHjY5Mo2/u5SxM0RpUFaaouQ==
X-Gm-Gg: Acq92OF5PT2JNRONFbnsYpzuLaOc4yRDM/C/zlyXcs4IF3aZEw9bfQd9MFXvUbJfbgt
	Y4Uou5lonaW3w8NH9yoeMwgNiCX+Bx7vEKjWKtMwG3kvzCYFTYbgLwLXe8Uv1jWEdK7ys9QZpuR
	eNMlagUnccn4YpBZNQ98TwSY34t9CrpFebSqEKVkepTVYDMd6ThJsLS4E3VWeY6ozc6MaMwjGTf
	SJQQkFoeqo+WaXRSXfAf0q02qu7aEID5gF9iII0Rl67qTHe6NmPJDOPayuuZbVS743At8Mnhx99
	u33sqlDM25AASwRFm+6FIXRms5vs/TLLKlOOlytiqroinKXPO3QWCaB6AOnpNT/IShsk2YoLY3t
	OlneLDwLev9sJBxaKZdjBVk7aliLz69xfl+7raO/F7Bq9jfvCejhItCUQ4+qN2oVWnaJW8+ph3v
	QLv+FZhh4Vugy6R90Gz0eiF/WAWDHpkDvUbe8i7IA=
X-Received: by 2002:a05:6a20:c88d:b0:3a3:adea:83b4 with SMTP id adf61e73a8af0-3acd446d7a1mr1454179637.21.1778543318226;
        Mon, 11 May 2026 16:48:38 -0700 (PDT)
Received: from zenbook ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267697d5asm9849101a12.14.2026.05.11.16.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 16:48:37 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	alistair.francis@wdc.com,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v2] nvme/tcp: handle rejected keys for secure concatenation
Date: Tue, 12 May 2026 09:45:53 +1000
Message-ID: <20260511234551.2925326-3-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_164840_303418_4C9409C6 
X-CRM114-Status: GOOD (  18.22  )
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

The NVMe-TCP specification [1] states that if the PSK retained or
generated is not available on the subsystem, the TLS 1.3 handshake shall
be aborted with an unknown_psk_identity alert and the connection be
closed.

Currently, when an unknown_psk_identity alert is sent from an endpoint,
tlshd returns EACCES as the TLS error. On subsequent reconnection
attempts, we fail with the same error because we keep attempting to
connect with a stale key. This may occur if the endpoint experienced a
full reset and lost its PSK.

With support in tlshd to return -EKEYREJECTED when an unknown_psk_identity
alert is received [2], the kernel can now detect this condition and revoke
the current tls_key. This allows the subsequent reconnect to perform
re-authentication via DHCHAP to generate a fresh PSK.

[1] https://nvmexpress.org/wp-content/uploads/NVM-Express-TCP-Transport-Specification-Revision-1.1-2024.08.05-Ratified.pdf
[2] https://github.com/oracle/ktls-utils/pull/149

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
V1 -> V2:
	- Typo in commit message
	- Re-worded the comment in code
	- Added reference to ktls-utils PR (merged) for userspace changes
---
 drivers/nvme/host/tcp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 15d36d6a728e..8e5421d2e8b9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1767,6 +1767,17 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 			dev_err(nctrl->device,
 				"queue %d: TLS handshake complete, error %d\n",
 				qid, queue->tls_err);
+
+			/*
+			 * If the key is stale, revoke it such that on a
+			 * subsequent reconnect, we will generate a new PSK.
+			 */
+			if (queue->tls_err == EKEYREJECTED && qid == 0 &&
+			    nctrl->opts->concat && nctrl->opts->tls_key) {
+				nvme_auth_revoke_tls_key(nctrl);
+				dev_warn(nctrl->device,
+					 "qid 0: revoking stale key\n");
+			}
 		} else {
 			dev_dbg(nctrl->device,
 				"queue %d: TLS handshake complete\n", qid);
-- 
2.54.0


