Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E89C54756
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 21:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a1Skc3BKYKY4vZQvCPtT4wkMPH/Qtgh0Jp8CJh2opIo=; b=UXGxjv1QhLdLfCXmelw8AR619F
	NaK1Asz4s5cwuibXuoCAu47eaWsnIGyRdU+eNyisN9oPS+edZ9VSEjObhCxcgSBLH/iKWZ+POGjgs
	TJlZSWVUStkln1tJte/3nrO0YUJmfVNAJI2VLVqzVr+1O0+Z2Gmpwhb9KL144CB7w/tMvHR85erk0
	oek9vovP3Y2JeAchPEcEkHzI4wSZTqhNCL8BEWN1orE4WbFSJLuP+Nm5TjjBHkTQjw7DqkRRs76aL
	qwNeFL5uBMd8pa7KpPqXekjO8w9ktpKknEQB1eOlLUlGMPJI6mQMPa4Akkh2Jr3oUaBvV7yBYG1V4
	3iyb2i5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH86N-0000000AZ9Y-1loH;
	Mon, 19 May 2025 21:32:51 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH7wj-0000000AWHd-0nx6
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 21:22:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9EBCF629D1;
	Mon, 19 May 2025 21:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C74C4CEE9;
	Mon, 19 May 2025 21:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689772;
	bh=OdAFbaqqvqqn0JoN+30LNaAJcQ6twsERV993d5E2HwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWnBFA8jtTCdFTrnFRY0ewz5HeEc7XmpAyi1lDl+u4nPLYFQwET4tvfpyLwsRoDKN
	 GOWdKIQDYx8vP4I9JMYmANxxCsvCyZ0HiumjB0i5r23EvaemjENHemHJK7VhlFJNM0
	 Dp4O8hF0C6E/+vXPKvfc1rRcAJuhqS9bEZVROPntBUbCss5M3OMl+rf1SFoHJfk2aj
	 +ldMkggWVMIIvPWz2tFx2a98XaTXPI0gxU2N8m6WQxE/caaVqF1WVOpy8UmXcGFXFv
	 7F+SDXL+Nre+oit7k1xJDrLLssbE/hO3CfiMdc2H4m7Zyiz4mWAVRaiMqALv6I8GOj
	 4PIbPJMIMYy5g==
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
Subject: [PATCH AUTOSEL 6.6 09/11] nvme-pci: add NVME_QUIRK_NO_DEEPEST_PS quirk for SOLIDIGM P44 Pro
Date: Mon, 19 May 2025 17:22:35 -0400
Message-Id: <20250519212237.1986368-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212237.1986368-1-sashal@kernel.org>
References: <20250519212237.1986368-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.91
Content-Transfer-Encoding: 8bit
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
index fdde38903ebcd..3773230c09d4f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3533,6 +3533,8 @@ static const struct pci_device_id nvme_id_table[] = {
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


