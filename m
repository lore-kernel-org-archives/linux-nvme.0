Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBC2D7833E
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 17:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yabv4Ty1VuPH9U+Xm8ER2BmKbUd8xZEfPN9eolh8Y70=; b=v2wc6blp6+UF8j9vDcsh6MIUkT
	dSyBtHh17wPVS3LKzeIjOWLz7KHXceXoC8hueHUv3Gb7kvrwDFqqvuSXuUHIKVlFrpNCHb65E12Oa
	j5M4zuC6EO+sZMjD03vLrM+jDmCGKU/AhZCYYX8S5TSu1tXUr6T8PRbDV6Ra93mRRLE8f40utNXDh
	TF8rZLVe+JKjSTuLewpssx1cVk9t9QOb34QeW6MUYdAZMTZs0DiWSCtq2WTRP912/1cvgCx8oTANM
	g7L53VX3xK5rvruGfluUtBgJeXbez7cxdOKCd4XKF9N0xWjH3tYYpZ8IpclUt19WsVf8vgL9Y8o8V
	f4MlbV/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIAcz-000000075PF-1PIW;
	Mon, 02 Dec 2024 17:54:33 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIAcx-000000075OB-0X0m
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 17:54:32 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2HhqEW008996
	for <linux-nvme@lists.infradead.org>; Mon, 2 Dec 2024 09:54:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=yabv4Ty1VuPH9U+Xm8
	ER2BmKbUd8xZEfPN9eolh8Y70=; b=S0j6bImRRGYFO+AIfaH6HAm9IUTGENJNco
	TGwRdnRwoUR9BQ7UhX9FnkzmEb58lDb+rTLJ7zvSDvasvOZf5k/ZlGu9Vy6csZjd
	FZPv4Jv+ZY4el+FREe8exyy56TyDCfEBi5zN+BEIc4ExvE7NZ525cdcbg2EVb+Qd
	CDt8zfsseQMe3pAuWMtM0tsjV2bNND17Ioa9eqO8siBpdeMdfQtdLJLP3SwuiHZG
	6NTHuogk/9JsfQKHwo7RD5FnCKhd/Sib52o/lh/Y1UFtMdGj+nbHfImRCIuHUVNB
	4qfEwG/frn6+2IW2hpylOrHlvjRxYWZG6KSD4eB2hPPgjV4LLNEA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 439ggegnw5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 02 Dec 2024 09:54:28 -0800 (PST)
Received: from twshared18321.17.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 2 Dec 2024 17:54:27 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id D5527159730E1; Mon,  2 Dec 2024 09:54:12 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-pci: remove two deallocate zeroes quirks
Date: Mon, 2 Dec 2024 09:54:10 -0800
Message-ID: <20241202175410.1207643-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wG-7L_Af0djmClZH7_OQt_MqGjEN8PXh
X-Proofpoint-GUID: wG-7L_Af0djmClZH7_OQt_MqGjEN8PXh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_095431_281844_94CEB8FD 
X-CRM114-Status: GOOD (  13.35  )
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

The quirk was initially used as a signal to set the discard_zeroes_data
queue limit because there were some use cases that relied on that
behavior. The queue limit no longer exists as every user of it has been
converted to use the write zeroes operation instead.

The quirk now means to use a discard command as an alias to a write
zeroes request. Two of the devices previously using the quirk support
the write zeroes command directly, so these don't need or want to use
discard when the desired operation is to write zeroes.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4c644bb7f0692..9535e35ef18a5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3588,12 +3588,10 @@ static const struct pci_device_id nvme_id_table[]=
 =3D {
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
 	{ PCI_VDEVICE(INTEL, 0x0a54),	/* Intel P4500/P4600 */
 		.driver_data =3D NVME_QUIRK_STRIPE_SIZE |
-				NVME_QUIRK_DEALLOCATE_ZEROES |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN |
 				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(INTEL, 0x0a55),	/* Dell Express Flash P4600 */
-		.driver_data =3D NVME_QUIRK_STRIPE_SIZE |
-				NVME_QUIRK_DEALLOCATE_ZEROES, },
+		.driver_data =3D NVME_QUIRK_STRIPE_SIZE, },
 	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
 		.driver_data =3D NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_MEDIUM_PRIO_SQ |
--=20
2.43.5


