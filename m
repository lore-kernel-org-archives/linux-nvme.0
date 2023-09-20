Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0380ECE79AC
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Sep 2023 08:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=42LaC+Ki9kS2X5mr9P1WxGQwcv49odezsy0vgHHfVsw=; b=VwR48hds0AH/jQ3BIXbeswoMIt
	pY7bEnAIqsD1/KCcc11wTePJQYh0t6+hazIFarSWBQdGbn3ruVNBGRdk/7otLcT1d0sgzhc5W8QGu
	ce+FLpumFpD1yj4z2ws0ZdzOAHsL3VdjQ8OdfmdYaZeDVooGK6ds4hDwra3ky6/UrZfjcwALWg7PM
	AoD1qX/NKXPIVQv/W3DtMa90eUoQgvrxXRrJjA15HZgTACw3wHDF0fDMyxkjTYsbcyanz4qcpApHE
	igCiYYV39ECWywLbtTqyHlR/FrSEsWKgYsXC8544gVm62dMqz5mjD9GpLub8Ntqvy7bMp7LSB53nd
	4D9foZLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiswn-002LJ0-1r;
	Wed, 20 Sep 2023 08:52:37 +0000
Received: from mail.tuxedocomputers.com ([157.90.84.7])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiswj-002LFL-1T
	for linux-nvme@lists.infradead.org;
	Wed, 20 Sep 2023 08:52:35 +0000
Received: from wse.fritz.box (p5de45a8d.dip0.t-ipconnect.de [93.228.90.141])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 213F42FC00D1;
	Wed, 20 Sep 2023 10:52:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1695199945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=42LaC+Ki9kS2X5mr9P1WxGQwcv49odezsy0vgHHfVsw=;
	b=mv0T9T498iqueOpCOv40rVcUWk2+Ha5utGq1dUZye38ZUOBKjBTzWioTp5oV7/1VXUep0C
	Nz1tVqDZ0TCIjcYQdIa1gZP+RpuMN68XYrHHNzRVWxAgR3Ry/6PyrDYp7AF642pPn4Qjjn
	xMVGyHv+De0RuCec2o+hwsSpT01epTs=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Georg Gottleuber <ggo@tuxedocomputers.com>,
	Werner Sembach <wse@tuxedocomputers.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: Add sleep quirk for Kingston drives
Date: Wed, 20 Sep 2023 10:52:10 +0200
Message-Id: <20230920085210.22573-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_015233_960188_94395585 
X-CRM114-Status: GOOD (  16.19  )
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

From: Georg Gottleuber <ggo@tuxedocomputers.com>

Some Kingston NV1 and A2000 are wasting a lot of power on specific TUXEDO
platforms in s2idle sleep if 'Simple Suspend' is used.

This patch applies a new quirk 'Force No Simple Suspend' to achieve a
low power sleep without 'Simple Suspend'.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
Cc: <stable@vger.kernel.org>
---
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  | 16 +++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c470afa..74f74b459f5fa 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -156,6 +156,11 @@ enum nvme_quirks {
 	 * No temperature thresholds for channels other than 0 (Composite).
 	 */
 	NVME_QUIRK_NO_SECONDARY_TEMP_THRESH	= (1 << 19),
+
+	/*
+	 * Disables simple suspend/resume path.
+	 */
+	NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND	= (1 << 20),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 347cb5daebc3c..b4e6f0d21a44c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2903,6 +2903,18 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
 		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
 			return NVME_QUIRK_SIMPLE_SUSPEND;
+	} else if (pdev->vendor == 0x2646 && (pdev->device == 0x2263 ||
+		   pdev->device == 0x500f)) {
+		/*
+		 * Exclude some Kingston NV1 and A2000 devices from
+		 * NVME_QUIRK_SIMPLE_SUSPEND. Do a full suspend to save a
+		 * lot fo energy with s2idle sleep on some TUXEDO platforms.
+		 */
+		if (dmi_match(DMI_BOARD_NAME, "NS5X_NS7XAU") ||
+		    dmi_match(DMI_BOARD_NAME, "NS5x_7xAU") ||
+		    dmi_match(DMI_BOARD_NAME, "NS5x_7xPU") ||
+		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1"))
+			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
 	}
 
 	return 0;
@@ -2933,7 +2945,9 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	dev->dev = get_device(&pdev->dev);
 
 	quirks |= check_vendor_combination_bug(pdev);
-	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
+	if (!noacpi &&
+	    !(quirks & NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND) &&
+	    acpi_storage_d3(&pdev->dev)) {
 		/*
 		 * Some systems use a bios work around to ask for D3 on
 		 * platforms that support kernel managed suspend.
-- 
2.34.1


