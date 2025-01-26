Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CCEC02181
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jan 2025 05:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2LmU0AhR1QcRCvDtrftLVzrBgzUIjowOlRVSyrqp0KA=; b=1AJj22uIeWKaOCDh3s0LVJSWf0
	z+iGQN8re/ixbpkZENe+FJgFFidjkNh4mpkyJm3ehS2kTSXvwBsQ1YQd8ALWNHLJeSs73Ws8sZ+yz
	Afia0KrksfxewnobHz69XG83VAReuWzfQril9+D0BMjd6h/JfXqMuLq8pC5aGuF2cE9laQZFGmWeq
	b88M50uuNfIQh3wF/7MBEaXaKki6WnBCkhBYixEZPVMh08f2ssg95ktSdrEwMohOVj2NYE1rkLzzi
	+DQP2xrO71Hwldj6d8+UKX6hLa30RgIFWjxg707YVoEFG7Tfl5TvNxEzFDt925aTOgD3mh+QAQkP9
	WmCIUn+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbuoF-0000000H7wH-2joR;
	Sun, 26 Jan 2025 05:03:47 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbuo9-0000000H7vw-3K4z
	for linux-nvme@lists.infradead.org;
	Sun, 26 Jan 2025 05:03:43 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2163b0c09afso63041835ad.0
        for <linux-nvme@lists.infradead.org>; Sat, 25 Jan 2025 21:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737867820; x=1738472620; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2LmU0AhR1QcRCvDtrftLVzrBgzUIjowOlRVSyrqp0KA=;
        b=N6Te6UWG8DUnA3ksg+REhs8oWt4Q1Fcyk9w3Fzp2TCX4sVIesnQcjqKEqmIA1Dy2mi
         IV8d3x39JjvEvF9zQEknxCiTIxFdd8EWEtYnIxLz2ZZfTFjJ44CfCi1uTqICNDM0Zw9L
         H00fC0fcM/VfbF74Y5xLuC5bjFu8m3eCOPqYCyDOzLTVA1nUU3/DD8yO8nsjTPd4CE5c
         67nmDm0qOzCyEa1ldAg3dvM0ZCYJaOMbVx61zkV44dxBQP7mvEj6dQliYkScCHB6xu//
         zUJmgcAr0lvnvAHJ1dKH6GACNDillWmTVz2+6l54YXqaYCYBbBU2yIdrr0+L3DoVfC7G
         TVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737867820; x=1738472620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LmU0AhR1QcRCvDtrftLVzrBgzUIjowOlRVSyrqp0KA=;
        b=L13NB9HPjR8MzKRMS4U7+TdSX9vc93l6N6X0yyLSnXHE2PFlSLfJSPemEWAIvx5dvC
         CjzCVjEIivhD/MV36iY9Z9YNKqOApIx0ELWuSw09WksMEeit02WhhOpzVHyUv7ZpUf+N
         YYi2ERHffhf2U72solETaqbgNpqDud0frA8ZcBWfSMUehJlWJEicVS9NwHcNRdF4DPkL
         slO7SDkvT6tOjtGQdl1ElIwKiz4RzjUoY4ujuOM1zQTPz2pt+11l203fe5CKwMdUjWk8
         8T+BrDV0ZwmlpRhHZbkS2hsQMxZiAjf161ZUGyJxKf5PfWEr1+uozLr98iEhOJFt5H5h
         3cUw==
X-Gm-Message-State: AOJu0YwmNb7aJM/d2ovPQ7cQAdU+yGBTVg6B6J/CNKOFOLDbAEefr8tJ
	V3zQWC/K0Hw41Jli+aVun/v5nZJKp2ITK2akiPtpo5j8EBxuxijmiBnEQOWzUQ==
