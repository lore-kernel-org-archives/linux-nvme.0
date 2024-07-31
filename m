Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B37C3DA7F
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jul 2024 23:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n+pOWS3wcUAX9NgewrwA4VLYDkN2ln1b86w+bGL6THA=; b=FDW/P0EYcoosVQjg9od6dPSgyg
	JkUJsxkBklLARTlh0qF86JTYqMEKuO3pR3RiO7jtFIMUIU6xfaJUUsAD+lSKJUGjxOKZKkRJPogmy
	8j3Wo+Hr0DvVJ7JMuGryMu2kR4IwpLi+5N8YO8o+ePmY2KVy+O8TXRWoX+kHYz7CjH1owPsqxeFNt
	xPr69Oie+PMFIn+AdKOhmOPoYMg7XzX4vFiSMlgZ/RaujExuo5do8YzvJtoffSF4T0q7JaSRZLhnU
	OH8634Tr02Mm4Y/hCaIitIrZlblOtf0+kLZ3J3K6/S6XwpvJQQf/53bjC2dJN8n29lJ4DjZdfjDuf
	rqTyYWtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJBQ-00000002r4L-0ZTf;
	Wed, 31 Jul 2024 23:56:40 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJBM-00000002r1Z-0BDl
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jul 2024 23:56:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 55DACCE1836;
	Wed, 31 Jul 2024 23:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9143EC4AF0C;
	Wed, 31 Jul 2024 23:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470193;
	bh=8roy8Xw2jj/VUUAXDLqEtyfSX75T55OU+WbOye7wrto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aOJyIKTQMvuUvlg5Y6+P1amhoJ4O6lBK3C+xy6c5g3TNR6pNW5apfDzplFtLYI7Tz
	 g/hubAajM0yEHS+5VN+9JovrHu9OzrcfJiRtHEervYSRmsi+2EoAohxQWkw5kpeR1Q
	 uRWYE4jjyA6KWcIA/y6B21ypT30c1/zs5V4sJNk3o4pEqOLxHWIGQi3s+DoC/+Dl34
	 secGByXQZ9GbiY9wNKSPwloXUDSQoU8W1si4tx43EAyMd3f2JKaDH/bQz91n+yZnVG
	 Cig65bEQT2EaM4fHQZihq54dQX+VWghPtl6iuMoUD7xFgREE+0xrc/h+/Oz0ii2bWE
	 YXGondBW7apew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: WangYuli <wangyuli@uniontech.com>,
	hmy <huanglin@uniontech.com>,
	Wentao Guan <guanwentao@uniontech.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 2/2] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Wed, 31 Jul 2024 19:56:28 -0400
Message-ID: <20240731235629.3929769-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731235629.3929769-1-sashal@kernel.org>
References: <20240731235629.3929769-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_165636_514588_61081684 
X-CRM114-Status: GOOD (  11.54  )
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

From: WangYuli <wangyuli@uniontech.com>

[ Upstream commit ab091ec536cb7b271983c0c063b17f62f3591583 ]

There is a hardware power-saving problem with the Lenovo N60z
board. When turn it on and leave it for 10 hours, there is a
20% chance that a nvme disk will not wake up until reboot.

Link: https://lore.kernel.org/all/2B5581C46AC6E335+9c7a81f1-05fb-4fd0-9fbb-108757c21628@uniontech.com
Signed-off-by: hmy <huanglin@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 163497ef48fd7..a243c066d9234 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2481,6 +2481,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 			return NVME_QUIRK_NO_APST;
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
2.43.0


