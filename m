Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EABC5321D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Aug 2024 18:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dkZdvnaqe11NEnOgxtjy1OaZym+c1mIB81+bk3ahsi0=; b=xMSjJwQXS7u/A7Q/0/HegFT11m
	VadH1BZYJMP//fccwo/jXPDNJ1kRB8guSCi7BPsdqbhUFAt4SZG0djzetrQj8jTnRT5x0V1/zasn+
	E/aAmyHAuU0IkjuVCT2SOsz6Xni8sEqaEsmPUO0Y64HWyvroY2rnUMti1jcHJDmhbUiWKAT9p5YDh
	RqKolf4xwZHYYHhoK8dy9Lh62urISdeN4ZOPhZxY5YtqxB1Fu6xNuo82AoDoZxsqPI1zt/hYjnU9i
	llpi/FlN3BkKl4QWhR6o9mdMUhWMl7eIaQ2zjF12E3fDQvD0zfj1I8OFmqy4gzxeOy9mBz9ATZx2l
	P36j3KbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sieRJ-00000008M3u-12Ul;
	Mon, 26 Aug 2024 18:27:41 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sieRG-00000008M3B-1cCq
	for linux-nvme@lists.infradead.org;
	Mon, 26 Aug 2024 18:27:39 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QErojp013274
	for <linux-nvme@lists.infradead.org>; Mon, 26 Aug 2024 11:27:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=dkZ
	dvnaqe11NEnOgxtjy1OaZym+c1mIB81+bk3ahsi0=; b=hLPFHILb3DUJZLO7guv
	AD4rB+n7/Ole4PejnUHviYzriARj1Gjt9467CT+WvakvrL3mFV1Owz60js/q3t0v
	onkgSMyHFvlL+reg1ENgqMlevNTG1Vl4fHYASxIbXGrlPTkQd2Dn16FvKUx81GVR
	FUYLQ6rekcLwJvdsOZbcd7cdFPu6jQOIS7ez45U42dP+PT/b6oGDd0Do+o1KTAXp
	kBA0NAXplKBSxGnEbgDP5zR5mKpxmi5p58twrRelT3nyE9IeIipzk0OMBZeevSzh
	ZGTstj00b99yrq6JDrEzGN/v6h6e8IDDI3WHQosp44Yi5zmxaybD4OfmAkfYQaZq
	hYA==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 418j87v3jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 26 Aug 2024 11:27:36 -0700 (PDT)
Received: from twshared16760.32.frc3.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 26 Aug 2024 18:27:35 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id EA12F12443B71; Mon, 26 Aug 2024 11:27:20 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-pci: allocate tagset on reset if necessary
Date: Mon, 26 Aug 2024 11:27:19 -0700
Message-ID: <20240826182719.3830725-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Rc20XkjU89oGVkhTBWVk_ayXXZ_5Itaz
X-Proofpoint-GUID: Rc20XkjU89oGVkhTBWVk_ayXXZ_5Itaz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_13,2024-08-26_01,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_112738_602148_F781458E 
X-CRM114-Status: GOOD (  13.01  )
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

If a drive is unable to create IO queues on the initial probe, a
subsequent reset will need to allocate the tagset if IO queue creation
is successful.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6cd9395ba9ec3..8e280e13cf10d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2508,9 +2508,14 @@ static unsigned int nvme_pci_nr_maps(struct nvme_d=
ev *dev)
=20
 static void nvme_pci_update_nr_queues(struct nvme_dev *dev)
 {
-	blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
-	/* free previously allocated queues that are no longer usable */
-	nvme_free_queues(dev, dev->online_queues);
+	if (!dev->ctrl.tagset) {
+		nvme_alloc_io_tag_set(&dev->ctrl, &dev->tagset, &nvme_mq_ops,
+				nvme_pci_nr_maps(dev), sizeof(struct nvme_iod));
+	} else {
+		blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
+		/* free previously allocated queues that are no longer usable */
+		nvme_free_queues(dev, dev->online_queues);
+	}
 }
=20
 static int nvme_pci_enable(struct nvme_dev *dev)
--=20
2.43.5


