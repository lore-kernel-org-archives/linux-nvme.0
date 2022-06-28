Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AC1C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jun 2022 02:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pwY6DOGV6Nq7q+wKJ3X3sLB5bbVJ/CfIVP/jmGloYBA=; b=lkxd5yj/g/AyXEKnimsLDnxe8t
	eB+HljR2IBIGfvgo6N94QcQMHSycj2FPxuSTEeD1Bj9NdJR0hKi/qLIJ+0x0tgEzsZqFe7/kCi0y+
	arAE230sveksmpveIo6cKHQJgfEkCIklvfZAl1euFt8Rjn2ygBKunnT2szZARLQz4sUDhtlGllEO6
	uqXqKwljxBCBxwKoldWdm9IBT3jezV0JCf2lJ9mHjTWWdWIPjguYd9hcrNEF1H3zq3Ef2rBid3uf7
	yZ3kXTxHW5ONM/wSisIuj2t9jlOgYAtuH+DqRh7501eUstpBJNdgPKsT0u73JlrwmFeMjsRjfzNmN
	5gu5Ar1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o612i-003mLM-NL; Tue, 28 Jun 2022 02:33:32 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o60te-003hPE-Fk
	for linux-nvme@lists.infradead.org; Tue, 28 Jun 2022 02:24:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 07BF3617D2;
	Tue, 28 Jun 2022 02:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643D6C341CB;
	Tue, 28 Jun 2022 02:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1656383049;
	bh=D44htnJaiYdon4tmSA7xAnY9arGM/evfbimFtieYM38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tdj+IqZnehFZDIjmLVak1Mj2+e0ORZ40Z0W9B8HfnPDJbzj3OGQ5uvyK0xbNcIOVA
	 GkN7KYUrdHWwn52GcGS3p1g771cb+0iNDIJIAzP4irsOEWy/yYsl5QX3rmSqJaQDQZ
	 nAf6vsCXhNtu2vHYD6Ty7zc6j3OzUgDTcJhwxAf7vMMnBuGKaBDpZJNeqrYtgQSJUo
	 uQjCpWRrO5DnjvOHBuOqU1znZklM4dag7cQS/TAljJm/dcjLEwb0FxPRjChmbITXRF
	 1VVfvKha+pTJLG6AxzlBAJCtyf51K2kWghnPjQRiYyW4mdL86QogLmzCCF34OtdZ5g
	 3gRy2Z+SO2FCg==
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
Subject: [PATCH AUTOSEL 5.10 32/34] nvme: add a bogus subsystem NQN quirk for Micron MTFDKBA2T0TFH
Date: Mon, 27 Jun 2022 22:22:39 -0400
Message-Id: <20220628022241.595835-32-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628022241.595835-1-sashal@kernel.org>
References: <20220628022241.595835-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_192410_622655_4A43A9F5 
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
index 7de24a10dd92..a5b32f60b0e6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3250,6 +3250,8 @@ static const struct pci_device_id nvme_id_table[] = {
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


