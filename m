Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA741C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Apr 2022 18:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hKJGGOpT3F2q12K0TOR4cwYGKrYX9Y91K4DjIS+rO9M=; b=FaFIKVECtDX3JVtFOx4xPbgVFG
	RXHKMsaCADfRcsKYAnBaonQ+u84SRMoqsDDcMJhXYx7zD+asraiU3xDaL/BfdxhSobEiSWMBFFxuN
	OAI9Qz5aIATWQwNLA82lRv91L2A8GyY7XwHoegFT2Y10P8vogst7OCJPpj/KXqQqZ3vtQy42mcyb7
	++CsQx2ZSpUj/B79AjGl/1TW50QVuWGPblS0G/XC5/z2AI4uscnZ1G6R5V1E/TTAj0YnXNhJbeMdy
	XmB8mRMmDp8z8BAZc8tQCFmSBkwGj70teRrWxD6tUU3KUfdvJBZkgBsGF31mUI0+w16oY+fzaGJUv
	Sd2o4VfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngsQo-005awr-Bg; Tue, 19 Apr 2022 18:18:30 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngsML-005YNE-Vz
 for linux-nvme@lists.infradead.org; Tue, 19 Apr 2022 18:13:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A763BB81185;
 Tue, 19 Apr 2022 18:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55316C385A5;
 Tue, 19 Apr 2022 18:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650392032;
 bh=ji0RFgXR37v47Ioji/Ek0sxM2Xxd8cjtq5D9oiSiFpU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YEHaHB2UIm3BJwsCySanI+F+djOBdJjokYvn7r44Zits6AROC9SH/QNYOxmmXnO63
 lgEJqnyBNWIRkpaH1V72z7UmHEJZAP5tvnsmTBU2CJDEqa5mvUO4i3Lzc2GprCicB8
 mr+i2PA9CJEuAu6gist/hi2HmQqsjNL9t7AYdziH8f5/p43qgIXmoMPMEFCtpy19N7
 bfFEmi2nuziyxoZZn6haCSrWzZ5y6UnndmkjpRr+H+7Df//V13K6yFxbYM/OvaocnK
 1Mbat5D+3KnKjS5TVf7SPFjG4i41HwMkg5qT+MJ7RxEA6ncTPKgbdftOUcxh3glkQL
 +jx+kkrtFz8pg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Sasha Levin <sashal@kernel.org>, axboe@fb.com,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 27/27] nvme-pci: disable namespace identifiers
 for Qemu controllers
Date: Tue, 19 Apr 2022 14:12:42 -0400
Message-Id: <20220419181242.485308-27-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419181242.485308-1-sashal@kernel.org>
References: <20220419181242.485308-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220419_111354_238835_33CF4E7C 
X-CRM114-Status: GOOD (  17.28  )
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 66dd346b84d79fde20832ed691a54f4881eac20d ]

Qemu unconditionally reports a UUID, which depending on the qemu version
is either all-null (which is incorrect but harmless) or contains a single
bit set for all controllers.  In addition it can also optionally report
a eui64 which needs to be manually set.  Disable namespace identifiers
for Qemu controlles entirely even if in some cases they could be set
correctly through manual intervention.

Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 61f01f5afdc1..d7695bdbde8d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3314,7 +3314,10 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS |
-				NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+				NVME_QUIRK_DISABLE_WRITE_ZEROES |
+				NVME_QUIRK_BOGUS_NID, },
+	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
 		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
-- 
2.35.1


