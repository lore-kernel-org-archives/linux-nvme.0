Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C671C3DA7F
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jul 2024 23:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HfRNQn4QU6LlQW+HVSP0MBKB2j72K6Kgs08Q6cSAnbo=; b=sLyciqDSn6aXYp/vnVYstMIjB0
	be1VLHzEp0hoOeh+e2UsvBxgNmdB22QGPvCfMBd5HM4N7ArGzuCzUQSoboIWkxuxpD2Vawa5b/qGw
	xCOeR0ghpK+7Pt0XZZG1mclHyVoh4wQCnyJg9xsF6RXJ8jUAh/yUopNR37k81glOOvX0JnkOkB4tQ
	K+Lt1zwbyjOIV3i5TNafW4F0jzASc1EgONo8bn6VBB9pa4yVyyQbzh/NfQ3IlYb/K5PmNyxroo8Ds
	lyYAe47wWKe6wOgx8Vtkzx/VKxOF+9GoK2HzrPTDTfLL7zRQ4qfrdTPiZaMkQdN5EI51uhGRof4LV
	5AqeA65A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJB8-00000002qru-0nMP;
	Wed, 31 Jul 2024 23:56:22 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJB5-00000002qq9-3DIk
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jul 2024 23:56:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2F85FCE1869;
	Wed, 31 Jul 2024 23:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6404C116B1;
	Wed, 31 Jul 2024 23:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470177;
	bh=T4sw8rKiOXTbYAT4aUb2OMUCS8f1KwLr5ACCRUuIPKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Enfic/QWWXq5c7KRDH0OMzjCJkkJtxAUgHe4KdrXcFehOHhvqocCT5dU0+jwrPDjV
	 Knh8ZY5pZ3+2rQPCmOpv/mKfwXrML+h1XkP4AMmEruiIQuLYG+zmP9Z7+pCklUAHVh
	 ClCM6mnQNuQTudy/jn/9xjJWuIfUEBnNXkajpEz5uFFheIt3q34fa/ni7iENI3BEVp
	 D/0yWpuglPCroMVZnB/4O5/gdzQLQgefND3ty16C/umeQ0jWLUCFee/RgnFo04L2dK
	 YOKZSyofCetFDld59x9iD7gIiZcbsu1UB9A72Zm4IHnI6tryh7xzR6qC80QzVooJc3
	 XGto6CQjmyxOw==
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
Subject: [PATCH AUTOSEL 5.15 2/2] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Wed, 31 Jul 2024 19:56:12 -0400
Message-ID: <20240731235613.3929589-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731235613.3929589-1-sashal@kernel.org>
References: <20240731235613.3929589-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_165620_018039_B81467C3 
X-CRM114-Status: GOOD (  11.50  )
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
index 5a3ba7e390546..d73b8eb76b8f5 100644
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
2.43.0


