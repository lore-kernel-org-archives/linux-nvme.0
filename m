Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CC1606A31B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=r9lafJNL;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=T8emXqUo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eV4V6Ql1yhUSOIj1G8kZxYoZiaKbhuIw/lAOeIWjF9M=; b=r9lafJNLbs8xSYYSiq80D/CAL1
	J9woUPL1rfd/jRLn9a9i+T56z7oXvqgNm8tHQKFgq+dEqTl1gwg5cjBDb1FwFNeE1wz/TrRCh/D3m
	vk0rMJTvbiYoR0gPmpso5XTYCk0Io5f8k+a0nPIYu2tXkphEBXxjTcu5fhtAqSamDg2bqT2cj6zY0
	q3awA2AI8O8dtGR2tJzaGn5bvyAL9k1sEXAUF6JIC27BR/L3/hfMh9TIYvRp3O4l9vGgG3zXuq6Nc
	fNuq1h9HmaElRvxBYY2qJD3MMNSWKJHO9ACSsiNnHUwWUVqd/UjGE818VKVd7ot3jTxwPQKcmPCDH
	XGClyDIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP2F1-0000000A8sR-1pKi;
	Thu, 05 Nov 2026 18:31:15 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP2E6-0000000A8hO-3y2V
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 18:30:42 +0000
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5ITeKE3625204
	for <linux-nvme@lists.infradead.org>; Thu, 5 Nov 2026 10:30:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=eV4V6Ql1yhUSOIj1G8kZxYoZiaKbhuIw/lAOe
	IWjF9M=; b=T8emXqUoqVc4kTuT7RyenACt8BFRKC2HrVq1TKtuJX6fh1RZSRp63
	OmFyza33VwCHdS2CnBiBZcEIXhXhncktS3LTL3eIGDnLe/BrVe9ZItYyejncS+VJ
	rLZjxN3EKiAalZC5s//I3b/OKYTG2yrGw4mtT5abzsWn1lirXe5sTyUfuG0qQNt2
	dIjYf9Gk0s1KfIMR0I2f7aU6lJ77Ml3viCTcpHYcpkuIzD1gk0RHPb9bji5QNgEy
	uW9k6Zlnvzg/Pp52TTaPK6z+i470n/Ndzu36EDKWw3ZhR/WhIlNodefNC8evCAxO
	gkhxhBfPf6H05VXXSTVC2TqcrbUuKSkAw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hrq68ujf4-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 05 Nov 2026 10:30:17 -0800 (PST)
Received: from twshared21535.34.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 5 Nov 2026 18:30:10 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id EB5882E80C129; Thu,  5 Nov 2026 10:27:06 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <tglx@kernel.org>, <bhelgaas@google.com>
CC: <maz@kernel.org>, <lrizzo@google.com>, <hch@lst.de>,
        <changfengnan@bytedance.com>, <namjain@linux.microsoft.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-x
Date: Thu, 5 Nov 2026 10:27:06 -0800
Message-ID: <20261105182706.3700908-3-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261105182706.3700908-1-kbusch@meta.com>
References: <20261105182706.3700908-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX56nL5bYqv1WS
 8ssDPWDiuUS1dJAWBv9SpVHNRiAEN0khv/mF+JGl1w+/kdrT4+DLKlgcOLzoh7v7wf//y1mKplK
 2FRwftXL/ZKS71V78e5mYmDzPJWguVG3mdBJP9eMDYljm2lL2OqABkLVSqbbQqEBdDMfZyW/lFJ
 ZQU7P2nkxDScFA0tG6J7cIuGfiz1N9jpiG25GzfXOvWQqgaUEuqXU3LnJYg5eC/Mj6syEyu0ri+
 dqvwYSDsEXaZwBGadKAjSldC9wq6u8oekeRU/qwYj4YCKy/cXYAyLM5b+DJqsApDdkuORcBhzgm
 /1itM3BDY/wixUMzn1UAQEfAEkDn+djd9kybCPH6sdJXPvehx2ZpDmE6V7lYdk/uj2llwgRNsMD
 9R8GMghG+wwdV76kfxSrE9PB6rb/34JC6X0c1GC7/Uob8jFdUdycXU0GCV+6zwn7VvT627zd1dP
 QIJe763teWD22EXvWqQ==
X-Proofpoint-GUID: wWuxJb48XiFFf1No6ZLtr0wOcKbrfwRF
X-Proofpoint-ORIG-GUID: wWuxJb48XiFFf1No6ZLtr0wOcKbrfwRF
X-Authority-Analysis: v=2.4 cv=adP0Dhot c=1 sm=1 tr=0 ts=6aeccb39 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=kkcUborcUVj0H7zxAXTl:22 a=VwQbUJbxAAAA:8 a=zwF_Yp6pZpUqULGlHS8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX4X6zGbX14DL/
 45OpSlgclW1gx3NZEw6vrF/EuuRcPtVguCSqwcEf57kyqaRFVin1M2aLLrPZ1Z9xed+Qq4bBLws
 F/SsGUqB/Vmjnb4iERWzmGKLX0k7rIE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_103019_897942_465E3893 
X-CRM114-Status: GOOD (  11.35  )
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
 drivers/irqchip/irq-msi-lib.c | 1 +
 drivers/pci/msi/irqdomain.c   | 6 ++++++
 drivers/pci/msi/msi.h         | 8 +++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

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
index f987cf897264e..db4dc37888f73 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -44,7 +44,8 @@ static inline void pci_msix_write_vector_ctrl(struct ms=
i_desc *desc, u32 ctrl)
 		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
=20
-static inline void pci_msix_mask(struct msi_desc *desc)
+/* Posted write only: the device may still send an interrupt after retur=
n */
+static inline void pci_msix_mask_noflush(struct msi_desc *desc)
 {
 	desc->pci.msix_ctrl |=3D PCI_MSIX_ENTRY_CTRL_MASKBIT;
=20
@@ -52,6 +53,11 @@ static inline void pci_msix_mask(struct msi_desc *desc=
)
 		return;
=20
 	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
+}
+
+static inline void pci_msix_mask(struct msi_desc *desc)
+{
+	pci_msix_mask_noflush(desc);
 	/* Flush write to device */
 	readl(desc->pci.mask_base);
 }
--=20
2.52.0


