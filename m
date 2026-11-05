Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE11606A326
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=28XKjb9h;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=JApOvJMj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=ge6S26TMgHzYn7CB5Vllm5OsMg5f83lV+CM0P6k32bk=; b=28XKjb9huEW/WwaO1JK4zIbWqw
	xsfv9U8Qd4MJb19mNO5o0IRGMFtsFFlOFRZK6xFe7o5+GwF3/H4wevMVbd9SdeKvSOSZuBhEr2olC
	0CicKGHtwmAuzhjSIiHy+epzq2UfEwSsvblytaFWQr06dv/Nz+Y4IjEhJU/FlPR0nUU1WDoM8FMAv
	f2dJtaiOKcW/D8SLoO6HLu564lig61XH07/btclVEeWvaH2pp85U0ddquOtArMdqjZCHbnslFCdv2
	uoQA5g1YL6xU4+aQOVhylFxH+TeKzvkUtecD+lFKwdP+sYIARq2bY5pbiKDrCTgJgj83H7smbY0hu
	+ohl8Awg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP2EV-0000000A8lB-0a90;
	Thu, 05 Nov 2026 18:30:43 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP2E0-0000000A8gN-41cx
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 18:30:41 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A5ITjNt2341302
	for <linux-nvme@lists.infradead.org>; Thu, 5 Nov 2026 10:30:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=ge6S26TMg
	HzYn7CB5Vllm5OsMg5f83lV+CM0P6k32bk=; b=JApOvJMj1JmRjH8w/fAAp1jmQ
	EiuDYbJXzlS3l2CmqsYlxdUuN/MaCm5EWdlHGW99i+/P5lyzzGWLUOdM8u8ukz33
	6YwGUwvY08SvnZArzU/5QaqoDPsMZZde4HdGVKz1yaiqLFbDqmzw9WIibA4veiCW
	AvLNlz++gJ0yZvkR/a68yq9aLUBFvGDdxNbopnHict9YwwX4hXREEiQ3k/hR9pfw
	nvnpV7cRTFDpInrtrlNLzB55u0CvX8ciaAPympYJlpi4uKWYzBfueF1EMSsx8l5v
	0qpUasOOmnPy2XlrA2ln96qZUjqlJxK/COZAnDWV+8RDhKqtjZE0TvPjMwGVA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4hray5yxmg-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 05 Nov 2026 10:30:11 -0800 (PST)
Received: from twshared36767.32.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 5 Nov 2026 18:30:08 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id DA8002E80C123; Thu,  5 Nov 2026 10:27:06 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <tglx@kernel.org>, <bhelgaas@google.com>
CC: <maz@kernel.org>, <lrizzo@google.com>, <hch@lst.de>,
        <changfengnan@bytedance.com>, <namjain@linux.microsoft.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/2] genirq, PCI/MSI: mask without flushing
Date: Thu, 5 Nov 2026 10:27:04 -0800
Message-ID: <20261105182706.3700908-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=b44ncdGx c=1 sm=1 tr=0 ts=6aeccb33 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=TAX1gFrxjG5BdyIcG9sA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX3IpJ5YH71gVi
 83LHpMFT8xP/FC+WfOL0oWxVd+lxyjJBarxDfg9jn4y8vDB5n5325TJHK3etkNREa00OqceWhD7
 pfqGox1bn4bsn+tMSiCHrXZZaHt8F30=
X-Proofpoint-GUID: aejTiatZ0E8CQSr-I_wMskbZnqomT5SU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX7dfS1QqEd8Pj
 JjVS6SqnPiXjPjl4/EH8cnBZOMbicQ21K6CL+M/5PTa2rdPRE9c46VNMLRapnDhyAVOmIzqiTiy
 JBpUXSiZp44cVkZbYObsvR9SB6Q3Ax/jTNGUJJbZxjXkq94y/e7xbp+vkX7bkBpdtFTZTsMcBmw
 4mnVgR1CoG7NwekIHfFiS5fb+1xsfkWx18JQokBQsvMQE3fI36n/XgCi6ZUIQUPrWNRT9SknPKY
 Nb8YhxEjNnCM08HuPWBs6UHk/ygwa1GeIwRdaM6Iz5HdSDOVqszJsaVB3IV39kmPPBJdI6wdA8A
 Z/O1ioQtMIOWpS9eQTgh8qsWW2T6csew7T4ZbGv7STuxzrIMc2lt1Y5tiO/sW407M4v+Z1+4sto
 brKAg7hrgHmGNX1wDaw4JKY98/32mfighx9kgFOuQQZ1kTqUFq6nUwpMrinQXoeZd8Ka8YU9SEI
 xegptm9lcGj+qewPwcA==
X-Proofpoint-ORIG-GUID: aejTiatZ0E8CQSr-I_wMskbZnqomT5SU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_103015_799395_0DBFFFDA 
X-CRM114-Status: UNSURE (   9.38  )
X-CRM114-Notice: Please train this message.
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
irq_chip irq_mask_noflush() callback, and implemented for PCI MSI-x. It
writes the mask without reading back, and is for callers where an extra
interrupt after returning is harmless compared to the added latency of
flushing the masking write to the device.

There are no users in this series; the hybrid irq/polling work from nvme
is expected to use it when switching between MSI-x interrupts and
polling, so these are posted separately as prep patches that are
hopefully generally useful.

RFC with the nvme usage:
  https://lore.kernel.org/linux-nvme/20261013223543.395054-1-kbusch@meta.=
com/

Keith Busch (2):
  genirq: Add disable_irq_noflush()
  PCI/MSI: Implement irq_mask_noflush() for MSI-X

 drivers/irqchip/irq-msi-lib.c |  1 +
 drivers/pci/msi/irqdomain.c   |  6 ++++++
 drivers/pci/msi/msi.h         |  8 +++++++-
 include/linux/interrupt.h     |  1 +
 include/linux/irq.h           |  3 +++
 kernel/irq/chip.c             | 31 +++++++++++++++++++++++++++++++
 kernel/irq/internals.h        |  1 +
 kernel/irq/manage.c           | 21 +++++++++++++++++++++
 8 files changed, 71 insertions(+), 1 deletion(-)

--=20
2.52.0


