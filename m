Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360AFC282EC
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Mar 2025 00:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YT8vAt9IzgpdyaXHaMyeLwCla0i8/YPcMT+Md4Evueo=; b=03bE1HjWhByrM+1haby0eGuSYJ
	diNXamXgoBTji7HDY30L8apVN1uCQbIcXJIkYC5ED5xRBafosoMV4k6fPy0+KchLweOt66VpV9rn9
	gOKTo1thdYWF90Fo7CbqzVbztCdXs3r9HDdZKZfwgM6bLI3Cfh4veTdSO4tioCxY5EtAb6HJoxUhN
	hvn6ifCCFfXozOy8ulN/u2mcpTvoqF88BGKhyvI9aAR9MNcIaa0k49DsJqhi0Y/Ud6F8PZxKdVyEO
	VfSRtX6GFtmDgqrBYCcEbd75R4eE8A5S+/+3n3NBf60SpQ08+4ExA/QP354gUQ+jjhxuRvkic9EQe
	CKtoZ8kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqLW9-0000000CcoR-0MkL;
	Fri, 07 Mar 2025 00:24:45 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqLW7-0000000CcnY-0NNr
	for linux-nvme@lists.infradead.org;
	Fri, 07 Mar 2025 00:24:44 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 5270JpFH030843
	for <linux-nvme@lists.infradead.org>; Thu, 6 Mar 2025 16:24:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=YT8vAt9IzgpdyaXHaM
	yeLwCla0i8/YPcMT+Md4Evueo=; b=an4uD9+BkxYIoZMEpyu7ikfI4wMf1IZrun
	bFM2R5yPfDORJK1z59FxSk7UWoZLv/LGqcnt8ZC3fXuXH/4b7xV5OHOBcQuhMWH5
	g/rdXXV9B6lV+Yk7rMw2QOc6Jgbf3LUC9i5hUcebqDAHTxCWjD6HiHXjleIxzEue
	gLG33blErvw4reKLW2T8VcxQ078ySK0/MB485hKU68HUphaa7MEXqapaRV23adyM
	b/cuOAHVc7k0PJ/KwqJZiBYm3BiQfKz0BiWaX2CpqpqBwvI9QreDYoFj03PD5OIl
	uZaroMrLBGYryK6mnI0VzTKADffB1lEUy/tVOwXRBbHs8S0SaVvg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 457n16gm2e-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 06 Mar 2025 16:24:41 -0800 (PST)
Received: from twshared3815.08.ash9.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 7 Mar 2025 00:24:38 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id D672218CE2E98; Thu,  6 Mar 2025 16:24:25 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-pci: fix stuck reset on concurrent DPC and HP
Date: Thu, 6 Mar 2025 16:24:24 -0800
Message-ID: <20250307002424.3655342-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: KjRvwpFCvjKDv3U-U0D2TStmC9E5FcEI
X-Proofpoint-ORIG-GUID: KjRvwpFCvjKDv3U-U0D2TStmC9E5FcEI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_08,2025-03-06_04,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_162443_327663_DB8B2D02 
X-CRM114-Status: GOOD (  16.30  )
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

From: Keith Busch <kbusch@kernel.org>

The PCIe DPC handling has the nvme driver quiesce the device, attempt to
restart it, then wait for that restart to complete.

The DPC event also toggles the PCIe link. If the slot doesn't have
out-of-band presence detection, this will trigger a pciehp
re-enumeration.

The DPC's error handling that calls nvme_error_resume is holding the
device lock while this happens. This lock prevents pciehp's request to
disconnect the driver from proceeding.

Meanwhile the nvme's reset can't make forward progress because its
device isn't there anymore withoutstanding IO, and the timeout handler
won't do anything to fix it because the device is undergoing error
handling.

End result: deadlocked.

Fix this by having the timeout handler short cut the disabling for a
disconnected PCIe device. The downside is that we're relying on an IO
timeout to clean up this mess, which could be a minute by default.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 640590b217282..5963a5f6da940 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1412,16 +1412,17 @@ static enum blk_eh_timer_return nvme_timeout(stru=
ct request *req)
 	struct request *abort_req;
 	struct nvme_command cmd =3D { };
 	u32 csts =3D readl(dev->bar + NVME_REG_CSTS);
+	struct pci_dev *pdev =3D to_pci_dev(dev->dev);
 	u8 opcode;
=20
-	if (nvme_state_terminal(&dev->ctrl))
+	if (nvme_state_terminal(&dev->ctrl) || pci_dev_is_disconnected(pdev))
 		goto disable;
=20
 	/* If PCI error recovery process is happening, we cannot reset or
 	 * the recovery mechanism will surely fail.
 	 */
 	mb();
-	if (pci_channel_offline(to_pci_dev(dev->dev)))
+	if (pci_channel_offline(pdev))
 		return BLK_EH_RESET_TIMER;
=20
 	/*
@@ -1522,9 +1523,12 @@ static enum blk_eh_timer_return nvme_timeout(struc=
t request *req)
=20
 disable:
 	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
-		if (nvme_state_terminal(&dev->ctrl))
+		if (nvme_state_terminal(&dev->ctrl) ||
+		    pci_dev_is_disconnected(pdev)) {
 			nvme_dev_disable(dev, true);
-		return BLK_EH_DONE;
+			return BLK_EH_DONE;
+		}
+		return BLK_EH_RESET_TIMER;
 	}
=20
 	nvme_dev_disable(dev, false);
--=20
2.47.1


