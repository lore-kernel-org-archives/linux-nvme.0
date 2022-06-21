Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF31C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 20:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nEToXfcsC62jjNaD4P9uIWb/5uXcpcb8XtaZ3TilSGc=; b=hP9xEB8WYajgjNwpWbwI04NhbC
	VbvPmtBWi3qfTHoCZYm7BIZNwSvFceENGgRhuV1rGGJM50Ak/o6dfYpRxBx/antXo3sDvg1qEwiO+
	/TsRZgrxJ5f/sKKE/RGPImh3fscxvTwmDpeCzmdolV8uOllH8wpYqTx8MHm/SwYJwCQuVIpDmZZGx
	ihryeWQRL5j4uGJ1XjAl8L3xSZf1lliPrG+xbyI1K7rmti0KtW0tMTQjpyHT2OIQegeu+QqycD8Bz
	tbbqb054ov/0gANyNfavpSzcr30w63ld3YJyzezR3me7wCxezF6Q3QfHbjQMDZea5Dj61dAQ/adrL
	zB8yi2dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kow-00768f-Vo; Tue, 21 Jun 2022 20:49:59 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kop-007642-Ni
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:49:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 6CF1AB81B24;
	Tue, 21 Jun 2022 20:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A66AC3411C;
	Tue, 21 Jun 2022 20:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655844589;
	bh=MLsaPkWl4pwEb56jRphAPhW21owYM+eoMh1VETT6uFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EgwC5tEmVdGWRBDptbYYAMAgIFGdS/TZWUjxnoo4GjPJbi16+ujK5MxVXhxX5HCDY
	 /33ihcNcFU27nWBZZ1uyGSJKXlph7fsBqzPyulgMlOdCL8kP7WyzgJhJ0KlfH/Co1l
	 qFm2DtcIASblXsPLhTxvOpnR/3Sh7cPTWE113qbQV34GK2SUIhp+1jDccm4HM/dE74
	 Qw2sSQ4de2S9lM90r8rxJ9RrVQm0E4YVFMkTCjr692ubV3YPkyepspTNWyIyOfX77y
	 S6wYncEBBLkw7V76i1t16qHhbcTWqoG8ck+Pq0LMr5/DjckiDF1raVbA35AHhQdu/t
	 JAjWK0ZHRlH8w==
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
Subject: [PATCH AUTOSEL 5.18 07/22] nvme-pci: add trouble shooting steps for timeouts
Date: Tue, 21 Jun 2022 16:49:13 -0400
Message-Id: <20220621204928.249907-7-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621204928.249907-1-sashal@kernel.org>
References: <20220621204928.249907-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_134951_954475_CBE71DF3 
X-CRM114-Status: GOOD (  11.81  )
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
index 37e05c83786d..a4393c5ca8db 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1334,6 +1334,14 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
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


