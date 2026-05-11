Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF123CD3427
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 00:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=F+fVAJX1UjczDD5tc9E8J72M5wmOjYTKiF/0N7p+R/E=; b=vwOX6P22JJTfC/b7Womj8knfEF
	nkqkvy6Vq7O9qJG8C9kYQgV3iMuX+cEawulGO30u4FMXj8lYTirOKDveQfLWlaQCDl/8Fi+6WI6tV
	4apdnGy7h6pcaAi9j/TdTb9B/JipNxhmK74sreZAN/Lo/3L5QcHVPgSUQV2AJDNh4tG0PsUniyRiq
	DOTmu2hdi/77P6TQ04JrbKjQN3yXXvOOn5h2fGoglKQ6eeVaWokgcmq8yDg98nvtQ7PBW7vEmHcBP
	XBZOClznfLXX1c2dm4jmwKADxcMtbGCmpxhT093fuC+4pqADhPUlhf3bo+r1XK12IywSpLFc1hIVU
	WAPqieAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMEwB-0000000Bvmf-3GB6;
	Mon, 11 May 2026 00:55:59 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMEw9-0000000BvmC-0u4o
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 00:55:58 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so2623949b3a.1
        for <linux-nvme@lists.infradead.org>; Sun, 10 May 2026 17:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778460955; x=1779065755; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F+fVAJX1UjczDD5tc9E8J72M5wmOjYTKiF/0N7p+R/E=;
        b=o5gCwzUnutDTqSpChNVqSszTgaF9HKPz2yiVBY7Gd5otm4h6Kq7sKWDhxYOLReFkdF
         PPMq9FdZPabxtU3V3tOtI4h6AIwiniUXJr/nZ9zF0cukU8HYtImXeDJWtTqY/UClrZhR
         7MqL3WvEQ3nnrPyIE4LvHjLYBNy08mDLK/ZPzwh+ho7ue9cOxlpfn+EhkqKnKCgozOzB
         2SxCr+WFnXi2fMfh1uEQ6kl6Ky8qEPHMIB6H1AV72JDE1lTHchpV4U/PS9v3MiKXgtNO
         E8v4Ws2QjnCzLuzdXAiVwNc20msGiY/5hmp03iswKKUDl6+0LtRe368NRyrMykw7KVTf
         GIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778460955; x=1779065755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+fVAJX1UjczDD5tc9E8J72M5wmOjYTKiF/0N7p+R/E=;
        b=AWQoG0GLnNboEPPNXuzlmzE5VlQwk958SllR3K/ZAXsmq3U9vqy+LRrUs2zynMW/zL
         Iat1DtXCFSr3aEYMyZ6VyQif17bi/IWgXqv/GsqqLaqBKP9k4ihoiH8pY868p0phIvpP
         ywcYktTaZ/wwU5xDXr9mqw/A66mqS1cU8FBTWlWPE9wFpSoeuaK4lT39I/dkJ6z/muoa
         JgepL1GBzVJXN8p8ZwT4EStgDkCr6TpNTBjfLu0EglFxLJ9JAQmgxnMQP0rQlu1rb+48
         6hAJvR0C136X5qC+57boZx8Ty1vJStBrLYFhWEFoz6aH6LBk9h9PcM9gQdHGzyWcW0L3
         iXYw==
X-Gm-Message-State: AOJu0YwIcQWbOoFv7Gab3jjufpNeF7dYj7UPdEhKHKHk5qWC/EVDXnyI
	IFvLFVtlGY83ZLWkzVsOjPYhvBz/bSJW14WZN3h5B3xOdADp9xfv7F1C
X-Gm-Gg: Acq92OFgJmoTdWYL7vWEgV4C8EbeRMHyAKyUwK2XkGghewSGkt45vc9PFHdxA4v8vn6
	9hhtlxABC5K8d1Gs2Wtui4vsfq/bg/9XbyluUbIaLCKpZDNsD2Ku2aUKgQwbSjIDgWGzY75OCiq
	IFv5VLr1GMJmBrKGAvNv3gOdUmJ4e4g4G8YBniUkNQe47Y3XT21rEkbd4KJ9C/I514pewyDKdp3
	oG7CrtFBj+xSk9en7UD9qF5jJDKfDYhUEZzcS6DAB6rOKb4xb9PgvOYDPRStL6DasCkVk4JQb16
	l1CbLIDVlgU/wAyWapXQrYmlvVkdjzKG4ptSc11xMPjK49D19bstaLqnnHC32tmsRlMdr0kfjgr
	a1qlhpJfrccJV9qVvyJQSUJW8XVGmBCzukpNnGMmHpntOAIxD7wDNgmqsdih4CWWuT6NHSKJYdr
	Z/P0eM6ytYF85bXoqI92BunZidAifG
X-Received: by 2002:a05:6a00:4517:b0:827:3d52:5d1a with SMTP id d2e1a72fcca58-83a58a2afc1mr19821159b3a.0.1778460955514;
        Sun, 10 May 2026 17:55:55 -0700 (PDT)
Received: from zenbook ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965b333f2sm22352788b3a.20.2026.05.10.17.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 17:55:55 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	alistair.francis@wdc.com,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH] nvme/tcp: handle rejected keys for secure concatnation
Date: Mon, 11 May 2026 10:54:55 +1000
Message-ID: <20260511005454.2486599-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_175557_292215_01C5EDED 
X-CRM114-Status: GOOD (  16.22  )
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
alert is received, the kernel can now detect this condition and revoke the
current tls_key. This allows the subsequent reconnect to perform
re-authentication via DHCHAP to generate a fresh PSK.

[1] https://nvmexpress.org/wp-content/uploads/NVM-Express-TCP-Transport-Specification-Revision-1.1-2024.08.05-Ratified.pdf

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 drivers/nvme/host/tcp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 15d36d6a728e..eff68eb7a5fe 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1767,6 +1767,17 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 			dev_err(nctrl->device,
 				"queue %d: TLS handshake complete, error %d\n",
 				qid, queue->tls_err);
+
+			/*
+			 * Key maybe stale, revoke it such that on a subsequent
+			 * reconnect, we will generate a new PSK.
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


