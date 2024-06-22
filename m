Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26954C27C53
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Jun 2024 04:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7HLbVa77QHLOazpzfxFfyMmEEfraG3+69KCW5x7jB+E=; b=LKJIS8otEoOkNP4YsjzyrRn4xL
	cFn66rE1krrvPz4D/IUmFIlTkWzvpF32o1WZpMby+5neVaUuYa8nNJLuSVVcV8M3xK3F68oDBRUJK
	snI6Ud3VTpGSEIDLMOp4Z+HYxTvcLVOrl9bYutwM7f4keb7mNOmE+Bo7KnWB2wSSDMcK9j+nGhTuh
	0aT86A0hLo22wDy41Gih+wnCy320lCkxnfgbL2c0fz8nHlih+Ng3DPiYUvrKfQWXvgGMK7nF2KEe1
	h1yZkJe4K11stZe+XmV3ydQG0vkgkyKgE3BestXU6XoIjvLUE8jf2wo99koSdLyD6mMkNgaAl7WKR
	JSVtuQFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKsHe-0000000BLey-1qpX;
	Sat, 22 Jun 2024 04:23:26 +0000
Received: from smtpbgsg1.qq.com ([54.254.200.92])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKsHb-0000000BLcn-0I04
	for linux-nvme@lists.infradead.org;
	Sat, 22 Jun 2024 04:23:25 +0000
X-QQ-mid: bizesmtpip1t1719030084tfaiozm
X-QQ-Originating-IP: PRuQglMkaNNVScql+O3EOQIRXjh5zzF4aXn6jiA2KD8=
Received: from 192.168.5.25 ( [255.167.206.11])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 22 Jun 2024 12:21:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6017219967189827787
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
Subject: [RESEND. PATCH] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Sat, 22 Jun 2024 12:21:08 +0800
Message-ID: <AFD9EEAB191702D0+20240622042108.10427-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240621_212323_497575_ED07191D 
X-CRM114-Status: UNSURE (   8.95  )
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
2.45.2


