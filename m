Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32541C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jun 2022 02:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x/MtmQDcWTko03E7oa/UXmHw1J1wfUjJT+qxAqJ1wr0=; b=N4c8r90Nyn0YgBAFRr3xGc4+LN
	BZjE6oAWEmv5c8b8DwY6ipFEIDJnvXFGoSE6/vYj8eyUs7ZorSBlQm5HWiABBPaptirK4YIQ9NJ0j
	JIvjVwT5zFEZoqvQSGmEJaVLB3Tc1DgXSMBCXhh5ue+lsOx6UhY1HTeqX/Alo/Y4d3pKrAUgu9kMf
	d983pC/3tbIxmd85J3K3RX9gSV8r6492smMHfJsv87WVCWeQHhQusAUT+vBECFX9r8NKbO9vdu9Nx
	ou3VOLQfa0ypvZf2L1DSY9NEjKgiIIhaQXCN9/tEYHAF659e/zthqFXct2Nf2Dw+YTKy0xqTVivD5
	cHblp8Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o60y2-003jvG-Oz; Tue, 28 Jun 2022 02:28:42 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o60sA-003gSr-Dn
	for linux-nvme@lists.infradead.org; Tue, 28 Jun 2022 02:22:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E95CB617D2;
	Tue, 28 Jun 2022 02:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ACAC341CD;
	Tue, 28 Jun 2022 02:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1656382957;
	bh=yH1up8tKSedcQtZ55q2RFNHgxh9aMD9iPVtn439Iq7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZiZjampbvYDvpRee/hzBgJLbbTeYBvYjVADFN7mfpzVq8XGqoJUVVOmPJMaUbiN5c
	 AdS5k191tqGv7c8iKtrZEsNH8I9hUqLsItJJaRWwiywbmmCXwcZGX39h7SBwD6Qx/a
	 MghifMXQh0hYEXZIKwCayhHvKmLm7QbhTdh6vbACvI7Q3r4G8G+kmm/PebvPEAdh/Y
	 aCrL40e0vw3tLAVymppDb3TpGmG7zB+4Z3dt3jXtVywIwNMCyHtWqWuS316mW8tVFf
	 DQcfxHV/VeoNP0EZ52qS+yQYFU9PyBfg1G9JzgemInPPmYcmf/TejyyOam9oRUPijK
	 0Z84PHPIZu13A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leo Savernik <l.savernik@aon.at>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 39/41] nvme: add a bogus subsystem NQN quirk for Micron MTFDKBA2T0TFH
Date: Mon, 27 Jun 2022 22:20:58 -0400
Message-Id: <20220628022100.595243-39-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628022100.595243-1-sashal@kernel.org>
References: <20220628022100.595243-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_192238_572217_D2868FCF 
X-CRM114-Status: GOOD (  13.44  )
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

From: Leo Savernik <l.savernik@aon.at>

[ Upstream commit 41f38043f884c66af4114a7109cf540d6222f450 ]

The Micron MTFDKBA2T0TFH device reports the same subsysem NQN for
all devices.  Add a quick to ignore it.

Signed-off-by: Leo Savernik <l.savernik@aon.at>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3ddd24a42043..ce56016b44dd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3346,6 +3346,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	 { PCI_DEVICE(0x1344, 0x5407), /* Micron Technology Inc NVMe SSD */
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN },
 	{ PCI_DEVICE(0x1c5c, 0x1504),   /* SK Hynix PC400 */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
-- 
2.35.1


