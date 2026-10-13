Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FF9CC6B0F
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 22:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/p1VXRvPsdzpyNaMEVuZe4zu8qtnztrsEYEyfTDBzQc=; b=JztqZOzOJ2zenv950RSxJMx+3f
	V+EA5VcJnn6WvyCLw+oRxVcC7p+7TarkF9fP26vnqG7ZK8ARn/yEwmo4wkKvSbP3bTST+bd1EU5uk
	DtLWUnrSmk7mmW8AwmWy8ELbYKXI0mY7w8++jDw/pcKRbGYouXjlJeundbuEgb73Ye6cfxtpFJFPl
	oP04/hMCINOr3dlM+8cbne+0oIRqHs6/NOYFtDae9vdtxFFM4luHghS0SQEsqkT/2gmkk/4CqYIYJ
	cFahM6MV2VSDbiR3vwf4J/1CkgobUVHM/4QCBRT96PSAfxSsDV+thxWhV5UFMJGzYqRp97blyP3lW
	mz5qBsuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGl6a-0000000E8sE-2cal;
	Tue, 13 Oct 2026 22:36:20 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGl6X-0000000E8pu-3R5q
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 22:36:19 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DKWlRv1625157
	for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 15:36:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=/p1VXRvPs
	dzpyNaMEVuZe4zu8qtnztrsEYEyfTDBzQc=; b=BhLvAeaOps4E1nARaARTQJD/J
	3Q6PwSPs4NCSngoBTQY6Gi6lyXhiDHIZoR3hIM0qAgP56RWgvlqEoa+kBBy0mIjK
	PZP5RpU8ZzPjcs5QxdUFvbRrKV3FdBF3vRZhG9DLsOnMs7w3dOaC+IsQx9+CNVgR
	29bY2yHUTuPIjQS5mDdq4Ct2U33F0HlBzQ1iLNidpe/jE/MohndOKR++VawsI/Dn
	a1aB2pSnjRhDSBydq+gyF6LDaqGJxfldiNnllqI3Li7hOtoQXIoTF5UgDwbJSK34
	5sExcFPsOUepKDrgFSf73bxLi5Qw3Ke1UmsOo9rKdvohnZhyzOfvqdguaYjpQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4h9hc46f0v-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 15:36:17 -0700 (PDT)
Received: from twshared134145.14.frc2.facebook.com (2620:10d:c085:108::150d)
 by mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 13 Oct 2026 22:36:12 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 6417A2D52CB77; Tue, 13 Oct 2026 15:35:53 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <changfengnan@bytedance.com>, <linux-pci@vger.kernel.org>,
        <tglx@kernel.org>, <namjain@linux.microsoft.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [RFC PATCH 0/3] nvme-pci: dynamic interrupt moderation
Date: Tue, 13 Oct 2026 15:35:40 -0700
Message-ID: <20261013223543.395054-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=L86I0OT8 c=1 sm=1 tr=0 ts=6aceb261 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=968KyxNXAAAA:8
 a=czqYIZ0shksRg8RT8RcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4OSBTYWx0ZWRfX4PF6AKwMAYSJ
 1cODVKthspII3bCzMbEACoxZIJ6svEAn7XUCPfdbamH1PBTZPtRPdtWIeiK/Wo25K76hfdjS4Ow
 d6HPctsjRhRAELsiP9kRVIHhYmqnAg0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4OSBTYWx0ZWRfX+ad8nkUrA0jb
 7enoYFolaWMJSO84YB1NZAsXR/sLTBo0Qo0YtcTCO+kXNtxo5j+cGGcp6DdYZWMQkVyHW8yz6AG
 olk/QT17vFCRHu9j75ik0vNRQxjeav64kJVAxWh0qiBWHFwkNKd58jG7CIfOowk9iQrQLnZNLca
 rau7NSOBzY8EtgCx9m8Pm1exPjMA03bGFnyALoAdg8h+DCVrcFSRLeLpXVX848mQwhsY7SDU6ic
 8C0VUeTROJvyFuQD71WeYmDn/GkdXdX2ilm/KsuRch6LPgojkQoImj5r5CeWlUg8oV62Qn/aXBP
 GDIcSS7c8G2VTi+JtA88YCVoej9b3hc8AkgMuRX6BRLue3DGEsi+x4Lh3BHsFAR8pDKv4ZOJHsN
 qFfW7HMVweh9wb7sbDAYNg7Ju8h55tzjISKNBQ6vs/MQ9bcUAI5LTraH4WQStRWpVGd88Qhi6Vz
 v/DovNH5xv3JrVPBq1w==
X-Proofpoint-ORIG-GUID: ORG8JbEZZldc6s1kp43Zj5zPFhoHhpBz
X-Proofpoint-GUID: ORG8JbEZZldc6s1kp43Zj5zPFhoHhpBz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_153617_883153_D526ACCF 
X-CRM114-Status: GOOD (  11.10  )
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

Just adding another nvme hybrid interrupt and polling mechanism to the
lists. There's some recent alternatives mentioned in the links below,
but I'm trying one last time to leverage the DIM framework. Performance
wise, this at least doesn't seem any worse than anything else proposed,
though I've only been able to test on mid-level hardware so far.

This one here as some irq prep patches that help some when transitioning
from irq to polling for MSI-x enabled NVMe completions. These should be
generally applicable, so isn't necessarily tied to how it gets used in
the last patch if someone else finds it useful too.

Links:

  [1] https://lore.kernel.org/linux-nvme/20261009050556.2817978-1-namjain=
@linux.microsoft.com/

  [2] https://lore.kernel.org/linux-nvme/20260818033846.53790-1-changfeng=
nan@bytedance.com/

Keith Busch (3):
  genirq: Add disable_irq_nowait()
  PCI/MSI: Implement irq_mask_nowait() for MSI-X
  nvme-pci: hybrid irq+polling

 drivers/irqchip/irq-msi-lib.c |   1 +
 drivers/nvme/host/Kconfig     |   2 +
 drivers/nvme/host/pci.c       | 624 ++++++++++++++++++++++++++++++++--
 drivers/nvme/host/trace.c     |   1 +
 drivers/nvme/host/trace.h     |  26 ++
 drivers/pci/msi/irqdomain.c   |   6 +
 drivers/pci/msi/msi.h         |   8 +-
 include/linux/interrupt.h     |   1 +
 include/linux/irq.h           |   4 +
 kernel/irq/chip.c             |  31 ++
 kernel/irq/internals.h        |   1 +
 kernel/irq/manage.c           |  21 ++
 12 files changed, 698 insertions(+), 28 deletions(-)

--=20
2.52.0


