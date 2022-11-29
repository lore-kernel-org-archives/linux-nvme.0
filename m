Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC2DC4321E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 13:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FrvnfBTugrlzoj/uKZX5uHlEQw2inwA7+9zzZMRMd6I=; b=djTBc0+kXAmSKHTkREcADifgKz
	ZUwThZIHUs02epxK5rGVr7J3OYjQmc0TeZCMn1uUylL2NYCwmJQX91auAzM/WtmOB7d5Uquc/b+qF
	b7X2/VL30j1YtZfkKpJqGMnlzZPQ/2YdScF20O5m5BvfzosCph7REk5fz8Sr1Yk14Wr2299hjqSd8
	7377CJTSBrm/G7HoLST+xtPfO4mAsYCG/gstjw+7pY45r9X3pb1WpsOi34Os7Ks0KyM7dZeu3V9QG
	LSaKz7NYiXxnr7zHWaTDeF4EZrh0PwIzOizScZF+/SrDra6YJTcHq3xi8Xfmg/LmNg3QwYlRGiXj/
	F7/ZsAJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00Z0-008lY2-VR; Tue, 29 Nov 2022 13:22:18 +0000
Received: from [2001:4bb8:192:26e7:691d:40a8:d7b5:b2f5] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00Yx-008lWO-Bq; Tue, 29 Nov 2022 13:22:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/9] nvme-apple: fix controller shutdown in apple_nvme_disable
Date: Tue, 29 Nov 2022 14:22:00 +0100
Message-Id: <20221129132208.4337-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221129132208.4337-1-hch@lst.de>
References: <20221129132208.4337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

nvme_shutdown_ctrl already shuts the controller down, there is no
need to also call nvme_disable_ctrl for the shutdown case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/apple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 94ef797e8b4a5f..56d9e9be945b76 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -831,7 +831,8 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
 
 		if (shutdown)
 			nvme_shutdown_ctrl(&anv->ctrl);
-		nvme_disable_ctrl(&anv->ctrl);
+		else
+			nvme_disable_ctrl(&anv->ctrl);
 	}
 
 	WRITE_ONCE(anv->ioq.enabled, false);
-- 
2.30.2


