Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA334C4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 02:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xq2UZc/qF6ygYEmucjhvtRnAU79JEXbt2OXuiPsGdb0=; b=UxkCJk3+nYKktm5Zsr5fStkkYl
	egyDLf6Q1oQIDgOAIXwojlYHd2u2Jkl3qJ+zeUAo604GMMhwZE70UWds10XHjSFduUUc0py1UTvCP
	TVExDJ0hjPc/6lE3ogY5GHJuRo+HIkfrTWrcPNTjhJQIqKhiSijjO8G7XOga73fMxMtNN16xmHhIe
	1fr/XngzdajgTQj0HjlJk2q/juoJVYv3GJOOpJq6AWTGlUnyJefVvb3iZ8qgMYtbd31Kgei7B+3sX
	KCmjwIDc5/NKsxQrBJkRAg0rSuwHxFxes2EE3AX1xvF2Gv2mvLdym7JAWGvHTkqzIn4VghOvRZf6V
	poleb05g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7oIN-003vqD-2V;
	Tue, 28 Nov 2023 02:57:55 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7oIK-003voT-2p
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 02:57:54 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5c2b7ec93bbso1886788a12.2
        for <linux-nvme@lists.infradead.org>; Mon, 27 Nov 2023 18:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701140269; x=1701745069; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xq2UZc/qF6ygYEmucjhvtRnAU79JEXbt2OXuiPsGdb0=;
        b=bt+I4Y9s0A9+dMpsI+TXaDh91PL1Vfbu4bGfza3jY+KXZZFO+hL4gt6HumxHv1h2Ym
         ygmapUYOdcAnpPWGz4LNGRNmE/OaoBcjCHY7mlb/JIXPEO48juUfNHlD8/sxJ1fgm3o3
         4i+FzVFqMYHKk9/Z0UCu9jCRZ9lQ2aVk0FKbVNnRNh1vfeCnmWSPOSnIKvMAWWaT6GNv
         w6NKHuAnZyXm1YlglSmC5tYPxakL3n/xIWm6ZE24ifvlxcQuQapz/XTdTRnh8qvk0gHo
         eQsUsilHlZ2PiDFaO49pRRtOC0H7lSnt6OhGo98focrNzjNpAXWjvIouqfA1lAL0XNEC
         rZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701140269; x=1701745069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xq2UZc/qF6ygYEmucjhvtRnAU79JEXbt2OXuiPsGdb0=;
        b=SN8xT2BEQdQjPO2y1gDeUZoXxnPPPhqIY2n2D4xN5PWCIhzE6o32vDOOb7KH29/Wdz
         5Qkblol7X/iVo5yxJG1lpz8POADkHFnKG4Ty20qpwvzgeUe2iIId2x4kJ1tBh/vXSt+H
         hTmj94GVTyWhlLdYr/s+/w7TMksqAXcwTvgNwKQE6AM+a/wdgVt2VcFe1tO7TGZF6mjq
         ns8SDOEQCCPE01ECIMsqbUqdojRZQ8fEPfu8fYHliUewxkt8SPnX0s+781MbULx0PUkb
         AP8zsohAbYTTEQ5NeLulYyDrdAhtmPuNjqDfbZr3M7As9OuHD7hN1NtJAWZNbpERczJB
         7nOg==
X-Gm-Message-State: AOJu0Yx0xfobsxVbVBe5rjtQY4v09ilwi3scFJkeoftv01eS4iD5M2Me
	FaL6Gv4TjR+2SLYb0BkdN/Y=
X-Google-Smtp-Source: AGHT+IHKfl6zCTzYaX64gPJ7IlYAWWrLTK7UXpqyPWkn0nLz5fGBBtge77cAR99etqzZixsoLdk/6A==
X-Received: by 2002:a05:6a20:54a1:b0:187:5302:4b21 with SMTP id i33-20020a056a2054a100b0018753024b21mr17952683pzk.46.1701140269419;
        Mon, 27 Nov 2023 18:57:49 -0800 (PST)
Received: from smi-System-Product-Name.tw.smi.ad (125-227-10-151.hinet-ip.hinet.net. [125.227.10.151])
        by smtp.gmail.com with ESMTPSA id n17-20020a056a0007d100b006cb65cfde6dsm7930782pfu.200.2023.11.27.18.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 18:57:49 -0800 (PST)
From: "Jim.Lin" <jim.chihjung.lin@gmail.com>
X-Google-Original-From: "Jim.Lin" <jim.lin@siliconmotion.com>
To: kbusch@kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jim.lin@siliconmotion.com,
	cj.chen@siliconmotion.com,
	david.yeh@siliconmotion.com,
	hardaway.tseng@sk.com
Subject: [PATCH] nvme-pci: disable write zeroes for SK Hynix BC901
Date: Tue, 28 Nov 2023 10:57:37 +0800
Message-Id: <20231128025737.53026-1-jim.lin@siliconmotion.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_185752_911752_0819CC37 
X-CRM114-Status: GOOD (  10.05  )
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

SK Hynix BC901 drive write zero will cause Chromebook takes more than 20 mins to switch to developer mode
"disable write zeroes" can fix this issue and Sk Hynix has been verified.

Signed-off-by: Jim.Lin <jim.lin@siliconmotion.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 507bc149046d..f27202680741 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3394,6 +3394,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1c5c, 0x174a),   /* SK Hynix P31 SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1c5c, 0x1D59),   /* SK Hynix BC901 */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
-- 
2.25.1


