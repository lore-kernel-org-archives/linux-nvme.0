Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55CFC79F9E
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Sep 2026 20:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JYrYFU5rbVzPv6FFpTGXsSRcBGtTs53y69QSHyJzaYg=; b=XDczkvsbExxf5AGZv5Di2PKQZv
	5AyVsMUE2FIkz/GI/wMRuF148PjdHrh4vwcoidxkfoCcuRFgBrClLlzIiCDy6tTv8d0EPGc053vVg
	Hi1zSgnZm1EvY4t7ntEXJ8X5XG4aQtsvF4qAq/xIOnQYZZo1ybscCrNlL4aoSdQ5SpDgHfSApF7qz
	N+3N5SAePHD0Ck9xzAkmVNubTzoTJMUB4voCzCNzCQPwXxczfbCYvBeAOq8DLUOgK/HlxCFeFFguE
	k448xaxjpr9Jy0U6tSFQvadm15Zv5A6JWpSJoyThV6tUit0iIs+b+h8OLG34JxGlsxcMEYLHh5V03
	6AYxJauw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3JHT-00000005Xaw-1cOI;
	Sun, 06 Sep 2026 20:15:59 +0000
Received: from mail.cyberchaos.dev ([195.39.247.168])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3JHO-00000005XaS-0rHr;
	Sun, 06 Sep 2026 20:15:58 +0000
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1788725748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JYrYFU5rbVzPv6FFpTGXsSRcBGtTs53y69QSHyJzaYg=;
	b=Fe/NIKlyE98soY7EGX/LVxVGmt7l2LHNfQeT/X8r01ydJvBHkgc999ERpy6V8q5e9X8AFh
	0fMd5zH8LqzK8Rs4A5pB4gkc3l97yCQz/Bl3e/tLfw+YIfqp5DanAZJoYAnlMMS0ukiXP5
	J86gk1rV7Bv/Kb9hcJelIS58U0g28PU=
Date: Sun, 06 Sep 2026 22:15:30 +0200
Subject: [PATCH v2 2/2] nvme: apple: add t8132 (M4) ANS2 NVMe support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-apple-nvme-t8132-v2-2-ac0328590823@cyberchaos.dev>
References: <20260906-apple-nvme-t8132-v2-0-ac0328590823@cyberchaos.dev>
In-Reply-To: <20260906-apple-nvme-t8132-v2-0-ac0328590823@cyberchaos.dev>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Yureka Lilian <yureka@cyberchaos.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260906_131554_502666_05BCC726 
X-CRM114-Status: GOOD (  17.02  )
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

Add support for ANS2 NVMe on the Apple t8132 (M4) SoC.

This variant requires the IO queues to be registered using additional
MMIO writes. The qsize of the create_{cq,sq} command is now ignored, and
instead a write to mmio_nvme+0x1210 (which was previously known as
APPLE_ANS_MAX_PEND_CMDS_CTRL) sets the IO queue sizes.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 drivers/nvme/host/apple.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index c63e28c75766..4621584b1b6f 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -42,7 +42,11 @@
 #define APPLE_ANS_ACQ_DB  0x1004
 #define APPLE_ANS_IOCQ_DB 0x100c
 
-#define APPLE_ANS_MAX_PEND_CMDS_CTRL 0x1210
+#define APPLE_ANS_T8132_IOQ_CMDS 0x1200
+#define APPLE_ANS_T8132_IOQ_CQES 0x1208
+#define APPLE_ANS_T8132_IOQ_SIZE 0x1210
+
+#define APPLE_ANS_T8103_MAX_PEND_CMDS_CTRL 0x1210
 
 #define APPLE_ANS_BOOT_STATUS	 0x1300
 #define APPLE_ANS_BOOT_STATUS_OK 0xde71ce55
@@ -184,6 +188,7 @@ struct apple_nvme_iod {
 
 struct apple_nvme_hw {
 	bool has_lsq_nvmmu;
+	bool needs_ioq_register;
 	u32 max_queue_depth;
 };
 
@@ -1133,9 +1138,16 @@ static void apple_nvme_reset_work(struct work_struct *work)
 			anv->mmio_nvme + APPLE_ANS_LINEAR_SQ_CTRL);
 
 		/* Allow as many pending command as possible for both queues */
-		writel(anv->hw->max_queue_depth
-			| (anv->hw->max_queue_depth << 16), anv->mmio_nvme
-			+ APPLE_ANS_MAX_PEND_CMDS_CTRL);
+		if (!anv->hw->needs_ioq_register) {
+			/*
+			 * Since T8132, this is replaced by IOQ_SIZE which is
+			 * located at the same offset and is handled with the
+			 * IO queue setup further below.
+			 */
+			writel(anv->hw->max_queue_depth
+				| (anv->hw->max_queue_depth << 16), anv->mmio_nvme
+				+ APPLE_ANS_T8103_MAX_PEND_CMDS_CTRL);
+		}
 
 		/* Setup the NVMMU for the maximum admin and IO queue depth */
 		writel(anv->hw->max_queue_depth - 1,
@@ -1190,6 +1202,16 @@ static void apple_nvme_reset_work(struct work_struct *work)
 	if (ret)
 		goto out_remove_cq;
 
+	if (anv->hw->needs_ioq_register) {
+		writeq(anv->ioq.cq_dma_addr,
+			anv->mmio_nvme + APPLE_ANS_T8132_IOQ_CQES);
+		writeq(anv->ioq.sq_dma_addr,
+			anv->mmio_nvme + APPLE_ANS_T8132_IOQ_CMDS);
+		writel((anv->hw->max_queue_depth - 1)
+			| ((anv->hw->max_queue_depth - 1) << 16), anv->mmio_nvme
+			+ APPLE_ANS_T8132_IOQ_SIZE);
+	}
+
 	apple_nvme_init_queue(&anv->ioq);
 	nr_io_queues = 1;
 	ret = nvme_set_queue_count(&anv->ctrl, &nr_io_queues);
@@ -1699,17 +1721,26 @@ static DEFINE_SIMPLE_DEV_PM_OPS(apple_nvme_pm_ops, apple_nvme_suspend,
 
 static const struct apple_nvme_hw apple_nvme_t8015_hw = {
 	.has_lsq_nvmmu = false,
+	.needs_ioq_register = false,
 	.max_queue_depth = 16,
 };
 
 static const struct apple_nvme_hw apple_nvme_t8103_hw = {
 	.has_lsq_nvmmu = true,
+	.needs_ioq_register = false,
+	.max_queue_depth = 64,
+};
+
+static const struct apple_nvme_hw apple_nvme_t8132_hw = {
+	.has_lsq_nvmmu = true,
+	.needs_ioq_register = true,
 	.max_queue_depth = 64,
 };
 
 static const struct of_device_id apple_nvme_of_match[] = {
 	{ .compatible = "apple,t8015-nvme-ans2", .data = &apple_nvme_t8015_hw },
 	{ .compatible = "apple,t8103-nvme-ans2", .data = &apple_nvme_t8103_hw },
+	{ .compatible = "apple,t8132-nvme-ans2", .data = &apple_nvme_t8132_hw },
 	{ .compatible = "apple,nvme-ans2", .data = &apple_nvme_t8103_hw },
 	{},
 };

-- 
2.55.0


