Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F4EC5AC67
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 20:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NUNpBm5aaKheXXtMtu8r/saBO/CwB8+dRxwdSsTSHsc=; b=ku5untiB6xtEHr5TTouQmdPVV4
	0v1JKDkNCVB7G4kd+O6LWnUy+jD5JyXgst7Gx0HRFPxGhHUafRCVMZXWcACRyfSXCWDEB4UJBlkae
	xVlC/KiVcAPo8UMyVuQcaZPZ0B+hi+L2sZYLxULlRPnzhSTT6EFYFIUYK7j8KMGUvfMpH8qV24j0v
	4BbfvjYjPVYgc0dl4966sZw2QDQ/oGEzcLZtvzonM3lUbWe95x81VLtTDPWVuedQfQCfz+wGGDdaT
	tXwisf9QzgBCGqZE32XzPf49SANLf08D6K1H8AkBZIw3np6/MEr9D58wNGXWkFCCk3M+fndfCBWS6
	7CejbBJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wttQU-0000000Ex4I-43lY;
	Tue, 11 Aug 2026 20:50:22 +0000
Received: from [195.39.247.168] (helo=mail.cyberchaos.dev)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wttQM-0000000Ewww-07l4;
	Tue, 11 Aug 2026 20:50:16 +0000
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1786481399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUNpBm5aaKheXXtMtu8r/saBO/CwB8+dRxwdSsTSHsc=;
	b=wsWKLoeUNFq04CoEzzyA0n8BeHTQJKh7UdT6xUjzdtw2xf8xYGBvOoJkL/64RSbYWUfhk6
	fHh9bDO+ZNNFfwuwmIxuCgRIAGQ+geRVIdwiIl2nkvWCFjJFM0wHlmcfU/BzbdWna2HAv4
	pqzJ90LrO86lIBbCIubXI7HhnVXGH5A=
Date: Tue, 11 Aug 2026 22:49:48 +0200
Subject: [PATCH 2/2] nvme: apple: add t8132 (M4) ANS2 NVMe support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-apple-nvme-t8132-v1-2-865be32e42c3@cyberchaos.dev>
References: <20260811-apple-nvme-t8132-v1-0-865be32e42c3@cyberchaos.dev>
In-Reply-To: <20260811-apple-nvme-t8132-v1-0-865be32e42c3@cyberchaos.dev>
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
X-CRM114-CacheID: sfid-20260811_135014_257175_6FD8CAB8 
X-CRM114-Status: GOOD (  18.50  )
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

This variant uses a separate MMIO base for its NVMMU and requires the IO
queues to be registered using an additional MMIO write.  Otherwise it is
largerly the same as the ANS2 NVMe variants present on Apple M1-M3 SoCs.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 drivers/nvme/host/apple.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index bf1c32c66153..7529474d56f0 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -42,6 +42,8 @@
 #define APPLE_ANS_ACQ_DB  0x1004
 #define APPLE_ANS_IOCQ_DB 0x100c
 
+#define APPLE_ANS_IOQ_CMDS           0x1200
+#define APPLE_ANS_IOQ_CQES           0x1208
 #define APPLE_ANS_MAX_PEND_CMDS_CTRL 0x1210
 
 #define APPLE_ANS_BOOT_STATUS	 0x1300
