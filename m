Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3D9C369CB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 02:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UbigUt5KF6vtXvm6Rdds6/wGeynUAGYeuhwG5Sk2oq4=; b=DctdqVDInAm9o1I2P+1CniDtw7
	wePuBtMVV9qszkzhnEoM3DMNMkYqT2oAOEcxhRM7qlzZ7FznyOWa0OTstGZAxRs94bwUAf0weYahK
	ZEmninW+2sf4hAN9lr+GIXDULa2mqFIDd1XGJvMbPcMDmwCb+64ejnoTSt987NDWHp4tkziwfzQ+V
	wbbq1xh7SHC3qF6m8I4LpVWAhzCrLF0VJ3g6o4IXSRXYJPlT7jQ1B5imyyZMXvytl54KQiacwGRDO
	YFVKedytdc/BWtig7tKoZ1cqlLuefhsag5u9WYCS0/2jcrQzl7Y43Yj5esioI7WbcudpFaXt919ln
	BIcsEdUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7mY7-0000000Cd7W-40VC;
	Thu, 24 Apr 2025 02:42:51 +0000
Received: from smtpbg154.qq.com ([15.184.224.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7mY3-0000000Cd6v-06AR
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 02:42:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1745462502;
	bh=UbigUt5KF6vtXvm6Rdds6/wGeynUAGYeuhwG5Sk2oq4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=mWXSd5kJFIEnBsc9l34FezvD80G0YxzvpQaijlpCmt65Kqf0ysS1ciXke8SQ55TfR
	 skXMoQx7/oMq1B+4pj6KUuBWW4ld87fXPDZuf/EhNfBLzo9pNjQsvhHyHwAymVMfTi
	 NL4cs3s10FHMK/jSjqmFneu5ajLRmUwI2AmXZrx8=
X-QQ-mid: izesmtp83t1745462490t61fbef5e
X-QQ-Originating-IP: qd4J+Brc3gEv+XdEw9ds53FUz9UbATLTkRp8ND+qv6Q=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 24 Apr 2025 10:41:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15135516614704015789
EX-QQ-RecipientCnt: 12
From: Wentao Guan <guanwentao@uniontech.com>
To: kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	linux-kernel@vger.kernel.org,
	hedgehog-002@163.com,
	rugk+github@posteo.de,
	sean.anderson@linux.dev,
	wangyuli@uniontech.com,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	wentaoguan@vip.qq.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH] drivers/nvme: Add quirks for WDC Blue SN550 15b7:5009
Date: Thu, 24 Apr 2025 10:40:10 +0800
Message-Id: <20250424024010.308175-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: izesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NojR6Ao/DkED1phwD+1NzoJUorjo/29SwbVNxXdxoYfr1sU90zFegIYa
	erT0CKxF2OBKrbxoL2JGWFZmx0nS3ma0Ev7P43dXrTKxuamQzYWv6jwhpM3DTJ8KUM2Y7F9
	pZfl/BXdUUkFk6UtwDuG3KWx8auvYC2P6iNnuANOj5FmVua6zlsitf4oB3+DIw55l2+1gb9
	0xj7sFK9atuun4eUoLM9KnKrubmCM7GCSwftjxeQSB9mVRydbW0l1JzNxWrUpeltFwpXXLT
	+J6+DQf+GOvV/t1d0qH4G6jvR5+2uOhJO6OFT3Eb1e4+BdCV1LyVFI4Tmv7Egi+dAfJGhKk
	bar+eLTGRDZWtQlBv3z+QhMkIuAgvx6pk17nCE/l5VBK+g9YnSQIx56iav425q+wN+dfhx9
	VxTVLc6E1t0a2ZaUynHOREz7nUdw/62pjildDkwU+68vzU8G8gbrSfSooSrQeDxLTboSWMR
	t/W7x4s5NXkHkwjGg2aXvk86W3TNALYcZbpBfUtIFy3yDLuRKRops79kwEv4/RgKjt5ns+8
	bbL0m+zxlDQiq+sbU8goG0bWqs1REG4xRBVPk5/j0M+n4GO0OvTmvcbF+FzSmavhQFaS3R/
	DP/5XJNkRRQkXq5ezYiz9m+pOYNPYTR8WrgIPtnnmaAApvVTTIqWYmssvHYAdtx8zdKbJ14
	T/Ic2Y78eahilWflc5Mqn97W6JVJ0o+I9od7bYS0kqO3whphLT/+17WpBh28p81juUKjMvO
	ZP3J+ABDriuWMfiTwakhn75tuaRW34dCQz//CGAMwf9PXI1pfRX9w3AgW65D5XAql7TbQiu
	L5u3OnHeF+77cgDKe+c1oxx1Pp1Ay8cmVIK7vrL+uf0LknaQkeJUy18Mbv1IO9+rvl32Xhn
	tNyPAXMQDYUryGEgafptqICjMQHW6YSVSs5VGuup3iFVqhYKzaC3fjJZ/tkCgsJhmeFJ91X
	THQjzAJymVafDQk0+d8bhHk9JuvaXr9oLYjm9ROg8sprHyMVmS0Vm/RGkwHZksVyzhbQ0ch
	v9iDf88GAfOxqKaE/YX5ekK1cGBSRwHUWi0O18NFskGr0c9EEoln0UEG9RgXSQ2WUQk5Hal
	Q==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_194247_723716_5246A04B 
X-CRM114-Status: GOOD (  10.97  )
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

Add two quirks for the WDC Blue SN550 (PCI ID 15b7:5009) based on user
reports and hardware analysis:

NVME_QUIRK_NO_DEEPEST_PS:
liaozw talked to me the problem and solved with
nvme_core.default_ps_max_latency_us=0, so add the quirk.
I also found some reports in the following link.

NVME_QUIRK_BROKEN_MSI:
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
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8eee28282b1e9..b6153f595076b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3453,6 +3453,9 @@ static const struct pci_device_id nvme_id_table[] = {
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
2.20.1


