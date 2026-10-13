Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C87CC6B1D
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 22:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=11ciqoNzryubv81w4EwgfcXUZZJqEdjWU7J2LGoY9IE=; b=jRu578/gUNm4Gyfl4egL1IQx68
	1JACbbUDfPOyP0r6LlzOUABk+7A5bUr8+kbzNjx0sNmeSkmwgBwSs3gpVnpDvqxycaOr8sLCblA1j
	sMmm8LhO/FY8sbIJq5vsmRxY/o3osxXP2EIOoo/Ej6Fg8AU1OQYN4nebnLTGELhfolLst3jBjEhJD
	GLP17IRuPBAM0YASYcTM0zq/guiWwWzhvBdEIUv9wUK0qEUOTME5mkvyUso+CJs1oYrehhuNrgv10
	mrfMm6Bs2a4KfbAVdU2myXMKlXpB6lKbtycDeN+tv3eMStLrtTt8qx2Voh9eQoBV2mfTJ0EoIE+iR
	8j6w9roA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGl6Y-0000000E8qZ-1YnI;
	Tue, 13 Oct 2026 22:36:18 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGl6W-0000000E8p0-11lG
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 22:36:17 +0000
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DKWPGQ610125
	for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 15:36:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=11ciqoNzryubv81w4EwgfcXUZZJqEdjWU7J2L
	GoY9IE=; b=IXn+iPYxoUSGlirIVoatVbUwvj6XI4B1FuMjr1+z7MbLsPpQyqKcN
	5Z9o5+063NqKe2u2CdmuIvAtGqqKSU4nhoEeyglRQdQQHh1rSrPYiBROzINYmepw
	GF7ihDKS/I+jDL/snHQ79atmUXBbA059DVYMfRA2ZafP+xuvcGTzqU10js4PoUUE
	9TTyi1j6TNmW+0VkPOh47Zf3mvvP0CKQYfg+FZBVHDqYiwzBFTEzkJnBLgndj3+/
	hJOhc5yMmYifJvWBuzhMsVporHIXMPe4QNTr7FguWXuJinlKSC2bQIs3ckakOs3y
	VCYBHiuSbY5tdkvyFtkD/nDQbQOlmUAvw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4h860hy7mv-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 15:36:14 -0700 (PDT)
Received: from twshared9243.02.snb2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 13 Oct 2026 22:36:13 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 6EDF22D52CB7A; Tue, 13 Oct 2026 15:35:53 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <changfengnan@bytedance.com>, <linux-pci@vger.kernel.org>,
        <tglx@kernel.org>, <namjain@linux.microsoft.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [RFC PATCH 2/3] PCI/MSI: Implement irq_mask_nowait() for MSI-x
Date: Tue, 13 Oct 2026 15:35:42 -0700
Message-ID: <20261013223543.395054-3-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261013223543.395054-1-kbusch@meta.com>
References: <20261013223543.395054-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4OSBTYWx0ZWRfXwfFM0tPkkil6
 CWPY21lhdcMQ5ZkZsbQdlMvikjXYB3+4iwrZsJcxNZUJ5uCI6VeOaocJX7oyBFfmi3QbJAjFGJZ
 U3tux89jkrESClcPGLtcMp+z4V7gdhE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4OSBTYWx0ZWRfX2csVbgjZzOPu
 SO+i2n+TSE+xYQ3dmJI5YlWp3/clcPAUDrkCAkDKxB1rQbYM96ZmZemNs1zXNdV0YeKkcfiD5/E
 Y59SiJFjqlehXy0vHbYhPe2ykohS/gQYHhAKeg62LppzAWIdL1oreUFol+cPE1FyYR4AIsG3bQd
 jJdYEuUEqtQQXusDSzHlR9vjNnXXQ+qr1tmjQyHuIF7l23sx0XXD4vk6tjoB4WtMrEEseASbCyZ
 99bIQub/EZQ/pQk47fnBZgX5spXv2S482YENkIZgVjLfV/TuNousbGGcz9KfbU1OLWqixqxw2cE
 Ug4wj/KQIhxLRcn+Gwp3cuszchyP3rcIuccnHMdKZo2sQZdtgUibOaHfkBrVgrh3i/+3yJM8ceN
 xV2mVnKlp+K5iOtwFyy6wepy+l5t6Cpo/+kjzRmy0bD1PxiBAarMNb6YBLhBtsO/+XbXWgt/gGO
 mcR1DuoxuGJqoeN90tg==
X-Authority-Analysis: v=2.4 cv=cJx1IVeN c=1 sm=1 tr=0 ts=6aceb25f cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=kkcUborcUVj0H7zxAXTl:22 a=VwQbUJbxAAAA:8 a=zwF_Yp6pZpUqULGlHS8A:9
X-Proofpoint-ORIG-GUID: VOai0XpoMWULrW2T-sGGU4ur-J085NCS
X-Proofpoint-GUID: VOai0XpoMWULrW2T-sGGU4ur-J085NCS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_153616_425153_918AD17B 
X-CRM114-Status: GOOD (  11.84  )
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

Skip the read-back that flushes the MSI-x mask write. Parent domains
that mask on behalf of PCI/MSI continue using their own irq_mask().

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/irqchip/irq-msi-lib.c | 1 +
 drivers/pci/msi/irqdomain.c   | 6 ++++++
 drivers/pci/msi/msi.h         | 8 +++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.=
c
index 45e0ed3134ce1..bff622b4839aa 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -126,6 +126,7 @@ bool msi_lib_init_dev_msi_info(struct device *dev, st=
ruct irq_domain *domain,
 	 */
 	if (info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT) {
 		chip->irq_mask		=3D irq_chip_mask_parent;
+		chip->irq_mask_nowait	=3D NULL;
 		chip->irq_unmask	=3D irq_chip_unmask_parent;
 	}
=20
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 6e65f0f44112e..92a53c2772659 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -162,6 +162,11 @@ static void pci_irq_mask_msix(struct irq_data *data)
 	pci_msix_mask(irq_data_get_msi_desc(data));
 }
=20
+static void pci_irq_mask_nowait_msix(struct irq_data *data)
+{
+	pci_msix_mask_nowait(irq_data_get_msi_desc(data));
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
+		.irq_mask_nowait	=3D pci_irq_mask_nowait_msix,
 		.irq_unmask		=3D pci_irq_unmask_msix,
 		.irq_write_msi_msg	=3D pci_msi_domain_write_msg,
 		.flags			=3D IRQCHIP_ONESHOT_SAFE,
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index 0b420b319f50f..337ff9d9da0ed 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -40,10 +40,16 @@ static inline void pci_msix_write_vector_ctrl(struct =
msi_desc *desc, u32 ctrl)
 		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
=20
-static inline void pci_msix_mask(struct msi_desc *desc)
+/* Posted write only: the device may still send an interrupt after retur=
n */
+static inline void pci_msix_mask_nowait(struct msi_desc *desc)
 {
 	desc->pci.msix_ctrl |=3D PCI_MSIX_ENTRY_CTRL_MASKBIT;
 	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
+}
+
+static inline void pci_msix_mask(struct msi_desc *desc)
+{
+	pci_msix_mask_nowait(desc);
 	/* Flush write to device */
 	readl(desc->pci.mask_base);
 }
--=20
2.52.0