@@ -167,6 +169,8 @@ struct apple_nvme_iod {
 
 struct apple_nvme_hw {
 	bool has_lsq_nvmmu;
+	bool need_ioq_register;
+	bool separate_nvmmu_region;
 	u32 max_queue_depth;
 };
 
@@ -175,6 +179,7 @@ struct apple_nvme {
 
 	void __iomem *mmio_coproc;
 	void __iomem *mmio_nvme;
+	void __iomem *mmio_nvmmu;
 	const struct apple_nvme_hw *hw;
 
 	struct device **pd_dev;
@@ -281,8 +286,8 @@ static void apple_nvmmu_inval(struct apple_nvme_queue *q, unsigned int tag)
 {
 	struct apple_nvme *anv = queue_to_apple_nvme(q);
 
-	writel(tag, anv->mmio_nvme + APPLE_NVMMU_TCB_INVAL);
-	if (readl(anv->mmio_nvme + APPLE_NVMMU_TCB_STAT))
+	writel(tag, anv->mmio_nvmmu + APPLE_NVMMU_TCB_INVAL);
+	if (readl(anv->mmio_nvmmu + APPLE_NVMMU_TCB_STAT))
 		dev_warn_ratelimited(anv->dev,
 				     "NVMMU TCB invalidation failed\n");
 }
@@ -1123,7 +1128,7 @@ static void apple_nvme_reset_work(struct work_struct *work)
 
 		/* Setup the NVMMU for the maximum admin and IO queue depth */
 		writel(anv->hw->max_queue_depth - 1,
-			anv->mmio_nvme + APPLE_NVMMU_NUM_TCBS);
+			anv->mmio_nvmmu + APPLE_NVMMU_NUM_TCBS);
 	}
 
 	/* Setup the admin queue */
@@ -1136,9 +1141,9 @@ static void apple_nvme_reset_work(struct work_struct *work)
 	if (anv->hw->has_lsq_nvmmu) {
 		/* Setup NVMMU for both queues */
 		writeq(anv->adminq.tcb_dma_addr,
-			anv->mmio_nvme + APPLE_NVMMU_ASQ_TCB_BASE);
+			anv->mmio_nvmmu + APPLE_NVMMU_ASQ_TCB_BASE);
 		writeq(anv->ioq.tcb_dma_addr,
-			anv->mmio_nvme + APPLE_NVMMU_IOSQ_TCB_BASE);
+			anv->mmio_nvmmu + APPLE_NVMMU_IOSQ_TCB_BASE);
 	}
 
 	anv->ctrl.sqsize =
@@ -1175,6 +1180,12 @@ static void apple_nvme_reset_work(struct work_struct *work)
 		goto out_remove_cq;
 
 	apple_nvme_init_queue(&anv->ioq);
+	if (anv->hw->need_ioq_register) {
+		writeq(anv->ioq.cq_dma_addr,
+			anv->mmio_nvme + APPLE_ANS_IOQ_CQES);
+		writeq(anv->ioq.sq_dma_addr,
+			anv->mmio_nvme + APPLE_ANS_IOQ_CMDS);
+	}
 	nr_io_queues = 1;
 	ret = nvme_set_queue_count(&anv->ctrl, &nr_io_queues);
 	if (ret)
@@ -1484,6 +1495,14 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 		ret = PTR_ERR(anv->mmio_nvme);
 		goto put_dev;
 	}
+	if (anv->hw->separate_nvmmu_region) {
+		anv->mmio_nvmmu = devm_platform_ioremap_resource_byname(pdev, "nvmmu");
+		if (IS_ERR(anv->mmio_nvmmu)) {
+			ret = PTR_ERR(anv->mmio_nvmmu);
+			goto put_dev;
+		}
+	} else
+		anv->mmio_nvmmu = anv->mmio_nvme;
 
 	if (anv->hw->has_lsq_nvmmu) {
 		anv->adminq.sq_db = anv->mmio_nvme + APPLE_ANS_LINEAR_ASQ_DB;
@@ -1685,17 +1704,29 @@ static DEFINE_SIMPLE_DEV_PM_OPS(apple_nvme_pm_ops, apple_nvme_suspend,
 
 static const struct apple_nvme_hw apple_nvme_t8015_hw = {
 	.has_lsq_nvmmu = false,
+	.need_ioq_register = false,
+	.separate_nvmmu_region = false,
 	.max_queue_depth = 16,
 };
 
 static const struct apple_nvme_hw apple_nvme_t8103_hw = {
 	.has_lsq_nvmmu = true,
+	.need_ioq_register = false,
+	.separate_nvmmu_region = false,
+	.max_queue_depth = 64,
+};
+
+static const struct apple_nvme_hw apple_nvme_t8132_hw = {
+	.has_lsq_nvmmu = true,
+	.need_ioq_register = true,
+	.separate_nvmmu_region = true,
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


