Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F263C0218F
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Feb 2025 13:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AuN7BHu6AedjoDRuSnGwpKMSWJrm5bcMsdTtrx29lx8=; b=sMGO5eRTLquCsFlmNhOTdXk4u2
	57RJW0mZnj6jbfCFt9ZGKQbukw44e9zQQ/hfpWGKz4RkGRItY3jedMQWpMcXSPay+1XzgYa7gRY/8
	4QxbbbSRcx3vNN5GW5rozHvbfiSzorCXpzRphvy3a7Vp5iQsQvxNC/ja/JOZVW2zmq4jopuMVFWOY
	x7JwfCmsOs81utdIQISO5cDVccKjHTHQA22WIBnG/8lXT/UU9ixJdYUar3vTmPWgjL302Z+VVgs9o
	LbQrClK3dVKFKFHPuy3FmgB0Cg2MSvcLw/N5DjSIMRcvVnMxpahYU0oFad6+JK7/Q6/VLvpW7rT1L
	7MiGsAKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1teaMl-0000000Dp3u-09WL;
	Sun, 02 Feb 2025 13:50:27 +0000
Received: from marcansoft.com ([212.63.210.85] helo=mail.marcansoft.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1teaLQ-0000000Dows-2LBA;
	Sun, 02 Feb 2025 13:49:05 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id B3156425EB;
	Sun,  2 Feb 2025 13:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1738504139;
	bh=8/oqLprNeg7EVnuTTsaaXog3vpr2RsRu8CJidMsfdTg=;
	h=From:Date:Subject:To:Cc;
	b=PzXFQMCE+PGJcmCW1IEEvsEBBYo/Gjae1csNzvFBnRcfao2ps/mh+lJ76FgNmGADA
	 1OZfcDCnXJI+eUxSYyN2jJ67Idd8KjfvWNb/jUuzfFNdIxRTXcqicL5fmupKMovL6l
	 cDv/DtsIDaPLBKAU0q1kGgizg7nytY8pXDgHSMZ+4bEwONQT3Pu+8KK9quRu6SuAhd
	 jk7GFxpaou4Wp6pfG5LoldOontGlqoNWpSAQE1qTEcBRyTAvFtQq8ToMPl4IFhpNVZ
	 ymuKQjahy0C+DwkXI1D+2l8HAVmV4EdyWrPX2vZHAZAnOnjgJpiknpqJeQVIuGY6Kn
	 Q2U7u1qG9wZYw==
From: Asahi Lina <lina@asahilina.net>
Date: Sun, 02 Feb 2025 22:48:47 +0900
Subject: [PATCH] soc: apple: rtkit: Pass the crashlog to the crashed()
 callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250202-rtkit-crashdump-v1-1-9d38615b4e12@asahilina.net>
X-B4-Tracking: v=1; b=H4sIAL53n2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIKFbVJKdWaKbXJRYnJFSmlugm2phYmFqYp6SmGJmrgTUVVCUmpZZATY
 xOra2FgCV2c5SYQAAAA==
X-Change-ID: 20250202-rtkit-crashdump-e848547dad67
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Janne Grunau <j@jannau.net>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738504138; l=2448;
 i=lina@asahilina.net; s=20240902; h=from:subject:message-id;
 bh=8/oqLprNeg7EVnuTTsaaXog3vpr2RsRu8CJidMsfdTg=;
 b=07z3hDB8bILFgXEkR6JO0Is8fvSGRwvSiXVhEAahHzizx7GNkNDd1YuAqpcRxgr7DPDHhBBp2
 fPrYpp690uXARJdHCFdhDxeYLCPPJybrk6tW3QS1ajUR03Koqql9R+O
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=tpv7cWfUnHNw5jwf6h4t0gGgglt3/xcwlfs0+A/uUu8=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250202_054904_788911_5EC3351A 
X-CRM114-Status: GOOD (  11.48  )
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

Client drivers might want a copy of the crashlog to stash into a
devcoredump blob. Since device memory management can be very variable,
the actual devcoredump implementation is left to client drivers. Pass
the raw crashlog buffer to the client callback so it can use it if
desired.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 drivers/nvme/host/apple.c       | 2 +-
 drivers/soc/apple/rtkit.c       | 2 +-
 include/linux/soc/apple/rtkit.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 4319ab50c10d11ed81dcc002275f190e053c1be6..f46b3f179a00dad054c24ccaa0c578d64ca75ec9 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -221,7 +221,7 @@ static unsigned int apple_nvme_queue_depth(struct apple_nvme_queue *q)
 	return APPLE_ANS_MAX_QUEUE_DEPTH;
 }
 
-static void apple_nvme_rtkit_crashed(void *cookie)
+static void apple_nvme_rtkit_crashed(void *cookie, const void *crashlog, size_t crashlog_size)
 {
 	struct apple_nvme *anv = cookie;
 
diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index e6d940292c9fbdfc4cd42020e89aca2662c5cdce..4b0783091a92324a707a0e1cd16d36dd6d984678 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -368,7 +368,7 @@ static void apple_rtkit_crashlog_rx(struct apple_rtkit *rtk, u64 msg)
 
 	rtk->crashed = true;
 	if (rtk->ops->crashed)
-		rtk->ops->crashed(rtk->cookie);
+		rtk->ops->crashed(rtk->cookie, bfr, rtk->crashlog_buffer.size);
 }
 
 static void apple_rtkit_ioreport_rx(struct apple_rtkit *rtk, u64 msg)
diff --git a/include/linux/soc/apple/rtkit.h b/include/linux/soc/apple/rtkit.h
index c06d17599ae7e3d37d99495e4296932b1de3a3c7..736f530180179bd144cf85eb0f0bd93844d7188a 100644
--- a/include/linux/soc/apple/rtkit.h
+++ b/include/linux/soc/apple/rtkit.h
@@ -56,7 +56,7 @@ struct apple_rtkit_shmem {
  *                 context.
  */
 struct apple_rtkit_ops {
-	void (*crashed)(void *cookie);
+	void (*crashed)(void *cookie, const void *crashlog, size_t crashlog_size);
 	void (*recv_message)(void *cookie, u8 endpoint, u64 message);
 	bool (*recv_message_early)(void *cookie, u8 endpoint, u64 message);
 	int (*shmem_setup)(void *cookie, struct apple_rtkit_shmem *bfr);

---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250202-rtkit-crashdump-e848547dad67

Cheers,
~~ Lina


