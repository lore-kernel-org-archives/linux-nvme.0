Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D862D597A5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 21:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FTfbQPxHjf38EU6vmv8GKyAgDQx311NBVe9b5JRZSDw=; b=yYIMYpYYcK72Q67YPmh+hAWx3C
	goIbKEfwC5hyCSGsHx8b5W58eZMJ7IZEn6/A6FDN02GU4U6+dFEoGlkdr65Kg3NllkCjZFC/eo6kC
	H9gaTAA4dJ82EiyN3Ko1/VXFQh5NARlGIzJgp7cSCJNf+rPXMcmf79FmE1Dx188WRwY24lL5IS7+M
	nFUyRycjsZY6mHHPsf/LqOOP2PnJKmfd+3XyvEXcc8Tr+ovU5iluIS5JMReRG3fJRjTRAADp2sr2e
	1gtBQ9lLq1d9EAbBVRgQW/QivRqmB0clM3YYI//Ina3mTkm6SlzzZ0d6I7pnAXzQwj7LKgSa+0G6O
	9J1EsDLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAy7s-00000004xcr-1U99;
	Tue, 12 Nov 2024 21:08:40 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAy5j-00000004xNJ-2U79
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 21:06:29 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4ACJ5KAt026460
	for <linux-nvme@lists.infradead.org>; Tue, 12 Nov 2024 13:06:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=FTfbQPxHjf38EU6vmv
	8GKyAgDQx311NBVe9b5JRZSDw=; b=AQ/Kx7uuwzocDVT24tPImFzTDrFH9w0DsL
	Z7LkC9cYOVOw0qX9IK2cu9zKNStCuEAlAmLYhpfZGBoNkduyGpc5kwsIsu3dtyYf
	Pg4ysOYSA1Na1Ajm0zEYjbQFc21YJLHqP+/H9lHYIGKPknhfu+QDSg2bMQCCrzPc
	xeuQPwe5AV8gmJdsfp4BWtMswHJja9WIvPk1C+KPEFIo4qrD8HzVg0WRxQQptb8h
	FIlthyxI/p2gfYh+MP9Z0fKuhCF+QSZHwD1hWmYUlcxyIVai4e8DT10sZmWUnwHF
	EfuyVudl0Sot34tY+bgG62vyB9dvtvj624tEtAj2xiKGJFKh22mQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 42v5sbcq25-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 12 Nov 2024 13:06:24 -0800 (PST)
Received: from twshared22972.15.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 12 Nov 2024 21:06:24 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id F27871502A720; Tue, 12 Nov 2024 13:06:20 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/2] Using SGLs for userspace commands
Date: Tue, 12 Nov 2024 13:06:18 -0800
Message-ID: <20241112210620.2650523-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -ZDbE-Rt0xrshwb5Fwxpz3Fdr8BKeKub
X-Proofpoint-GUID: -ZDbE-Rt0xrshwb5Fwxpz3Fdr8BKeKub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_130627_827548_E1BF0356 
X-CRM114-Status: UNSURE (   8.72  )
X-CRM114-Notice: Please train this message.
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

Changes from previous version:

  Merged up to linux 6.12, which had some necessary blk-integrity
  patches

  Dropped all the initial "cleanup" patches. This is instead the minimum
  patchset to satisfy using the feature.

  Fixed setting the queue limit

  Fixed the SGLS MPTR bit

Keith Busch (2):
  nvme-pci: add support for sgl metadata
  nvme-pci: use sgls for all user requests if possible

 drivers/nvme/host/core.c |   3 +
 drivers/nvme/host/nvme.h |   5 ++
 drivers/nvme/host/pci.c  | 139 ++++++++++++++++++++++++++++++++++-----
 include/linux/nvme.h     |   1 +
 4 files changed, 131 insertions(+), 17 deletions(-)

--=20
2.43.5


