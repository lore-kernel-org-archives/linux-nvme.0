Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7C0C3DA45
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jul 2024 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0FeWaqpt+XDbRrv0f4hnE2ToVYoIjHZUfSzU9VZPuYM=; b=2YmW2eMfPjsnAk+6RNR+l0v4HC
	FKxeJEJ8WZ53W9TFJ0RugJ/ax+YKqcc8B9t+kaAU4m5ov80vi9UNx7s4DoMHRw9uxxTe8+q52vQlt
	b3RPfIwmzFOukZn5LvRzOfzVvW8OFcZDG7z1sbXjuZlpKm4awYltGARKao82IRoxluaAW8/TzOpL2
	u1TtLfKsbU54sR2b7kMCPd+1K/rz5X+5vaSCXK9bxj3hPDRi9gNTioy/WAtRidHYI/z37kMlS3DUO
	8CqrbCmRMh5DprTam/5VTSKSAzZJj3a9U0kufzkNT5POPIbQNjmTW46oGly7Cv+lX6OiTWQlPRq0t
	k2v1JKaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS2lr-0000000FlFz-1TWw;
	Thu, 11 Jul 2024 23:00:15 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS2lo-0000000FlFO-2fWg
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jul 2024 23:00:14 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WKqtz0J9qz6CmM6M;
	Thu, 11 Jul 2024 23:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1720738808; x=1723330809; bh=0FeWaqpt+XDbRrv0f4hnE2ToVYoIjHZUfSz
	U9VZPuYM=; b=GZftTx7xTJdb5BSgbumm6cajCT4GZCpSUuh6E/oBi5YG1ByWVIt
	RMDbO/MFbQ3Fq5rGuKAc8sAhHiDBBmtJYsiVzStiGweTStwaV2VpF683PKRgGG8M
	+9h4uyW7Y0pRwxcgLVM7e93ob5vhM84T5+Su9apKGNOprvNr+9pUSfedF3X/P0la
	uyxtix3y65NHAGkKUm1mEPfrpVRZrsSfUx1kzKSUh9NT0nzBdr+0BxSCwVo/r7EK
	F0m3AqTZnGSH00K8q3hxsstxjTG5UK2EK4q3WTjFUnpKEAvyubWM6KXWOzBZiiUi
	tXTamRwifSUwUmxnbpMUkULrd0HCZOfpmkQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id OUQ2Z7X7hbnM; Thu, 11 Jul 2024 23:00:08 +0000 (UTC)
Received: from asus.hsd1.ca.comcast.net (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WKqtw16Mbz6CmM6D;
	Thu, 11 Jul 2024 23:00:07 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2] nvme-pci: Fix the instructions for disabling power management
Date: Thu, 11 Jul 2024 15:59:52 -0700
Message-ID: <20240711225952.5445-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240711_160012_726778_C490A584 
X-CRM114-Status: GOOD (  13.13  )
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

pcie_aspm=3Doff tells the kernel not to modify the ASPM configuration. Th=
is
setting does not guarantee that ASPM (Active State Power Management) is
disabled. Hence add pcie_port_pm=3Doff. This disables power management fo=
r
all PCIe ports.

This patch has been tested on a workstation with a Samsung SSD 970 EVO Pl=
us
NVMe SSD.

Fixes: 4641a8e6e145 ("nvme-pci: add trouble shooting steps for timeouts")
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---

Changes compared to v1: restored "pcie_aspm=3Doff"

 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 102a9fb0c65f..9e9b05e79c47 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1274,7 +1274,7 @@ static void nvme_warn_reset(struct nvme_dev *dev, u=
32 csts)
 	dev_warn(dev->ctrl.device,
 		 "Does your device have a faulty power saving mode enabled?\n");
 	dev_warn(dev->ctrl.device,
-		 "Try \"nvme_core.default_ps_max_latency_us=3D0 pcie_aspm=3Doff\" and =
report a bug\n");
+		 "Try \"nvme_core.default_ps_max_latency_us=3D0 pcie_aspm=3Doff pcie_p=
ort_pm=3Doff\" and report a bug\n");
 }
=20
 static enum blk_eh_timer_return nvme_timeout(struct request *req)

