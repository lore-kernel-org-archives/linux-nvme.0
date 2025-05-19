Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D20C2D0CD
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 21:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5aiorvOoeqpnFH2rnmrpy29h1Ocn2hzpb8s6LwTI1Ko=; b=zGUn/IA5pmIS9ktIGvfQXhzS2W
	lWQG9+yBfBVDKdvrI8gNXnSXYtO3liSipwHj7PCw6atrMYIOpOWPU1dKHQKD4ZlNVZhvgmovTYlWS
	ABSSNSwswfrL48gjIc6DHWUth6vMUepqRwE/Ri18uwCddwxf2nF+2qNOKBIlFKtZx0jl/ikm+Ptg7
	0/Am98Hxk8gW5x/8wYIrXBFC6vHxjNjzEsbowIVkhtlIZBBvoG8F9GRzwg1QrFWMtzUyYhU/1y4JL
	4KBsBzy70uOMOOo2Rg5tI5oBqf8dxJ2UqUicQ059gXAQGSe/clfZ1VNwc4pKXWSBhkRCn3hegxB/r
	RlVxp+RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH88U-0000000AZr0-0nPh;
	Mon, 19 May 2025 21:35:02 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH7ww-0000000AWMs-1qYn
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 21:23:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BD5845C0ECD;
	Mon, 19 May 2025 21:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87240C4CEEB;
	Mon, 19 May 2025 21:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689785;
	bh=Cj3KGAKM5g24m22nJ6N3XMlJxhdPvcN6/6t+Z7L/ytE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kbxuIf2AQOE/wTWaOHHAGlIyzphAH2fs9+YzfrzLIc8Mi4kXlThQgNTWuLNLRvodU
	 ECkmVaJEWFiPyO/s1j091hvKwl/ccfMbSjynOI8/6SzPYVRCkgePwmHSpuXVEcKmco
	 lY4Xs/LIw+4Ags0dncij8iIgcPP/DX6G2u4oqojtdp+OuS6p/FtWpJBDf7q+zw4m7g
	 kgUR1NgTo/cLgIMHoOAJ6aM7FfMSbQJpErjaUPi5NhVS9Nrn55a0jLmVzTPsJgczBJ
	 P21IcZXoJEPvH1zU2nEs9yj+CzWUedARLh2JlRO/ErxnkHn+X7pHwVM0jsFOhmESCB
	 XK2uQ4zI414ag==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ilya Guterman <amfernusus@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 6/8] nvme-pci: add NVME_QUIRK_NO_DEEPEST_PS quirk for SOLIDIGM P44 Pro
Date: Mon, 19 May 2025 17:22:53 -0400
Message-Id: <20250519212255.1986527-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212255.1986527-1-sashal@kernel.org>
References: <20250519212255.1986527-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.139
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_142306_523385_088C241C 
X-CRM114-Status: GOOD (  11.40  )
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

From: Ilya Guterman <amfernusus@gmail.com>

[ Upstream commit e765bf89f42b5c82132a556b630affeb82b2a21f ]

This commit adds the NVME_QUIRK_NO_DEEPEST_PS quirk for device
[126f:2262], which belongs to device SOLIDIGM P44 Pro SSDPFKKW020X7

The device frequently have trouble exiting the deepest power state (5),
resulting in the entire disk being unresponsive.

Verified by setting nvme_core.default_ps_max_latency_us=10000 and
observing the expected behavior.

Signed-off-by: Ilya Guterman <amfernusus@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index da858463b2557..8e3283e0f0ae9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3590,6 +3590,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x025e, 0xf1ac),   /* SOLIDIGM  P44 pro SSDPFKKW020X7  */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1d97, 0x2263), /* Lexar NM610 */
-- 
2.39.5


