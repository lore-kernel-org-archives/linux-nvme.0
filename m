Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD1CC04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 22:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IHG63Gyvqhcu0kvakTTCYbjTfWngcUP7JcGGeAIW2Us=; b=Xx2Rl+RS/p5EdEto43sFwOsSWI
	nFN3mLieS/nEqpEHTau5n1UYjDyLW+/P9YbIue+a8VV1SptViFYc+mMug6a8EUkZxOQBPgXL5XHl0
	1LCVl7Dwdy2vgwqVcqKsEt1eZkYcqSIs5A+xrebt4sM9LCdAicYai53y8Z9+HxA7MGuwInI5MohXo
	i9P3V1tpdS9TuMgOGeUk/glnS/nUDDI3XzOQ42O+CNFo1SWiqCsQ8pZirJC3E51EGQisKi2h+hPZW
	aJkubfY9feJ/we4oRVfG1mXkVjNn+tRaw2WKo2AqKTQ5oV1plvxDhB6xj2UOQJpoQDPNWLDBSzUbz
	ez8TWptg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHBjq-00FI5n-2x; Thu, 28 Jul 2022 22:12:14 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHBjj-00FI20-9z
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 22:12:08 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26SILox8032703
	for <linux-nvme@lists.infradead.org>; Thu, 28 Jul 2022 15:12:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=IHG63Gyvqhcu0kvakTTCYbjTfWngcUP7JcGGeAIW2Us=;
 b=nVQSMyPSbz6tTANM+8YHE7NBJQ9TPNiTzJ8UaYwO0lC71wOUoeAJE4osCLFZPUUmuG0m
 tSt+rMCcRxH+K5reRAk1d5wlpt25mlNVs8Ep9WeOF3yq3T93E3uiMIki2OM+KAiDFz+H
 5XPFr3YDpg+oJyCtL/Ik02A9Nuge3tt9dGQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3hkpemdmxb-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 28 Jul 2022 15:12:01 -0700
Received: from twshared25107.07.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 15:11:59 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id BD78E6B202B0; Thu, 28 Jul 2022 15:11:52 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 4/5] nvme-pci: iod nents fits in s8
Date: Thu, 28 Jul 2022 15:11:50 -0700
Message-ID: <20220728221152.538648-5-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220728221152.538648-1-kbusch@fb.com>
References: <20220728221152.538648-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _G6jNSM7rtZNiVo6GCppnnkpvTp9Atek
X-Proofpoint-GUID: _G6jNSM7rtZNiVo6GCppnnkpvTp9Atek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_151207_509665_81E9083F 
X-CRM114-Status: GOOD (  16.54  )
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

The maximum number of 'nents' allowed by the queue limit is 127, which
fits in an 's8'.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9e5bbf4e3e07..546de3c2000b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -229,7 +229,7 @@ struct nvme_iod {
 	bool use_sgl;
 	bool aborted;
 	s8 npages;		/* In the PRP list. 0 means small pool in use */
-	int nents;		/* Used in scatterlist */
+	s8 nents;		/* Used in scatterlist */
 	dma_addr_t first_dma;
 	unsigned int dma_len;	/* length of single DMA segment mapping */
 	dma_addr_t meta_dma;
--=20
2.30.2


