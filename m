Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38753C49EA1
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jul 2024 23:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nQiy6Q4bv7YlfzzDk3bRs0s5HLqzIyk9U6bnCvENfo0=; b=lsgXup3CTvBOn6fDufnvRKCzIL
	QmFHRNxm2+rFciYumB5zh7TrjL3jHLzjMwIRGf8w8iYPpa3AX/RuSA9/sW/z6RyT9TXlOb02pkqvC
	B8lNu970YjV7W/fallnHqpJAL//+oWjomLhb/BM5/n+JSUi3vuisOkdG6rkFs9jZlicrxT+jYVa85
	3wzIDF5DWeh7zaZvdPGjrLAKm/a5HDR9ZsAK3SL/BbXwH8cKZED0fuxrNK0pSXPPwi2q9joxzIQeg
	OBUNaw4p1dq9/k0Vf+xsSd8O8vc2wjVotBxHsS9C0Y0opq+X3AM1efXKXb4Kcpe2zbXI4q5BKrByh
	4HzZJnug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJBH-00000002qzL-3fJW;
	Wed, 31 Jul 2024 23:56:31 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJBF-00000002qxS-0iHe
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jul 2024 23:56:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AAAD062608;
	Wed, 31 Jul 2024 23:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDA0C116B1;
	Wed, 31 Jul 2024 23:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470188;
	bh=QtboQ5fxJmEorxCHqjzcYckd8B+t2Q5YktnNVTP0358=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jfiol3eQ8d93gn6YwLi4X7ny1EOZL0zae4qaPJ76WWtfVrCOhqa6bIMg4NQCHmoPb
	 um/sw8tHsmQqSw7/Dl7kMt6Jh32rjY/yeKLVfsID+PMqOl0EzDXknTgO+UCKjuI9gS
	 pe/P2E+staSUpY0ywb+s4l9tFd7F+cfaEK1U0/3ut96PyT2Jpw3eqKMtVzp1bXjnvI
	 k+w5oP6DkaimZ+dcJEZLp7d6iQCGrYormTibxXzXWjD+D/P3kj2Kxs3a+Zakh1fKsJ
	 lPuSeGAtDpTtvqFHy4qhK9o63jZO9a6JQT9ZrGWRclx95mBpm3LKHKM9qsMQexJsqM
	 fgsB5GkbbbF9w==
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
Subject: [PATCH AUTOSEL 5.4 2/2] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Wed, 31 Jul 2024 19:56:23 -0400
Message-ID: <20240731235624.3929717-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731235624.3929717-1-sashal@kernel.org>
References: <20240731235624.3929717-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_165629_277777_CE1B407C 
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
index 486e44d20b430..e4776cff42082 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2821,6 +2821,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
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


