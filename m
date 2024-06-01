Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2660C25B76
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Jun 2024 09:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iZFH+34nJJZwuAUvFcw78Fm2IRQxd7dUJrTw9KF80QE=; b=IRXTaTt938pc5jWNDCxrnFGN5N
	d27YetKJfyFqRzG2nPPC8RI4zp7/LBsAuNjGWZWd/jz/35c9hDxGlipEzdDkU9iQ1BvmdQ/i0fTu/
	0nsL9AClsABooSklMv0Tojzq14YtacCFw85iuo9/UwHwW+OpdsNsHSw/i3khUqIZwSD/BhR3bcxOA
	CkdkFbw3VfOFAkt5zqm69pi+TG6PKMj0N0z696asDYj0MPoFKr6gNmXA1tnSDuL87VZ4aYeyn6s53
	vE6jvmkZNqeR2qifnCK9fteO+3kXCgnXQjhJyGgvAKe/GPtRyasvGfB/MZ3sG18Qzc1jNappc+LoC
	0hU14/KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDLGm-0000000CINq-47tV;
	Sat, 01 Jun 2024 09:43:24 +0000
Received: from smtpbgjp3.qq.com ([54.92.39.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDLGg-0000000CIMW-1seK
	for linux-nvme@lists.infradead.org;
	Sat, 01 Jun 2024 09:43:20 +0000
X-QQ-mid: bizesmtpip2t1717234916tdymemk
X-QQ-Originating-IP: gIy0LiGnTn3AK5EL3/Cf5tzlesxG0DekhLgc7FFD8Ec=
Received: from 192.168.5.25 ( [255.207.235.15])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 01 Jun 2024 17:41:54 +0800 (CST)
X-QQ-SSF: 01400000000000E0B000000A0000000
X-QQ-FEAT: bQsUcYFpAAYZgSaD1UReWU5dBtwmic1unPItvAt6mXUVEjD4YR4qZAM1DyCf6
	DMURWVXHAsEDKCj8ppWQlKDcrKWnrAkOU8fEqloyUnfO+nWAqbx584kbglKz+H8mfzeMSRx
	aqCbqe9OqvNxXh5EU3cAL/zFZGHppKbP153Toorc4EGs7ix059btDWeIN1364Xi+oIyuWBC
	ZU+ptyVxS6n9hruSFCfIPRY7AlYl1hKqvDbB70TcyKrzipGOx18JZGsiJJUzMHXZfp5xQS/
	TyipkdLmwtYvYbSX+ZEg0LvhE3ivOEJLLwDk/FpL344bXGeP5aIcoU+KkIkNgI88Y11nKxF
	kdyBhhUAXpoMirRFzq27sXTu2Si1ulnn3Oj3C16haxJdyhjWC9Zta0n7bI9vFC4/PbTjgoN
	5x3+Wgz3cbc=
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11862926628622183392
From: WangYuli <wangyuli@uniontech.com>
To: wangyuli@uniontech.com,
	guanwentao@uniontech.com,
	huanglin@uniontech.com,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Sat,  1 Jun 2024 17:41:43 +0800
Message-ID: <5CB69FDA62BB24AB+20240601094143.295718-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240601_024318_797505_A6465EA8 
X-CRM114-Status: UNSURE (   9.60  )
X-CRM114-Notice: Please train this message.
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

There is a hardware power-saving problem with the Lenovo N60z
board. When turn it on and leave it for 30 minutes, there is a
20% chance that a nvme disk will not wake up until reboot.

Signed-off-by: hmy <huanglin@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/nvme/host/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 282d808400c5..1e0991667453 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2903,6 +2903,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 			return NVME_QUIRK_SIMPLE_SUSPEND;
 	}
 
+	/*
+	 * NVMe SSD drops off the PCIe bus after system idle
+	 * for 30 minuites on a Lenovo N60z board.
+	 */
+	if (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6"))
+		return NVME_QUIRK_NO_APST;
+
 	return 0;
 }
 
-- 
2.45.1


