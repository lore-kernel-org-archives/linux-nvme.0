Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371F7C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 21:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bo117i0IhceI/J2RG8T6BmIoTwkF6CFARS8uX/pTwqo=; b=EpJZilSGMuxbZjIi4yYbiel746
	8XxKobRsmlQ3CeIut3tA/1kk42+RrHGnwGzQfv+x/6hHLsD3+pWhFzEMGGdovGpx8/2iI323IL9Hw
	8FopHaPzsY6MEpH9dSNZpSDmIT0hZ123ExcpkG0zvKCI8cyBsPu+CTxWnsnpfbeabiHMWVo9NOT3z
	c/ULtzdo56/CEXPzuHR5HwSqaVDiE4zsfMo8N35gyqiGuWeOmgWdJNFTf20vp6U76Kjod350Q+eql
	XptQMTAQU0fwdhG/x/OpwVHR4OPWuyZ7OPxHt4HVlYEslCSv3fXqyXpRknCD/SgqGeq0XwyfsE1o0
	2sTQvL6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3l2g-007D1c-HJ; Tue, 21 Jun 2022 21:04:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kqM-00772O-AG
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:51:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E05E8618DF;
	Tue, 21 Jun 2022 20:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A21AC341D5;
	Tue, 21 Jun 2022 20:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655844685;
	bh=4SvmTqbPB0WkTO/yBHfrQPTCQ7bSChoZSTaFwJbbbi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XHnRoHhOTuj8YAT1BGbtaiphCQps2eqLS2em2BzVTlYulDTx3ERiMuq+VMrwmWaFK
	 lIJG1I+CHdzY1sWCRTF2cC5s1QXyxJhxG1ejk9shCCCcwXTbgwMU/rKghKFTuTApfp
	 mpL5F58hFdfdH6FWFaSvRnJHtcJYR+pBZRx12+EYkUrWLNry1It+MrSB+QeJtm6aUa
	 9UxeQo9p0aDxDClYlA4W29arDJHoybI6mbsN6r+mbBtEosADoOtEy7/Q95JDnmUQkv
	 ee+c4V9QdLeEv0acKHpoh3nJSMKvaOI+7p6zVx2Hbfu8TuizWVMZkOEZJ1VGc8BrX8
	 Kl+GcFKaMdiwg==
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
Subject: [PATCH AUTOSEL 5.4 4/7] nvme-pci: add trouble shooting steps for timeouts
Date: Tue, 21 Jun 2022 16:51:16 -0400
Message-Id: <20220621205120.250779-4-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621205120.250779-1-sashal@kernel.org>
References: <20220621205120.250779-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_135126_452967_921DC615 
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
index 10fe7a7a2163..df3b93e190e8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1266,6 +1266,14 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
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


