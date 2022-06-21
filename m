Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72B6C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 20:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dODsyYpnFl0O9Pj/oaSjk6DlBCd05Cgis0sVHc5C9fg=; b=YfndRgPUy9XoKu5snL4G/89wsN
	x59XR51k69uzfYqGpKY/cjYnS2wFFiPBtJXkTuNrPo9a5km+r04MO2vIkDp+AVJ758FDMhjL20J3R
	T/f4fiP/wBm8iZ9RR86GRDww/TipQLPxqdoUc+SG8420iwTGN6jk4EZ21FtmvKzefSj5hD8yq1LHq
	wiLM0H2HviP+xnaFYyxKzFV2kY37H0+et7chvcaQTXtOUuUMAfzmi2ahQX6umgN5qrWw1D+gyhFau
	lr2mP7b8HeqCDqB8QWUK8gCwcXYm7M4Ca0V23LnnXZxCLKrlM6Hh5fFYWuVXZ04ZYCgwifn2YXfuk
	qjTOVmkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kos-00766M-Kj; Tue, 21 Jun 2022 20:49:54 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kop-007641-85
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:49:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 983C76184B;
	Tue, 21 Jun 2022 20:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA54C341C5;
	Tue, 21 Jun 2022 20:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655844590;
	bh=uZjgm7qavAbocjanMQ8eDS7EXa62sZGIK8QR7SKRvLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AdC5mL00lB2Rf6MZXkKOU0Vu6q7zTD+2cUV6CbM3zsEcXkFHHGGLvZCndoVHzDmLz
	 SA+F8HBYfS1TUWL7td3hi0XOIGLul0bYdK4dwlZdMnRK8VpR3HwodX15O/PpGvao13
	 Pkkn2YjUE45RcEZSNT27yqpX+Z/bZjTXJH/Jmo8jkLH/dFFs/bNVVgRY7DOBr34kJo
	 6RVkbc6OLrMKV5vASXWb2WO4+W+LXJ3UwU19+OiZLImKkzHfJgDssye66Ff+tifGna
	 ftg8PkYFbmAiv+fjw2LrFdtE4X0T5LqaR2jFLiNZFMbyezIxdcpECkNjTeeqvq00pk
	 HLOtxeGFOYUxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Reiter <stefan@pimaker.at>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.18 08/22] nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG GAMMIX S50
Date: Tue, 21 Jun 2022 16:49:14 -0400
Message-Id: <20220621204928.249907-8-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621204928.249907-1-sashal@kernel.org>
References: <20220621204928.249907-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_134951_369661_B3F44B98 
X-CRM114-Status: GOOD (  12.56  )
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

From: Stefan Reiter <stefan@pimaker.at>

[ Upstream commit 3765fad508964f433ac111c127d6bedd19bdfa04 ]

ADATA XPG GAMMIX S50 drives report bogus eui64 values that appear to
be the same across drives in one system. Quirk them out so they are
not marked as "non globally unique" duplicates.

Signed-off-by: Stefan Reiter <stefan@pimaker.at>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a4393c5ca8db..37a2a88d35c9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3479,6 +3479,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.35.1


