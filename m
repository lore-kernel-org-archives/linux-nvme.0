Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0A1C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jun 2022 08:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BL+J4dVPWV0+dl+w3FqcxeDWe0nUoATye6dRhG4OrFY=; b=Xt4c+sc7vXoKIEElnrzLmq8IaN
	+3YCV9uExKL4vBVlFOdQQlLQEw/sKb4QEFvB6ugvbiRno/GdnC263vKJWutcv/YIKvXiZaj9g6Ah1
	tXfo9SIHsBotp4J1V76uDUnGfJmN2rYIdQUy97lKODFde+DZuSwF/zxDjMPhRcngY4ENVny8Sw9D2
	gpSLEsQsqGBJO2BY0z0gnl1k2BdK7rgFfv3jag1SfNBAPJSlVvzJrTbcOcPlNqWoB1eZkgWqXoy0z
	9kc+h/dh+md/SmS+BLdZPjCzQjWuEAkPRcp6h1em6bQN2PKXgPTPvhdSCQB2n96tUFPOZKWHtoqtt
	U7l7poMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o27Om-006KYd-Jh; Fri, 17 Jun 2022 08:32:12 +0000
Received: from [2001:4bb8:180:36f6:9c91:42c8:8d10:d7ed] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o27Oi-006KWn-Vf; Fri, 17 Jun 2022 08:32:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org
Cc: sagi@grimberg.me,
	monish.kumar.r@intel.com,
	Jason@zx2c4.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: move the Samsung X5 quirk entry to the core quirks
Date: Fri, 17 Jun 2022 10:32:06 +0200
Message-Id: <20220617083206.1146088-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This device shares the PCI ID with the Samsung 970 Evo Plus that
does not need or want the quirks.  Move the the quirk entry to the
core table based on the model number instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 14 ++++++++++++++
 drivers/nvme/host/pci.c  |  4 ----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 24165daee3c8f0..bfc5568a447a20 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2546,6 +2546,20 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
 		.vid = 0x1e0f,
 		.mn = "KCD6XVUL6T40",
 		.quirks = NVME_QUIRK_NO_APST,
+	},
+	{
+		/*
+		 * The external Samsung X5 SSD fails initialization without a
+		 * delay before checking if it is ready and has a whole set of
+		 * other problems.  To make this even more interesting, it
+		 * shares the PCI ID with internal Samsung 970 Evo Plus that
+		 * does not need or want these quirks.
+		 */
+		.vid = 0x144d,
+		.mn = "Samsung Portable SSD X5",
+		.quirks = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
+			  NVME_QUIRK_NO_DEEPEST_PS |
+			  NVME_QUIRK_IGNORE_DEV_SUBNQN,
 	}
 };
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 48f4f6eb877bcc..d05ee8fb23e084 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3483,10 +3483,6 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_128_BYTES_SQES |
 				NVME_QUIRK_SHARED_TAGS |
 				NVME_QUIRK_SKIP_CID_GEN },
-	{ PCI_DEVICE(0x144d, 0xa808),   /* Samsung X5 */
-		.driver_data =  NVME_QUIRK_DELAY_BEFORE_CHK_RDY|
-				NVME_QUIRK_NO_DEEPEST_PS |
-				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ 0, }
 };
-- 
2.30.2


