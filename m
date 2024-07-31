Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A954C3DA7F
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jul 2024 23:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lpHsTem0fFHJfxo1rUqrj7MU/kjYm8ASN8vRwjItUyM=; b=xQd919wgLCbmPDkx7zRD07kiOC
	yej3CEU+UJ/FjdwpN8EQ5p9keRenweKaNLDABAY9DpKyOdePTMPAmrrqjVdEewiVAzqklcZSy+wmV
	xQr5HTI8ExnT4/vbcafv+GclgDxSbozzvmuB45WpCuQvqgBkib9H5BYqIv+tbHrYvY4gwKCofzoNb
	YqbJ4NM2BAWoQrqlUqmGSeZlFfc9r7tgRtofQTLvmZ+kuzskMn5FP6I4GrC790COzV29w+pP7uAxZ
	yR9zrN8O060PU5/oyO+pRzbGPJJgoGFl5dc7We91wM6yvbRSduwRZKBigIfT/lgF9CP32VzXTpH2W
	tBqH/gRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJAs-00000002qlA-1EjL;
	Wed, 31 Jul 2024 23:56:06 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJAp-00000002qk9-2miw
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jul 2024 23:56:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 125ED62646;
	Wed, 31 Jul 2024 23:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7422C32786;
	Wed, 31 Jul 2024 23:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470161;
	bh=2jl/1a5d2ylIOUyh5NIIGlObyWPaxNiMOTU0OECXk6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQwnRjh220Ojn7w4sLVp52VCEvAThs39Y9F7cQIWU7KF3j3NSg+LTRB0njW6cL/p9
	 Qve8rmCz4lUw1FAJt2kRGNcPld/XrltrQ4KuuRxdNwV8PtZ+lUHShoAKGWBHUWwKTG
	 UtpqGkPcmQUbXXXreaX5pBp1jURIQUw3sghfnizuoIAOteiKKAHc8Tg33K8Lf87Imr
	 atpoDJb5fPKhCaJyFCea2Sz+Ag6+vH9f7MAAGKEkSPOVArmdMdWEH6BFk7zAPbdQme
	 T6/R/mGDMkWNxCLRBMOXICWl6ZYKwJBXdQCaTP/QHU4EmH58kEttxMZxwLo9RMDXR0
	 DNMCaRYP1VIyA==
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
Subject: [PATCH AUTOSEL 6.10 2/2] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Wed, 31 Jul 2024 19:55:56 -0400
Message-ID: <20240731235557.3929433-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731235557.3929433-1-sashal@kernel.org>
References: <20240731235557.3929433-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_165603_791723_3B43AD17 
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
index 102a9fb0c65ff..19184b26920d9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2932,6 +2932,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
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


