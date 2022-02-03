Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB40C433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 20:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gpo1MSJTpkeLh83gRoEVxHEYFy5O093ayOX++Qc76qo=; b=Tdt9T4r1i+LVCI1jFKEO6+nxMb
	a2RWFcdaxXyL3t3aTi1TzGRYbCWGrsQdXJTorWyCtNi9K/VOEYeIf5BHCzc4Zax8Qoh20kqoS04S7
	kL6nINyHqnHkzq0tHkejvAVvDfAbPD/ElpMYWmWxXfbf/gDT1DQXXTMISQZlqrlmQssX40rlVTdS4
	/P6DyTWSRKDsboLFSth9drrHFzOp1cPof9VupzAbNz7lyLqe+SOwrJHylLnGBMaIoJYd0y8+NFvPk
	nA1b9LPr0WRHfTbzo9yPyPu8JPf5I1W6WaARxf7Q0CCkP/iJ+sR1D6OrafD1K+dx3Fb52vXyfzc14
	1ABgaxYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFisa-002nb8-Lx; Thu, 03 Feb 2022 20:38:56 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFipV-002lpo-Ek
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 20:35:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E23D7B83556;
 Thu,  3 Feb 2022 20:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EBAC340E8;
 Thu,  3 Feb 2022 20:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643920542;
 bh=ZIoruihJRDf1q4OFLPrXAa1XVhoSo5Vgetf4aKxnfEQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h0Q8g56TUvX/gJMnJulQvHmviv7vLyWpRwJdkK93dwkt7O12rFnOUVhzdxNCGl96D
 gDo+wBenOdLHYCSWh1+nANtLG283gmcUSgw+BHZZ20CuGV5rqg33b8QrU2eZY0lBaF
 DlNwXMLF4flAQsifhFABXtegYDr58b/yMAYjdoKY9PGWbqFRkPHz7btSIlJvmwCNa5
 mmjsX0Ag0d8LiPWk5Hw5WoXi9BrR4TO2OK1QDuRJQorZDPlliJYsZWSrpNrbvDfNkT
 DdfhGNTxAuUZ+ADMHwRs19eVmjrbkJ4w0kiaUwfZ5Lo6+mM1kfDkvV/dUZN6xlne9W
 c5FljZ7sTPRkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wu Zheng <wu.zheng@intel.com>, Ye Jinhe <jinhe.ye@intel.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, axboe@fb.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 24/25] nvme-pci: add the IGNORE_DEV_SUBNQN quirk
 for Intel P4500/P4600 SSDs
Date: Thu,  3 Feb 2022 15:34:45 -0500
Message-Id: <20220203203447.3570-24-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203203447.3570-1-sashal@kernel.org>
References: <20220203203447.3570-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_123545_667637_8423FFC4 
X-CRM114-Status: GOOD (  13.90  )
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

From: Wu Zheng <wu.zheng@intel.com>

[ Upstream commit 25e58af4be412d59e056da65cc1cefbd89185bd2 ]

The Intel P4500/P4600 SSDs do not report a subsystem NQN despite claiming
compliance to a standards version where reporting one is required.

Add the IGNORE_DEV_SUBNQN quirk to not fail the initialization of a
second such SSDs in a system.

Signed-off-by: Zheng Wu <wu.zheng@intel.com>
Signed-off-by: Ye Jinhe <jinhe.ye@intel.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1b85349f57af0..97afeb898b253 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3198,7 +3198,8 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
 	{ PCI_VDEVICE(INTEL, 0x0a54),	/* Intel P4500/P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
-				NVME_QUIRK_DEALLOCATE_ZEROES, },
+				NVME_QUIRK_DEALLOCATE_ZEROES |
+				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_VDEVICE(INTEL, 0x0a55),	/* Dell Express Flash P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
-- 
2.34.1


