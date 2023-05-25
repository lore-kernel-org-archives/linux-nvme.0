Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADA8C77B7A
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 18:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iHB6VTUcqNeB0TeRLNt0Td7PJVizyqaOkRVm3TGb2Mc=; b=nbIQsEYrQ7/COOLzftTIPHjm5G
	2aiQc4f3NFcupYXKGfWUYiXWtNPEh7Qoswzr8NxZQbFquG0To33OpH3fPERCvqEmCAuGfGIWROeKK
	U0Ayk85TMFgaaWzV2Y5BazEFJocY6pU9SJU4G9AhBB7wDXYY30g0UKE9sh0YNxPeZILuHLsrONHjT
	c8AOUwRKzQvQlO8B3zMLdURPayBBcYrlWsl1Tkqm8y2cNfB+KmYP0GeG5opPdzLYo/nZR2X5VWEjG
	PVdYkbjdGOmjDup1GzlZH7yclluR4AzMGyT2C7tj6ip2pHieFlY3vcCt3gU3wL+wEfRTM2oZAtKsM
	sXknzALA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Fkf-00HOxe-2y;
	Thu, 25 May 2023 18:31:53 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Fkc-00HOwF-1F
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 18:31:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 54D07619E5;
	Thu, 25 May 2023 18:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C4DC433EF;
	Thu, 25 May 2023 18:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685039507;
	bh=VFjO42l3luArZ4psdOiK4HwyLgEcsNzr91BCbnzwSXI=;
	h=From:To:Cc:Subject:Date:From;
	b=WWDqDeQxEIkw+zhSJXSG3t9VTEDmZCqsmxGW39Nf4hCDCCWQo530dRPnkGMv0nS4b
	 RtKxeRtBEV1jfeoU1GgZdqXueUo7LgStSIWFCCMsASCTxP/LbA62RwHD/oLq2tkQ7t
	 R/1b7n7ge3IZBP9EAjhWzldeG1+5mfqc/Qd66wGyRLslw4jwux/LTK/TFVu8pWQplu
	 nTI1Wmt3G/hi5ZE9KgqzSJ2fYNA8xYr83784/elAoISGjlKOUjrrR5aA6YK+RlTiyX
	 6pZb1TEsvrNHy9tkuhn/wxGKcDRkHTr1OMRw0v1f1sjVAoHofZsJfb03t8AySI0T6X
	 bodb7uN01uy2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Andrey God <andreygod83@protonmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.3 01/67] nvme-pci: add NVME_QUIRK_BOGUS_NID for HS-SSD-FUTURE 2048G
Date: Thu, 25 May 2023 14:30:38 -0400
Message-Id: <20230525183144.1717540-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_113150_481751_140168DA 
X-CRM114-Status: GOOD (  12.43  )
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

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 1616d6c3717bae9041a4240d381ec56ccdaafedc ]

Add a quirk to fix HS-SSD-FUTURE 2048G SSD drives reporting duplicate
nsids.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217384
Reported-by: Andrey God <andreygod83@protonmail.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cd7873de31215..bbf96567365cd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3445,6 +3445,8 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x10ec, 0x5763), /* TEAMGROUP T-FORCE CARDEA ZERO Z330 SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1e4b, 0x1602), /* HS-SSD-FUTURE 2048G  */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.39.2


