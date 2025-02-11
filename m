Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95736C0219B
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2025 18:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nh4p/vkoe1IUhU0kNW+lsCY3zF9KIL8HN2NY6NLEHFk=; b=X03SMtfrnUtaOYGy1FQYF/H4vW
	xqEZ9uvyBc7r9QhZQ8dfUJ9WhEebrpUK8XG6j/8sDidDdnPhosZno85Fktoo5uurtIw+HxfeCNZXo
	vau3Dr64TbHcmSd0wMTRFJ6d50bhpGC73mOdjeWQeaG+gmx7Om4AgKP83NhjNVDpwuO/tkJMmF/5P
	ybLlC9GuFSFh3/TVXVBulR5BbTCrrf4oPyfSgIqidyImUg22Tl2BGmlq9byk5dbFqnIPYgQZuyee3
	fLygIKEtOH6RcHVhmWKh2vQJjMMViS+RPosYKs8ZxMElZu7bwXys2lMTa1UE53NXnQhXeSJtT8WAH
	kDRH6oMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thv7Y-00000004rXC-3rYA;
	Tue, 11 Feb 2025 18:36:32 +0000
Received: from out-189.mta0.migadu.com ([91.218.175.189])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thuxT-00000004q3C-3jRR
	for linux-nvme@lists.infradead.org;
	Tue, 11 Feb 2025 18:26:09 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739298363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nh4p/vkoe1IUhU0kNW+lsCY3zF9KIL8HN2NY6NLEHFk=;
	b=vDjaf+wWvTT2dtZEaGODEDZJsVIgTvnYQtaKIxJn4GbTbjrBijwoB5qQfbUhf2sPI1tUY5
	GEKhxSP7SKvU8XEhHO8eXPdBYHmh+mZ2UYkRBUuSavkNdWWt1xIveiqsX7sv/qpMFJ9kxm
	CRuH/IsOXeRGw+YbDpCKPqI7I0SAOFAQX67nmtjaS8xN2mFdNquWtS7/fTyfSa53OYdBB/
	/+pM+JIhiFlMxrKTWKHesQprp2ubjhUSymlIoQd/8XaMo4bujL6POhG5d82uhMbYwLHt8M
	X4WrEt7365IO9iz9GRRuEXx24PDVtKP4fnSq+XJjb7Sm3BxrX7gjsjdSEUclNA==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Tue, 11 Feb 2025 13:25:57 -0500
Subject: [PATCH 1/3] apple-nvme: Support coprocessors left idle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-nvme-fixes-v1-1-6958b3aa49fe@rosenzweig.io>
References: <20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io>
In-Reply-To: <20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3914; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=mqPCDjV0fSRn/nhoe3qxtBUGiudls3umAeMV7A1xI+w=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnq5Y3MY4msd3EKNRZnQIhChthfJmteSkdbuijp
 khUKHo+m8qJAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ6uWNwAKCRD+/lBaCvVY
 DUj8EACAF38TFG6b+7PMcQoaejAgCZiZcTG/DnrV7ydUZ4i8628bjueZahLtieUOM8b3U/lYgek
 DChUb++lo0EhEuTx0jTFATxLtg4dGT7ibBZRNwwZIvLC+BXKxRPaCUqhKTO7eA5YGPVUUAf8ORO
 ErcnDdc8WsFluYzoB1vUbaf0YRywB7qOlV/f8iIgZdcWEH5uUuh2I8qNi3adfo7igJMjXr5CMNl
 fhf858j5VdOD0Up3KtXYOwqfQRWUNK1vQGv0gc+ipp933FCKbEG65w5A5MeUp+q96xsTkw8FEqf
 DIhWnCzjPlA/tJDEvTd9wF4tCywFN7Q6HijhzgOhZAnFExhH/dJmqREB/sTWdgdnHnE0QIf0lpW
 ULgeAbozpB/+1vHHmzQQxUkbxByFPvKg40Jp1LwyZ2qSayHTOXjCInICSfIWSnJNrNF6eKJyqka
 oIVTS0MhQPi4UQfl7v3gAqcU1U3kG/qag1QQL65G97aVK5J/Cx25WNkXICzjd1plk2WO5fP6IFX
 roHzxcZPgODAMJ1GjYaHF+dz9rGgLx8tVfN6sT8PjlahEHQIIIu1eM/BwIJiwAKEqP6EL3BgMy8
 y2sPU/g+iUEizOIK97GrcwqBFyZxwsrnVsqb0ydOUC2JlF96pq1LU/rEyn6z2ebx5n3F5Bf/KVq
 2ukcrsMB8YB8L4Q==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250211_102608_229545_0791AC36 
X-CRM114-Status: GOOD (  16.83  )
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


