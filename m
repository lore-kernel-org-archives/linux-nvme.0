Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4589CC369C2
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 17:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ILnIg8485nbBCITzT3YOtYhPQStGWU6yt+zuqVUPzGc=; b=SWaGR9D+7XGaHbkk/e65cex14O
	gtabLoBxBoNxT0Fqk+48B2sJmZ5+Lg6xree6EijEk32cMWQJe1x4y9MgibnvAZHYFBpaev/2eVcEF
	6Zc1v1XjoGQC2fx3Oz9Ao8t32LtEEHjlmi496ksVJG5p+59yr8+4OOs5sIqYKqERCbCNyTcJ+gU6E
	GQfcPRTwWuBdNKiFcTgQlKd6i2yAsl6gngIOtnLjwi5Vp2Sxu01PAmr5dZNx3QjeFsBGZ3CxiyzKR
	0zrWRCyg6b5ekwBoEVkWDFlYoM4XMjXB9okWLj3YleVnpWjU4+IiamVF0i4C74z/+3/PpPvRIZxZO
	xf9YqRvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u80DH-0000000EsI0-0drY;
	Thu, 24 Apr 2025 17:18:15 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u80DD-0000000EsHA-3Pry
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 17:18:13 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 53OGWRD0024937
	for <linux-nvme@lists.infradead.org>; Thu, 24 Apr 2025 10:18:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=ILnIg8485nbBCITzT3
	YOtYhPQStGWU6yt+zuqVUPzGc=; b=TIKcCA2CVAgA+Z2Sgr9meKoS9Jw1uMFisU
	ZIpkFM4Ppd1fX+nhWXziBh66IeO6iv5SrkrapqIyTDRmWwYLwDyeF1P4bRAakdKI
	UCLSksT8bQxHRL6FG3Gqj4srkCRxPx+eiI/46DAY4OXZ4L2SQVpvdVjN9ipcVbPF
	MRz1FwnWrK4nRHNnDRc9PgqQ+wfj7i/IjAwEkU9GbM5nBAKWrgWDuLx0WvWjratj
	wPOen5DEy7RPemH7WK3JUNFxsKqfUyyY3oI+DXdAXSDsBCFhCKgixR5MS/3Vkbwj
	ehqmVNNb2faH+/rcS82wcIibdRdVqTkV2qAyvO83RJ79BZMNKpfQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 467k9mk7dc-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 24 Apr 2025 10:18:09 -0700 (PDT)
Received: from twshared11145.37.frc1.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 24 Apr 2025 17:18:06 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 435F61AB09BEB; Thu, 24 Apr 2025 10:18:02 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>,
        Dhankaran Singh Ajravat
	<dhankaran@meta.com>
Subject: [PATCH] nvme-pci: fix queue unquiesce check on slot_reset
Date: Thu, 24 Apr 2025 10:18:01 -0700
Message-ID: <20250424171801.2300390-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=cKPgskeN c=1 sm=1 tr=0 ts=680a7251 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=_Qq6qd6OV63giPMY3-sA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: agyU1h_ItV-s5W6vJncqEIK6J1o5vVwG
X-Proofpoint-GUID: agyU1h_ItV-s5W6vJncqEIK6J1o5vVwG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDExOSBTYWx0ZWRfXxxbSsVJUdh9T d+Fjbe2ceF2vpf4SDbPVfXziZsS98UY84Sw4Ivwx88GoEHnj2XLLS55MaSlsvHvbJLgDrFk8iki FicCMPpObtwS8KIdVIAshXndkTUToOe2W9/b5ZBqjMqfZpTg+oxK9WzJAQv8cDdzz7ZuApz92F5
 s9mIGFl6jZY+hXEZniTUT3432DDsMjV433rqbdygqZf+MK7nbN9pcFogb5MBe/NHog400ZYX9FF k6BcOFhFpewwcJ0/uyhX5ds1rxY2pfRhyRm8RWVABPs+VMqvoTnqoWootO7iRvoiTAsYHAbzEmR PDt8evedORMHrZHFiLjuXf4gcSKPvvKSGGZeVugtiUmQg0uR3/92cKiEktkj/Mxqrlzm3aPzZux
 a9mI1y7cgpvxHwH96am4BERcQn4wqTi55HtQCo1zKbmLtx+bJuuc13vmEj1REgXLNJRrGfas
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_07,2025-04-24_02,2025-02-21_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_101812_068619_294487BE 
X-CRM114-Status: GOOD (  12.02  )
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

A zero return means the reset was successfully scheduled. We don't want
to unquiesce the queues while the reset_work is pending, as that will
just flush out requeued requests to a failed completion.

Fixes: 71a5bb153be104 ("nvme: ensure disabling pairs with unquiesce")
Reported-by: Dhankaran Singh Ajravat <dhankaran@meta.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b178d52eac1b7..c9e2a5450bc0f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3575,7 +3575,7 @@ static pci_ers_result_t nvme_slot_reset(struct pci_=
dev *pdev)
=20
 	dev_info(dev->ctrl.device, "restart after slot reset\n");
 	pci_restore_state(pdev);
-	if (!nvme_try_sched_reset(&dev->ctrl))
+	if (nvme_try_sched_reset(&dev->ctrl))
 		nvme_unquiesce_io_queues(&dev->ctrl);
 	return PCI_ERS_RESULT_RECOVERED;
 }
--=20
2.47.1


