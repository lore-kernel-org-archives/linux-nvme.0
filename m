Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C128606A326
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GbspXYAT;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=iaNcJSjq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2u2HaXWVBlsAShP0j1POHMWxhhA5tg6guUv3sGangSk=; b=GbspXYATLWP4jU5eaoy0+9cvPj
	ADXLqpXYWIAxyEyV2leWmARf/BTxCPnwEqq3aqIEX8C1keKxosVcoA/ePunwALDdGdtgjGUwpuLqr
	pFeP+RceZ7o53G83y3ZGF9d8JfyyyUSp7neYsrxy42NdkrXMc6LCT/T2vbEZ02zBMWlwklL8xl99J
	R1JyizELyVpBy7nquoyXofR2pnLpxREECa+F2R6M5ezA6za+MGwF5ppKgjfOfERxPvO4fUwjOgELl
	0qXNI+G/AIsur/aLdk0GQy6wQrJ4wKne5y6dGtuT9ABHCWn4Q2VxJ4H6A6xaowMLxLV6oDojiWOOX
	kunRPNLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP2za-0000000AJEN-0TP5;
	Thu, 05 Nov 2026 19:19:22 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP2zT-0000000AJBf-0Q0X
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 19:19:20 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5J5nDC309699
	for <linux-nvme@lists.infradead.org>; Thu, 5 Nov 2026 11:19:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=2u2HaXWVBlsAShP0j1POHMWxhhA5tg6guUv3s
	GangSk=; b=iaNcJSjq+xKM+jm8kXik2b60JEih0xOzmPbTcN/vQL4Gb80hb5D7d
	qh98FI6PlZZD89dB3UwK2wqdJweOG+hSz+hn9e2mT24qI6rhL61ZUrFi1Z/T6U3E
	baDG/kN3F0rTNuQdsNyNetGmFdUrtoxXTnoBqDBhTOo31VDUEfhKrOYv5dh52HL6
	8y4xV60zKsNS2ij279XDsBtfQjqnvvzPfgK1QZgP2b6Dre3y8xUdI1H27TUGyMIG
	/ZMjvxOEMSUbXzvgWdJsTPTGtcvfNAaoXp1KrHwe+qWnc5vKEbsGD2pQtH6lpD7y
	Lq2uQmsBmnhQFx2EGOrc+ACOcoTfk3ebQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hrb4a07gt-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 05 Nov 2026 11:19:14 -0800 (PST)
Received: from twshared21535.34.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 5 Nov 2026 19:19:12 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 0E84B2E811C68; Thu,  5 Nov 2026 11:16:01 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <tglx@kernel.org>, <bhelgaas@google.com>
CC: <maz@kernel.org>, <lrizzo@google.com>, <hch@lst.de>,
        <changfengnan@bytedance.com>, <namjain@linux.microsoft.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-x
Date: Thu, 5 Nov 2026 11:15:56 -0800
Message-ID: <20261105191556.4042191-3-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261105191556.4042191-1-kbusch@meta.com>
References: <20261105191556.4042191-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3NiBTYWx0ZWRfX2qHEuzUzv3no
 fNyd98+57BpATp7KHrnqyD9TFemN1Vdym/EwQ8RMDAbEgpi371myoeMQ3lO29Y/Mjai0iKfm4wO
 6rVw8G48dTcnykkULr75jaokTSDXbRA=
