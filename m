Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C71AC3DA64
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jul 2024 07:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9EO1RFJDGcnIAR5Bo4ooG8eDw8kX1FYWcxx8vjYm5wk=; b=1JN6eM5XGsisxfvB72dttc0y/X
	DVBQTuj7GR/+D6uQohRCBDRu5YZYaUjhV89BU8lf/GoWqoI2UapVzsRFtjq0Dt79IPcR1RhHUMvuk
	C3UBe/vSqeyemnbfkJevMLS5Jmx9tWOD1rxIXYydNJv9ep9UqtkHrDi5gNJ/JMSBKVdyGHA/sL6bc
	e75veKIbs9iRjWD63N3fUvHOO1xw76JvjwT/nemRHkTWi1SB7b2t3si0QiU76PlxTd8XjHac3MxGX
	ahtNn7lK0C/BW4UH5vSHt2sT/LCtiVdEFF5dsbhj9NUL//O+m+dTBC+kCOvUBjV021f0rVdrcqoqK
	FaF8V7pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ3cu-000000006DZ-2nSF;
	Wed, 31 Jul 2024 07:20:00 +0000
Received: from smtpbgsg1.qq.com ([54.254.200.92])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ3cr-000000006BF-1rBl
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jul 2024 07:19:59 +0000
X-QQ-mid: bizesmtpsz5t1722410311try9sf4
X-QQ-Originating-IP: C5w+M+Kj2iBjfhCctdGi3rxO6aiEPtaKJp8lEDpKgyA=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 31 Jul 2024 15:18:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14924432582986564659
From: WangYuli <wangyuli@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: keith.busch@intel.com,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xuerpeng@uniontech.com,
	WangYuli <wangyuli@uniontech.com>,
	hmy <huanglin@uniontech.com>,
	Wentao Guan <guanwentao@uniontech.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 5.15+] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Wed, 31 Jul 2024 15:18:27 +0800
Message-ID: <722C75CD96F242C0+20240731071827.112255-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_001957_856046_5C654457 
X-CRM114-Status: GOOD (  10.55  )
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

commit ab091ec536cb7b271983c0c063b17f62f3591583 upstream

There is a hardware power-saving problem with the Lenovo N60z
board. When turn it on and leave it for 10 hours, there is a
20% chance that a nvme disk will not wake up until reboot.

Link: https://lore.kernel.org/all/2B5581C46AC6E335+9c7a81f1-05fb-4fd0-9fbb-108757c21628@uniontech.com
Signed-off-by: hmy <huanglin@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5a3ba7e39054..d73b8eb76b8f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2968,6 +2968,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
 	}
 
+	/*
+	 * NVMe SSD drops off the PCIe bus after system idle
+	 * for 10 hours on a Lenovo N60z board.
+	 */
+	if (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6"))
+		return NVME_QUIRK_NO_APST;
+
 	return 0;
 }
 
-- 
2.43.4


