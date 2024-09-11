Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF7EEE0206
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 17:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=l9a+PXHeC0Ttem0yHba9vzG3nzemDL0nrzKINWIQ64M=; b=z6icYmacC2+4YvR7Q9R8PqSwL+
	QMzIEbM/KBU1bHaws0YQXLHqGS4dde5fIS2wnQqfjOtD2v2bIxQBrMFiialIWx6LkHcE//p654+SP
	WDDmlWtt3FW3noIjgaZPgNFurpgdCXmu9pN3TZ9O3Iryphm1VHC0Z+zSGWzLDr0AqWR/bGHe/BLxw
	8HpselH9x28Ds9jYWUprZDz8wEH3unebpWKQgm3tkeIgRNsUNhWbjcrRlCgV93m+P+ecXgLxib7R5
	eZbzhmsueGWrnSWqNsSiP+NJsxvTuO5R6aKVfoHRJMvd0mSYIsIc1birDmFDTIsJVPu33FQWC9hZi
	9varFXVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soRQb-0000000AYYQ-45h9;
	Wed, 11 Sep 2024 17:46:53 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soRQY-0000000AYWg-2bnJ
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 17:46:52 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BHjoG8029757
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 10:46:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=l9a
	+PXHeC0Ttem0yHba9vzG3nzemDL0nrzKINWIQ64M=; b=DbLUW+y66WnqFbpJiSM
	d1Xhgn8C+S8IwPxtkOugwb2bpDsxqRYMe5vG8QaMRtfB42FmICaVitrWVkbcWzO+
	AwXLBSaMmcRZpx3yx2KMwWkAaaxnvgCOP4WrlhpY6QiPx+EowjngPqFyIPnonn8y
	mYyGlaBC94DVPm/b106mso1gyc4A9qja/PS0UqXdGpFcDrnfhJRShcyXULy7aQIK
	cdxHJUxdLpf36Xfppzky6+xdBY/KRsQHyFkN6QgN+Ll33QEi95LYa4BS/rFM0ZV+
	5vyJGpQXaXK+yrYb1tIUMLCtWv+lmvetObos02cOV+9auX6+qNapaxBrMh3zgi/L
	A2w==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41jhyyb80e-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 10:46:47 -0700 (PDT)
Received: from twshared2068.05.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Sep 2024 17:46:45 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 3D6E712E4EC8A; Wed, 11 Sep 2024 10:46:32 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>,
        Robert Beckett
	<bob.beckett@collabora.com>
Subject: [PATCH] nvme-pci: qdepth 1 quirk
Date: Wed, 11 Sep 2024 10:46:31 -0700
Message-ID: <20240911174631.3484553-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8ng0SiiZefev9QQwTNsWlL7J8Mz5dcv-
X-Proofpoint-GUID: 8ng0SiiZefev9QQwTNsWlL7J8Mz5dcv-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_104650_817497_55FBAF77 
X-CRM114-Status: GOOD (  17.15  )
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

Another device has been reported to be unreliable if we have more than
one outstanding command. In this new case, data corruption may occur.
Since we have two devices now needing this quirky behavior, make a
generic quirk flag.

The same Apple quirk is clearly not "temporary", so update the comment
while moving it.

Link: https://lore.kernel.org/linux-nvme/191d810a4e3.fcc6066c765804.97361=
1676137075390@collabora.com/
Reported-by: Robert Beckett <bob.beckett@collabora.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  | 18 +++++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index af22368800e77..69a3fb6de1e9c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -90,6 +90,11 @@ enum nvme_quirks {
 	 */
 	NVME_QUIRK_NO_DEEPEST_PS		=3D (1 << 5),
=20
+	/*
+	 *  Problems seen with concurrent commands
+	 */
+	NVME_QUIRK_QDEPTH_ONE			=3D (1 << 6),
+
 	/*
 	 * Set MEDIUM priority on SQ creation
 	 */
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6cd9395ba9ec3..2c245c3f693a7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2557,15 +2557,8 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	else
 		dev->io_sqes =3D NVME_NVM_IOSQES;
=20
-	/*
-	 * Temporary fix for the Apple controller found in the MacBook8,1 and
-	 * some MacBook7,1 to avoid controller resets and data loss.
-	 */
-	if (pdev->vendor =3D=3D PCI_VENDOR_ID_APPLE && pdev->device =3D=3D 0x20=
01) {
+	if (dev->ctrl.quirks & NVME_QUIRK_QDEPTH_ONE) {
 		dev->q_depth =3D 2;
-		dev_warn(dev->ctrl.device, "detected Apple NVMe controller, "
-			"set queue depth=3D%u to work around controller resets\n",
-			dev->q_depth);
 	} else if (pdev->vendor =3D=3D PCI_VENDOR_ID_SAMSUNG &&
 		   (pdev->device =3D=3D 0xa821 || pdev->device =3D=3D 0xa822) &&
 		   NVME_CAP_MQES(dev->ctrl.cap) =3D=3D 0) {
@@ -3425,6 +3418,8 @@ static const struct pci_device_id nvme_id_table[] =3D=
 {
 				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
 		.driver_data =3D NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1217, 0x8760),
+		.driver_data =3D NVME_QUIRK_QDEPTH_ONE },
 	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
 		.driver_data =3D NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_BOGUS_NID, },
@@ -3559,7 +3554,12 @@ static const struct pci_device_id nvme_id_table[] =
=3D {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0xcd02),
 		.driver_data =3D NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
-		.driver_data =3D NVME_QUIRK_SINGLE_VECTOR },
+		/*
+		 * Fix for the Apple controller found in the MacBook8,1 and
+		 * some MacBook7,1 to avoid controller resets and data loss.
+		 */
+		.driver_data =3D NVME_QUIRK_SINGLE_VECTOR |
+				NVME_QUIRK_QDEPTH_ONE },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
 		.driver_data =3D NVME_QUIRK_SINGLE_VECTOR |
--=20
2.43.5


