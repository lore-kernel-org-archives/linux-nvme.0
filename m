Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC9AC7EE33
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 18:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BEHstlP+GYSiQo6u+C544ik+B9dWHRnVYComErvDVbc=; b=kJaxhizmO7/tplNQfGSnZ08ClP
	Dn2P2YRzNe6DXe8aRx8Xgtlr56XtPfXRJAze7V+oWAsElCNq31jloJjM1OT5eZnrqlNm8P7nqsgi9
	1HvD14bYUGOdoxKJl3zaVHic8hjN+DxEgbPICb2sj+LVX9lB4o0uHwfB3qmgNcOKTogppMStlH+eX
	XhhNt1foGWyB/ziRQiXr+eBPTYQ9jVbu05XbRFQhm0mNru6vFAxGwN5pLKJSE84jpRmOK5Bolimh8
	kDZtAijPKLdgSzya5IlUTMqUM91Xo/3DieD3K4FCpn2tmwCVYfGJHdnRxutZ5v0P70Mj24W7fcY/y
	6DhpypGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Fos-00HQZ7-2o;
	Thu, 25 May 2023 18:36:14 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Fop-00HQXI-2M
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 18:36:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4F8B5648FD;
	Thu, 25 May 2023 18:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF49C433EF;
	Thu, 25 May 2023 18:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685039770;
	bh=D5ZUEJh3RhvRR1pWSaBjXg7F0+fGT3wtks2GuZmrgoE=;
	h=From:To:Cc:Subject:Date:From;
	b=WUGTb3XFdqn8tgu49UTiQDWS3vR6xP6gM5lQsMcHlgJZM8qEBhmKpUapXsAsSF/QE
	 TriEIi1aqxERnI5oY9n6Xo8aScX2zFcJTKbFZAkM1btzJPkaXFPPZpl/Nex0v2Lees
	 BPSpuaU98WNUvZUHwj2UJFpaZZ6RSdcPwp149MoZAdMZvfhNMyKLkVhKEeTcpdEs/s
	 0uYCA72Hul2cumh38cUAsaYokCVzTaDlVljjZ3UIAX9l98JSObHnkR/p/PimzRa1pJ
	 2Uo/9LmwbxPN5OLgvm4ppMJbUpMGNOLu3EgrL2k6vQdyWP+i1+bU1ACwWj6sfV3Gd2
	 LLwWNqQXE3x/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Andrey God <andreygod83@protonmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 01/57] nvme-pci: add NVME_QUIRK_BOGUS_NID for HS-SSD-FUTURE 2048G
Date: Thu, 25 May 2023 14:35:11 -0400
Message-Id: <20230525183607.1793983-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_113611_806158_D4C9F9F9 
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
index 581bf94416e6d..3347e86b3c55f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3554,6 +3554,8 @@ static const struct pci_device_id nvme_id_table[] = {
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