X-Gm-Gg: ASbGncv5mWSrg11hYTeX57wpy0N76hq5bJ+TE4098nMUemMqgPEDkmjaybyEifLeytG
	UWV67gIW5fKdWe/J8VIYh7JYj/Bdao71pJv9uKlVPBRBIj1PHbzERaS/Mc37INxBj5xui+bfoAd
	4awRZSQfWjXdA/HzY0fNbqjnuN2+8wd/gaSOcdn5Ddu765NabG25d8uXNQgJGQhh4vAZYp275h9
	i2Ab2X7XH5vHr3l1dg50h7dvaizwn13Tef1kMbxE++3Fx6nYvpbpch5MmvFp78qkactCfBO+jH0
	7XBNd1bagndLZZzZ20ICVFCPCj4JRoY=
X-Google-Smtp-Source: AGHT+IFHEyHxX7irul6vkLjKxGN++SAL9AbT8cYCTv6RzUwpK3beUMVv7CAA6YJTgynH06wxyLRoXQ==
X-Received: by 2002:a17:903:11cd:b0:215:b5c6:9ee8 with SMTP id d9443c01a7336-21c351d3065mr477220725ad.7.1737867820274;
        Sat, 25 Jan 2025 21:03:40 -0800 (PST)
Received: from localhost.localdomain ([120.60.50.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9c5bfsm40747515ad.37.2025.01.25.21.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 21:03:39 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	rafael@kernel.org,
	ulf.hansson@linaro.org,
	helgaas@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] nvme-pci: Use NVME_QUIRK_SIMPLE_SUSPEND for Qualcomm Snapdragon 8cx Gen 3 platforms
Date: Sun, 26 Jan 2025 10:33:09 +0530
Message-Id: <20250126050309.7243-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250125_210341_868566_D8098D96 
X-CRM114-Status: GOOD (  21.36  )
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

On these platforms, power to the PCIe bus is not retained if the SoC enters
its own deep low power state called, CX power collapse state during system
suspend. Once the SoC resumes after going through CX power collapse, all
the PCIe bus state will be lost. So the NVMe devices on these platforms
won't resume properly, rendering the machines useless until forcefully
restarted by the users.

To workaround this issue, the PCIe controller driver is keeping a minimal
vote on the PCIe-MEM interconnect path in its system suspend callback
current currently. While this gives a working system suspend, it also
results in increased power consumption during suspend as the SoC never
enters its low power state. So with this change, the workaround can finally
be removed.

Also it should be noted that the actual fix to this issue lies in the
PCI/PM core. But currently there is no such fix exist as of now and the
consensus to reach it is also taking a lot of time.

So use this quirk to allow users to save battery life on these platforms
until the PCI/PM core comes up with an API that tells the PCI client
drivers when to turn off the devices.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Hi,

I'm sending this patch as there seems to be no consensus so far (as been
discussed in this thread [1]) in coming up with a PCI/PM API that tells the
client drivers when to safely turn off the devices. Since coming up with these
kind of generic APIs are bound to take time (I do intend to pursue), it makes
sense to allow these platforms to make use of the existing
NVME_QUIRK_SIMPLE_SUSPEND quirk in the meantime. Once such API is upstreamed and
used in this driver, this quirk can be reverted.

It should be noted that this CX power collapse issue only exist on the platforms
based on the Qcom Snapdragon 8cx Gen 3 SoC. On other platforms, it is a more of
a policy decision to decide whether to shutdown the devices or not. And these
other platforms can wait for the generic API to be made available by the PCI/PM
core.

[1] https://lore.kernel.org/linux-pci/20241118082344.8146-1-manivannan.sadhasivam@linaro.org

 drivers/nvme/host/pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e2634f437f33..c52dced952a1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3162,6 +3162,16 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 	if (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6"))
 		return NVME_QUIRK_NO_APST;
 
+	/*
+	 * Qualcomm Snapdragon 8cx Gen 3 (SC8280XP) platforms doesn't retain
+	 * power to the PCIe bus after entering low power CX power collapse
+	 * state during system suspend. So shutdown the NVMe devices to have a
+	 * working system suspend on these platforms.
+	 */
+	if (dmi_match(DMI_PRODUCT_FAMILY, "SCP_MAKENA") ||
+	    dmi_match(DMI_PRODUCT_FAMILY, "ThinkPad X13s Gen 1"))
+		return NVME_QUIRK_SIMPLE_SUSPEND;
+
 	return 0;
 }
 
-- 
2.25.1