X-Authority-Analysis: v=2.4 cv=U7sHnuru c=1 sm=1 tr=0 ts=6aecd6b2 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=wpfVPzegXHpEFt3DAXn9:22 a=VwQbUJbxAAAA:8 a=hxC21McARV9yLVABsx8A:9
X-Proofpoint-GUID: UGZvZUn8Z9557OiQMLizv93xuz-hdMDL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3NiBTYWx0ZWRfX5R33OO2hWp++
 W9vP5m5Y81+Oup0UHVDgjxFvEcjrvK34QoDzR8pfunwNZID2aSGsjCa1mvXasXask/KrY4jx270
 NybptGqV/BSpicbx+wq187t3ZjazEHC8JO0xD9yy1mlwn4bLRJbLHG/hVRDIAWbB2Hm9E1yVWgv
 aEZ5SRdnFsR1I74RsdOnm7QQLDa4VS4OEYPTsqoAninyRaNOvl+5STJizQUTgqhkVZBfIWwN9Cs
 wMNn6pgQm8F1ykycbjminI2k76RQN1V+yEjtKCm17LekD/BktoONtRK6dGCvf5Ki5DN1Kmwtv5n
 qDNmv/OGOr8yqP7k4Kz0KxuF59iT7IWNC2PR3eLIbdce3mLHGOhsqgoh7IPNPGiR/sN12bq2Moh
 8L7uooXtBjnUIDHj9U+ev1y5/HHBeF0wCYjXAONdMwQ8q1F7pbzPbaAOl6VC1qj9uG+1x/eymun
 mynUUr7QNAJ4tqVGjUA==
X-Proofpoint-ORIG-GUID: UGZvZUn8Z9557OiQMLizv93xuz-hdMDL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_111918_796011_14CF1176 
X-CRM114-Status: GOOD (  11.75  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Busch <kbusch@kernel.org>

Skip the read-back that flushes the MSI-x mask write. Parent domains
that mask on behalf of PCI/MSI keep using their own irq_mask().

Suggested-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/irqchip/irq-msi-lib.c |  1 +
 drivers/pci/msi/irqdomain.c   |  6 ++++++
 drivers/pci/msi/msi.h         | 10 ++++++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.=
c
index 45e0ed3134ce1..97bc95d592122 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -126,6 +126,7 @@ bool msi_lib_init_dev_msi_info(struct device *dev, st=
ruct irq_domain *domain,
 	 */
 	if (info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT) {
 		chip->irq_mask		=3D irq_chip_mask_parent;
+		chip->irq_mask_noflush	=3D NULL;
 		chip->irq_unmask	=3D irq_chip_unmask_parent;
 	}
=20
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 6e65f0f44112e..2b9a5a0c305fb 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -162,6 +162,11 @@ static void pci_irq_mask_msix(struct irq_data *data)
 	pci_msix_mask(irq_data_get_msi_desc(data));
 }
=20
+static void pci_irq_mask_noflush_msix(struct irq_data *data)
+{
+	pci_msix_mask_noflush(irq_data_get_msi_desc(data));
+}
+
 static void pci_irq_unmask_msix(struct irq_data *data)
 {
 	pci_msix_unmask(irq_data_get_msi_desc(data));
@@ -182,6 +187,7 @@ static const struct msi_domain_template pci_msix_temp=
late =3D {
 		.irq_startup		=3D pci_irq_startup_msix,
 		.irq_shutdown		=3D pci_irq_shutdown_msix,
 		.irq_mask		=3D pci_irq_mask_msix,
+		.irq_mask_noflush	=3D pci_irq_mask_noflush_msix,
 		.irq_unmask		=3D pci_irq_unmask_msix,
 		.irq_write_msi_msg	=3D pci_msi_domain_write_msg,
 		.flags			=3D IRQCHIP_ONESHOT_SAFE,
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index f987cf897264e..c40d24e5ca901 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -44,14 +44,20 @@ static inline void pci_msix_write_vector_ctrl(struct =
msi_desc *desc, u32 ctrl)
 		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
=20
-static inline void pci_msix_mask(struct msi_desc *desc)
+/* Posted write only: the device may still send an interrupt after retur=
n */
+static inline void pci_msix_mask_noflush(struct msi_desc *desc)
 {
 	desc->pci.msix_ctrl |=3D PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
+}
+
+static inline void pci_msix_mask(struct msi_desc *desc)
+{
+	pci_msix_mask_noflush(desc);
=20
 	if (pci_channel_offline(msi_desc_to_pci_dev(desc)))
 		return;
=20
-	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
 	/* Flush write to device */
 	readl(desc->pci.mask_base);
 }
--=20
2.52.0


