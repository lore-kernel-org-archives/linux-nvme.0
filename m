Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CE6C4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 20:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=emB/iOP7ps0bFuNEUwI1XqrC4BJtE/aDQ8W/UvE/4h8=; b=BQq93WQHTRwY/lQAWj8f5vle94
	yTQAlzp4KhfBzfEOMaRV4GZ4R/ZUM908vU4P2VPQiRXrxBFeNkS4M2IYSpnI/ASVwcX09n2oUiTno
	FPZGpvsvZgd5Kzx7jvOQMVAsi7Lhn1a8HxrTyFjtlkTSIHqamDD8ML8OFcfuMEyRVKLGopqtuT2bA
	kZZBlQi1gm9NSeEBwdD5XWkyJmcVoZCLfxjDKxo3e9gmmM/OsKyN2XNyxVlJJXtefy7btNmSflwhb
	T6Y0o9B76rg+2/daeVP2VlEcllCVGuMUeieRknx+1C47PL5UgPy/GwqhqezXnAhjAMxHwqs52I/ev
	BpeYpJWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFiqJ-002mIh-Ex; Thu, 03 Feb 2022 20:36:35 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFio0-002krV-D1
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 20:34:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D54F9619D3;
 Thu,  3 Feb 2022 20:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B67C36AE2;
 Thu,  3 Feb 2022 20:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643920451;
 bh=SlsAxB7GlVdFg1xsl04fZWbORDq09QyWjRaYXy2tIvE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=b0zJLDIzQsan7YmqbhrTCBgmh38qyuDbK/XAMu7W1uF5pY12d+EtowCy6RdRgwvag
 nZEPSP9rcM8u5LRWIR6KPf5CUtxHeLxsrj4bjD0bEORLDCYEKCUgUoqE/koe1L6+pA
 8dADNI40eGAEJMNhGDRE6PPcEuIxd7iynSoV/ljrftthudOS7UIg79qNnJg2SRqWCt
 vXcFiPxrmu1J8EWt2fioReBqhap1rsHuiSQ3j+vHq/C+1qyRihUVZhnNS0naMIo+V2
 ac0VpZFfMqpDd0oOCuNPL4fE4FQxTl/w5bFxYMXufmqIqAZNwBhmhX3C5zsnFMuXyn
 vkOe6gZWwA+/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wu Zheng <wu.zheng@intel.com>, Ye Jinhe <jinhe.ye@intel.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, axboe@fb.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 38/41] nvme-pci: add the IGNORE_DEV_SUBNQN quirk
 for Intel P4500/P4600 SSDs
Date: Thu,  3 Feb 2022 15:32:42 -0500
Message-Id: <20220203203245.3007-38-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203203245.3007-1-sashal@kernel.org>
References: <20220203203245.3007-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_123412_514719_D856583B 
X-CRM114-Status: GOOD (  13.81  )
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
index 149ecf73df384..b925a5f4afc3a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3300,7 +3300,8 @@ static const struct pci_device_id nvme_id_table[] = {
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


