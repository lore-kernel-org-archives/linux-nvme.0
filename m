Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67468606A319
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gipU8jTQ;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=edhhW5LG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vIH9Q4srWAzZV4ros0rpTOQQCBVci/zaS1xLRE132NA=; b=gipU8jTQXHVe1fCyr622b2jVir
	4kLCqLGPURfB6e3XQGcxi+vQ3UPNJgQgx9DHHB8ixm2jEfiSt6EN5FcSqSFvmnmoRqaoT32u8Wbtv
	Maxsbs7qOoxIXuhJhv1Orr3oZvguGFFFZysU6pcJdoa/Zb6Q/F2RX3DBd2cGY4+kjr1UB3ZxDDpLQ
	HBwIHwqfCJkP5/N/vP2R8IAE7TszZMqCVYmuhPJ2866ObKsE4P43BVG623WpKJJCtMjWsjRO6N8qy
	6KHK2mUQ/9jGvGvFoa9KbcBq2FAKJC7e/4y85utYcWkq1deufLTL6In9ysuvF6Ev5gcbFc+8P+wUD
	l3iuWRmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJbLQ-0000000CgMH-04Ng;
	Wed, 21 Oct 2026 18:47:24 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJbLK-0000000CgJu-45fI
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 18:47:20 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69LHrwUx1477582
	for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2026 11:47:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=vIH9Q4srWAzZV4ros0rpTOQQCBVci/zaS1xLR
	E132NA=; b=edhhW5LGlSgI6dAuDw2hblOVCAgXCNATv+qbb+7D2YuWRd2TpWxkh
	IjM45kIxn+hCmMhJWzrNsH2p3m8jhlNtzhvzn0wU8ZRDHsMSH0CiKtRZJ6J/n4j+
	mtVS2uVuKQ7GyQguCYffRGq2eTHub/iXvsG48S/Z2UbCzHTxW/OGY4I+JbBhOgTy
	doaIXoqGXNQj9a2wpp8VPpYmiiiCy1wFF11fOp9q87jLDt5j6uIRMxttUmS+tSVE
	1MkzHLbML8MWPfIG4XSXEhQtWiqusjeoH/TEJPkjLvoXOjccdF0NSr2nbeMYVEpD
	RiCbE98V7JYNbIRVS9N72Smn2Wq86XkHA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4hdw56xu11-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2026 11:47:17 -0700 (PDT)
Received: from twshared17659.01.snb2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 21 Oct 2026 18:47:16 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id A0CE42DBB477E; Wed, 21 Oct 2026 11:46:59 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <axboe@kernel.dk>, <asml.silence@gmail.com>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] nvme-pci: detach dma-bufs only on removal
Date: Wed, 21 Oct 2026 11:46:58 -0700
Message-ID: <20261021184658.644645-3-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261021184658.644645-1-kbusch@meta.com>
References: <20261021184658.644645-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: mpHyvITbgei8tXSr5D1sxXYJj0eFv6cl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3NCBTYWx0ZWRfXyxodfawbPr3o
 jCID4bnus9L4gSEKs6bgnoeyDL0LebEsjyGgzOJXo4ZOpJvBe861XLTyT/ERybBYiGndS5vGmk0
 ku8mSkvsg0SEVw9DcujquEXnv0D0LiAcmIp5SW0wWM305h92qHLLUXwzDUFyC5BKFehfBJpGFC8
 g8SGKEa4WJ5pnXv9wU0KOyevCMGy2uMJgEbdkqqcS+J0BtgDv1lGapBywkCOIKaWWsxFVLM6N3Y
 8sRTcrwr6zqVHiv1eft5nLn7ESl15MLJX71DGIpST3nFdmxahpKNA9V4v1kHyiv3gzvaactwF6b
 SD4MOEDGBmRQPhTwisezw7WTLc8ZNqidH/snu1jpMLTzVOyfgPxd9coKKalN9XpIa1bEgb8XeIz
 atmAsCntEHPcCx9EkV189FVrHF6Ak/Z2OecOcihwSNp32VItm3anE5NHLiCnqP2ihK1iWNk7haU
 40OEKQ4YODkrkfB450A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3NCBTYWx0ZWRfX4Kg8bUvzcLvU
 0p1t3zNkbqqX6u6sTdVU5kF/sU3NRBJev9ttqkfH9DmORTY++EjQLyhuwIKg9xcoM+YNgPRlds/
 hm93Q09JbIIUzNZ3YMMijQkoXv+Xgyo=
X-Authority-Analysis: v=2.4 cv=J+Q/fwnS c=1 sm=1 tr=0 ts=6ad908b5 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=VwQbUJbxAAAA:8 a=VX5OWN6_KMkPTkhSNNQA:9
X-Proofpoint-ORIG-GUID: mpHyvITbgei8tXSr5D1sxXYJj0eFv6cl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_114719_133009_6140AC9F 
X-CRM114-Status: GOOD (  11.79  )
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Busch <kbusch@kernel.org>

Detaching the dma-bufs on every shutdown permanently prevents dma-buf
I/O after resuming from a suspend. The mappings remain valid across
suspend, so detach these only when the device is being removed.

Fixes: ce5e386c1108 ("nvme-pci: implement dma-buf backed requests")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9610e1ff98a2d..a29de6e520b29 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3578,9 +3578,6 @@ static void nvme_dev_disable(struct nvme_dev *dev, =
bool shutdown)
 			nvme_unquiesce_admin_queue(&dev->ctrl);
 	}
 	mutex_unlock(&dev->shutdown_lock);
-
-	if (shutdown)
-		nvme_pci_remove_dmabuf(&dev->dmabufs);
 }
=20
 static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdow=
n)
@@ -4150,6 +4147,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_stop_ctrl(&dev->ctrl);
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_disable(dev, true);
+	nvme_pci_remove_dmabuf(&dev->dmabufs);
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_dbbuf_dma_free(dev);
--=20
2.52.0


