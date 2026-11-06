Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD028606A32E
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pVmI8FqF;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=IO9RGWok
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=Aa1inciFCzYw1Srr/tci0p6G+k8c03Dt2gAFbSarJOc=; b=pVmI8FqFzU+5dwIuc66p2kbA3z
	LqmlMfZa2dIoaRiBkvchQNpXcEePAf9C5z+A7i7aUWxfpIfZyq5Bt7qqE3viZZwt/OpST8RJhJMD/
	ZHQy5Hivfjt4IEDegnknMRXnnps3BWnmt9ozyPSKiorLDqz6y1ZNro9/3s0EQd5SUtlcJpQl2vJY2
	bgzpK35ju1id+EdVIAWm2d9QAYC3Yb9rZUMh17Yto26sSItSwSIIxUkr6Sh8fkBpwqwa563vYKHwO
	nD2FbPX1pu0meUIqPk1ICXncCwj8PSXH19/m+ts0ZdLW6ckdQcxTvs5V0MOcX3rHG2/H7poqN9vOG
	3e67kZeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPNtE-0000000DFrl-0JKY;
	Fri, 06 Nov 2026 17:38:12 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPNt8-0000000DFpJ-2Q78
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 17:38:11 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6HWTbB1219991
	for <linux-nvme@lists.infradead.org>; Fri, 6 Nov 2026 09:38:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=Aa1inciFC
	zYw1Srr/tci0p6G+k8c03Dt2gAFbSarJOc=; b=IO9RGWokpUqk3ljwDRugG0NxN
	vtZtht1R1cG9huXjIcWFdhoMthQOefBihrp6P4fmVny9bjBcOvWZpUXH1Uot7tq3
	PbnxVYGHeuF0YuyOjWW+ULB8d2S/jae/lubKt8MmB5qrsK2GoBu8c9FJwPkGprcZ
	/Tp7FhaH1HRKz5l79H1rWqgKQLmx6dzezXZhdsJNZJJPZCz7BueFiPkievH9jx1P
	NvwVbBs2jx4pH8KEqUEsZMPrXfECs0zbtwlwGvCT3hAR1ELK3jsd+8lbfd9dsnUi
	mKAAtwOs1iPaFAdslvIPwj6a2Culo1UC/2MMQ0o+iucTcPf859meXz8sNV5Gg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hs3r6nnrv-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2026 09:38:05 -0800 (PST)
Received: from twshared31846.02.snb1.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 6 Nov 2026 17:38:02 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 72ED32E8DCB9F; Fri,  6 Nov 2026 09:34:48 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <tglx@kernel.org>, <bhelgaas@google.com>
CC: <maz@kernel.org>, <lrizzo@google.com>, <hch@lst.de>,
        <changfengnan@bytedance.com>, <namjain@linux.microsoft.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v3 0/2] genirq, PCI/MSI: mask without flushing
Date: Fri, 6 Nov 2026 09:34:46 -0800
Message-ID: <20261106173448.34794-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfX2AiBzYOEWyHW
 L1dMyf4L5M9hzsbbpHDswSGG1L36xf1ozG6j2X+6+cO6+UcCRgsYscxJ3fXEjn/cpMntWhJJWS8
 MYPmU+bTEFNNOsxr/0wDgdJIZLlRIDOweuOXIsesGIm2uP8jKfpnq4+BU8/WBmcxwiQe2vUsfoI
 JYTxQGeOczJZmjfAGHJTWT6k9+PdZQsRapyCfmDfX8Iwm7cXEjm/zariOUq66lNwHNTkAfJaKaI
 jJLlBX9J3OA/WG1d3Av1dMgVh6G/R/LvocPPfma9j/p/GrquG1VJPgImS4Q2tiOibTW6C7Kg6Y7
 54ixJ3EOCD3Dilyr1ulwOiRMRz26L0Ydn0PjErgaTEJjXmDg1GWme5FSfPhjNA/D4C/Nh8vyhF9
 OFHPT53JZfl4vPVRedP/SQSeKsGaujPzTdy0vZ6bKcQAjuW3LjHGRre79MvOjl1JJHQSE3Ly9yW
 VoPuCtiLuK0YVt4mJdA==
X-Authority-Analysis: v=2.4 cv=IsGL47/g c=1 sm=1 tr=0 ts=6aee107d cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=TAX1gFrxjG5BdyIcG9sA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 8EGshkfaPh-lxd76A_p2kdztfU-sprun
X-Proofpoint-ORIG-GUID: 8EGshkfaPh-lxd76A_p2kdztfU-sprun
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfX6TApBOLiOvCw
 4bnXwx+wnrrzbWiJ0ii282gJw6lUtoMKrQYluk2D8Mp+ZOdsZj+TBlDEMvED3KxFp6UC7M3wl6o
 UFKJNA0rDHsww4TzcRTlf8cp8ZE1C4Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_093806_624327_2EB8DD5C 
X-CRM114-Status: GOOD (  10.43  )
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Busch <kbusch@kernel.org>

This adds a new irq api, disable_irq_noflush(), backed by an optional
irq_chip irq_mask_noflush() callback, and implemented for PCI MSI-X. It
writes the mask without reading back, and is for callers where an extra
interrupt after returning is harmless compared to the added latency of
flushing the masking write to the device.

There are no users in this series; the hybrid irq/polling work from nvme
is expected to use it when switching between MSI-X interrupts and
polling, so these are posted separately as prep patches that are
hopefully generally useful.

RFC with the nvme usage:
  https://lore.kernel.org/linux-nvme/20261013223543.395054-1-kbusch@meta.=
com/

Changes since v2:
  - Just the commit log to use the preferred "MSI-X"
Changes since v1:
  - Keep the channel offline check guarding the flush read in
    pci_msix_mask() (Sashiko)

v1: https://lore.kernel.org/all/20261105182706.3700908-1-kbusch@meta.com/

Keith Busch (2):
  genirq: Add disable_irq_noflush()
  PCI/MSI: Implement irq_mask_noflush() for MSI-X

 drivers/irqchip/irq-msi-lib.c |  1 +
 drivers/pci/msi/irqdomain.c   |  6 ++++++
 drivers/pci/msi/msi.h         | 10 ++++++++--
 include/linux/interrupt.h     |  1 +
 include/linux/irq.h           |  3 +++
 kernel/irq/chip.c             | 31 +++++++++++++++++++++++++++++++
 kernel/irq/internals.h        |  1 +
 kernel/irq/manage.c           | 21 +++++++++++++++++++++
 8 files changed, 72 insertions(+), 2 deletions(-)

--=20
2.52.0


