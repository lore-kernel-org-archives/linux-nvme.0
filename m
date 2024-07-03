Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17CEC2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 20:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=m8s1/6VXGyWQdDgcsz54E34xEKNOwQvyxLhv42c54qA=; b=L/HayfLHmVV2m1gHfr3wEz+XFH
	Zlw9L+ItS6znFC55gObhR5ARNV9P04BqQ4XnCmZKhvHocyysRq4ow5sVQ1kvMqAKC32iCSpk9TTvR
	7Uop5B/Mfk35jepqKn5BcMatmmWuICRLnYLdmL/0HzMLqiW6tw88vS7Rb9/iwodJ0z0vmMvXxjJBa
	opcn5IH4/NOe6QvmD7ogPIUBb0aEIY3kBg6znvMROSOFJ494kRos0YsgGIwwirwJ6mAvAk5beDlz+
	0CjgqM0VeQDSsHnJFa/vBkEAFlXPW+ujjCN0SxK8VjZ8Nb4g5mCmoATvac084LyWjJDWLBxFKJ1Nt
	PNq4hptQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP6Cu-0000000BKj0-3Vkw;
	Wed, 03 Jul 2024 20:04:00 +0000
Received: from smtpbgau1.qq.com ([54.206.16.166])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP6Cq-0000000BKe6-3qtv
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 20:03:59 +0000
X-QQ-mid: bizesmtp80t1720036976t7hj17pi
X-QQ-Originating-IP: w7kLUGn3+OAwjLKXRoNA/5hdg2gjbxR4tC64VJOBRHM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Jul 2024 04:02:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9036598913565450035
From: WangYuli <wangyuli@uniontech.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	guanwentao@uniontech.com,
	huanglin@uniontech.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH v3] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Thu,  4 Jul 2024 04:02:50 +0800
Message-ID: <342CA313D86762A1+20240703200250.218225-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_130357_350563_9D43C231 
X-CRM114-Status: UNSURE (   9.66  )
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
board. When turn it on and leave it for 10 hours, there is a
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
2.43.4


