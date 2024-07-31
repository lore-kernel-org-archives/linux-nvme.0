Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883C2C3DA7F
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jul 2024 23:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fNIDu3W1Vy9kV3dAdkOli/jU3U8z+TN6B/3WO6g491w=; b=opha5hiYuLW8biSh3W6fTKFiVW
	v92f93z9julziqj3hX995TDWThO1VGaF9tk3vAsOER/eArNJM0adCnjN+GS/9MnkDxqnsvB4J2Ri0
	tsPk9ixUQNrB3islJC5WHIIzEm9qSYDM7I1l/IzyvI3aaeLZkS6ofpWHgDqJnaWXTPLNvLTupjs/G
	PMFrPKiXRKMP5KzT2CS9WTlCuCojdsUXh3V78oFSGBILlcpT193PeqSgqkjeytI1rYaPUp4eR8uK0
	Rfw6okxYfQ3wa/LcZ4t7OUI3df6kw5yuU08rnHWCPXEfHVy9raODdYVG7kImVsMGrFnSuHeifVNuC
	y3HsWdhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJBD-00000002qwC-0iXM;
	Wed, 31 Jul 2024 23:56:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJBA-00000002qtA-0vzR
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jul 2024 23:56:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8127F62608;
	Wed, 31 Jul 2024 23:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21207C4AF11;
	Wed, 31 Jul 2024 23:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470183;
	bh=kdR2LEy/ink/mBs9qor8KWfMUd9udeGRCCasPf1W8BI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RGK4qYuXolk4tvjtwqpIgcGFiPU0R/d9Y4NjufVL6jh1WP/2GCUGW4+EU1B5HF8Kq
	 cduXzoQO6FqofOrSUFYzQaelrC9Cd3r1NLCRgbksSpAuEJbMkM1vPJmPxVi7+0lOSF
	 el9xWO14KeL6mStSWgDBk1QlqipMSnEB0J6E5tPUYTsSxtSyTg4+lLaE41HK22ztwf
	 guX0XB4R5w8qaluoD9QdlvAFPyAfPfiDwG94jMCQfd4uVPAUy26JoglQeLFpbtR6t+
	 7esX9m882octMngiong6IeyQmFkGosMXw5MxZVgWybnrGbyOoNBDxhYkujYF6cQhgU
	 GCjGyq5DLOxeQ==
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
Subject: [PATCH AUTOSEL 5.10 2/2] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Wed, 31 Jul 2024 19:56:18 -0400
Message-ID: <20240731235618.3929665-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731235618.3929665-1-sashal@kernel.org>
References: <20240731235618.3929665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_165624_363697_7DC6CC99 
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
index a7131f4752e28..148996ae80644 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2847,6 +2847,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 			return NVME_QUIRK_SIMPLE_SUSPEND;
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


