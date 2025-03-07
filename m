Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1D2C282DE
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Mar 2025 23:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=alBvsCpZYSIxk1a8vAyLMZncaqA6ChiX9wfLVeUONOg=; b=EhyKmNs7Ig+01IE6EGgOeV0QjG
	XfLT37kLt0r87F8mpPrhY7viDGnkWk6kgwHmKfUmhLUsiFjMImPZUourQFtc6f/jI9GA/gquROnDT
	0InUJjGOfk2mf2vwfCpYyiLaZZEQXL4CdoEpZZqDeyLUui9TR+l50vqnnkfhJt+Wn61V7U/Bk9ntu
	kHYiocd40h/hIj527NzzR3y16Lc/V9znRtj+/hN2jGv8BjizeUPrsvjEGI/TTbxLzWfSdKqSwsMTH
	6QEhb29Mi2Cnhd/eP9Ucr4adnZxQY+hejUigad6yeGj+CvXLNSNE9/2Og5BG1fNi0d6Ogf9gktK35
	ATzoO1/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqh5K-0000000FnXH-1DZL;
	Fri, 07 Mar 2025 23:26:30 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqh5H-0000000FnWI-3HZd
	for linux-nvme@lists.infradead.org;
	Fri, 07 Mar 2025 23:26:29 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527J3PPB006545
	for <linux-nvme@lists.infradead.org>; Fri, 7 Mar 2025 15:26:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=alBvsCpZYSIxk1a8vA
	yLMZncaqA6ChiX9wfLVeUONOg=; b=dBc5/Z1ssbeUznd1NyaX0DIQeo5u0zA/Qd
	6jvC2YyrqJR3SiD1GQplnBmaeQkfPH5Uwq7Lg35xFPoLzQrs6VMQ8my97TVvahq1
	0/JZk1o9EWidVbj16sBxV80YRB4YUaqVn7djGONYU1cjqVfXUMfxsGN7jdeyAsja
	D+HCLCV3xH08EkmWUaHrRWqHWTJNdwOaVCoh/Am79sFXefVKgc3iAEhSS+CWLsnP
	Yv9K361wkUCerQs/eYN2Rq7aimo1mGlnfiYKpB0CIzLpo4ZzMo2xaNRu2oXmcAxb
	zK7rNL0OK2oa6s/B4ZCEZJPNUPqGu+w+4086hFOXvUlnXmOlS1Ng==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 457ybawpec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 07 Mar 2025 15:26:26 -0800 (PST)
Received: from twshared18153.09.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 7 Mar 2025 23:26:25 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id E63EB18D703C3; Fri,  7 Mar 2025 15:26:19 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <nilay@linux.ibm.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2] nvme-pci: fix stuck reset on concurrent DPC and HP
Date: Fri, 7 Mar 2025 15:26:18 -0800
Message-ID: <20250307232618.2141065-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: KPo43i4xIYNVYuV66uaiqxcA1py1ofxD
X-Proofpoint-ORIG-GUID: KPo43i4xIYNVYuV66uaiqxcA1py1ofxD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_08,2025-03-07_03,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250307_152627_840506_41244992 
X-CRM114-Status: GOOD (  16.21  )
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

Meanwhile the nvme's reset_work can't make forward progress because its
device isn't there anymore with admin IO, and the timeout handler won't
do anything to fix it because the device is undergoing error handling.

End result: deadlocked.

Fix this by having the timeout handler disable the nvme queueus for a
disconnected PCIe device. We're relying on an IO timeout to unblock
this, which is a minute by default.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Leveraged the state machine to make the patch that much simpler.

 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 640590b217282..710f3dfef3663 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1411,9 +1411,12 @@ static enum blk_eh_timer_return nvme_timeout(struc=
t request *req)
 	struct nvme_dev *dev =3D nvmeq->dev;
 	struct request *abort_req;
 	struct nvme_command cmd =3D { };
+	struct pci_dev *pdev =3D to_pci_dev(dev->dev);
 	u32 csts =3D readl(dev->bar + NVME_REG_CSTS);
 	u8 opcode;
=20
+	if (pci_dev_is_disconnected(pdev))
+		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	if (nvme_state_terminal(&dev->ctrl))
 		goto disable;
=20
@@ -1421,7 +1424,7 @@ static enum blk_eh_timer_return nvme_timeout(struct=
 request *req)
 	 * the recovery mechanism will surely fail.
 	 */
 	mb();
-	if (pci_channel_offline(to_pci_dev(dev->dev)))
+	if (pci_channel_offline(pdev))
 		return BLK_EH_RESET_TIMER;
=20
 	/*
--=20
2.47.1


