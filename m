Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA4D606A32D
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PhFPohnA;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=V6bzAZZp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=54s/XY28gPj1MdKye4HEZJivjTWRn1il+4R4YG/d41w=; b=PhFPohnAf8vZyErGhPkBESvTQm
	j3bcqsRUYmzCrjf7SIUdn0dZKHddQeSce1PjDVmD/ZZvW0qK9xSW0HiHsMfCfQr/6UZaAdvI6VupK
	9A+k4IBKuec+TOHWWeRuIOtfEROiRHxIEasswkS2mRsrfC5/oc0p6CP11hD9TIdvw8hH3LTB+pToT
	FwrwrEIARPed296azg7rY2+2TgQNnoDMuDDBifdagr/REddJNg5LvrR6kNZDPb0gx6qQp6mP3hwHt
	aKvZjfMZNxOBmP6kxv4nDgFMF/jTJ/3dyYvrSGAQAYtxevF4N6onDSPYgc9p7SCZp8dHHFPXk68kq
	judRf2Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPNtD-0000000DFre-2nmu;
	Fri, 06 Nov 2026 17:38:11 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPNt9-0000000DFq9-3r0K
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 17:38:10 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6HWuKD3339540
	for <linux-nvme@lists.infradead.org>; Fri, 6 Nov 2026 09:38:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=54s/XY28gPj1MdKye4HEZJivjTWRn1il+4R4Y
	G/d41w=; b=V6bzAZZp/Rc2cTsp8cq5olqq6mtXTE6YVi+1+c4PL6W/fnsbpLW3Q
	JszVcshdN8V/kLGzX0PV7lxGEghED6LFpHhvbi7KSuRv1QRGv7Ipb1yoUEi4jzlI
	WcVWXzdBHnDOxr1QM3LVUcFI0kvF8DjzxMqWV9P7gy+oIxCGlAD//GzHbgJrxn6g
	e32OlJwxFKkz7wlVw2ty8Y2w7zsDkcoFKAb0phnZoNxw6kh4jFVnTdA3v/Bjq1Qr
	oQcRnYOsLdX3ep6PF2q3V69BSSAyr3oP+8I5l6F/3Y76fi9+tiQ2xJEYsawJBMqw
	2sfH70LT+viIkaEUfLOqp9CvvxNralw0A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hs3r35njn-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2026 09:38:07 -0800 (PST)
Received: from twshared8585.02.snb3.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 6 Nov 2026 17:38:05 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id BE5952E8DCBF3; Fri,  6 Nov 2026 09:34:55 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <tglx@kernel.org>, <bhelgaas@google.com>
CC: <maz@kernel.org>, <lrizzo@google.com>, <hch@lst.de>,
        <changfengnan@bytedance.com>, <namjain@linux.microsoft.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v3 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-X
Date: Fri, 6 Nov 2026 09:34:48 -0800
Message-ID: <20261106173448.34794-3-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261106173448.34794-1-kbusch@meta.com>
References: <20261106173448.34794-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfX3C9g9qFnoYMJ
 nJ5oAvxta7b2m5VojtTzElTPxfjiVWtqN7BBMXP2hlZSSeq5pnQeT1SjAYo/xUk066bOghtZRSN
 0Etw+9xPxdIhUbmJgHl/p5FrHbvaStPUEzNEy8MhvoX2VGgxJ0a+ETf1zBqiuvo6isPyynYwoR8
 eYhPExlWBovG8XrPA8ZeE+Ntp7PVq+63UnT9maxyt6tX8j0BIztGqJ2gM0eQ2Am+lwBOcUtWUQU
 7qs9SnJTRSYE3IubTFEgC8ej2edGYXxtI8CQqZF70pN33dor9EOqSqFLYmKgLBnJ7uF0T6RRfdk
 LyHXnHP6nV/6oOdKFVr1kzo05RmVr/HUCT/rrHC+KNhFdbeSGDTXxOPicCFjK9mq/t8D8M8E/jl
 rYINccGvWLnouMxua9tkxWCFEEnOTxxP3qP2qrvjLwdKK0mRTIhlMYbpat7TnNOau9h7FPSGGhH
 N0dTPyrO3bS7QcAxPbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfX+3ELLMesMlG2
 kBgx80atmQ534ddPPfbaJhD/wIOVn2pP+t83s33vqUgwM1KksV2JpjSRo8cFipW7dFbXrnG61sz
 BMaxQaZBfHAQj9YANXzV19VwT7QoObs=
X-Proofpoint-ORIG-GUID: 1ZL2MXYMJ8rbT-XFxcPVfdJMcsxi6s3u
X-Authority-Analysis: v=2.4 cv=N468hG9B c=1 sm=1 tr=0 ts=6aee107f cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=03ozwUkBphtHgyqjj1sw:22 a=VwQbUJbxAAAA:8 a=hxC21McARV9yLVABsx8A:9
X-Proofpoint-GUID: 1ZL2MXYMJ8rbT-XFxcPVfdJMcsxi6s3u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_093807_969241_C130526A 
X-CRM114-Status: GOOD (  11.48  )
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

Skip the read-back that flushes the MSI-X mask write. Parent domains
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


