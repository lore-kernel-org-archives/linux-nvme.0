Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D91C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 15:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZvjTeVSrDSJDzJqyuAE959EcEQL2Z6wDhbDZlFmU+Pw=; b=Zjzagx3S0UVOwYOCfGakYqc2cv
	L3da5o25AE5bhFDoeYUzDQUz+zeXufcdD/EqesWNDeJfkv7IZsGjEDq8wMmVHEiA1RJqFmvE273sG
	cyoMHLgKaqK5pdvhqHlqD0c05S284w/G5p3uZWhvbFhq2YY/Yik0km2BetNnHrdChCsuDQfvguNro
	mnypjYZZgyG4PGbO2UT8/CqIw4otRER4AFFSiD5L7tv2iS6ugYnOd291jlh/a4kDW+786xieUe3X4
	S7XHs2UJ8L+gxrVzM7EUSony7WZaxi3YG0TMvUt77SkjkpMF5Kj/VFmiuEA1TLD8HMF1PK183bjqO
	Om0CVdSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIBHj-004DM8-M1; Thu, 10 Feb 2022 15:23:03 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIBHP-004DFZ-1d
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 15:22:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A3134B825A9;
 Thu, 10 Feb 2022 15:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA53EC004E1;
 Thu, 10 Feb 2022 15:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644506558;
 bh=XbtIImxiwtqgWzOKDrLeQAB7usJ4ZvM5rG+veYKK0Ik=;
 h=From:To:Cc:Subject:Date:From;
 b=Ko7NusiQtg8bIwmGZf4XOkjyaiKRchnFK/py6+B/kwDADROvQADyVOfHI74xeNFw+
 286FSVdOvF8ndBLbf+wIMNk6kDVUIFr8h2ZojnElEO3fdfp4phIkAv+hn2rXviJIAN
 Xa2D1C1myLmrWE5w98j91opwULrY6u0PoWIAzw1o9W1ORAttB0CDL6m//g/hhKMess
 JRnoaKGQHLqlCALDTblw/j134QuGqPuFpWsgH1H4zQ40JcKW6iQtz7w+Jq+43y9FFX
 TbOWa1w1Pzk+zLnXbnuo/cX0AZIXYM23dZN5Vw1y2/0gHx6qGeY6uNCGSRVRcWVWNX
 m+2kY1rIsE09Q==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] nvme-pci: simple suspend quirk for vmd devices
Date: Thu, 10 Feb 2022 07:22:33 -0800
Message-Id: <20220210152233.1657933-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_072243_269789_C6136D11 
X-CRM114-Status: GOOD (  12.06  )
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

Bug reports from users tell us platfroms with vmd enabled regressed
power when using nvme power management on s2idle. We can't get the
StorageD3Enable property on such devices so the driver used the wrong
suspend method. Add a simple suspend quirk for the domain since that is
the safest option.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215467
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed680915..6fa66d5d924e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3094,6 +3094,12 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		dev_info(&pdev->dev,
 			 "platform quirk: setting simple suspend\n");
 		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
+	} else if (pci_domain_nr(pdev->bus) > 0xffff) {
+		/*
+		 * ACPI device properties are not reliable within VMD domains,
+		 * so assume the worst.
+		 */
+		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
 	}
 
 	/*
-- 
2.25.4


