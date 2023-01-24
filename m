Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC58C38142
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jan 2023 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jTq1Gi1Tb30vOXwv8Bo/tLVqyI9drsWKrMfkCvnUcKc=; b=QoROuHKm3ifS4GAy1WmBuRDH+6
	APqt0iuAtkGIrSQDjUa8Co8j4hT3QemRTOsqN0qt8Ma6cuoWdLdHT88Wz8TIuPBoYJDn8EILq05wH
	senbWQRXY+F7A2ckfZ49UXypE/JR6VV+pxL3LnKW8xXb+wgcDl/jMd9TovMttcH7uW74slWoxTmkw
	+4XPhahCUKFP8O05bs+EasM4O+spYgFZyZQKX++awhYnPfZltg7r2EOXDfqFipsPQ7Msa8RfT34hL
	tp0wAEgxiI906X3xXz8xEG4UClO4CWMtKQHaeqEVVTapC3HfIQ8LSVc9TfOGhYW6wRgX3Qd4cjt1+
	s/oKqDwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKJgw-00454s-CW; Tue, 24 Jan 2023 13:50:26 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKJZO-0041Dh-G8; Tue, 24 Jan 2023 13:42:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0209E611E6;
	Tue, 24 Jan 2023 13:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B0AC4339C;
	Tue, 24 Jan 2023 13:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674567757;
	bh=SGhr37+TV6G0LvjAGKsSRgYYqvpyCDZRUG+oipTEypM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UEi45r/UAbC442wDJLx6BHQxWVk1QKplGfYHlR/d8kP25L0WmKsTlanhyRdS7CFQK
	 PKxA2y4l7H6+5v9cfwKK6WJMCyxlQmQJSrrPF0J7JFnquWEuHlvoeZZqXdexOwr7EJ
	 37NlPM8wZ9Wrztu1PXBBe2AU72sYnMaZ9cW6TCdQ6lBxfx8UBE51BTcm0C+WX0CZmL
	 QJ1BKZRzdgnk2IN0BlQjM6vtMqTBbGx4B5UuUMEJTG6oU7KfuBXmJesuKd1zZn2OKR
	 PkFs0Z2QwEfmhub82JnuixBCaI+MoW5itipwMKbDBmvlZJgT4jKalcXgkZh1bXG9zQ
	 Rg1KdU8eh75wQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Janne Grunau <j@jannau.net>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	marcan@marcan.st,
	sven@svenpeter.dev,
	kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 26/35] nvme-apple: only reset the controller when RTKit is running
Date: Tue, 24 Jan 2023 08:41:22 -0500
Message-Id: <20230124134131.637036-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230124134131.637036-1-sashal@kernel.org>
References: <20230124134131.637036-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230124_054238_621468_A7616ECF 
X-CRM114-Status: GOOD (  15.54  )
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

From: Janne Grunau <j@jannau.net>

[ Upstream commit c0a4a1eafbd48e02829045bba3e6163c03037276 ]

NVMe controller register access hangs indefinitely when the co-processor
is not running. A missed reset is preferable over a hanging thread since
it could be recoverable.

Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/apple.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index ff8b083dc5c6..262d2b60ac6d 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -987,11 +987,11 @@ static void apple_nvme_reset_work(struct work_struct *work)
 		goto out;
 	}
 
-	if (anv->ctrl.ctrl_config & NVME_CC_ENABLE)
-		apple_nvme_disable(anv, false);
-
 	/* RTKit must be shut down cleanly for the (soft)-reset to work */
 	if (apple_rtkit_is_running(anv->rtk)) {
+		/* reset the controller if it is enabled */
+		if (anv->ctrl.ctrl_config & NVME_CC_ENABLE)
+			apple_nvme_disable(anv, false);
 		dev_dbg(anv->dev, "Trying to shut down RTKit before reset.");
 		ret = apple_rtkit_shutdown(anv->rtk);
 		if (ret)
-- 
2.39.0


