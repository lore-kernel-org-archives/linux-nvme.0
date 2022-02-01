Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C597C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 16:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mJTbzaMWYfGisH5BV7gxndhVa8EIrwOYkjH+h6LOpwc=; b=HhXQgXEnbHzMUbb1pnSLTjS8ab
	S4MbYkBlruaqhFl3bGkBynlLUXWklL7ZsFOT/2k9aiqNqVVVobe65wgOyp78AJ0w+z2yE9zE/q6tQ
	1dpkSiK6WrvcqawNfsXOqvp4fIH5g/Y7JKzFgyG/WCLihEh5XqjxHNM/Gl2q7lSABNAU/raYBUCu3
	Ffp3sgHpEjEir95iVJnQfavMO7zdjDtGlZgdVGN5ZnCzkU7IjRZ/YgHdAdCn7DHxJCI52mixPj94A
	e5hXUVLhQwGRwZQwZCBqtUaPt9FeamnG4TMt0CI1nKWeTuwK28W/mxwGbq6NPB2qlr0JWigA5VQWi
	SapEGZUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEwMM-00D2DB-Bh; Tue, 01 Feb 2022 16:50:26 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEwMJ-00D2BC-3b
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 16:50:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 36526CE1A23;
 Tue,  1 Feb 2022 16:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFBBC340EB;
 Tue,  1 Feb 2022 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643734214;
 bh=mzhA8/eAoGj6hlGTh/7dkED0rgBXn9uwyaGgzaDzEr4=;
 h=From:To:Cc:Subject:Date:From;
 b=XtSz5JGSHlMw244rr6d2HYcAiqdiJEIGzI+nH9vw7r/ZHo/TgyJCEmyXxUy4YDRPz
 TLUfkoULK19pksaAiAkvOVo+83cvQm2TtvJrVrJX6+FgkV7BGmjslOeFbGySiOA5IW
 VGy1oC5ddE1Lf9Rhcg5PMyfYgM5JsRKtAxqlprTJ3Ippc2wl8peb3pf+pXtKX9nUXI
 h0znSpMHD+UYqNBTc0jGu96cn3vMiwOoBWdGzQ6nBDL9u8BEHONPh07pMSc5WlFjlO
 wDUEdHFIOENXD82GDwCjM5qVwEqQfSXGmGzWHLpwc7D+CqVsvvoTn5y+7jt0tV2GdK
 WLkl64qaFXr7g==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, Keith Busch <kbusch@kernel.org>,
 Rafael Wysocki <rafael.j.wysocki@intel.com>,
 Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH] nvme/pci: default to simple suspend
Date: Tue,  1 Feb 2022 08:50:06 -0800
Message-Id: <20220201165006.3074615-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_085023_361925_E488E91A 
X-CRM114-Status: GOOD (  14.82  )
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

There is no complete set of attributes a driver can check to know if
nvme power management is the correct thing to do in a runtime suspend
situation. Every attempt so far to optimize idle power consumption and
resume latency for a particular platform just leads to regressions
elsewhere.

Default to the simple shutdown since it is the historically safest
option, and provide a user parameter to override it if the user knows
it's safe to use for their platform.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215467
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d8585df2c2fd..7e25cdef09a2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -103,6 +103,10 @@ static bool noacpi;
 module_param(noacpi, bool, 0444);
 MODULE_PARM_DESC(noacpi, "disable acpi bios quirks");
 
+static bool pwr_mgmt;
+module_param(pwr_mgmt, bool, 0444);
+MODULE_PARM_DESC(pwr_mgmt, "use nvme power management for runtime suspend");
+
 struct nvme_dev;
 struct nvme_queue;
 
@@ -3094,7 +3098,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		dev_info(&pdev->dev,
 			 "platform quirk: setting simple suspend\n");
 		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
-	}
+	} else if (!pwr_mgmt)
+		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
 
 	/*
 	 * Double check that our mempool alloc size will cover the biggest
-- 
2.25.4


