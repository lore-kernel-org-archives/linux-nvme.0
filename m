Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1743DC56205
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M8ZoroyVOF30khOlnJcfY8jte17w4QH50uA5skRXVXE=; b=EmVX1+wB0/9udCSnL1Tew7U48z
	rR28aKgdRLRIdbTjKbsU9ibYTmyiUovU9R1SfNc5okwYDoaZr4bUMGXrYnucMQa4mcMg16iuNjigu
	+2T+598Nwqx4+p5BmiflP3OQteL815T0VnEgHiz9FbNPfw6qEOjemRd8fvjagjM9AmQImNSLieKco
	0xRiJTdQueR2i1DjJw65gUzFzPYugiY2g714N+DLweey0mo9J7uFplKEdLlp1amm1G2Jdxdvbgwu3
	ZGJC9kCgeuxLaOZkzBTQNew7GTwro4RTrFDK9AxRRnXvNDUAqvMLpVp6yG33/i9dDArVOH3sx+f49
	35U7gp8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws01h-000000065P6-2Rcy;
	Thu, 06 Aug 2026 15:28:57 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws01Y-000000065Dz-2BQr;
	Thu, 06 Aug 2026 15:28:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DA47260DB7;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 682B3C2BCF5;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786030127;
	bh=6Q/s+CU1jpcGZ6EF4+2fc7K8wZes4JUuaLdDIeWZEvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bNu2pfiNPO4rW4yxyAemjAMMYATMfOi6mdBgliZjLTQcrhoRNrlYFegVi0mkLAfJ3
	 MHtwE4yAHq7TF3uqkuoW2CPxToTFe2VWJ3odxjrAlnthbkuDVgHsH8DkVMhU/DJRF+
	 9rWwsPdMwxBICp1+8z++18hTILaxvdZ6vJdiCOcjPAi9HdBOUq9PK0cwgc2EnJSo5A
	 h/Hu1+8zuShRDVvIWwFnB+I/gibFlx1ioAUDv9Hn+tTlDeC5TQqW/PthHtP12dgUwc
	 mc3pj1bW6t9uI/r7x/g3FuqarXinXS8a/fF1YpfJ9jzbggCLK40kApiezD1Z8+cUE2
	 +QI39Sm/avgeg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D187C56207;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Thu, 06 Aug 2026 17:27:34 +0200
Subject: [PATCH 2/6] nvme-apple: Don't set a DMA direction for commands
 without a data transfer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-nvme-fwabi-v1-2-bde19ce8db04@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=6Q/s+CU1jpcGZ6EF4+2fc7K8wZes4JUuaLdDIeWZEvE=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ1bJCo1Ci7YTJ/Rde1f9ieC46p6heE9usf/Ngm1HjzDnu
 nlx87R1lLIwiHExyIopsmzfb2/65OEbwaWbLr2HmcPKBDKEgYtTACbia8bwm0VC95rI952nKy5O
 k+yrOnvNPvxZiqP1g4rFlnrf6tO1axj+KUirywmJL1G+vHKK1P2DUx+5l/DL5W+7ub7a6YPfq7y
 5/AA=
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

Setting the DMA direction for commands that don't do any transfer likely
triggered the PRP NULL check for which we needed a chicken bit. That bit
has disappeared starting with macOS 15 so let's just do this correctly
instead.

Fixes: 5bd2927aceba ("nvme-apple: Add initial Apple SoC NVMe driver")
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/nvme/host/apple.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 321502847a2c..f134b5ffb774 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -324,7 +324,9 @@ static void apple_nvme_submit_cmd_t8103(struct apple_nvme_queue *q,
 	tcb->length = cmd->rw.length;
 	tcb->command_id = tag;
 
-	if (nvme_is_write(cmd))
+	if (!cmd->common.dptr.prp1)
+		tcb->dma_flags = 0;
+	else if (nvme_is_write(cmd))
 		tcb->dma_flags = APPLE_ANS_TCB_DMA_TO_DEVICE;
 	else
 		tcb->dma_flags = APPLE_ANS_TCB_DMA_FROM_DEVICE;

-- 
2.55.0



