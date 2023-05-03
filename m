Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF00C77B75
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 15:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bEpuYZYtEbtZDscJwnUW1pS2d4J8PXjQ8unkix7abqA=; b=Av17v8Pevt6Zu6aSwcUK8fGQ8H
	62imkCKEAYK5NeURSnFM3pi9lfb7+Ebm/pkN0+y+3yFtu7MDAX2AbAeO+x8rVgMftVckwH8f3FQ3O
	KcTLL+qRewjj1+jDW+mJXU/Q5bTAZfLioVB28XYho9IhW6HaRz2T1ITCFvep9zCb5t3I8nqEVfmX6
	AOYEWntEc7UKqBJ98Id2DdZnPbiMicEZkBAshkP2MTwTCWBRcwe8NDAZDeEZtmalmI8TSINlphzBA
	GiCS556HBbjQL/f4G84P3cnzyU8l01MIpyhaoX7AixPaUx4dACBj958sJp5Sxo2J4T/NdwCyndLbu
	jc/7V5bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puErO-00525k-0C;
	Wed, 03 May 2023 15:57:42 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puErL-00524P-12
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 15:57:40 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f16f792384so12511865e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 03 May 2023 08:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683129455; x=1685721455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEpuYZYtEbtZDscJwnUW1pS2d4J8PXjQ8unkix7abqA=;
        b=dXK9RtYHqIVIT5NZt1VKtYkFKP/U70nFtSdjwG1cW+DtziIixJR/ggj7ISH6qWmWQH
         MAttgr7mkA2xPVYWDFnizD1dEPJ62lgSoWjA0hj4JiL4mDqJ+0gqJedoSAclDKceVc7r
         cAFcp+PYuUVJSfoscNa51Wrn64Cy8DJUmqYfb0Ee6nYE6I/gvHEZFuVHfQgU7kNlREuV
         0Cuc2rFd5epyVYX2wNMxqyEtaAXLQs5ojtLz+n26ncKDaxNUq62gog/sFrNphKHeVKbW
         4HzGehezQH8timjkUBcX2AUBhzNkL/BVOHhdIw+SdgGFMlqrrhzu4Ig3pM0RgAPBURx4
         D9JQ==
X-Gm-Message-State: AC+VfDxJBt4Ae/lz2K55wCNPhYAqWHYeu64LaNYHI/ardPq7jJQJXKAy
	Jev1/v4LivnCQCV+AWt2MBBTHc+JzGA=
X-Google-Smtp-Source: ACHHUZ6h1Z5e2VmD8lcCqpZiS6Nejx5tzstqL5nJIdzPJX7mg9waDjufHnPF/QkuGbU9EROGf6fm6Q==
X-Received: by 2002:a05:600c:3b99:b0:3f1:7138:91ee with SMTP id n25-20020a05600c3b9900b003f1713891eemr4902464wms.2.1683129455315;
        Wed, 03 May 2023 08:57:35 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t15-20020adfe10f000000b00304832cd960sm24298980wrz.10.2023.05.03.08.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:57:35 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Cc: Andrey God <andreygod83@protonmail.com>
Subject: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for HS-SSD-FUTURE 2048G
Date: Wed,  3 May 2023 18:57:33 +0300
Message-Id: <20230503155733.866408-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_085739_355645_1901006F 
X-CRM114-Status: GOOD (  11.79  )
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

Add a quirk to fix HS-SSD-FUTURE 2048G SSD drives reporting duplicate
nsids.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217384
Reported-by: Andrey God <andreygod83@protonmail.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 593f86323e25..d8b660daf7c2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3433,6 +3433,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1d97, 0x2269), /* Lexar NM760 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1e4b, 0x1602), /* HS-SSD-FUTURE 2048G  */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.34.1


