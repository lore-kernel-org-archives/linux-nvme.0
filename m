Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91ECC2D0CD
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 21:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gPHjz+zeXUdVZkG47y117OjFBwFNEdWMbqhb1DZwVEg=; b=THi0YL78LO5ORXDq0bDWnCwhwj
	/0NZ3EcLlCO0tPXwiDHA4piPvKQanKo9S7ucgE+X/0p774dnQ25RNN6EX1nJBLq7tk/uGteu1sMCj
	OHHocRr8/KCaEgMn+8HNHHEYW1VyP/579Q9ajQvpov2OKnPjd8fg2xtYOlXBe16vJBZyY744lVb+1
	dbOSQL6q8x71BWL07DuSh97RL/o9uMYKWWqFuXQDGYSkBJgk6dHwmi4TBJkCJS10/Y2zXAbX10QzM
	ZfIAit6s2PIMN00T4l2a1PT8xD+YImR4g/KkdfnMP4O7m8sungxvAWMj+MH2bbv6ylY1kYMB7hBgC
	TapAue5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH84G-0000000AYXs-37hP;
	Mon, 19 May 2025 21:30:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH7wM-0000000AW6S-13ih
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 21:22:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8E4D75C4C29;
	Mon, 19 May 2025 21:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC38C4CEEB;
	Mon, 19 May 2025 21:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689749;
	bh=dZyFCARnSEGITE3TmTBboOfTWmLSUHWZzVwCmlaSCtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SvjeLzJP3aWKeDlXuAWmUqslDIhvvJHiTwyxFBD1M85vkRNjHYNTNmWM2Qb5ZtZGe
	 hZE9we+CE09WabmH/Yvm8PSzD9CdHznoXnqQ/FwT+9ABSbmKuqXRCp8e9DdjA2pMaw
	 hfKOW68ql5DsOj1VtnRTeppW/RkT9Y5FJhmgVkb4X9WFpXo1krZ6NvthUFFtFEoLhS
	 Jf0ChaRY39z+q+zn91kSN9q8x/UMm3ZMDrlsmeTo9xxw7yI2DIzklXShtPDHDJQJqr
	 YvygkADgc4vwkaptklumyVOUaOwVNuWhYNc5yuuqe1REx6S+r22SIdMXrR/RAdVHX1
	 A5jWh2o3qCdfg==
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
Subject: [PATCH AUTOSEL 6.12 13/18] nvme-pci: add NVME_QUIRK_NO_DEEPEST_PS quirk for SOLIDIGM P44 Pro
Date: Mon, 19 May 2025 17:22:02 -0400
Message-Id: <20250519212208.1986028-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212208.1986028-1-sashal@kernel.org>
References: <20250519212208.1986028-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.29
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_142230_335372_265EFC96 
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
index 83ee433b69415..8fc9a7e38daba 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3693,6 +3693,8 @@ static const struct pci_device_id nvme_id_table[] = {
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


