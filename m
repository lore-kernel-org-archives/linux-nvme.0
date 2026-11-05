Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50B2606A32E
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kDYDvLb9;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Olw5oDdX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=vuMKL4MeBxIRVdSpKFbvUMhYO/YtfoToNH2hzrzeago=; b=kDYDvLb9VAUnVpP+oX/HXDyGS1
	6bkULMPyq4ajgJ0X2Mtz+dx413svYW5mtJGbpBaMpOC4AqhllT9NdRWPsnZajRdhMeRba13OIRyD+
	rlzzsU3KuZza2nCrt5zP0hIPgXtqtC7utsX/WH8UEiYdrWizSaFneXyR9SOYmWDUguqjcfE4nuNTs
	3R1qjmlCWzF7XPTY2IrfFzJRWATxzHY4Y5QX6+0Y3Lk/sa1PfWf0FOpw/yQZg7OCq7yUw75pt8LzD
	C07Uvwx0vsGv7+EY76hRIqjwnrKAmJns5HBvYQfB/spD/FW3maDlzsN6X5OS8/snTOIjnqPjDZJj9
	L+9Ql1eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP2zP-0000000AJAY-3gXk;
	Thu, 05 Nov 2026 19:19:11 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP2zK-0000000AJ9f-3cH5
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 19:19:10 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5J5taK309860
	for <linux-nvme@lists.infradead.org>; Thu, 5 Nov 2026 11:19:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=vuMKL4MeB
	xIRVdSpKFbvUMhYO/YtfoToNH2hzrzeago=; b=Olw5oDdXMTbpDd96kwpFhMmQ4
	xR0an3jViZ/tnQFrtdbYuNE8dZDw3UPUR74l5BdB+lEEeRXRk8owyEvnEHhnYJUp
	4dFZRVx0gmh3UFqsyd8ML7IbCf+Nx+aNirzqbFUuH6zK5Rg/gnsVHrQiyOWtWSdk
	CsPxpy6zFOOzikHT10UM5vhxRiwu83lKhDv+KkvYzLn82apA31oghb+i0k+H0Xmh
	Vn0kYGh+aI9jNHuaQdHP1g9wRzwU0DYzp7Jtve/ejvs7UN6DaVUbkwxfkVhxM9K/
	eQQknQW/MNMgTmSOfB9z1/xjI5eBINTw98vyu3yplM8Vflg591gojgzdVKERw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hrb4a07fv-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 05 Nov 2026 11:19:05 -0800 (PST)
Received: from twshared18199.01.snb2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 5 Nov 2026 19:19:02 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id F296F2E811C62; Thu,  5 Nov 2026 11:16:00 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <tglx@kernel.org>, <bhelgaas@google.com>
CC: <maz@kernel.org>, <lrizzo@google.com>, <hch@lst.de>,
        <changfengnan@bytedance.com>, <namjain@linux.microsoft.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2 0/2] genirq, PCI/MSI: mask without flushing
Date: Thu, 5 Nov 2026 11:15:54 -0800
Message-ID: <20261105191556.4042191-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3NiBTYWx0ZWRfX5F/kXYq4q/Sm
 zp8iltcHzAHUT5fj0bgsArJam0fD6EaaTme/tRO07nhlta7BNyMrqQe5O0BQwSsN84HuB7VtMsQ
 B8h95VCqT2c1nMi/HNhafPilwrcW+DQ=
X-Authority-Analysis: v=2.4 cv=U7sHnuru c=1 sm=1 tr=0 ts=6aecd6a9 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=wpfVPzegXHpEFt3DAXn9:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=TAX1gFrxjG5BdyIcG9sA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: CvFNd6-GugT2zlorfmt0AD13a5K7OEMu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3NiBTYWx0ZWRfX0fGHHFHJspnx
 OwPYxBdclAs0zgdUcbUp3lU/ULsjKpah2iesiR9OruLYL7kmrC99/jr7/vE/kiY08SUgWjADW3y
 qKeKQLh1TLxQ1jJydMq/sCQuA6D0ROlpKL/InLvNxw0mZWTrS5x7yzGrDhpRkclWrLB7yewZrn+
 5I3XDCJe3Uw64oyXrrvN7GeENFjLPA+4nczppxq6vETitrjb0+F5qUI4w/bArHspqDqRGW3YZns
 Qv8iRFl19tqMqgkjd1MFnc/ctN8t/OxUt8bLLZj2SL3je1RvTafma1dgNQFERnstBIDAJ656Tot
 Q+j2Xl8z7+YFNCntxYRLPx8mhOdaWDY+0qw6Fs/BlCT8N0TK204oGvPPZn2yegPZMgynFleJ1yn
 Pbi83hHMKojiA9dSF9Hq6xzYx9Iw+MncGNAIj4QPXX4TutmOJ36jO/TgTH58bCeGJVq1O/I+0r+
 xFrw2GhLHwHCHmkCcEw==
X-Proofpoint-ORIG-GUID: CvFNd6-GugT2zlorfmt0AD13a5K7OEMu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_111907_524048_E694D229 
X-CRM114-Status: UNSURE (   9.85  )
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

Changes since v1:
  - Keep the channel offline check guarding the flush read in
    pci_msix_mask() (Sashiko)

v1: https://lore.kernel.org/all/20261105182706.3700908-1-kbusch@meta.com/

Keith Busch (2):
  genirq: Add disable_irq_noflush()
  PCI/MSI: Implement irq_mask_noflush() for MSI-x

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


