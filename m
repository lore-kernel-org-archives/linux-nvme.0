Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC304C77B7E
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 19:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ubyJ3OujDmLQ+svnakMHj6tu0cYgoC7BB5MXcZ3Xx1k=; b=zcc72r7zp6OyBio7QPR0WbXA4l
	BDiOuBTV0w0zQkgsDKk2rt4+0jY26ds3fdo40YfXEYpExq4c/h2eeXPkf6qpb9bu841EQl0aqOz9v
	5bibRLWCFuw667YsBiazzd3ScO9PZx1WvcHIN9bYNNdoCdephmQOLjwP5xElOCekAr1kMJ9DojIT6
	PN5DHPnWE4Y5TkZJ8kHBiwPtIaEwcVeqprCD6s4TpgBrUyBb3L2AGx8eWhkhDMb7Bml8eBTksJZSb
	N7Fy3ZAGpREdkh9d2Fo+UXsdXFlfpMwalvx4jfdbIn+7SZpsU/SUQUE08PoToCTbi+LhZAGk+22w9
	FXkSnQfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Gyj-0001Q2-3C;
	Thu, 25 May 2023 19:50:29 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FrW-00HRWs-18
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 18:38:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id F113F64948;
	Thu, 25 May 2023 18:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97298C433EF;
	Thu, 25 May 2023 18:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685039937;
	bh=kZTG3ob6lvK4ed6LIxJODwypGdMd3TUKZh3hvud4Soc=;
	h=From:To:Cc:Subject:Date:From;
	b=CP5QOmVDDZIFhKTjwqKaZqX7iJLCMhmyR9u2f5KS9YqtxBBQQpqCKFYKjhRchPQSH
	 TWuKDqR4J+DR6AcyT6HmA13j71BrkPl7BsLvaFA9eo7JHc8qBy8N8wsrv22rmz3CpB
	 HGB7GbogbSWoJTdLbr3b2uVfiGC4UCLP5XOA/BjXkL6nNKiF/L15YX9Tu0HR8mIUPa
	 T/JtfqrU5ife+Dzg/2mf3EeGf2ZTVsiKcw93kGqunFq2wRTaqbs2RoYvT9tEbpje/k
	 FsRPJoHtBwHIvfBD05sZFkBb8wf8hYt7k425xeD8LsFs/lba5aTm3ovTpmno6SgNx7
	 D1TmD7giOBIVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Andrey God <andreygod83@protonmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 01/43] nvme-pci: add NVME_QUIRK_BOGUS_NID for HS-SSD-FUTURE 2048G
Date: Thu, 25 May 2023 14:38:12 -0400
Message-Id: <20230525183854.1855431-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_113858_429001_E74C72C6 
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
index c3acef6c32917..bfb9ddec9f887 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3403,6 +3403,8 @@ static const struct pci_device_id nvme_id_table[] = {
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


