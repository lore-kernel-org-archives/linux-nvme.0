Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB159C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 21:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sdxKnOKyAcFO+Aq0yndNAwapXKdKbEuAsTiqNRe0P/M=; b=Gsn48Vgjtn3uMKWsUHmjLGeC7L
	1y81yBkDyR8BYNvUcjDpipBrg+Ub7e0m47ywb6IG1RYQQJsgeMi0RdkkmIR4s9wfSBz0zcWGu9Tfp
	ngBHdOYb3+Gm26zBFZRWoAlLCVGyVUtIs4ETxEEeS/+q6JUDte3BKlkcSXJLybQ5C+kii2a56xB3J
	0nG8A4Z8sd9reGcoFac/5RTvIuBj1rLpBI2PEmHh5T7ZoHNpEMrnpJBnHh4fpIFv+xnQH6kjhNEJh
	JqJ2dVLa/wMKPXa90ZWSAS0l5RLh5hACtA4/P9Htl8+uQkrdypOaVlgxcLrA9f8OgwWmO68VaAO/0
	IyqZbjkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3l3k-007DXw-Nk; Tue, 21 Jun 2022 21:05:16 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kqX-00778D-MX
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:51:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 51AB961889;
	Tue, 21 Jun 2022 20:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5A9C385A2;
	Tue, 21 Jun 2022 20:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655844695;
	bh=dA8eO3kJ42RFGQFpPPCVUellUtKHSutFT3VRfj0OK3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jr1AdTHsJn6nEz99XerquZB+35OAWxs65emNEe7EYr4BjADn6y5rvg85Q2XmanKK2
	 +reeh+rLprVF5RvFoX9P77grfvxE3B4RfU1sD3KCOAiAO1Qq0gT7kraoFqY9hGFFmq
	 V8wQMZH4KpPu+fF2Y6r9rKdsvbHNiKnvYjFIXyPc3n6E8VeFt48X12HqHVuz/xu+xZ
	 cuDNEZMugWOQVFOim7TFck3rzHr+KLSkrF7IygZw8Kiv8f7vuRo4dtV39aGGTQBgrA
	 /GUFU9nqxvfjYdxb7Cdcn4EYLzqspE/Lt7icuFDda/ZM2hIc99LDwumPkqmT7yFTNX
	 a1tBU2rxHRn5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 4/7] nvme-pci: add trouble shooting steps for timeouts
Date: Tue, 21 Jun 2022 16:51:26 -0400
Message-Id: <20220621205130.250874-4-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621205130.250874-1-sashal@kernel.org>
References: <20220621205130.250874-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_135137_844233_DB8892E2 
X-CRM114-Status: GOOD (  11.90  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 4641a8e6e145f595059e695f0f8dbbe608134086 ]

Many users have encountered IO timeouts with a CSTS value of 0xffffffff,
which indicates a failure to read the register. While there are various
potential causes for this observation, faulty NVMe APST has been the
culprit quite frequently. Add the recommended troubleshooting steps in
the error output when this condition occurs.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b06d2b6bd3fe..f9fd62b894dc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1138,6 +1138,14 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
 		dev_warn(dev->ctrl.device,
 			 "controller is down; will reset: CSTS=0x%x, PCI_STATUS read failed (%d)\n",
 			 csts, result);
+
+	if (csts != ~0)
+		return;
+
+	dev_warn(dev->ctrl.device,
+		 "Does your device have a faulty power saving mode enabled?\n");
+	dev_warn(dev->ctrl.device,
+		 "Try \"nvme_core.default_ps_max_latency_us=0 pcie_aspm=off\" and report a bug\n");
 }
 
 static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
-- 
2.35.1


