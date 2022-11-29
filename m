Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AF2C4321E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 13:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fuoVSw1VxLl5QCFXba4yvZ2M2fszDXiorTW4AkBniVw=; b=MOJG5owLoJbjRbdSX263Li/Xiy
	GDhM5P1jCiXUtWhMS9fwcIv8TCmlME0oiOmnM6kvKdiSFF+z+OzizQvT1mLj7HRVNLT7bcR/9bBzq
	5fXC0DnjFh2ovJgNt7Cs9lpPcfzk9hms1Y54njoTEgtcrJLHgWz1x+lgcu+xqAAXNl0qSoXbtggwI
	GSEVkktohYFOanW126WFDjI6TZqlad/F1t5BLnMclE/uVzPBR0fyUpmVbex6z7RxM2HyiQ5/UnUlx
	M1MT8Tv5ALyC9irlGSeArD63zSvcPC407qeTQlbqJmxUb4mjmFRrfaD5IjcYPWjJNaXKoObX6Hx6s
	HxQLZ3tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00ZW-008loq-Bc; Tue, 29 Nov 2022 13:22:50 +0000
Received: from [2001:4bb8:192:26e7:691d:40a8:d7b5:b2f5] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00ZJ-008lfV-AW; Tue, 29 Nov 2022 13:22:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 8/9] nvme-pci: return early on ctrl state mismatch in nvme_reset_work
Date: Tue, 29 Nov 2022 14:22:07 +0100
Message-Id: <20221129132208.4337-9-hch@lst.de>
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

When nvme_reset_work is called not in the resetting state something went
horribly wrong and we should not try to touch the controller registers,
so just leave the controller alone.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1b527377e35197..02940b4f42b104 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2792,8 +2792,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (dev->ctrl.state != NVME_CTRL_RESETTING) {
 		dev_warn(dev->ctrl.device, "ctrl state %d is not RESETTING\n",
 			 dev->ctrl.state);
-		result = -ENODEV;
-		goto out;
+		return;
 	}
 
 	/*
-- 
2.30.2


