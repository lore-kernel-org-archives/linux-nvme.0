Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921E3C021A6
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 16:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r0Nf5RrE3KZyG8T6/Sgi1E+IBrK5T7wX35BvpGHC0+U=; b=xnuIt1VgiCaMzV3OJutRqIsRCj
	9LHb8fW5uTUvZgHKKje1qF6II7P1Mwvzs7+iZITIGWN/lzM6Xqn8lk1WTFh6KclAB0G3HqYobZ64h
	ftPJaf3tqi/dxOsH99fJ9qyycdkkX9jmrmkLeGgxyCEgopFETCjy9vUDCJhS/plzyIhAJwV4b7nuM
	HdUO+Q2S3zyrtBZucbO/TvJf9qsrM02S9N3c6/Ngxr7gLGFqw8i2f/joPUxYL5KCqcCkBhA5kTKRA
	a/SKhiMC9yXXEfv5SPF7O1ZDlvsXxU8XeaQgUIRzhnocNI8U5tZ1072Yjd18U1/hpuAehkNK/R6jm
	bdpfupyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ticH0-0000000Bodr-3sYm;
	Thu, 13 Feb 2025 16:41:10 +0000
Received: from out-177.mta1.migadu.com ([2001:41d0:203:375::b1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tibq7-0000000BhyT-3YgE;
	Thu, 13 Feb 2025 16:13:25 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739463201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0Nf5RrE3KZyG8T6/Sgi1E+IBrK5T7wX35BvpGHC0+U=;
	b=rW6iqdT2IIKFIc4ByRE/jDZZXcqFpt+1lHLcNfSkXp99I/OXEDKlcMLXSEM97W1QqmveXY
	i7DatTU/YoFDZrA09D9uAmUe31w08KGi7PMDVZeNKV4r1xn9ymLXNfy7cnkCZd37Ojodt1
	btwzBCh9O/KFyjzfEM1B74wGDDjaafHg+kINcDQX0MHm7ECoA7KZTYmDI4LHj7nv+Y5wZC
	SZGCblERZNulG7uGHU1mHnzFiJM8ABu+QqmMbn1RHTLTDZE2UF+IrxZnffpfcd8qYkumux
	W1q9pp9D9pKWoUI2/MhJ2g/dIJ4WOo8CuFeeRMT7M0ssk8CBDALVNpQRWZkfDQ==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Thu, 13 Feb 2025 11:12:58 -0500
Subject: [PATCH v2 1/2] apple-nvme: Support coprocessors left idle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-nvme-fixes-v2-1-a20032d13e38@rosenzweig.io>
References: <20250213-nvme-fixes-v2-0-a20032d13e38@rosenzweig.io>
In-Reply-To: <20250213-nvme-fixes-v2-0-a20032d13e38@rosenzweig.io>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3956; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=wgj0LnXTlJwA+cyZHdZxivR1UD5uIhGd2SbgazZk4FE=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnrhoc9Ofuju1L0nnrZHtcWJgmTPea5jx4psjLw
 gjqdLMtVE2JAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ64aHAAKCRD+/lBaCvVY
 DRtND/49sh9V1/soTyP5SuFCNJIgFlGeGYy85Ck1KOk0EoE48GPzpnvho6FertRM2gaHItRzems
 YDHTP4zK4NcW96rugh09hmsIBntluG/DfyHx+asnib+6JQmt8Ahdwycj7NNak7OODb0NH+GoQPx
 5yUBRf1fE5oJY7uwwcRaZSc2Sv5Yqxebwxj9MfDmKaVx0MU5vM48uQkQ85rFtmQNXyHDQPsbRL0
 MSwCW+o4oUz3dooqIHkC+gigEo0LUj1tnHVqrgWVNboA0e36o2WrGIszUvMNr+h5eXQpALv2TXa
 4xB2VN8r1Ry/veiea+JzcYglzVqPferF9lsIyxjTIjj336RNvXLlzit8A1UoQumaiOWFEOSlFks
 KF0XBTG68hVsERjJBhGOh2huOgqjIbCaNChyHfkdlXxLfQvSAUGRefWKRKswQgSptxJZtJ8/mI8
 TTjhpHSD6d1aXmLe3Vfwa5r2Pz4LxvWUIOfReD8KBUh05dLYc5LmJ8PUdt3bk2Ithg6kRU2M7sJ
 HWAhX5Rinc71c25GrPinTk80YixcBIwWAKMTSHBjOnZ0vDYnjNOFEE3iCXhEJdIGd4iTVocwhu0
 hKd9z1kPai//VGEhtzi/C0Tt1/H40jAPjcimBfYYDVQZiq/0yysBn6oCfl0Ffjqk5LzvbOWXu6+
 zLmg+ePrBqgnvQw==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250213_081324_180885_2D923305 
X-CRM114-Status: GOOD (  15.94  )
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

From: Hector Martin <marcan@marcan.st>

iBoot on at least some firmwares/machines leaves ANS2 running, requiring
a wake command instead of a CPU boot (and if we reset ANS2 in that
state, everything breaks).

Only stop the CPU if RTKit was running, and only do the reset dance if
the CPU is stopped.

Normal shutdown handoff:
- RTKit not yet running
- CPU detected not running
- Reset
- CPU powerup
- RTKit boot wait

ANS2 left running/idle:
- RTKit not yet running
- CPU detected running
- RTKit wake message

Sleep/resume cycle:
- RTKit shutdown
- CPU stopped
- (sleep here)
- CPU detected not running
- Reset
- CPU powerup
- RTKit boot wait

Shutdown or device removal:
- RTKit shutdown
- CPU stopped

Therefore, the CPU running bit serves as a consistent flag of whether
the coprocessor is fully stopped or just idle.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/nvme/host/apple.c | 53 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 1de11b722f049abbc96a6bb62b072ac973b8c4aa..5e1c01a67ee81a36faa3da2f86a3a24fefcdfd6f 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1011,25 +1011,37 @@ static void apple_nvme_reset_work(struct work_struct *work)
 		ret = apple_rtkit_shutdown(anv->rtk);
 		if (ret)
 			goto out;
+
+		writel(0, anv->mmio_coproc + APPLE_ANS_COPROC_CPU_CONTROL);
 	}
 
-	writel(0, anv->mmio_coproc + APPLE_ANS_COPROC_CPU_CONTROL);
+	/*
+	 * Only do the soft-reset if the CPU is not running, which means either we
+	 * or the previous stage shut it down cleanly.
+	 */
+	if (!(readl(anv->mmio_coproc + APPLE_ANS_COPROC_CPU_CONTROL) &
+		APPLE_ANS_COPROC_CPU_CONTROL_RUN)) {
 
-	ret = reset_control_assert(anv->reset);
-	if (ret)
-		goto out;
+		ret = reset_control_assert(anv->reset);
+		if (ret)
+			goto out;
 
-	ret = apple_rtkit_reinit(anv->rtk);
-	if (ret)
-		goto out;
+		ret = apple_rtkit_reinit(anv->rtk);
+		if (ret)
+			goto out;
 
-	ret = reset_control_deassert(anv->reset);
-	if (ret)
-		goto out;
+		ret = reset_control_deassert(anv->reset);
+		if (ret)
+			goto out;
+
+		writel(APPLE_ANS_COPROC_CPU_CONTROL_RUN,
+		       anv->mmio_coproc + APPLE_ANS_COPROC_CPU_CONTROL);
+
+		ret = apple_rtkit_boot(anv->rtk);
+	} else {
+		ret = apple_rtkit_wake(anv->rtk);
+	}
 
-	writel(APPLE_ANS_COPROC_CPU_CONTROL_RUN,
-	       anv->mmio_coproc + APPLE_ANS_COPROC_CPU_CONTROL);
-	ret = apple_rtkit_boot(anv->rtk);
 	if (ret) {
 		dev_err(anv->dev, "ANS did not boot");
 		goto out;
@@ -1563,9 +1575,12 @@ static void apple_nvme_remove(struct platform_device *pdev)
 	apple_nvme_disable(anv, true);
 	nvme_uninit_ctrl(&anv->ctrl);
 
-	if (apple_rtkit_is_running(anv->rtk))
+	if (apple_rtkit_is_running(anv->rtk)) {
 		apple_rtkit_shutdown(anv->rtk);
 
+		writel(0, anv->mmio_coproc + APPLE_ANS_COPROC_CPU_CONTROL);
+	}
+
 	apple_nvme_detach_genpd(anv);
 }
 
@@ -1574,8 +1589,11 @@ static void apple_nvme_shutdown(struct platform_device *pdev)
 	struct apple_nvme *anv = platform_get_drvdata(pdev);
 
 	apple_nvme_disable(anv, true);
-	if (apple_rtkit_is_running(anv->rtk))
+	if (apple_rtkit_is_running(anv->rtk)) {
 		apple_rtkit_shutdown(anv->rtk);
+
+		writel(0, anv->mmio_coproc + APPLE_ANS_COPROC_CPU_CONTROL);
+	}
 }
 
 static int apple_nvme_resume(struct device *dev)
@@ -1592,10 +1610,11 @@ static int apple_nvme_suspend(struct device *dev)
 
 	apple_nvme_disable(anv, true);
 
-	if (apple_rtkit_is_running(anv->rtk))
+	if (apple_rtkit_is_running(anv->rtk)) {
 		ret = apple_rtkit_shutdown(anv->rtk);
 
-	writel(0, anv->mmio_coproc + APPLE_ANS_COPROC_CPU_CONTROL);
+		writel(0, anv->mmio_coproc + APPLE_ANS_COPROC_CPU_CONTROL);
+	}
 
 	return ret;
 }

-- 
2.48.1


