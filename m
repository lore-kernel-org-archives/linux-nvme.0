Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E87C56208
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 15:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=96YiMEHTPjVYOYR4q4ZD8nnOS9gprq4WjdET6qlWVhY=; b=M7EGpFGXI+628ejM0HXbWj2YZz
	Pwi9Uy88NXVYpNrNyMVB/ep0zO+M1x++kz/SwnHtNu62xIhcOFYpeLD48llB1ul3GzJphhrr68aDw
	BNW3g8+5NgMFdT3NNxdleGJ800PThOSfPy3BMXM4lw7DJsDbOFbkM9cZEJGh6b80uPis2Aw2iaMxO
	18I95w4ZkKeJaq2VpZCYKz4mSVTMuxzg0Zjbc7ihCrnutXi15OCZ240TbXMxsea8RJJNtYKFuGdJF
	UyotYQaWl/SC0VVtV+0W+ck2aOtSzABQYxXloEYIpPkZK1YrrKbwECS5qLPW52jbmFoERBVxgexw1
	fKM8XxGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws01a-000000065H1-3aZu;
	Thu, 06 Aug 2026 15:28:50 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws01Y-000000065E0-1jjS;
	Thu, 06 Aug 2026 15:28:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C8DA443F7E;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5956C2BCF7;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786030127;
	bh=YxBzcKnSFS/hs7Z6ZB2yAm0XU5wv5qxZmHDbDUlH1so=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rIzbwdeF3ZCdd01M+KYWYEYL6jSkwAO4FkUwgZFiOIGgvTDC+B6zKRU8zxE6DSMAL
	 RqwblFxs8UEbTMsxj0dbn7LBBWoIaLlsoeZZYVaPctzP1Jw3jBM8UuhMDX9Jafh0T3
	 0QRF/w3AlUQDfxEQqfQf7BelQdrE2wcm4kNjjfVddPbRZrA+q1w2u8UAEApPC+a+kI
	 ktZs3fn4mC5gQVgaARpmUS86yZczTDZbM6sekoVsdxlthHXqalGopMIT1K0SE1s3zO
	 uzJes6c7FD/Nu5EqoBER1RC8PII8yYvLSUjTNW9nuOlxtNSzyusu7f0PKxt9dqBXTW
	 sRoVphMTNe1vw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC1DC56208;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Thu, 06 Aug 2026 17:27:38 +0200
Subject: [PATCH 6/6] nvme-apple: Drop the PRP null check chicken bit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-nvme-fwabi-v1-6-bde19ce8db04@kernel.org>
References: <20260806-b4-nvme-fwabi-v1-0-bde19ce8db04@kernel.org>
In-Reply-To: <20260806-b4-nvme-fwabi-v1-0-bde19ce8db04@kernel.org>
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1941; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=YxBzcKnSFS/hs7Z6ZB2yAm0XU5wv5qxZmHDbDUlH1so=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ1bJCp3+P3XspXXZp+S/LvvxxCa4t3kKT7zkhKjNH0pcx
 Q/WhLF0lLIwiHExyIopsmzfb2/65OEbwaWbLr2HmcPKBDKEgYtTACYyaQIjw+qi5gKbfSf7NWV+
 fK+33TfR8mlZgl6E6Ksfnx/7HNIxmMnIMD/3TkTyRp0doQ9vxm14oc5lOps3Y0Fd58ZI/ecT9Zg
 iuAA=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407
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

Now that we program the DMA direction correctly the NULL check that used
to make commands fail passes. Another side effect of this bit was that
non-align buffers on the admin queue were silently allowed and that's
been fixed now as well and we this don't need this chicken bit anymore.
More importantly, starting with the firmware installed with macOS 15,
which is required for M4 but can also be installed on the previous SoCs,
the controller no longer exposes this control register and any access
SErrors instead. Just drop the write entirely.

Fixes: 5bd2927aceba ("nvme-apple: Add initial Apple SoC NVMe driver")
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/nvme/host/apple.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 78f89b5679e5..bf1c32c66153 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -47,9 +47,6 @@
 #define APPLE_ANS_BOOT_STATUS	 0x1300
 #define APPLE_ANS_BOOT_STATUS_OK 0xde71ce55
 
-#define APPLE_ANS_UNKNOWN_CTRL	 0x24008
-#define APPLE_ANS_PRP_NULL_CHECK BIT(11)
-
 #define APPLE_ANS_LINEAR_SQ_CTRL 0x24908
 #define APPLE_ANS_LINEAR_SQ_EN	 BIT(0)
 
@@ -1127,17 +1124,6 @@ static void apple_nvme_reset_work(struct work_struct *work)
 		/* Setup the NVMMU for the maximum admin and IO queue depth */
 		writel(anv->hw->max_queue_depth - 1,
 			anv->mmio_nvme + APPLE_NVMMU_NUM_TCBS);
-
-		/*
-		 * This is probably a chicken bit: without it all commands
-		 * where any PRP is set to zero (including those that don't use
-		 * that field) fail and the co-processor complains about
-		 * "completed with err BAD_CMD-" or a "NULL_PRP_PTR_ERR" in the
-		 * syslog
-		 */
-		writel(readl(anv->mmio_nvme + APPLE_ANS_UNKNOWN_CTRL) &
-			~APPLE_ANS_PRP_NULL_CHECK,
-			anv->mmio_nvme + APPLE_ANS_UNKNOWN_CTRL);
 	}
 
 	/* Setup the admin queue */

-- 
2.55.0



