Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF17DCCA473
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 21:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GmbSrontRyaMelV9feqp5qGdio1fU/mmkME4BJZr5XE=; b=aa0oT09IfFJoLhs0S5HX2qiw+v
	yRxMTcApFYQ3QfKon5Ria89b1c4w+zAWGm/OILapzHy1ZXzkW1wiPkbA8kMTVfVU53gD0ugdqnKSU
	+Aar6btcmrzW6jicil4T0s+5O6awx8fiVKw2lN9rfnmUM+Sjpjse2F3jNLIP5aT9vnp4gzdB2SOhA
	a/hmkIwBzJmqgbxsGdaBGPfGWUyQuUjVUpUDbifNI6U9Lx1iR/jzrG8nIwrpY6Xbp3ml8pZgZxW9e
	4PduFEYo5N1lQVliy/7CiJxNi9UEjsPalGFrZwJQCC1P9prfaYQddqhLL0Qh4e0HV0ht9yppLqWz3
	d46IVKTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kzl-007BV9-Ab; Tue, 21 Jun 2022 21:01:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kq8-0076u3-0L
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:51:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 75918618A6;
	Tue, 21 Jun 2022 20:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2705DC341C5;
	Tue, 21 Jun 2022 20:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655844670;
	bh=lfZC+lVFAvSXtJSVdmb9j6eQHqF28S1Poh+pDUdcEYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ww/fKWeFVcUG6w5mq46lQ0oNL2+hGFdDW0lDvLRmuWUB8D5756F4Pkm5A7oP5lbjM
	 Evz5N2g9vbv0+SRkyyCcRKsGU4LbC+c97UoFesVS7NR96CmHNtBRYL1Ts9lJpsW+xd
	 Hrx0FQy6kEY8wbN1oFBXkSa59AaO6cZIXgsvGtm4md7YWkGg6btcnFM0fZAiicMnM+
	 H08cCDhWU/I7RqAGrvd9bbaf40Juc7XX9BOeXNcymGRatVzcAEX+TgQFJYAD8z1LKk
	 zN/unms1g5uYV0dCEVgZEDDMHwyQeYytawgFquwKZQJ1UUFU4LqbbY36zNSMAw7/ux
	 yecJiRJhGcYmg==
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
Subject: [PATCH AUTOSEL 5.10 04/11] nvme-pci: add trouble shooting steps for timeouts
Date: Tue, 21 Jun 2022 16:50:58 -0400
Message-Id: <20220621205105.250640-4-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621205105.250640-1-sashal@kernel.org>
References: <20220621205105.250640-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_135112_134912_B28287AD 
X-CRM114-Status: GOOD (  11.70  )
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
index 7de24a10dd92..26f451b70511 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1252,6 +1252,14 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
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


