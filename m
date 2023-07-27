Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6EEC001DC
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jul 2023 10:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dazoiG/A1vrVzBtZaRm1eL6aOfJ6AlDwSG66EtOsTmE=; b=KE7iU0xFPaMKoXlGXCNZslhKhm
	75UTmUKxdKI6dzaaFBC8tPeFgHyojkkciiZqfvwZiX/IZmmniGHfUsG+3hzBEFgMedzcfRzRUtqWf
	eIE18znyy6Twye5kmeM9UgJwbfCLZ+T4tjCWuOikoXJIin+MBHdGga1queNXgNkVqwos7i29pitoB
	1PTi5x+m1yVKBe5WwysV8UVUzFaIK4IRaiLeI2Q+UmTQbnXCJ4zUxiCnkHhOngoSUymTFmGteICLW
	Qu34AYGkRt89zZD1fXsrGeNjfc80KgpmVOWbkMOMA8rdnxX0nslsSCKto+2o6A7M8HHz/cjbg2h0W
	Yx9EvHoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOy6X-00CyYs-2c;
	Thu, 27 Jul 2023 10:20:21 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOy6T-00CyVN-0o
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jul 2023 10:20:18 +0000
X-UUID: efdee9600b8242dab6b8f45134d09719-20230727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:cd34a3cc-68f4-4daf-8285-83140148c9bd,IP:5,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-INFO: VERSION:1.1.28,REQID:cd34a3cc-68f4-4daf-8285-83140148c9bd,IP:5,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:3f028542-d291-4e62-b539-43d7d78362ba,B
	ulkID:230727181935Q0FGY2OS,BulkQuantity:0,Recheck:0,SF:44|38|24|17|19|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: efdee9600b8242dab6b8f45134d09719-20230727
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(111.48.58.12)] by mailgw
	(envelope-from <aichao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1232940138; Thu, 27 Jul 2023 18:19:32 +0800
From: Ai Chao <aichao@kylinos.cn>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ai Chao <aichao@kylinos.cn>
Subject: [PATCH] nvme-pci: add quirk to disable APST feature for BIWIN AP443 256GB SSD
Date: Thu, 27 Jul 2023 18:19:28 +0800
Message-Id: <20230727101928.1366179-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230727_032017_500534_0BA132AF 
X-CRM114-Status: GOOD (  10.24  )
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

Add quirk to disable APST feature for BIWIN AP443 256GB SSD.
It drops off the PCIe bus on a Lenovo board, board name
 is LXKT-ZXFG-N6 or LXKT-ZXE-N70.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
 drivers/nvme/host/pci.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7f25c0fe3a0b..240e8e946e01 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2897,7 +2897,18 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
 		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
 			return NVME_QUIRK_SIMPLE_SUSPEND;
-	}
+	} else if (pdev->vendor == 0x1dee && pdev->device == 0x5216) {
+		/*
+		 * BIWIN AP443 256GB SSD drops off the PCIe bus on a
+		 * Lenovo or KaiTian board, board name is LXKT-ZXFG-N6
+		 * or LXKT-ZXE-N70
+		 */
+		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO") ||
+		     dmi_match(DMI_BOARD_VENDOR, "KaiTian")) &&
+		    (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6") ||
+		     dmi_match(DMI_BOARD_NAME, "LXKT-ZXE-N70")))
+			return NVME_QUIRK_NO_APST;
+		}
 
 	return 0;
 }
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

