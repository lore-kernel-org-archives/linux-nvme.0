Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194FEC3ABBE
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 02:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bZ4bMOjGv7D6sd3L23coGmIDLYiyBaPyoQHsznA7gVc=; b=NWDoGVBU1y39LLWG+tD/H3rXCL
	3bWV7YYrs7egTmvomY4/tcFFrGJnMTEnJ6ur2+6g8WQw+KaHLLYEpkHgPLQ05kemEoCcQvpFGE27s
	8CZhU02hhWB0fX66ZG+9ZNxVg9EE87HwAZysac0WdiD++TtOgJfjw1BZfSOw4S1a48a8kae+VC0o3
	wRBtFLNxg6bYNloRTisZ2S6Nu3BHbF25OxWwV97f93dD4jhQ3yn/zCFxdzSjQKlbmQNfu432/2DX+
	LSHxLj/f8R2DUNZhIpWcZAc6al2TapXy7bymMcXhSLjD9e2J8ax4yI5y21h777f2P7KFEP/WoF+Jw
	+2xDfrHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCUc3-0000000Dx16-06k7;
	Wed, 07 May 2025 02:34:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCPxB-0000000DR7a-0UIz
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 21:35:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 84421629DB;
	Tue,  6 May 2025 21:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC31C4CEEF;
	Tue,  6 May 2025 21:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746567352;
	bh=9OPaPp9DstA0XlNR57+xYgmnCq8Lh8YQouDfZ8UmP9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oS6Fb5LuTqeKTFYFPiFyKCPqHa2tXVqwBz5GfYra3k9YBm9xr4R9uw7gOqDFqMCiZ
	 Z8BPxbp1GjV3LdXJhIv2sByH4H7+Z1TmX1rtE6dbcZz/QmKkIbyIfAwTMFvxXj+qRc
	 7CyF952y36nE1pDbb6pnukxA6tKzvzRvdrtg+pDbDZAvztXqpUb/obkzKHGfDcT1GB
	 qExsA+oIPwCK2k1B4LVjyzR7mdKfTIIEVnGjBbABQHANbCIcDoktH/AOmuoTRfOwja
	 Vgm18C8k3tN/L+nNMm4exB5sQtV8gLvUkp5Mbb2EaRtTvs4msHIQA5tDnOEnsWNq1p
	 RUCIRWTQsfN7A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Wentao Guan <guanwentao@uniontech.com>,
	liaozw <hedgehog-002@163.com>,
	rugk <rugk+github@posteo.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 13/20] nvme-pci: add quirks for WDC Blue SN550 15b7:5009
Date: Tue,  6 May 2025 17:35:16 -0400
Message-Id: <20250506213523.2982756-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506213523.2982756-1-sashal@kernel.org>
References: <20250506213523.2982756-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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

From: Wentao Guan <guanwentao@uniontech.com>

[ Upstream commit ab35ad950d439ec3409509835d229b3d93d3c7f9 ]

Add two quirks for the WDC Blue SN550 (PCI ID 15b7:5009) based on user
reports and hardware analysis:

 - NVME_QUIRK_NO_DEEPEST_PS:
	liaozw talked to me the problem and solved with
	nvme_core.default_ps_max_latency_us=0, so add the quirk.
	I also found some reports in the following link.

 - NVME_QUIRK_BROKEN_MSI:
	after get the lspci from Jack Rio.
	I think that the disk also have NVME_QUIRK_BROKEN_MSI.
	described in commit d5887dc6b6c0 ("nvme-pci: Add quirk for broken MSIs")
	as sean said in link which match the MSI 1/32 and MSI-X 17.

Log:
lspci -nn | grep -i memory
03:00.0 Non-Volatile memory controller [0108]: Sandisk Corp SanDisk Ultra 3D / WD PC SN530, IX SN530, Blue SN550 NVMe SSD (DRAM-less) [15b7:5009] (rev 01)
lspci -v -d 15b7:5009
03:00.0 Non-Volatile memory controller: Sandisk Corp SanDisk Ultra 3D / WD PC SN530, IX SN530, Blue SN550 NVMe SSD (DRAM-less) (rev 01) (prog-if 02 [NVM Express])
        Subsystem: Sandisk Corp WD Blue SN550 NVMe SSD
        Flags: bus master, fast devsel, latency 0, IRQ 35, IOMMU group 10
        Memory at fe800000 (64-bit, non-prefetchable) [size=16K]
        Memory at fe804000 (64-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 3
        Capabilities: [90] MSI: Enable- Count=1/32 Maskable- 64bit+
        Capabilities: [b0] MSI-X: Enable+ Count=17 Masked-
        Capabilities: [c0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [150] Device Serial Number 00-00-00-00-00-00-00-00
        Capabilities: [1b8] Latency Tolerance Reporting
        Capabilities: [300] Secondary PCI Express
        Capabilities: [900] L1 PM Substates
        Kernel driver in use: nvme
dmesg | grep nvme
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.12.20-amd64-desktop-rolling root=UUID= ro splash quiet nvme_core.default_ps_max_latency_us=0 DEEPIN_GFXMODE=
[    0.059301] Kernel command line: BOOT_IMAGE=/vmlinuz-6.12.20-amd64-desktop-rolling root=UUID= ro splash quiet nvme_core.default_ps_max_latency_us=0 DEEPIN_GFXMODE=
[    0.542430] nvme nvme0: pci function 0000:03:00.0
[    0.560426] nvme nvme0: allocated 32 MiB host memory buffer.
[    0.562491] nvme nvme0: 16/0/0 default/read/poll queues
[    0.567764]  nvme0n1: p1 p2 p3 p4 p5 p6 p7 p8 p9
[    6.388726] EXT4-fs (nvme0n1p7): mounted filesystem ro with ordered data mode. Quota mode: none.
[    6.893421] EXT4-fs (nvme0n1p7): re-mounted r/w. Quota mode: none.
[    7.125419] Adding 16777212k swap on /dev/nvme0n1p8.  Priority:-2 extents:1 across:16777212k SS
[    7.157588] EXT4-fs (nvme0n1p6): mounted filesystem r/w with ordered data mode. Quota mode: none.
[    7.165021] EXT4-fs (nvme0n1p9): mounted filesystem r/w with ordered data mode. Quota mode: none.
[    8.036932] nvme nvme0: using unchecked data buffer
[    8.096023] block nvme0n1: No UUID available providing old NGUID

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5887dc6b6c054d0da3cd053afc15b7be1f45ff6
Link: https://lore.kernel.org/all/20240422162822.3539156-1-sean.anderson@linux.dev/
Reported-by: liaozw <hedgehog-002@163.com>
Closes: https://bbs.deepin.org.cn/post/286300
Reported-by: rugk <rugk+github@posteo.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=208123
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d4d109df3c84d..5b0ad7787be6f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3652,6 +3652,9 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x15b7, 0x5008),   /* Sandisk SN530 */
 		.driver_data = NVME_QUIRK_BROKEN_MSI },
+	{ PCI_DEVICE(0x15b7, 0x5009),   /* Sandisk SN550 */
+		.driver_data = NVME_QUIRK_BROKEN_MSI |
+				NVME_QUIRK_NO_DEEPEST_PS },
 	{ PCI_DEVICE(0x1987, 0x5012),	/* Phison E12 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
-- 
2.39.5


